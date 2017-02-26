class MicropostsController < ApplicationController
  def create
     @micropost = current_user.microposts.build(micropost_params)
     @micropost.save!
  end
  
  def show
      @micropost = Micropost.find(params[:id])
  end

  def new
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end
  
  def index
      @microposts = Micropost.all
  end
  
  def update
    @micropost = Micropost.find(params[:id])
    @micropost.update(micropost_params)
    redirect_to microposts_path
  end

      private
      
        def micropost_params
          params.require(:micropost).permit(:title, :lecture, :professor, :price, :content, :user_id)
        end
end
