class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]
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
    @post = Post.new(post_params)
    @post.user = current_user

    # debugger

    if have_products? || !@post.save
      flash.now[:alert] = 'Some errors happend' 
      @post.products.build if have_products?
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
      products_attributes: [:id, :name, :price, :description, :_destroy])
  end

def set_post
  @post = Post.find(params[:id])
end
def authorize
  if @post.user != current_user
    redirect_to root_path
    flash[:alert]= "You have no permission !" 
  end 
end

def rejected_products_size
  params[:post][:products_attributes]
    .count { |index, attr| attr[:_destroy] != '0' }
end

def have_products?
  (params[:post][:products_attributes].size - rejected_products_size).zero?
end

end