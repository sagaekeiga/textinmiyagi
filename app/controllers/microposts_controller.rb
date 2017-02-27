class MicropostsController < ApplicationController
  def create
     @micropost = current_user.microposts.build(micropost_params)
     user_id = params[:micropost][:user_id]
     file = params[:micropost][:photo]
    
     name = file.original_filename
     @micropost.photo = name
     @micropost.save!

     if !['.jpg', '.gif', '.png'].include?(File.extname(name).downcase)
       msg = 'アップロードできるのは画像ではありません'
     elsif file.size > 10.megabyte
       msg = 'アップロードは10メガバイトまでです'
     else
       dir_path = "public/micropost_image/#{@micropost.id}"
       FileUtils.mkdir_p(dir_path) unless FileTest.exist?(dir_path)
       
       File.open("public/micropost_image/#{@micropost.id}/#{name}", 'wb') { |f| f.write(file.read) }
       msg = "#{name}のアップロードに成功しました"
     end

     render :text => msg
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
    redirect_to micropost_path
  end

    def destroy
        @micropost = Micropost.find(params[:id])
        if @micropost.delete
         flash[:success] = "deleted"
        end
        redirect_to root_path
    end
    
      private
      
        def micropost_params
          params.require(:micropost).permit(:title, :lecture, :professor, :price, :content, :user_id)
        end
end
