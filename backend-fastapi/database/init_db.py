from database.database import engine, Base
from models.tables import Case, InterrogationSession, QARecord


def init_db():
    Base.metadata.create_all(bind=engine)


if __name__ == '__main__':
    init_db()
    print('database initialized')
