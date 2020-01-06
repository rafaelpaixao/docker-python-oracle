def test_oracle():
    import cx_Oracle
    import os

    ORACLE_CON_STR = os.environ.get('ORACLE_CON_STR')
    con = cx_Oracle.connect(ORACLE_CON_STR)
    print(f"Oracle DB: {con.version}")
    con.close()


test_oracle()
