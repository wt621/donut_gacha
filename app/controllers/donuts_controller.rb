class DonutsController < ApplicationController
  def index
  end

  def gacha
    quantity = Integer(params[:quantity].to_s, 10)

    unless quantity.between?(1, 10)
      return render json: { error: "個数は1〜10個で指定してください。" },
                    status: :bad_request
    end

    all_donuts = Donut.all

    if all_donuts.empty?
      return render json: { error: "抽選できるドーナツがありません。" },
                    status: :unprocessable_entity
    end

    # 指定された個数分、ランダムにドーナツを選ぶ
    results = Array.new(quantity) { all_donuts.sample }

    response_data = results.map do |donut|
      {
        name: donut.name,
        group_name: donut.group_name,
        price: donut.price
      }
    end

    render json: response_data
  rescue ArgumentError
    render json: { error: "個数は1〜10個の数字で指定してください。" },
           status: :bad_request
  end
end
