
import sqlite3
from pathlib import Path

# Percorso del database
BASE_DIR = Path(__file__).resolve().parent
DB_PATH = BASE_DIR / "football.db"

def get_connection(read_only=False):
    if read_only:
        conn = sqlite3.connect(
            f"{DB_PATH.as_uri()}?mode=ro",
            uri=True
        )
    else:
        conn = sqlite3.connect(DB_PATH)

    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")

    return conn


def initialize_database():
    schema_path = BASE_DIR / "schema.sql"

    with get_connection() as conn:
        schema = schema_path.read_text(encoding="utf-8")
        conn.executescript(schema)

    print("Database creato correttamente!")


if __name__ == "__main__":
    initialize_database()
