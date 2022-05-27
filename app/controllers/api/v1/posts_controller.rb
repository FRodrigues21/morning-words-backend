class Api::V1::PostsController < ApplicationController
  def create
    if !current_post.nil?
      current_post.update(content: post_params[:content])
      current_post.save
      render json: { post: current_post }
    else
      @post = Post.new(content: post_params[:content], word_count: post_params[:word_count], user: current_user)

      if @post.valid?
        @post.save
        render json: { post: @post }
      else
        render json: { error: "failed to create post" }, status: :not_acceptable
      end
    end
  end

  def show
    @post = Post.find_by("DATE(created_at) = ?", Time.parse(params[:date]).to_date)

    puts params[:date].to_date

    if @post.present?
      render json: { post: @post }
    else
      render json: { error: "no post created on the supplied date" }, status: :not_acceptable
    end
  end

  def progress
    service = GetCurrentMonthProgress.new(user: current_user)

    render json: { progress: service.call }
  end

  private

  def current_post
    @current_post ||= Post.find_by("DATE(created_at) = ?", Date.today)
  end

  def post_params
    params.require(:post).permit(:content, :word_count, :date)
  end
end
