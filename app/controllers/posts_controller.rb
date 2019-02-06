class PostsController < ApplicationController

  before_action :require_login

  def new 
    @post = Post.new
    #@subs = Sub.all
  end 

  def create 
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to sub_url(params[:post][:sub_ids][-1])
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end 

  def show 
    @post = Post.find(params[:id])
  end 

  def edit 
    @post = Post.find(params[:id])
    #@subs = Sub.all
  end 

  def update 
    @post = current_user.posts.find(params[:id])
    @post.user_id = current_user.id
    if @post.update_attributes(post_params)
      redirect_to sub_url(params[:post][:sub_ids][-1])
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end 

  def destroy 
    post = Post.find(params[:id])
    post.destroy
    redirect_to sub_url(params[:post][:sub_ids][-1])
  end 

  private 

  def post_params 
    params.require(:post).permit(:title, :url, :content, :user_id, sub_ids: [])
  end 

end
