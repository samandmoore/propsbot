class PraiseController < ApplicationController

  def index

    render json: {
      hello: 'index'
    }.to_json
  end
end
