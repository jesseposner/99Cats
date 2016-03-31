class SessionsController < ApplicationController

  before_action :redirect_to_cats, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    if @user.nil?
      @user = User.new
      flash.now[:errors] = ["Invalid User/Password"]
      render :new
    else
      flash[:notice] = ["Successfully logged in"]
      log_in!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    current_user.reset_session_token! if current_user
    log_out!
    redirect_to new_session_url
  end

  def redirect_to_cats
    redirect_to cats_url if current_user
  end

end
