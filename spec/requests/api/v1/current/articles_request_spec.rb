require 'rails_helper'

RSpec.describe "Api::V1::Current::Articles", type: :request do
  describe " GET/api/v1/current/articles" do
    subject{get(api_v1_current_articles_path,headers:headers)}
     let!(:current_user){create(:user)}
     let(:headers){current_user.create_new_auth_token }
     let!(:article1){create(:article, :published, user:current_user)}
     let!(:article2){create(:article, :published, user:current_user)}
     let!(:article3){create(:article, :published, user:current_user)}

     let!(:article4){create(:article, :draft)}

    fit "ユーザーに紐づいた公開記事の一覧が取得できる" do
     subject
     res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(response.status).to eq 200
    end
   end

end
