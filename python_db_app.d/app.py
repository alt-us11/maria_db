import os
os.putenv('LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN', '1') # Send password using clear text
import mysql.connector
from dotenv import load_dotenv
load_dotenv()

print("Hello world")
try:
    connection = mysql.connector.connect(
        host=os.getenv('DB_HOST'),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD'),
        database=os.getenv('DB_NAME')
)
except mysql.connector.Error as err:
    print(f"Error: {err}")
else:
    print("Connection successful!")
    my_sql_query = ('SELECT P_CODE, P_QOH FROM PRODUCT;')
    cursor = connection.cursor()
    cursor.execute(my_sql_query)
    results = cursor.fetchall()
    
    # print(results)
    for row in results:
        print(f'Product Code-> {row[0]}, Quantity on Hand-> {row[1]}, END')

    print('Query executed successfully!')

finally:
    if connection.is_connected():
        cursor.close()
        connection.close()