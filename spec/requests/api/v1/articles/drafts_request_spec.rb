require 'rails_helper'

RSpec.describe "Api::V1::Articles::Drafts", type: :request do
  describe " GET/api/v1/articles/drafts" do
   subject{get(api_v1_articles_drafts_path,headers:headers)}
    let!(:current_user){create(:user)}
    let(:headers){current_user.create_new_auth_token }
    let!(:article1){create(:article, :draft, user:current_user)}
    let!(:article2){create(:article, :draft, user:current_user)}
    let!(:article3){create(:article, :draft, user:current_user)}

    let!(:article4){create(:article, :published)}

   it "ユーザーに紐づいた下書き記事の一覧が取得できる" do
    subject
    res = JSON.parse(response.body)
     expect(res.length).to eq 3
     expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
     expect(response.status).to eq 200
   end
  end

  describe "GET/api/v1/articles/drafts/:id" do
    subject{get(api_v1_articles_draft_path(id),headers:headers)}
    let!(:current_user){create(:user)}
    let(:headers){current_user.create_new_auth_token }
    let!(:article){create(:article, :draft,user:current_user)}
    let!(:id){article.id}
    it "下書き記事の詳細が取得できる" do
      subject
      res=JSON.parse(response.body)
      expect(res["user_id"]).to eq current_user.id
      expect(res["id"]).to eq article.id
      expect(res["status"]).to eq "draft"
      expect(res.keys).to eq ["id", "title", "body", "user_id", "created_at", "updated_at", "status"]
      expect(response.status).to eq 200
    end
  end

end
