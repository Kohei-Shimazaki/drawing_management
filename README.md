# README

# Drawing_management (図面管理)

## 概要
設計会社向けの図面・業務管理アプリです。
煩雑になりがちな図面・業務の整理に役立ちます。
アプリを通して、業務を進めることで報連相を自動化することができます。
また、チャット機能もあり、ラインなどの情報漏洩が心配なサービスを使わずにオンラインで連絡を取り合うことができます。

## バージョン
Ruby 2.6.5 Rails 5.2.4

## 機能一覧
* 優先度：高
  * 会社登録機能(就職term・devise)
  * 社員登録機能(就職term・rails_admin)
  * プロジェクト・図面・タスク・エビデンス登録機能
  * チーム作成機能
  * 質問投稿機能
  * 通知機能(カリキュラム外・ポリモーフィック)
  * 図面検索機能(カリキュラム外・gem randsack)
  * チャット機能(就業term・メッセージ機能)
* 優先度：中
  * リファレンス登録機能
* 優先度：低
  * グッド機能
  * ゲスト登録機能

## カタログ設計
https://docs.google.com/spreadsheets/d/e/2PACX-1vRr6zEI-rcJk62sxnMVHxt6KLqAmlbLrNQvl_j7b2ZfgrvNM8xYEPtNlACFmcVUJ69KAoPRSA11helV/pubhtml

## テーブル設計
https://docs.google.com/spreadsheets/d/e/2PACX-1vTE9iMSOvJIqfx8oTDBhdpBCYrMMFj8KMzEcqprUiKZr6qGeEyOigq19pVeRiYwtiShkcabqgxPmb1n/pubhtml

## ER図
docsフォルダ内のer.jpg

## 画面遷移図
docsフォルダ内のscreen_transition_diagram.png

## 画面ワイヤーフレーム
https://docs.google.com/spreadsheets/d/e/2PACX-1vSVeED-vB260a4aXEFcnhkQBUennwcA-jOv6PsYx10FlV1xCK1KhEbVSq8SiqadgH-BvPjASesQ8cd4/pubhtml

## 使用予定gem
* whenever
* devise
* rails_admin
* banken
* randsack
* simple_calendar
* roo
* carrierwave
* mini_magick
* fog-aws
