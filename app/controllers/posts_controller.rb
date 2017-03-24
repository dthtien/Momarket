class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  def show
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = 'Create successfully'
      redirect_to @post
    else
      flash.now[:alert] = 'Some errors happend'
      render :new
    end
  end

  def edit

  end

  def update
   if @post.update(post_params)
     flash[:notice] = 'Update successfully'
     redirect_to @post
   else

   end
 end


 private
  def post_params
    params.require(:post).permit(:title)
  end

def set_post
  @post = Post.find(params[:id])
end
end