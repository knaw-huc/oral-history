import mysql.connector

def testDatabase(USER, PASSWORD, HOST, DATABASE):

    cnx = mysql.connector.connect(user=USER, password=PASSWORD,
                                host=HOST,
                                database=DATABASE)
    cursor = cnx.cursor()                              
    query = ("SELECT profile_id,name, description FROM profiles")
    cursor.execute(query)

    results = cursor.fetchmany()
    print(results)

    lijst = []
    for (id, name, description) in cursor:
        d = {name: description}
        lijst.append(d)
        print(name, " \t\t\t ", description)
    
    cursor.close()
    cnx.close()