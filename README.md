Mobile webapp for tracking disc golf scores

Made with CoffeeScript + Nodejs + MongoDB, as an experiment to test express-resource and mongoose node modules


How to build:

1) [Install node](https://github.com/joyent/node/wiki/Installation)

2) [Install npm](http://howtonode.org/introduction-to-npm)

3) [Install coffee](http://jashkenas.github.com/coffee-script/#installation)

4) [Download mongodb](http://www.mongodb.org/downloads)

5) Start mongo:

`cd ~/Downloads/mongodb-osx-x86_64-1.8.2-rc3`

`./bin/mongod --dbpath ./data/`

6) Create a user in mongo db:

`./bin/mongo`

`> use flipfling`

`> u = {login:'foo',password:'bar',role:'admin'}`

`{ "login" : "foo", "password" : "bar", "role" : "admin"}`

`> db.users.save(u)`

7) Clone repo & install dependencies:

`cd ~/dev`

`git clone git://github.com/JoshKast/flipfling.git`

`cd flipfling/app`

`npm install`

8) Compile coffee and start app:

`cd ~/dev/flipfling`

`coffee -c -o app/ coffee/app/`

`coffee -c -o app/static/script/ coffee/static/`

`node app/app.js`