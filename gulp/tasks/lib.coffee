###
gulp browser-sync gulp-plumber gulp-notify
###

gulp = require('gulp')
browserSync = require('browser-sync')
plumber = require('gulp-plumber')
notify = require('gulp-notify')

# JavaScripts
uglify = require('gulp-utlify')
concat = require('gulp-concat')

config = require('../config')

gulp.task 'lib', () =>
    gulp.src(config.src.lib)
        .pipe plumber(
            errorHandler: notify.onError("Error: <%= error.message %>")
        )
        .pipe uglify(
            # minify & コメントを残す
            preserveComments: 'some'
        )
        .pipe concat('lib.js')
        .pipe gulp.dest(config.dist.js)
        .pipe browser.reload(stream: true)