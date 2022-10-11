class ApplicationController < ActionController::API
  before_action :authenticate_user!

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { "error": "#{ current_user.email } is not authorized to do #{ request.method } action on #{ request.fullpath}." }, status: 401
  end
end
