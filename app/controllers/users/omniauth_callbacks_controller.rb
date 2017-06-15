class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def slack
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user && @user.active_for_authentication?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Slack"
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = "Unable to sign in! Make sure you're using the right account."
      redirect_to root_path
    end
  end
end
