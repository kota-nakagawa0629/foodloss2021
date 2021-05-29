class ItemsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    if current_user.present? && current_user.shop?
      @items = current_user.items
    else
      @items = Item.order(id: :desc).page(params[:page])
    end
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = '商品を投稿しました。'
      redirect_to @item
    else
      @items = current_user.items.order(id: :desc).page(params[:page])
      flash.now[:danger] = '商品の投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @item.destroy
    flash[:success] = '商品を削除しました。'
    redirect_back(fallback_location: root_path)
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :address, :content, :price, :photo, :stock)
    end

    def correct_user
        @item = current_user.items.find_by(id: params[:id])
        unless @item
          redirect_to root_url
        end
    end
    
    
    
    
end
