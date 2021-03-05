---
name: new_crud_template
about: new_crud_template
title: ''
labels: 1.機能追加
assignees: toshi-ue

---

## 概要
CRUDを作成

## タスク、変更点
- [ ] destroyは論理削除用gemを使用する
    > [「paranoia」は使用非推奨なので、論理削除に「discard」を使う（Rails） - ryotaku's Tech Blog](https://www.ryotaku.com/entry/2019/07/03/002004)
- [ ] 変更履歴を終えるように
- [ ] ログ追跡のためにpaper_trailを導入
   > [Railsで監査ログやバージョン管理機能を追加するPaperTrailの使い方をまとめてみた - Qiita](https://qiita.com/ko-he-8/items/bd8fae10b6852840691b)
