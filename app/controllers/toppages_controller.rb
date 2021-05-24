class ToppagesController < ApplicationController
  def index
        @items = Item.limit(3).order('id DESC')
  end
end


