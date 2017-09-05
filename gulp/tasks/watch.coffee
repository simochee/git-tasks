gulp = require('gulp')
watch = require('gulp-watch')

config = require('../config')

gulp.task 'watch', () =>

    # html
    gulp.watch [
        "#{config.src.html}**/*.pug"
        "!#{conifg.src.html}_template/**/*"
    ], () =>
        # 個別に更新
        config.isHtmlAllFlag = false
        gulp.start('pug')

    gulp.watch "#{config.src.html}_template/**/*.pug", () =>
        # テンプレートが変更されたら全体を更新
        config.isHtmlAllFlag = true
        gulp.start('pug')

    # stylesheets
    gulp.watch "#{config.src.css}**/*.styl", ['stylus']

    # javascripts
    gulp.watch "#{config.src.js}**/*", ['js']