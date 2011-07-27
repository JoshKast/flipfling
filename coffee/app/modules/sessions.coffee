#
# Handlers for session login/logout
#

require '../models/users'
Users   = require('mongoose').model('User')

# setup() had to be called by main app
exports.setup = (app) ->

    # Show login form
    app.get '/sessions/new', (req,res) ->
        res.render 'sessions/new', locals: redir:req.query.redir

    # Check login and assign session user, or show login failed message
    app.post '/sessions', (req,res) ->
        Users.authenticate req.body.login,req.body.password, (user) ->
            if user
                req.session.user = user
                res.redirect( req.body.redir || '/courses' )
            else
                req.flash('warn','Login failed')
                res.render 'sessions/new',
                    locals: redir:req.body.redir

    # End session and return to login form
    app.get '/sessions/destroy', (req,res) ->
        delete req.session.user
        res.redirect '/'
