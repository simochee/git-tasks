###
gulp run-sequence
###

gulp = require('gulp')
runSequence = require('run-sequence')

#　デフォルト処理
gulp.task 'default', (callback) =>
    runSequence(
        # 依存関係があるタスク
        'task0'
        # 依存関係のない残りのタスク
        [
            "task1"
            "task2"
        ]
        callback
    )