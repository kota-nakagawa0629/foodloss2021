class TradesController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    current_user.trade(item)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    item = Item.find(params[:item_id])
    current_user.untrade(item)
    flash[:success] = 'お気に入りの追加を解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
