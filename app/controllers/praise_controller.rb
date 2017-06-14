class PraiseController < ApplicationController

  before_action :validate_slack_token!

  def index

  end

  def create

  end

  private

  def validate_slack_token!
    render status: :unauthorized unless params[:token] == ENV['SLACK_TOKEN']
  end

end
