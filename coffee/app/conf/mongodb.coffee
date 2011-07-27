#
# Config for MongoDB connection string
#

db =
    name:'flipfling'
    user:null
    password:null
    host:'localhost'
    port:null

exports.conn_str = ->
    conn = 'mongodb://'
    conn += db.user+':'+db.password+'@' if db.user?
    conn += db.host
    conn += ':'+db.port if db.port?
    conn += '/'+db.name
    return conn