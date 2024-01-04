#!/bin/bash

# argumentvariables
secret_key=`hexdump -vn16 -e'4/4 "%08X" 1 "\n"' /dev/urandom`

# setup virtual environment and add dependencies
pipenv install --python 3.9.2

# install python packages
pipenv install flask flask-sqlalchemy sqlalchemy-serializer flask-cors flask-restful flask-migrate flask-bcrypt python-dotenv

# filestructures
mkdir server
touch server/app.py
touch server/config.py
touch server/seed.py
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
echo -e "import os\n" >> server/config.py

# configuring config.py
echo -e "load_dotenv()\n" >> server/config.py

echo -e "naming_convention = {
    \"ix\": \"ix_%(column_0_label)s\",
    \"uq\": \"uq_%(table_name)s_%(column_0_name)s\",
    \"ck\": \"ck_%(table_name)s_%(constraint_name)s\",
    \"fk\": \"fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s\",
    \"pk\": \"pk_%(table_name)s\",
}\n" >> server/config.py
echo -e "metadata = MetaData(naming_convention=naming_convention)\n" >> server/config.py
echo "app = Flask(__name__)" >> server/config.py
echo "app.secret_key = os.getenv(\"FLASK_SECRET_KEY\")" >> server/config.py
echo "app.config[\"SQLALCHEMY_DATABASE_URI\"] = os.getenv(\"DATABASE_URI\")" >> server/config.py
echo -e "app.config[\"SQLALCHEMY_TRACK_MODIFICATIONS\"] = False\n" >> server/config.py
echo -e "db = SQLAlchemy(app=app, metadata=metadata)\n" >> server/config.py
echo -e "migrate = Migrate(app=app, db=db)\n" >> server/config.py
echo -e "bcrypt = Bcrypt(app=app)\n" >> server/config.py
echo -e "api = Api(app=app)\n" >> server/config.py
echo "CORS(app)" >> server/config.py

# imports app.py
echo -e "from config import app\n" >> server/app.py

# configuring app.py
echo "if __name__ == \"__main__\":" >> server/app.py
echo "  app.run(port=5555, debug=True)" >> server/app.py

# configuring seed.py
echo -e "from config import app, db\n" >> server/seed.py
echo "if __name__ == \"__main__\":" >> server/seed.py
echo "  with app.app_context():" >> server/seed.py
echo "    pass" >> server/seed.py
echo "    # remove pass and write your seed data" >> server/seed.py

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

# clear out vite configuration by removing file and re-adding
rm vite.config.js
touch vite.config.js

# add new vite configuration

echo "import { defineConfig } from 'vite'" >> vite.config.js
echo -e "import react from '@vitejs/plugin-react'\n" >> vite.config.js
echo "// https://vitejs.dev/config/" >> vite.config.js
echo "export default defineConfig({" >> vite.config.js
echo "  plugins: [react()]," >> vite.config.js
echo "  server: {" >> vite.config.js
echo "   proxy: {" >> vite.config.js
echo "    '/api': {" >> vite.config.js
echo "      target: 'http://localhost:5555'," >> vite.config.js
echo "      changeOrigin: true," >> vite.config.js
echo "      rewrite: (path) => path.replace(/^\/api/, '')," >> vite.config.js
echo "    }," >> vite.config.js
echo "   }," >> vite.config.js
echo "  }" >> vite.config.js
echo "})" >> vite.config.js

cd ..

touch README.md

echo "# Project Name Here" >> README.md
echo "Fill out your project details here in your README.md" >> README.md

git init
git add .
git commit -m 'initial commit'