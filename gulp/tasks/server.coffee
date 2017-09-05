gulp = require('gulp')
browserSync = require('browser-sync')

config = require('../config')

gulp.task 'server', () =>
    browserSync(
        notify: false
        server:
            baseDir: config.dist.root
    )