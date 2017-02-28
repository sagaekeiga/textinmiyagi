class PagesController < ApplicationController

  def index
    @microposts = Micropost.all.sort_by(&:created_at).reverse
    @q = Micropost.search(params[:q])
    @search_microposts = @q.result(distinct: true)
  end
  
  def show
  end
  
  def index_smart_phone
  end
  
end
