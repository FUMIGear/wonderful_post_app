class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  #↑現在のユーザ情報を入手するため必要か？→ログインしてなければログイン画面に移るメソッド

  # protected
  # def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  # end
    # devise_parameter_sanitizer.permit(:sign_in) do |user_params|
    #   user_params.permit(:username, :email)
    # end
end
