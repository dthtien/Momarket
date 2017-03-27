class ProductsController < ApplicationController
  def new
    @index = params[:index].to_i
    @post = Post.new
    @post.products.build
    render layout: false
  end
end
