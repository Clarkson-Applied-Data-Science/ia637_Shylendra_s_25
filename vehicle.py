from baseObject import baseObject
import pymysql
import hashlib

class vehicle(baseObject):
    def __init__(self):
        self.setup()
        self.pk = 'store_id'
        
  
    def role_list(self):
        rl = []
        for item in self.roles:
            rl.append(item['value'])
        return rl
    def verify_new(self,n=0):
        self.errors = []
        row = self.data[n]

        if not row.get('name'):
            self.errors.append("Store name is required.")
        if not row.get('location'):
            self.errors.append("Store location is required.")
        if not row.get('contact_info'):
            self.errors.append("Contact info is required.")
        if not row.get('user_id'):
            self.errors.append("A seller (user_id) must be assigned to the store.")

        return len(self.errors) == 0

        
        # if len(self.errors) == 0:
        #     return True
        # else:
        #     return False
    def verify_update(self,n=0):
        self.errors = []
        row = self.data[n]

        if not row.get('name'):
            self.errors.append("Store name cannot be empty.")
        if not row.get('location'):
            self.errors.append("Store location cannot be empty.")
        if not row.get('contact_info'):
            self.errors.append("Contact info must be provided.")
        if not row.get('user_id'):
            self.errors.append("Store must be linked to a seller (user_id).")

        return len(self.errors) == 0
        
        # if len(self.errors) == 0:
        #     return True
        # else:
        #     return False
    def getWithOwner(self):
        sql =  '''
        SELECT s.*, u.name AS seller_name, u.email 
        FROM Stores s
        LEFT JOIN Users u ON s.user_id = u.user_id;
    '''
        self.cur.execute(sql)
        self.data = []
        for row in self.cur:
            self.data.append(row)
            
    def getById(self, id):
        sql = f"SELECT * FROM `{self.tn}` WHERE `{self.pk}` = %s;"
        self.cur.execute(sql, [id])
        self.data = []
        for row in self.cur:
            self.data.append(row)

    def get_price_comparision(self, search_term):
        sql = '''
            SELECT
                p.name as product_name,
                c.category_name,
                s.name as store_name,
                s.location as store_location,
                pr.original_price,
                pr.todays_price,
                pr.discount,
                pr.last_updated
            FROM Products p
            JOIN Categories c ON p.category_id = c.category_id
            JOIN Prices pr ON p.product_id = pr.product_id
            JOIN Stores s ON pr.store_id = s.store_id
            WHERE p.name LIKE %s
            ORDER BY pr.discount DESC
        '''
        self.cur.execute(sql, ('%' + search_term + '%',))
        return self.cur.fetchall()

    
    def get_product_suggestions(self, prefix):
        sql= 'SELECT distinct name from products where name like %s limit 10'
        self.cur.execute(sql, (prefix + '%', ))
        return [row['name'] for row in self.cur.fetchall()]