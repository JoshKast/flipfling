#
# Node executable for scoring app
# Sets up web server and routing
#

port = 8080 # web server

express = require 'express'
require 'express-resource'

# Open DB connection defined in config
mongoose = require 'mongoose'
mongoose.connect require('./conf/mongodb').conn_str()

require './models/scores'
Score = mongoose.model 'Score'

# Start web server with some express helpers for session management
#   and parsing forms
app = express.createServer()
app.configure ->
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.session( secret:'secret' )
    app.use express.static( __dirname + '/static' )
    app.use express.errorHandler
        dumpExceptions:true
        showStack:true

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

# Make session accessible in the views
app.dynamicHelpers
    session: (req,res) ->
        return req.session

# Root handler redirects to course list
app.get '/', (req,res) ->
    res.redirect('/courses')

# Handlers for login/logout
require('./modules/sessions').setup app

# Disallow non-iphone/ipod
#app.get /\/.*/, (req,res,next) ->
#    if req.headers['user-agent'].match /(iPhone|iPod)/
#        next()
#        return
#    res.render 'mobile_only'

# Access control for /courses - require login to add/edit
publicCourseRoutes = [
    /^\/courses$/
    /^\/courses\/(?!new)[a-z0-9]+$/
    /^\/courses\/(?!new)[a-z0-9]+\/play$/
    /^\/courses\/(?!new)[a-z0-9]+\/scores.*$/
]
app.get /\/courses.*/, (req,res,next) ->
    if req.session.user? and req.session.user.role == 'admin'
        next()
        return
    for allowedRoute in publicCourseRoutes
        if req.url.match(allowedRoute)
            next()
            return
    res.redirect('/sessions/new?redir='+req.url)

# CRUD handlers for courses
courses = app.resource 'courses', require('./modules/courses')

# Scores nested under courses
scores = app.resource 'scores', require('./modules/scores')
courses.add scores

# Actually start the server
app.listen(port)

# Starting a new round removes saved scores for the course
# TODO: put this in the courses module
app.get '/courses/:id/play', (req,res) ->

    Score.purge req.params.id, ->
        res.redirect('/courses/'+req.params.id+'/scores/new')

console.log "Server running on port "+port