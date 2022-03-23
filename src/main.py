import psycopg2
conn = psycopg2.connect(host='localhost', database='vikings_db', \
                         user='admin', password='123123aa'
)
cur = conn.cursor()