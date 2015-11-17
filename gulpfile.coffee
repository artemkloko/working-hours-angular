gulp = require 'gulp'
connect = require 'gulp-connect'
karma = require 'karma'

# testing
#########

gulp.task 'test', (done) ->
    karmaServer = karma.Server
    new karmaServer({
        configFile: __dirname + '/karma.conf.js'
    }, done).start()

# development
#########

gulp.task 'dev', ->
    connect.server
        root: 'public'
        livereload: true
        fallback: 'public/index.html'

watchFiles = [
    'gulpfile.coffee'
    'public/*.html'
    'public/static/js/*.js'
    'public/static/js/*.coffee'
    'public/static/js/modules/*/*.js'
    'public/static/js/modules/*/*.coffee'
    'public/static/partials/*/*.html'
]

gulp.task 'reload', ->
    gulp.src watchFiles
        .pipe connect.reload()

gulp.task 'watch', ->
    gulp.watch watchFiles, ['reload']

gulp.task 'default', ['dev', 'watch']