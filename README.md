# Challenge conditions for this project
Containers:
- Web frontend:
    - PHP 7.0.33
    - xdebug
    - apache
- MySQL
- MongoDB

Simple application to connect to both SQLs, read data and display it.

Constraints:
Build either in windows or in mac computers.
Configuration variables should be injected.
No schema nor script specification.
Should be possible to build dev and prod version:
- with xdebug turned on/off
- with php error reporting, tracking, displaying
  
  
## Setting up your environment  
   
### Pre-requisites
Having docker-compose installed.  
Set your .env.dev or .env.prod files with the required variables or export them to the environment (either windows or linux-like). Use the .DUMMYenv.dev file as base.  
Startup script should be executable, if it is not already.

### Startup script
This script handles the working directory environment variable, which differs between linux-like and windows PCs (to ensure filesystem mappings).  
Validates parameters, checks docker-compose file exists, and finally, it gets the arch to do either mariadb or mysql (mysql and arm don't mix so good). For that, it will make a copy of the corresponding compose configuration file with the correct environment keys for the chosen DB engine.
After doing that check it just starts docker-compose with a few recommended parameters for this project.  


#### For windows
Only requisite is to run it on a command line ./startup-script.bat

#### For macos or linux
Only requisite is to run it on a command line ./startup-script.sh  
  

## Conclusion
Restricting PHP version forced to also set up versions for xdebug and mongodb because of drivers compatibility.  
Volumes were created since it isolated filesystem ownership and avoided issues.
The platform you use to build matters, some docker images don't exist for M1 silicon chipset, like mysql.