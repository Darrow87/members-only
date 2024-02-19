class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
  
    def new
      @post = Post.new
    end
  
    def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
    end
  
    def index
      @posts = Post.all
    end
  
    private
  
    def post_params
      params.require(:post).permit(:title, :body)
    end
  
    def authenticate_user!
      redirect_to new_user_session_path, alert: "You must be signed in to do that." unless user_signed_in?
    end
  end
  