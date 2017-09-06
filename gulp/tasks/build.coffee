###
del run-sequence
###

del = require('del')
runSequence = require('run-sequence')

config = require('../config')

gulp.task 'clean:build', () =>
    return del ['build']

# リリース時はこれを実行する
gulp.task 'build', ['clean:build'], (callback) =>
    config.isBuildFlag = true
    # pathの上書き
    config.dist.root = config.build.root
    config.dist.html = config.build.html
    config.dist.img = config.build.img
    config.dist.css = config.build.css
    config.dist.js = config.build.js

    runSequence(
        # defaultと同様の処理を実行
        'task0'
        [
            'task1'
            'task2'
        ]
        callback
    )