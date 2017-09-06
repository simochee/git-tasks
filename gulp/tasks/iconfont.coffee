###
gulp gulp-iconfont gulp-consolidate
###

###
// _iconfont.styl with lodash
@font-face
    font-family "<%= fontName %>"
    src url('<%= fontPath %><%= fontName %>.eot')
    src url('<%= fontPath %><%= fontName %>.eot?#iefix') format('eot'), url('<%= fontPath %><%= fontName %>.woff') format('woff'), url('<%= fontPath %><%= fontName %>.ttf') format('truetype'), url('<%= fontPath %><&= fontName %>.svg#<%= fontName %>') format('svg')
    font-weight normal
    font-style normal

<% _.each(gliphs, function(glyph) { %>$<%= glyph.name %> '\<%= glyph.unicode[0].charCodeAt(0).toString(16).toUpperCase() %>'
<% }) %>

iconfont($iconfontName)
    content: $iconfontName
    font-family '<%= fontName %>'
    font-style normal
    font-weight normal
    line-height 1.05
    text-indent 0
    text-align center
    speak none
    -webkit-font-smoothing antialiased
    -moz-osx-font-smoothing grayscale
###

###
アイコンsvgへのパス
/path/to/src/fonts/_icons/
###

gulp = require('gulp')

# icon font
iconfont = require('gulp-iconfont')
consolidate = require('gulp-consolidate')

gulp.task 'iconfont', (callback) =>
    gulp.src([
        "#{config.src.root}fonts/_icons/*.svg"
    ])
    .pipe iconfont(
        fileName: 'iconfont'
        fixedWidth: true
        startCodepoint: 0xF001
    )
    .on 'glyphs', (glyphs, options) =>
        gulp.src("#{config.src.root}fonts/_template/_iconfont.styl")
            .pipe consolidate('lodash',
                glyphs: glyphs
                fontName: 'iconfont'
                fontPath: '../fonts/'
                className: 'iconfont'
            )
            .pipe gulp.dest("#{config.src.css}_partial/")
            .on 'end', callback
    .pipe gulp.dest("#{config.dist.root}fonts/")