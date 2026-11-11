# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 既存のデータを削除
Donut.destroy_all

# パイ（オレンジ）
Donut.create!(name: 'きのことチキンのクリームシチューパイ', group_name: 'pie', price: 259)
Donut.create!(name: 'ミートソースのラザニア風パイ', group_name: 'pie', price: 259)
Donut.create!(name: 'つぶつぶコーンクリームパイ', group_name: 'pie', price: 259)
Donut.create!(name: 'エビグラタンパイ', group_name: 'pie', price: 248)
Donut.create!(name: 'ホット・セイボリーパイ BBQ フランクフルト', group_name: 'pie', price: 248)
Donut.create!(name: 'ホット・スイーツパイ りんご', group_name: 'pie', price: 248)

# ドーナツ（黄色）
Donut.create!(name: 'ポン・デ・リング', group_name: 'pon-de', price: 172)
Donut.create!(name: 'ポン・デ・黒糖', group_name: 'pon-de', price: 172)
Donut.create!(name: 'ポン・デ・ストロベリー', group_name: 'pon-de', price: 183)

# オールドファッション（薄い茶色）
Donut.create!(name: 'オールドファッション', group_name: 'old-fashion', price: 172)
Donut.create!(name: 'チョコファッション', group_name: 'old-fashion', price: 183)
Donut.create!(name: 'オールドファッション ハニー', group_name: 'old-fashion', price: 183)

# フレンチクルーラー（白）
Donut.create!(name: 'フレンチクルーラー', group_name: 'french', price: 172)
Donut.create!(name: 'エンゼルフレンチ', group_name: 'french', price: 183)
Donut.create!(name: 'ストロベリーカスタードフレンチ', group_name: 'french', price: 183)

# イーストドーナツ（ピンク）
Donut.create!(name: 'ハニーディップ', group_name: 'yeast', price: 172)
Donut.create!(name: 'シュガーレイズド', group_name: 'yeast', price: 172)
Donut.create!(name: 'チョコリング', group_name: 'yeast', price: 183)
Donut.create!(name: 'ストロベリーリング', group_name: 'yeast', price: 183)
Donut.create!(name: 'エンゼルクリーム', group_name: 'yeast', price: 183)
Donut.create!(name: 'カスタードクリーム', group_name: 'yeast', price: 183)

# チョコレート（濃い茶色）
Donut.create!(name: 'チョコレート', group_name: 'chocolate', price: 172)
Donut.create!(name: 'ダブルチョコレート', group_name: 'chocolate', price: 183)
Donut.create!(name: 'ゴールデンチョコレート', group_name: 'chocolate', price: 183)
Donut.create!(name: 'ココナツチョコレート', group_name: 'chocolate', price: 183)

# バラエティドーナツ（薄いピンク）
Donut.create!(name: 'ハニーチュロ', group_name: 'variety', price: 172)
Donut.create!(name: 'ドーナツポップ8個入り', group_name: 'variety', price: 313)
Donut.create!(name: 'もっちりフルーツスティックハニー', group_name: 'variety', price: 172)
Donut.create!(name: 'もっちりフルーツスティックシナモン', group_name: 'variety', price: 172)

# マフィン（橙色）
Donut.create!(name: 'しっとりマフィン バター風味', group_name: 'muffin', price: 248)
Donut.create!(name: 'しっとりマフィン チョコ', group_name: 'muffin', price: 248)

# アレルギー特定原材料不使用ドーナツ（薄緑）
Donut.create!(name: 'ふかふか焼きドーナッツ', group_name: 'allergy-free', price: 442)

puts "#{Donut.count} 件のドーナツを登録しました！"
