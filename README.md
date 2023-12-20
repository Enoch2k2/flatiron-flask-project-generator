# Simple Flask Project Generator for Flatiron School

This script is for generating a barebone phase 4 project that's already configured for Flask with a React frontend.

### How to use

* Create a directory for your project and cd into your project
* open up the terminal in your project directory (make sure your terminal shows the project directory)
* run in the terminal `curl -s https://raw.githubusercontent.com/Enoch2k2/flatiron-flask-project-generator/main/script.sh | bash`
* Grab some popcorn

### Note while the project is being created

There may be points during project generation that you get prompted to input either a yes or no into the terminal. Or to install something (like vite). Follow the prompts closely (basically say yes to everything and it should be fine!). You will only need to do the prompts once.

### What now that it's done running?

You're Flask project is ready to go! Create models / routes / etc... You will not have to worry about initializing your database with flask db init, flask db revision -m 'initial db', flask db upgrade head. That is already done for you! You will however need to use `pipenv shell` in order to go into your virtual environment.

You also now have a client folder which is your React application. You can definitely use it if you want (if it this is your project, you will want to use this). This includes react-router-dom, formik, and yup automatic installations.

### Note on the proxy in client/vite.config.js ###
If your backend prefixes `/api` to all of your routes, for example: `http://localhost:5555/api/check_session` and you have `api.add_resource(CheckSession, "/api/check_session")`, you can remove the `rewrite` line which removes the `/api` from the route so you can use `/api` in your backend routes.

### If you run into issue with flask-bcrypt installing because of a rust issue

Run this command:
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Then delete everything in your folder and run `rm -rf .git`. Then redo the installation instructions!