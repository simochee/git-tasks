# Gulpタスクバックアップ

## Usage

最低限、`require-dir`パッケージが必要です。

### `gulpfile.coffee`

```coffeescript
dir = require 'require-dir'
dir( './gulp/tasks', recurse: true )
```

## 仕様

### 開発時

開発時のソースファイルは `src/` に置く

### 開発時

開発時のコンパイル先 `.temp/`

ローカルサーバーも `.temp/` をベースディレクトリとして起動する

### リリース時

リリース時のビルド先 `build/`