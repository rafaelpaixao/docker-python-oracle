import os


def test_oracle():
    import cx_Oracle
    host = os.environ.get('ORACLE_HOST')
    user = os.environ.get('ORACLE_USER')
    pwd = os.environ.get('ORACLE_PASS')
    name = os.environ.get('ORACLE_NAME')
    con = cx_Oracle.connect(user + "/" + pwd + "@" + host + "/" + name)
    print(con.version)
    con.close()


def test_postgres():
    import psycopg2
    host = os.environ.get('POSTGRES_HOST')
    user = os.environ.get('POSTGRES_USER')
    pwd = os.environ.get('POSTGRES_PASS')
    name = os.environ.get('POSTGRES_NAME')
    con = psycopg2.connect(database=name, user=user, password=pwd, host=host, port="5432")
    print(con.server_version)

def test_sql_server():
    import pyodbc
    host = os.environ.get('SQLSERVER_HOST')
    user = os.environ.get('SQLSERVER_USER')
    pwd = os.environ.get('SQLSERVER_PASS')
    cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+host+';PORT=1443;UID='+user+';PWD='+pwd)
    cursor = cnxn.cursor()
    tsql = "SELECT @@version;"
    with cursor.execute(tsql):
        row = cursor.fetchone()
        print (str(row[0]))


print("\nTesting Oracle...")
test_oracle()
print("\nTesting Postgres...")
test_postgres()
print("\nTesting SQL Server...")
test_sql_server()
