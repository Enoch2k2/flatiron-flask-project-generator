# Simple Flask Project Generator for Flatiron School

This script is for generating a barebone phase 4 project that's already configured for Flask. React you will still need to add (possibly adding this later).

### How to use

* In the root of your project, create a script.sh file.
* Then copy the contents of this script.sh into your script.sh file in your project.
* in the terminal type `chmod 777 script.sh` in order to give it executable permissions.
* Type in the terminal `./script.sh secret_key` where you replace `secret_key` with a top secret key!
* Grab some popcorn

### If you run into issue with flask-bcrypt installing because of a rust issue

Run this command:
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Then delete everything in your folder except the script.sh. Type exit in your terminal to make sure you are out of your pipenv shell and then re-run the script.sh.