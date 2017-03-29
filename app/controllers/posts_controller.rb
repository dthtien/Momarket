class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]
  before_action :authenticate, except: [:index, :show]
  # Get
  def index 
    @posts = Post.all
  end

  #Get
  def show
  end

  # Get
  def new
    @post = Post.new
    @post.products.build
  end

  # Get 
  def edit
    @post = current_user.posts.find(params[:id])
  end


  # Post
  def create
    @post = current_user.posts.new(post_params)
    # debugger

    if have_no_products? || !@post.save
      flash.now[:alert] = 'Your post have to have at least 1 product!'
      # Hit post for rendering its own errors
      @post.valid?
      # Dislay at least 1 product from
      @post.products.build if have_no_products?
      render :new
    else
      flash[:notice] = 'Create successfully'
      redirect_to @post
    end
  end


  # Patch/put
  def update
    @post.user = current_user

    if @post.update(post_params)
     flash[:notice] = 'Update successfully'
     redirect_to @post
   else
    flash.now[:alert] = 'Some errors happend' 
    render :new
  end
end


 # Delete
 def destroy
   @post.destroy
   flash[:notice] = "This post has been destroyed"
   redirect_to root_path
 end

 private
   def post_params
    params.require(:post).permit(:title, 
      products_attributes: [:id, :name, :price, :description, :_destroy,
        :category_id, :product_image])
  end

  def set_post
    @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Page not found"
      redirect_to root_path
   
  end
  def authorize
    if @post.user != current_user
      redirect_to root_path
      flash[:alert]= "You have no permission !" 
    end 
  end

  def rejected_products_size
    params[:post][:products_attributes].count do |index, attr|
      attr[:_destroy] != 'false' || 
      attr.slice(:name, :price, :description).all? { |k, v| v.blank? }
    end
  end

  def have_no_products?
    (params[:post][:products_attributes].size - rejected_products_size).zero?
  end

end