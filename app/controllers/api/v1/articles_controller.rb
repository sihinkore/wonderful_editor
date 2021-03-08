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
     # ログインユーザーと紐付いた記事が作成できる。
    article = current_user.articles.create!(article_params)
    # jsonとして値を返す
    render json: article  #each_serializer: Api::V1::ArticleSerializerはいらない？
  end

  def update
    article = current_user.articles.find(params[:id])
    article.update!(article_params)

     # jsonとして値を返す
    render json: article
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!

    render json: article
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
