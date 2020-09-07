# README

# Drawing_management (図面管理)


## 概要
設計会社向けの図面・業務管理アプリです。
煩雑になりがちな図面・業務の整理に役立ちます。
アプリを通して、業務を進めることで報連相を自動化することができます。
また、チャット機能もあり、ラインなどの情報漏洩が心配なサービスを使わずにオンラインで連絡を取り合うことができます。

## 使用技術
* Ruby 2.6.5
* Ruby on Rails 5.2.4
* JavaScript (jQuery)
* Bootstrap 4
* Action Cable
* AWS ( EC2 / S3 / Route53)
* Nginx, Unicorn
* RSpec
* Redis
* Git, GitHub

## 機能一覧
### 会社、会社の管理人登録
* サインアップ、ログインができる(devise)
* サインアップ時に、会社の情報と管理人の情報を同時に登録できる
### 社員招待機能
* エクセルの社員表から社員招待のメールを送信することができる(devise_invitable)
### 図面・タスク登録機能
* CRUD機能
* Ajaxによる非同期処理
### チーム作成機能
* 図面を管理するチームを作成する
* チームメンバーは同じ会社の社員から追加できる
### 質問投稿機能
* 社員は担当しているタスクに関する質問を投稿できる
* 質問を投稿すると、リアルタイムでチームメンバーに通知が届く(Action Cable)
### 検索機能
* 図面、質問、チャットを検索できる(ransack)
### いいね機能
* 質問をいいね登録することができる
* Ajaxによる非同期処理、いいね数を見ることができる
### チャット機能
* チーム内でリアルタイムチャットができる(Action Cable)
### 通知機能
* 質問投稿、タスクのレビジョン登録、タスク承認、タスク承認取り消し、チャット送信時に同じチームのメンバーに通知がリアルタイムで届く(Action Cable)
### カレンダー機能
* タスクの終了期限を一覧することができる
* マイページでは社員が持つタスク、チーム画面ではチームが持つタスクの期限を見ることができる


## カタログ設計
https://docs.google.com/spreadsheets/d/e/2PACX-1vRr6zEI-rcJk62sxnMVHxt6KLqAmlbLrNQvl_j7b2ZfgrvNM8xYEPtNlACFmcVUJ69KAoPRSA11helV/pubhtml

## テーブル設計
https://docs.google.com/spreadsheets/d/e/2PACX-1vTE9iMSOvJIqfx8oTDBhdpBCYrMMFj8KMzEcqprUiKZr6qGeEyOigq19pVeRiYwtiShkcabqgxPmb1n/pubhtml

## サービス構成図


## ER図
file:///C:/Users/kohei/workspace/drawing_management/docs/er.png?time=1599461211549

## 画面遷移図
docsフォルダ内のscreen_transition_diagram.png

## 画面ワイヤーフレーム
https://docs.google.com/spreadsheets/d/e/2PACX-1vSVeED-vB260a4aXEFcnhkQBUennwcA-jOv6PsYx10FlV1xCK1KhEbVSq8SiqadgH-BvPjASesQ8cd4/pubhtml

## 使用gem
* aws-sdk-s3
* bootstrap
* coffee-rails
* devise
* devise-i18n
* devise_invitable
* dotenv-rails
* faker
* jbuilder
* jquery-rails
* kaminari-bootstrap
* mini_magick
* mini_racer
* pg
* puma
* rails
* ransack
* redis-rails
* roo
* rubocop
* simple_calendar
* unicorn
