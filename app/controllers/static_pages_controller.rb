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

  def ban
    if current_user.admin?
      u = User.where(id: params[:id]).first
      if u
        u.ban = true
        u.save!

        redirect_to users_path, alert: "Пользователь #{u.email} был заблокирован"
      else
        redirect_to users_path, alert: "Пользователь #{u.email} не найден!"
      end
    else
      flash[:denger]="У вас нет доступа к данной функции!"
    end
  end

  def unban
    if current_user.admin?
      u = User.where(id: params[:id]).first
      if u
        u.ban = false
        u.save!

        redirect_to users_path, alert: "Пользователь #{u.email} был разблокирован!"
      else
        redirect_to users_path, alert: "Пользователь #{u.email} не найден!"
      end
    else
      flash[:denger]="У вас нет доступа к данной функции!"
    end
  end

end
