class MicropostsController < ApplicationController

  AWS.config(access_key_id: 'AKIAIOMG4DZ5N46SAPDQ', secret_access_key: '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', region: 'ap-northeast-1')

    
    
  def create
     @micropost = current_user.microposts.build(micropost_params)
     user_id = params[:micropost][:user_id]
     file = params[:micropost][:photo]
    
     s3 = AWS::S3.new
     bucket = s3.buckets['text-miyagi']
     fileS3 = micropost_params[:file]
     
     file_name = fileS3.original_filename
     file_full_path="micropost_image/"+file_name
     
     object = bucket.objects[file_full_path]
     object.write(fileS3 ,:acl => :public_read)
     @micropost.file_name="http://s3-ap-northeast-1.amazonaws.com/text-miyagi/micropost_image/#{file_name}"
     
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
          params.require(:micropost).permit(:title, :lecture, :professor, :price, :content, :user_id, :photo, :file)
        end
end
