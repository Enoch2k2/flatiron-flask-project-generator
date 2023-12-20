# Simple Flask Project Generator for Flatiron School

This script is for generating a barebone phase 4 project that's already configured for Flask. React you will still need to add (possibly adding this later).

### How to use

* In the root of your project, create a script.sh file.
* Then copy the contents of this script.sh into your script.sh file in your project.
* in the terminal type `chmod 777 script.sh` in order to give it executable permissions.
* Type in the terminal `./script.sh` to run the file.
* Grab some popcorn

### What now that it's done running?

You're Flask project is ready to go! Create models / routes / etc... You will not have to worry about initializing your database with flask db init, flask db revision -m 'initial db', flask db upgrade head. That is already done for you!

You also now have a client folder which is your React application. You can definitely use it if you want (if it this is your project, you will want to use this). This includes react-router-dom, formik, and yup automatic installations.

### Note on the proxy in client/vite.config.js ###
If your backend prefixes `/api` to all of your routes, for example: `http://localhost:5555/api/check_session` and you have `api.add_resource(CheckSession, "/api/check_session")`, you can remove the `rewrite` line which removes the `/api` from the route so you can use `/api` in your backend routes.

### If you run into issue with flask-bcrypt installing because of a rust issue

Run this command:
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Then delete everything in your folder except the script.sh. Type exit in your terminal to make sure you are out of your pipenv shell and then re-run the script.sh.