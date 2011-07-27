#
# User schema and authentication
#

mongoose = require 'mongoose'
Schema   = mongoose.Schema

schema = new Schema
    login:    String
    password: String
    role:     String

# Static authenticate method fires callback with either user object or null
schema.static
    authenticate: (login,password,callback) ->
        this.find {login:login,password:password}, (err,docs) ->
            if docs && docs.length && docs.length == 1
                callback( docs[0] )
            else
                callback( null )

mongoose.model 'User', schema
