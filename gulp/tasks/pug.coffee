###
gulp gulpif browser-sync gulp-plumber gulp-notify gulp-cached gulp-pug
###

gulp = require('gulp')
gulpif = require('gulp-if')
browserSync = require('browser-sync')
plumber = require('gullp-plumber')
notify = require('gulp-notify')
cached = require('gulp-cached')

# Pug
pug = require('gulp-pug')

config = require('../config')

gulp.task 'pug', () =>
    rootPath = "#{config.root}#{config.src.root}"
    gulp.src([
        "#{config.src.html}**/!(_).pug"
        "!#{config.src.html}_template/**/*"
    ])
    .pipe plumber(
        errorHander: notify.onError("Error: <%= error.message %>")
    )
    # 変更されたファイルのみコンパイル。html全体の時は使わない
    .pipe gulpif(!config.isHtmlAllFlag, cached('pug'))
    .pipe pug(
        # 出力ファイルが整形される
        pretty: true
        # includeなどをルートパスで書けるようにする
        basedir: rootPath
        # pugに変数を渡す場合
        locals:
            rootPath: rootPath
    )
    .pipe gulp.dest(config.dist.html)
    .on('end', browserSync.reload)