###
gulp browser-sync gulp-plumber gulp-notify gulp-if gulp-webpack vinyl-named vinyl-source-stream gulp-uglify vinyl-buffer
###

# webpack -> gulp-webpack( config )
# babel-loader + preset-es2015

gulp = require('gulp')
browserSync = require('browser-sync')
plumber = require('gulp-plumber')
notify = require('gulp-notify')
gulpif = require('gulp-if')

# JavaScript
webpack = require('gulp-webpack')
named = require('vinyl-named')
source = require('vinyl-source-stream')
uglify = require('gulp-uglify')
buffer = require('vinyl-buffer')

config = require('../config')

gulp.task 'js', () =>
    errorMsg = () ->
        args = Array.prototype.slice.call(arguments)
        # Send error to notification center with gulp-notify
        notify.onError(
            title: 'Compile Error'
            message: '<%= error %>'
        ).apply(this, args)
        # Keep gulp from hanging on this task
        this.emit('end')
    
    gulp.src("#{config.src.js}*.coffee")
        .pipe named()
        .pipewebpack(
            module
                loaders: [
                    test: /\.coffee$/
                    loader: 'coffee-loader'
                    exclude: /node_modules/
                    options:
                        sourceMap: true
                ]
        )
        .on 'error', errorMsg
        .pipe plumber()
        .pipe buffer()
        .pipe gulpif(config.isBuildFlag, uglify(preserveComments: 'some')))
        .pipe gulp.dest(config.dist.js)
        .pipe browserSync.reload(stream: true)
        # jsonをコピー
        return gulp.src("#{config.src.js}*.json")
            .pipe gulpif(!config.isBuildFlag, gulp.dest(config.dist.js))