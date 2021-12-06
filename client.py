import mysql.connector

db = mysql.connector.connect(
    host = "marmoset04.shoshin.uwaterloo.ca",
    user = "zj2yan",
    passwd = "dbiojGHP2WU8zh@H63%8",
    database = "NHL_356"
)
cur = db.cursor()

cur.execute("SELECT * FROM GameGoals;")

for i in cur:
    print(i)