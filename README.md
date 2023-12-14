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

You will need to go to `vite.config.js` in your client folder and inside the `defineConfig` under the `plugins: [react()],` line, you will need to add:

```
server: {
  proxy: {
      '/api': 'http://localhost:5555'
  },
}

```

This will mean anytime you do a fetch with `/api` at the start, it will proxy to `http://localhost:5555`. Example:

```
fetch('/api/check_session')
```

The /api will trigger the proxy and will send the request to `http://localhost:5555`.

Note: Hoping to get this automated in the future. Just not there yet.

### If you run into issue with flask-bcrypt installing because of a rust issue

Run this command:
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Then delete everything in your folder except the script.sh. Type exit in your terminal to make sure you are out of your pipenv shell and then re-run the script.sh.