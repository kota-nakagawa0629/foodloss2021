class TradesController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    current_user.trade(item)
    flash[:success] = '購入希望に追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    item = Item.find(params[:item_id])
    current_user.untrade(item)
    flash[:success] = '購入希望を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  
   private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  
  
  
  
  
  
end
