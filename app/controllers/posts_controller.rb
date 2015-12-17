class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only:[:edit, :update]


  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show
    @comment = Comment.new

  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was saved :)"
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit; end

  def update
   
    if @post.update(post_params)
      flash[:notice] = "Your post was updated"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def vote
   @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted"
        else
          flash[:error] = "You can only vote on that once"
        end
        redirect_to :back
      end
      format.js
    end
  end

  private
  
  def post_params
    params.require(:post).permit(:url, :description, :title, category_ids: [])
  end

  def set_post
    @post = Post.find_by slug:params[:id]
  end

  def require_creator
   access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end
end