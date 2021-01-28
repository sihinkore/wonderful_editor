class Api::V1::ArticlesController < Api::V1::BaseApiController
  def index
    articles = Article.order(updated_at: :desc)
    render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  def create
     # 記事のタイトルと本文が作られる。このとき誰が作った事になる？
    article = current_user.articles.create!(article_params)

    # jsonとして値を返す
    render json: article  #each_serializer: Api::V1::ArticleSerializerはいらない？
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
