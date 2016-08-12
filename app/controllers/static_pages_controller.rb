class StaticPagesController < ApplicationController

  def index
  end

  def show
    @users = User.all
    unless user_signed_in?
      flash[:danger]="Для просмотра всех пользователей требуется войти в существующий аккаунт, либо зарегистрироваться"
      redirect_to root_path
    end
  end

end
