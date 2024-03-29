# Kijiコレ

<!-- TABLE OF CONTENTS -->

## 📌 目次

- [:book: プロジェクトについて](#book-プロジェクトについて)
  - [概要](#概要)
  - [機能](#機能)
- [:computer: 技術](#computer-技術)
- [:hammer: 環境構築](#hammer-環境構築)
  - [事前準備](#事前準備)
  - [ビルド手順](#ビルド手順)

## :book: プロジェクトについて

複数の記事投稿サービスから特定アカウントの記事をまとめて取得するiOSアプリ

### 概要

- このアプリを作成した理由
  - Qiita、Zenn、Mediumなど複数のブログサービスを使っているユーザーは多いのではないしょうか
  - 特定のユーザーの記事を一気に閲覧したい場合、複数のブログサービスを開いておかなければいけないのは大変です
  - アカウント名が同じであれば、複数のブログサービスから同じユーザーの記事を一気に閲覧することができるように、このアプリを作りました

### 機能

- 特定のユーザーの記事を閲覧
- 記事をお気に入り登録する

[(トップに戻る)](#-目次)

## :computer: 技術

- Xcode 13.4.1
- Swift
- Firebase SDK
  - Firebase Analytics
  - Firebase Firestore
  - FIrebase Crashlystics
- LicensePlist
- Realm
- SVProgressHUD
- lottie-ios

[(トップに戻る)](#-目次)

## :hammer: 環境構築

### 事前準備

- Cocoapods がインストールされていること

### ビルド手順

- ライブラリをインストールする
  - `pod install`
- ビルドする

[(トップに戻る)](#-目次)