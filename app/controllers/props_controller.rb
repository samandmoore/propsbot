class PropsController < ApplicationController
  before_action :validate_slack_token!, except: :index
  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :authenticate_user!, only: :create

  def index
    @props = Prop.all.includes(:user, :recipients).order(created_at: :desc)
    @options = ['All Props', 'Props From Me', 'Props For Me']
  end

  # receive text payload and parse for user and whatever the comment is
  def create
    puts params[:user_name]
    message_processor = MessageProcessor.new(params[:text], params[:user_id], params[:user_name])

    render json: {
      text: message_processor.perform
    }.to_json
  end

  private

  def validate_slack_token!
    head :unauthorized unless params[:token] == ENV['SLACK_SLASH_COMMAND_TOKEN']
  end

end
