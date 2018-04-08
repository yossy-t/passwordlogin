class SessionsController < ApplicationController
  def new
  end

  def create
    password = params[:session][:password]
    if login(password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to :root
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(password)
    @user = User.find_by(id: 1)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
