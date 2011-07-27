(function() {
  var db;
  db = {
    name: 'flip-fling',
    user: 'flipfling',
    password: 'password',
    host: 'mongo.otherwise.dotcloud.com',
    port: 6213
  };
  exports.conn_str = function() {
    var conn;
    conn = 'mongodb://';
    if (db.user != null) {
      conn += db.user + ':' + db.password + '@';
    }
    conn += db.host;
    if (db.port != null) {
      conn += ':' + db.port;
    }
    conn += '/' + db.name;
    return conn;
  };
}).call(this);
