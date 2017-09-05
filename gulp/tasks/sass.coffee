###
gulp gulp-if browser-sync gulp-plumber gulp-notify gulp-sass gulp-autoprefixer gulp-sourcemaps gulp-combine-mq
###

gulp = require('gulp')
gulpif = require('gulp-if')
browserSync = require('browser-sync')
plumber = require('gulp-plumber')
notify = require('gulp-notify')

# Stylesheets
sass = require('gulp-sass')
autoprefixer = require('gulp-autoprefixer')
sourcemaps = require('gulp-sourcemaps')
combineMq = require('gulp-combine-mq')  # Media Queryをひとつにまとめる

config = require('../config')


# sassコンパイル
gulp.task 'sass', () =>
    gulp.src("#{config.src.css}**/*.{sass,scss}")
        # エラーメッセージを通知
        .pipe plumber(
            errorHandler: notify.onError('Error: <%= error.message %>')
        )
        # 開発向けの手続き
        .pipe gulpif(!config.isBuildFlag, sourcemaps.init())
        .pipe gulpif(!config.isBuildFlag,
            # mapがずれるためcompressedにしない
            sass(
                outputStyle: 'expanded'
            )),
            # Buildの時はcompressed
            sass(
                outputStyle: 'compressed'
            )
        # Build時のみメディアクエリをまとめる
        .pipe gulpif(config.isBuildFlag,
            combineMq(
                beautify: false
            )
        )
        # ベンダープレフィックスを追加
        .pipe autoprefixed(
            browsers: [
                'last 2 versions'
                'ie 9'
                'ios 6'
                'android 4'
            ]
            cascade: false
        )
        # 開発時にはsourcemapを生成
        .pipe gulpif(!config.isBuildFlag, sourcemaps.white('.'))
        .pipe gulp.dest(config.dist.css)
        .pipe browserSync.stream()