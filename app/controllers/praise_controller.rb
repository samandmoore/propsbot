class PraiseController < ApplicationController

  before_action :validate_slack_token!
  skip_before_action :verify_authenticity_token

  def index
    render json: {
      praises: Praise.all
    }.to_json
  end

  # receive text payload and parse for user and whatever the comment is
  def create
    message_processor = MessageProcessor.new(params[:text], params[:user_id])

    render json: {
      text: message_processor.perform
    }.to_json
  end

  private

  def validate_slack_token!
    head :unauthorized unless params[:token] == ENV['SLACK_TOKEN']
  end

end
