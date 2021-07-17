class Api::V1::Articles::DraftsController < Api::V1::BaseApiController
  #Api::V1::BaseApiControllerを継承
  def index
    articles = Article.draft.where(user_id:current_user.id).order(updated_at: :desc)
    render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
  end

  def show
    article = Article.draft.where(user_id:current_user.id).find(params[:id])
    render json: article
  end
end
