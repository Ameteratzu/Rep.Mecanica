# Rep.Mecanica/database.py

from flask_sqlalchemy import SQLAlchemy

# Esta es la instancia que usarás en tus modelos y en run.py
db = SQLAlchemy()


# Si necesitas conexiones “raw” con pymysql, usa esto:
import pymysql
from pymysql.cursors import DictCursor
from config import Config

def get_raw_connection():
    cfg = Config()
    return pymysql.connect(
        host=cfg.DB_HOST,
        user=cfg.DB_USER,
        password=cfg.DB_PASS,
        database=cfg.DB_NAME,
        port=int(cfg.DB_PORT),
        cursorclass=DictCursor
    )
