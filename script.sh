#!/bin/zsh

# argumentvariables
secret_key=`hexdump -vn16 -e'4/4 "%08X" 1 "\n"' /dev/urandom`

# setup virtual environment and add dependencies
pipenv install --python 3.9.2
pipenv install flask flask-sqlalchemy sqlalchemy-serializer flask-cors flask-restful flask-migrate flask-bcrypt python-dotenv

# filestructures
mkdir server
touch server/app.py
touch server/config.py
touch .env
touch .gitignore

# imports config.py
echo "from flask import Flask" >> server/config.py
echo "from flask_sqlalchemy import SQLAlchemy" >> server/config.py
echo "from sqlalchemy import MetaData" >> server/config.py
echo "from flask_migrate import Migrate" >> server/config.py
echo "from flask_bcrypt import Bcrypt" >> server/config.py
echo "from flask_restful import Api" >> server/config.py
echo "from flask_cors import CORS" >> server/config.py
echo "from dotenv import load_dotenv" >> server/config.py
echo "import os\n" >> server/config.py

# configuring config.py
echo "load_dotenv()\n" >> server/config.py

echo "naming_convention = {
    \"ix\": \"ix_%(column_0_label)s\",
    \"uq\": \"uq_%(table_name)s_%(column_0_name)s\",
    \"ck\": \"ck_%(table_name)s_%(constraint_name)s\",
    \"fk\": \"fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s\",
    \"pk\": \"pk_%(table_name)s\",
}\n" >> server/config.py
echo "metadata = MetaData(naming_convention=naming_convention)\n" >> server/config.py
echo "app = Flask(__name__)" >> server/config.py
echo "app.secret_key = os.getenv(\"FLASK_SECRET_KEY\")" >> server/config.py
echo "app.config[\"SQLALCHEMY_DATABASE_URI\"] = os.getenv(\"DATABASE_URI\")" >> server/config.py
echo "app.config[\"SQLALCHEMY_TRACK_MODIFICATIONS\"] = False\n" >> server/config.py
echo "db = SQLAlchemy(app=app, metadata=metadata)\n" >> server/config.py
echo "migrate = Migrate(app=app, db=db)\n" >> server/config.py
echo "bcrypt = Bcrypt(app=app)\n" >> server/config.py
echo "api = Api(app=app)\n" >> server/config.py
echo "CORS(app)" >> server/config.py

# imports app.py
echo "from config import app\n" >> server/app.py

# configuring app.py
echo "if __name__ == \"__main__\":" >> server/app.py
echo "  app.run(port=5555, debug=True)" >> server/app.py

# configuring .gitignore
echo ".env" >> .gitignore

# configuring .env
echo "FLASK_SECRET_KEY=$secret_key" >> .env
echo "DATABASE_URI=sqlite:///app.db" >> .env

# initializing database
cd server

pipenv run flask db init
pipenv run flask db revision -m 'initial db'
pipenv run flask db upgrade head

cd ..

# creating react client
npm create vite@latest client -- --template react
cd client
npm install react-router-dom formik yup
cd ..

# enter into the pipenv shell (currently stops the script until you exit from the pipenv shell)
pipenv shell