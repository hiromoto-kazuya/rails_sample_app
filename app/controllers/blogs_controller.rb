class BlogsController < ApplicationController
  before_action :set_blog, only:[:edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blogs_path, notice: '投稿が完了しました'
    else
      render 'new'
    end
  end

  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    @comments = @blog.comments
    @comment = @blog.comments.build
  end

  def edit
  end

  def edit_confirm
    @blog = Blog.find(params[:id])
    @blog.title,@blog.content = blog_params[:title], blog_params[:content]
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "編集が完了しました"
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: 'ブログを削除しました'
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    unless @blog = current_user.blogs.find_by(id: params[:id])
      redirect_to blogs_path, notice: "権限がありません"
    end
  end
end
