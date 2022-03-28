import psycopg2
import sys

class Database():
  def __init__(self):
    self.connection = psycopg2.connect(host='src_db_postgres_1', \
                                        database='vikings_db', \
                                        user='admin', password='123123aa'
    )
    self.cursor = self.connection.cursor()

  def query(self, query):
    try:
      self.cursor.execute(query)
      return self.cursor.fetchall()
    except Exception as err:
        print(err, file=sys.stderr)
        return None

  def query_one(self, query):
    try:
      self.cursor.execute(query)
      return self.cursor.fetchone()
    except Exception as err:
        print(err, file=sys.stderr)
        return None

  def insert(self, query):
    try:
        self.cursor.execute(query) 
    except Exception as err:
        print(err, file=sys.stderr)
        return None

  def commit(self):
    try:
      self.connection.commit()
    except Exception as err:
      self.connection.rollback()
      print("Error: commit failed", file=sys.stderr)

  def close(self):
    self.cursor.close()
    self.connection.close()