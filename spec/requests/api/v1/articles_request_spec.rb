require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  describe "Get/api/v1/articles" do
    subject{get(api_v1_articles_path)}
    let!(:article){create_list(:article,3)}

   fit "記事の一覧が取得できる" do
    subject
    res = JSON.parse(response.body)
    binding.pry
     expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
     expect(response.status).to eq 200
   end
  end
  describe "Get/api/v1/articles/:id" do
    subject{get(api_v1_article_path(id))}
    context "対象の記事のidが存在する時" do
    let!(:article){create(:article)}
    let!(:id){article.id}

    # let(:user_id){User.first}
    it "記事の詳細が取得できる" do
    subject
    res = JSON.parse(response.body)
    end
    end
    context "対象の記事が存在しないとき" do
    # subject{get(api_v1_article_path(id))}
    # let!(:article){create(:article)}
    let(:id){10000}
    fit "エラーが発生する" do
      # binding.pry
      expect{ subject }.to raise_error ActiveRecord::RecordNotFound

    end
    end
  end
end
