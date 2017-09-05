###
gulp
###

gulp = require('gulp')

config = require('../config')

gulp.task 'task', () =>
    return gulp.src(
        config.copy,
        base: config.src.root
    )
    .pipe gulp.dest(config.dist.root)