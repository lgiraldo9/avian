import mysql.connector

#conexion DATABASE MYSQL
def get_connection():
    try:
        connection = mysql.connector.connect(
            host= 'localhost',
            user= 'root',
            password= '',
            database= 'avian'
        )
        return connection
    except mysql.connector.Error as err:
        raise err