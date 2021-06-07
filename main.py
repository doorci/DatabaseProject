import tkinter as tk
from tkinter import filedialog
import pandas as pd
import pymysql

import sys

root = tk.Tk()

canvas1 = tk.Canvas(root, width=300, height=300, bg='lightsteelblue2', relief='raised')
canvas1.pack()


def csv_to_mysql(load_sql, host, user, password):

    try:
        con = pymysql.connect(host=host,
                              user=user,
                              password=password,
                              autocommit=True,
                              local_infile=1)
        print('Connection à la BD: {}'.format(host))

        cursor = con.cursor()
        cursor.execute(load_sql)
        print('Table chargée avec succes depuis csv.')
        con.close()

    except Exception as e:
        print('Error: {}'.format(str(e)))
        sys.exit(1)


# Execution
#Remplacer le nom du fichier correspondant
#exemple avec sante.city
load_sql = 'LOAD DATA LOCAL INFILE \'/tmp/nom_du.csv\' INTO TABLE sante.city\
 FIELDS TERMINATED BY \',\' ENCLOSED BY \''
host = 'localhost'
user = 'root'
password = ''
csv_to_mysql(load_sql, host, user, password)

def getCSV():
    global df

    import_file_path = filedialog.askopenfilename()
    df = pd.read_csv(import_file_path)
    print(df)


browseButton_CSV = tk.Button(text="      Import CSV File     ", command=getCSV, bg='green', fg='white',
                             font=('helvetica', 12, 'bold'))
canvas1.create_window(150, 150, window=browseButton_CSV)

root.mainloop()
