import pandas as pd
import sqlite3


def load_data_from_database(SQL, path):
    with sqlite3.connect(path) as con:
        return pd.read_sql(SQL, con)

def load_excel(path):
    return pd.read_excel(path)