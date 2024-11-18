
```shell
$ docker ps // list images

IMAGE
my-mongodb-container

$ docker exec -it my-mongodb-container bash

// -it is a flag for 'interactive terminal', bash is the shell we'll use

root@example:/# mongo 
// enter mongodb shell

> use admin 
// switched to db admin

> db.auth("username", "password");
// 1

> show dbs
admin  0.000GB
config 0.000GB
local  0.000GB
mydb   0.000GB

> use mydb
// switched to db mydb

```