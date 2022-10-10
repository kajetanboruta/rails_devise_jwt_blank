class Users::SessionsController < Devise::SessionsController
  respond_to :json
  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.valid_password?(params[:password])
      sign_in(@user)
      render json: @user, status: :ok
    else
      render json: 'login failed'
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :ok
  end
end
