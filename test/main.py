import os


def test_oracle():
    import cx_Oracle
    ORACLE_CON_STR = os.environ.get('ORACLE_CON_STR')
    con = cx_Oracle.connect(ORACLE_CON_STR)
    print(con.version)
    con.close()


def test_sql_server():
    import pyodbc
    SQL_SERVER_CON_STR = os.environ.get('SQL_SERVER_CON_STR')
    cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'+SQL_SERVER_CON_STR)
    cursor = cnxn.cursor()
    tsql = "SELECT @@version;"
    with cursor.execute(tsql):
        row = cursor.fetchone()
        print (str(row[0]))


print("\nTesting Oracle...")
test_oracle()
print("\nTesting SQL Server...")
test_sql_server()
