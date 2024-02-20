class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
  
    def new
      @post = Post.new
    end
  
    def create
      @post = current_user.posts.build(post_params) # Builds the post with user_id set to current_user.id
      if @post.save
        redirect_to posts_path, notice: 'Post was successfully created.' # Redirects to the index action
      else
        render :new
      end
    end
  
    def index
      @posts = Post.all.order(created_at: :desc) # Retrieves all posts and orders them by creation date
    end
  
    private
  
    def post_params
      params.require(:post).permit(:title, :body)
    end
  
    def authenticate_user!
      redirect_to new_user_session_path, alert: "You must be signed in to do that." unless user_signed_in?
    end
  end
  