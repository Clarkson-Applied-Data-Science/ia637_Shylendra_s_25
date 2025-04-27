from flask import Flask
from flask import render_template
from flask import request,session, redirect, url_for, send_from_directory,make_response 
from flask_session import Session
from datetime import timedelta
from user import user
from vehicle import vehicle
import time
import datetime
from flask import Flask, render_template, request, session, redirect, url_for, send_from_directory, make_response, jsonify


app = Flask(__name__,static_url_path='')

app.config['SECRET_KEY'] = '5sdghsgRTg'
app.config['SESSION_PERMANENT'] = True
app.config['SESSION_TYPE'] = 'filesystem'
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(hours=5)
sess = Session()
sess.init_app(app)

@app.route('/')
def home():
    return redirect('/login')

@app.context_processor
def inject_user():
    return dict(me=session.get('user'))

def format_datetime(value, format='%Y-%m-%d %H:%M:%S'):
    if value is None:
        return ''
    try:
        return value.strftime(format)
    except AttributeError:
        return 'NA'

app.jinja_env.filters['format_datetime'] = format_datetime

@app.route('/login',methods = ['GET','POST'])
def login():
    if request.form.get('name') is not None and request.form.get('password') is not None:
        u = user()
        if u.tryLogin(request.form.get('name'),request.form.get('password')):
            print("Login ok")
            session['user'] = u.data[0]
            session['active'] = time.time()
            return redirect('main')
        else:
            print("Login Failed")
            return render_template('login.html', title='Login', msg='Incorrect username or password.')
    else:   
        if 'msg' not in session.keys() or session['msg'] is None:
            m = 'Type your email and password to continue.'
        else:
            m = session['msg']
            session['msg'] = None
        return render_template('login.html', title='Login', msg=m)    
    
@app.route('/logout',methods = ['GET','POST'])
def logout():
    if session.get('user') is not None:
        del session['user']
        del session['active']
    return render_template('login.html', title='Login', msg='You have logged out.')
@app.route('/main')
def main():
    if checkSession() == False: 
        return redirect('/login')
    role = session['user']['role']
    
    if role == 'admin':
        return render_template('main.html', title= 'Admin Dashboard')
    elif role == 'buyer':
        return render_template('customer_main.html', title= 'Buyer Dashboard')
    elif role == 'seller':
        from user import user
        from vehicle import vehicle
        v= vehicle()
        seller_id = session['user']['user_id']
        v.cur.execute("SELECT * from Stores where user_id = %s", (seller_id,))
        stores = v.cur.fetchall()
        return render_template(
            'seller_main.html', title = 'Seller Dashboard', stores= stores
        )
        
    else:
        return redirect('/logout')
    # if session['user']['role'] == 'admin':
    #     return render_template('main.html', title='Main menu') 
    # else:
    #     return render_template('customer_main.html', title='Main menu') 

@app.route('/compare', methods=['GET'])
def compare_prices():
    if checkSession() == False:
        return redirect('/login')

    search_term = request.args.get('q', '').strip()
    if not search_term:
        return render_template('ok_dialog.html', msg="No search term provided.")

    v = vehicle()
    result = v.get_price_comparision(search_term)

    labels = []
    prices = []
    tooltips = []

    for row in result:
        label = f"{row['store_name']} ({row['store_location']})"
        discount_price = float(row['todays_price'])
        labels.append(label)
        prices.append(round(discount_price, 2))
        tooltips.append(
            f"Original: ${row['original_price']:.2f} | Discount: {row['discount']}%"
        )

    chart_data = {
        'labels': labels,
        'prices': prices,
        'tooltips': tooltips
    }

    return render_template('compare.html', query=search_term, results=result, chart_data=chart_data)



@app.route('/suggest', methods= ['GET'])
def suggest():
    term = request.args.get('term', '')
    v = vehicle()
    suggestions = v.get_product_suggestions(term)
    return jsonify(suggestions)


@app.route('/team/dashboard', methods=['GET'])
def team_dashboard():
    if checkSession() == False or session['user']['role'] != 'admin':
        return redirect('/login')

    u = user()
    role_filter = request.args.get('role', '')
    name_search = request.args.get('name', '')

    # Base query
    sql = f"SELECT * FROM {u.tn} WHERE 1=1"
    tokens = []

    if role_filter:
        sql += " AND role = %s"
        tokens.append(role_filter)

    if name_search:
        sql += " AND name LIKE %s"
        tokens.append(f"%{name_search}%")

    u.cur.execute(sql, tokens)
    data = u.cur.fetchall()

    return render_template("view.html", users=data, selected_role=role_filter, search_name=name_search)


@app.route('/team/dashboard2', methods=['GET'])
def team_dashboard2():
    if checkSession() == False or session['user']['role'] != 'admin':
        return redirect('/login')

    u = user()
    v = vehicle()

    # All users
    u.getAll()
    all_users = u.data

    # Count by role
    stats = {
        'total_users': len(all_users),
        'total_admins': len(u.get_all_admins()),
        'total_sellers': len(u.get_all_sellers()),
        'total_buyers': len(u.get_all_buyers()),
    }

    # Recent users
    u.cur.execute("SELECT * FROM Users WHERE created_at >= NOW() - INTERVAL 7 DAY ORDER BY created_at DESC")
    recent_users = u.cur.fetchall()

    # Active users (last 1 day)
    u.cur.execute("SELECT * FROM Users WHERE updated_at >= NOW() - INTERVAL 1 DAY")
    active_users = u.cur.fetchall()
    active_user_count = len(active_users)

    # 🔥 New: Price Analytics
    v.cur.execute("SELECT COUNT(*) AS total_products, AVG(todays_price) AS avg_price, MAX(discount) AS max_discount FROM Prices")
    price_analytics = v.cur.fetchone()

    v.cur.execute("""
        SELECT DATE(last_updated) AS update_date, 
            AVG(todays_price) AS avg_price, 
            AVG(discount) AS avg_discount
        FROM Prices
        WHERE last_updated >= NOW() - INTERVAL 7 DAY
        GROUP BY DATE(last_updated)
        ORDER BY update_date ASC
    """)
    price_trends = v.cur.fetchall()


    return render_template(
        "team_dashboard.html",
        stats=stats,
        recent_users=recent_users,
        active_user_count=active_user_count,
        active_users=active_users,
        price_analytics=price_analytics,
        price_trends=price_trends
    )



@app.route('/users/manage',methods=['GET','POST'])
def manage_user():
    if checkSession() == False or session['user']['role'] != 'admin': 
        return redirect('/login')
    o = user()
    action = request.args.get('action')
    pkval = request.args.get('pkval')
    if action is not None and action == 'delete': #action=delete&pkval=123
        o.deleteById(request.args.get('pkval'))
        return render_template('ok_dialog.html',msg= "Deleted.")
    if action is not None and action == 'insert':
        d = {}
        d['name'] = request.form.get('name')
        d['email'] = request.form.get('email')
        d['role'] = request.form.get('role')
        d['location'] = request.form.get('location')
        d['password'] = request.form.get('password')
        d['password2'] = request.form.get('password2')
        now = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        d['created_at'] = now
        d['updated_at'] = now
        o.set(d)
        if o.verify_new():
            #print(o.data)
            o.insert()
            return render_template('ok_dialog.html',msg= "User added.")
        else:
            return render_template('users/add.html',obj = o)
    if action is not None and action == 'update':
        o.getById(pkval)
        o.data[0]['name'] = request.form.get('name')
        o.data[0]['email'] = request.form.get('email')
        o.data[0]['role'] = request.form.get('role')
        o.data[0]['location'] = request.form.get('location')
        o.data[0]['password'] = request.form.get('password')
        o.data[0]['password2'] = request.form.get('password2')
        if o.verify_update():
            o.update()
            return render_template('ok_dialog.html',msg= "User updated. ")
        else:
            return render_template('users/manage.html',obj = o)
    if pkval is None:
        o.getAll()
        return render_template('users/list.html',obj = o)
    if pkval == 'new':
        o.createBlank()
        return render_template('users/add.html',obj = o)
    else:
        print(pkval)
        o.getById(pkval)
        if not o.data:
            return render_template('ok_dialog.html', msg = "User not found.")
        return render_template('users/manage.html',obj = o)
    
##############################################################################3
###################               Stores:
############################################################################

@app.route('/vehicles/manage', methods=['GET', 'POST'])
def manage_vehicle():
    if checkSession() == False or session['user']['role'] != 'admin':
        return redirect('/login')
    o = vehicle()
    u = user()
    u.getAll()
    o.owners = u.data
    action = request.args.get('action')
    pkval = request.args.get('pkval')


    if action == 'delete' and pkval:
        o.deleteById(pkval)
        return render_template('ok_dialog.html', msg="Store deleted.")

    if action == 'insert':
        d = {}
        d['name'] = request.form.get('name')
        d['location'] = request.form.get('location')
        d['user_id'] = request.form.get('user_id')
        d['contact_info'] = request.form.get('contact_info')
        d['created_at'] = datetime.datetime.now()
        d['updated_at'] = datetime.datetime.now()
        o.set(d)
        if o.verify_new():  # You'll need to implement this in your vehicle class
            o.insert()
            return render_template('ok_dialog.html', msg="Store added.")
        else:
            return render_template('vehicles/add.html', obj=o)

    if action == 'update' and pkval:
        o.getById(pkval)
        if o.data:
            o.data[0]['name'] = request.form.get('name')
            o.data[0]['location'] = request.form.get('location')
            o.data[0]['user_id'] = request.form.get('user_id')
            o.data[0]['contact_info'] = request.form.get('contact_info')
            if o.verify_update():  # Implement this in your vehicle class
                o.update()
                return render_template('ok_dialog.html', msg="Store updated.")
            else:
                return render_template('vehicles/manage.html', obj=o)
        else:
            return render_template('ok_dialog.html', msg=f"Store with ID {pkval} not found.")

    if pkval is None:
        o.getWithOwner()
        return render_template('vehicles/list.html', obj=o)

    if pkval == 'new':
        o.createBlank()
        return render_template('vehicles/add.html', obj=o)

    else:
        o.getById(pkval)
        if o.data:
            return render_template('vehicles/manage.html', obj=o)
        else:
            return render_template('ok_dialog.html', msg=f"Store with ID {pkval} not found.")

# Seller Section
@app.route('/get_products_by_store/<int:store_id>')
def get_products_by_store(store_id):
    v = vehicle()
    sql = '''
        SELECT p.product_id, p.name 
        FROM Products p 
        JOIN Prices pr ON p.product_id = pr.product_id 
        WHERE pr.store_id = %s
    '''
    v.cur.execute(sql, [store_id])
    products = v.cur.fetchall()
    return jsonify(products)


@app.route('/seller/update_price', methods=['POST'])
def update_price():
    if checkSession() == False or session['user']['role'] != 'seller':
        return redirect('/login')

    store_id = request.form.get('store_id')
    product_id = request.form.get('product_id')
    new_price = float(request.form.get('new_price'))

    v = vehicle()
    # Update today's price, discount is handled via trigger
    sql = "UPDATE Prices SET todays_price = %s, last_updated = NOW() WHERE store_id = %s AND product_id = %s"
    v.cur.execute(sql, (new_price, store_id, product_id))
    return render_template('ok_dialog_seller.html', msg="Price updated successfully.", redirect_url="/main")


@app.route('/seller/add_product', methods=['POST'])
def add_product():
    if checkSession() == False or session['user']['role'] != 'seller':
        return redirect('/login')

    store_id = request.form.get('store_id')
    name = request.form.get('product_name')
    description = request.form.get('description')
    category_id = request.form.get('category_id')
    original_price = float(request.form.get('original_price'))
    todays_price = float(request.form.get('todays_price'))

    v = vehicle()
    # Insert into Products
    sql_product = "INSERT INTO Products (name, description, category_id, created_at) VALUES (%s, %s, %s, NOW())"
    v.cur.execute(sql_product, (name, description, category_id))
    product_id = v.cur.lastrowid

    # Insert into Prices
    sql_price = "INSERT INTO Prices (product_id, store_id, original_price, todays_price, last_updated) VALUES (%s, %s, %s, %s, NOW())"
    v.cur.execute(sql_price, (product_id, store_id, original_price, todays_price))

    return render_template('ok_dialog_seller.html', msg="Product added successfully.", redirect_url="/main")

@app.route('/categories')
def all_categories():
    if checkSession() == False or session['user']['role'] != 'buyer':
        return redirect('/login')
    v = vehicle()
    sql = "SELECT category_id, category_name FROM Categories WHERE parent_id IS NULL"
    v.cur.execute(sql)
    top_categories = v.cur.fetchall()
    return render_template("all_categories.html", categories=top_categories)


@app.route('/categories/<int:parent_id>')
def subcategories(parent_id):
    if checkSession() == False or session['user']['role'] != 'buyer':
        return redirect('/login')
    v = vehicle()
    # Get subcategories
    v.cur.execute("SELECT category_id, category_name FROM Categories WHERE parent_id = %s", (parent_id,))
    subcats = v.cur.fetchall()

    # Get products belonging to this category
    v.cur.execute("""
        SELECT p.product_id, p.name, p.description, pr.todays_price, pr.original_price, pr.discount
        FROM Products p
        JOIN Prices pr ON p.product_id = pr.product_id
        WHERE p.category_id = %s
    """, (parent_id,))
    products = v.cur.fetchall()

    return render_template("category_products.html", subcategories=subcats, products=products)



# endpoint route for static files
@app.route('/static/<path:path>')
def send_static(path):
    return send_from_directory('static', path)

#standalone function to be called when we need to check if a user is logged in.
def checkSession():
    if 'active' in session.keys():
        timeSinceAct = time.time() - session['active']
        #print(timeSinceAct)
        if timeSinceAct > 500:
            session['msg'] = 'Your session has timed out.'
            return False
        else:
            session['active'] = time.time()
            return True
    else:
        return False   


if __name__ == '__main__':
   app.run(host='127.0.0.1',debug=True)   