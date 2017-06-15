class PraiseController < ApplicationController
  before_action :validate_slack_token!, except: :index
  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :authenticate_user!, only: :create

  def index
    @praises = Praise.all
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
    head :unauthorized unless params[:token] == ENV['SLACK_SLASH_COMMAND_TOKEN']
  end

end
