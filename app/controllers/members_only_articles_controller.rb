class MembersOnlyArticlesController < ApplicationController
  before_action :require_login

  def index
    articles = Article.where(is_member_only: true)
    render json: articles
  end

  def show
    article = Article.find_by(id: params[:id], is_member_only: true)
    if article
      render json: article
    else
      render json: { error: 'Article not found' }, status: :not_found
    end
  end

  private

  def require_login
    unless logged_in?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def logged_in?
    session[:user_id].present?
  end
end

