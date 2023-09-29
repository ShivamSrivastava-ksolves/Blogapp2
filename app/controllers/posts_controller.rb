class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = Post.includes(:comments).order('posts.created_at DESC').page(params[:page])
  end

  # myposts
  def myposts
    @posts = Post.all
  end

  #.....................................................................................................................

  def like
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
      @post.decrement!(:like)
    else
      @post.likes.create(user: current_user)
      @post.increment!(:like)
    end

    # @post = Post.find(params[:post_id])
    # @post.increment!(:like)
    # @post.save


    # @posts = Post.find(params[:id])
    # @posts.increment!(:likes)
    # redirect_to @post, notice: 'Post liked successfully'

  end




  # GET /posts/1 or /posts/1.json
  def show

    impressionist(@post)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create

    @post = Post.new(post_params)


    respond_to do |format|
      if @post.save

        PostMailer.with(user: current_user, post: @post).post_created.deliver_now

        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:avatar, :title, :description, :keywords, :user_id, :likes)
    end


end
