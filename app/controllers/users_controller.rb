class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :likes]
  before_action :correct_user, only: [:likes]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    if @current_user.user?
      @user = User.find(params[:id])
      @items = @user.items.order(id: :desc).page(params[:page])
      counts(@user)
    end
    if @current_user.shop?
      @user = User.find(params[:id])
      @items = Item.where(user_id: current_user.id)
      counts(@user)
    end
  end


  def new
     @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  

    def likes
      @user = User.find(params[:id])
      @items = @user.likes.page(params[:page])
      counts(@user)
    end


    def likeds
      @user = User.find(params[:id])
      @items = current_user.items.select{|item| Trade.where.not(user_id: current_user.id).pluck(:item_id).include?(item.id)} # お気に入り登録された商品のみを抽出する
      counts(@user) 
    end


  private

  def user_params
    params.require(:user).permit(:category, :name, :address, :email, :password, :password_confirmation)
  end

  def correct_user
      @user = User.find(params[:id])
      unless @user == current_user
      redirect_to "/users/#{@user.id}"
      end
  end

end

