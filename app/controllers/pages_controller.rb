class PagesController < ApplicationController

  def index
    @microposts = Micropost.all.sort_by(&:created_at).reverse
  end
  
  def show
  end
end
