class Donut
  attr_reader :name, :group_name, :price

  def initialize(name:, group_name:, price:)
    @name = name
    @group_name = group_name
    @price = price
    freeze
  end

  DATA = [
    # パイ
    new(name: "きのことチキンのクリームシチューパイ", group_name: "pie", price: 259),
    new(name: "ミートソースのラザニア風パイ", group_name: "pie", price: 259),
    new(name: "つぶつぶコーンクリームパイ", group_name: "pie", price: 259),
    new(name: "エビグラタンパイ", group_name: "pie", price: 248),
    new(name: "ホット・セイボリーパイ BBQ フランクフルト", group_name: "pie", price: 248),
    new(name: "ホット・スイーツパイ りんご", group_name: "pie", price: 248),

    # ポン・デ・リング
    new(name: "ポン・デ・リング", group_name: "pon-de", price: 172),
    new(name: "ポン・デ・黒糖", group_name: "pon-de", price: 172),
    new(name: "ポン・デ・ストロベリー", group_name: "pon-de", price: 183),

    # オールドファッション
    new(name: "オールドファッション", group_name: "old-fashion", price: 172),
    new(name: "チョコファッション", group_name: "old-fashion", price: 183),
    new(name: "オールドファッション ハニー", group_name: "old-fashion", price: 183),

    # フレンチクルーラー
    new(name: "フレンチクルーラー", group_name: "french", price: 172),
    new(name: "エンゼルフレンチ", group_name: "french", price: 183),
    new(name: "ストロベリーカスタードフレンチ", group_name: "french", price: 183),

    # イーストドーナツ
    new(name: "ハニーディップ", group_name: "yeast", price: 172),
    new(name: "シュガーレイズド", group_name: "yeast", price: 172),
    new(name: "チョコリング", group_name: "yeast", price: 183),
    new(name: "ストロベリーリング", group_name: "yeast", price: 183),
    new(name: "エンゼルクリーム", group_name: "yeast", price: 183),
    new(name: "カスタードクリーム", group_name: "yeast", price: 183),

    # チョコレート
    new(name: "チョコレート", group_name: "chocolate", price: 172),
    new(name: "ダブルチョコレート", group_name: "chocolate", price: 183),
    new(name: "ゴールデンチョコレート", group_name: "chocolate", price: 183),
    new(name: "ココナツチョコレート", group_name: "chocolate", price: 183),

    # バラエティドーナツ
    new(name: "ハニーチュロ", group_name: "variety", price: 172),
    new(name: "ドーナツポップ8個入り", group_name: "variety", price: 313),
    new(name: "もっちりフルーツスティックハニー", group_name: "variety", price: 172),
    new(name: "もっちりフルーツスティックシナモン", group_name: "variety", price: 172),

    # マフィン
    new(name: "しっとりマフィン バター風味", group_name: "muffin", price: 248),
    new(name: "しっとりマフィン チョコ", group_name: "muffin", price: 248)
  ].freeze

  def self.all
    DATA
  end
end
