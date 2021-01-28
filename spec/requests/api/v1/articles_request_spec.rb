require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  describe "Get/api/v1/articles" do
    subject{get(api_v1_articles_path)}
    let!(:article){create_list(:article,3)}

   it "記事の一覧が取得できる" do
    subject
    res = JSON.parse(response.body)
     expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
     expect(response.status).to eq 200
   end
  end
  describe "Get/api/v1/articles/:id" do
    subject{get(api_v1_article_path(id))}
    context "対象の記事のidが存在する時" do
     let!(:article){create(:article)}
     let!(:id){article.id}
    it "記事の詳細が取得できる" do
    subject
    res = JSON.parse(response.body)
     expect(res.keys).to eq ["id", "title", "body", "updated_at", "user"]
     expect(response.status).to eq 200
     end
    end
    context "対象の記事が存在しないとき" do
     let(:id){10000}
     it "エラーが発生する" do
      expect{ subject }.to raise_error ActiveRecord::RecordNotFound
     end
    end
  end
  describe "POST/api/v1/articles" do
    subject{post(api_v1_articles_path,params:params)}
  context "ユーザーがログインしているとき" do
    # let!(:user){create(:user)}
    # let(:current_user){User.first}
    let(:current_user){create(:user)}
    let(:params){{article:attributes_for(:article)}}
    before{allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user)}
  it "記事が作られる" do
    expect{subject}.to change {Article.count}.by(1)
    res = JSON.parse(response.body)
    expect(res.keys[1]).to eq "title"
    expect(res.keys[4]).to eq "user"
    end
   end
  end
end
