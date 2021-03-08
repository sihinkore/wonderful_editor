require 'rails_helper'

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST/api/v1/auth/sign_in" do
    subject{post(api_v1_user_session_path,params:params)}
  context "emailとpasswordが入力されたとき" do
  #データベースにユーザー情報が登録されている状態をつくる
  let!(:user){create(:user)}
  #データベースに登録されているユーザーのemail,password
  let(:params){{email:email,password:password}}
  let(:email){user.email}
  let(:password){user.password}

  it "ログインできる" do
    subject
    res = response.headers
    expect(res["uid"]).to be_present
    expect(res["access-token"]).to be_present
    expect(res["client"]).to be_present
    expect(response.status).to eq 200

  end
  end
  context "emailが正しくない場合" do
    let!(:user){create(:user)}
    let(:params){{email:email,password:password}}
    let(:email){""}
    let(:password){user.password}

  it "ログインできない" do
    subject
    res = JSON.parse(response.body)
    expect(res["success"]).to eq false
    expect(res["errors"]).to include("Invalid login credentials. Please try again.")
    expect(response.headers["uid"]).to be_blank
    expect(response.headers["access-token"]).to be_blank
    expect(response.headers["client"]).to be_blank

  end
  end
  context "passwordが正しくない場合" do
    let!(:user){create(:user)}
    let(:params){{email:email,password:password}}
    let(:email){user.email}
    let(:password){""}
    it "ログインできない" do
      subject
    res = JSON.parse(response.body)
    expect(res["success"]).to eq false
    expect(res["errors"]).to include("Invalid login credentials. Please try again.")
    expect(response.headers["uid"]).to be_blank
    expect(response.headers["access-token"]).to be_blank
    expect(response.headers["client"]).to be_blank
    end
  end
  describe "POST/api/v1/auth/sign_out" do
    subject{delete(destroy_api_v1_user_session_path,headers:headers)}
    context "ログアウトしたとき" do
      let(:user){create(:user)}
      let(:headers){user.create_new_auth_token}

    it "ログアウトできる" do
      subject
      expect(user.reload.tokens).to be_blank
      expect(response.status).to eq 200
    end
    end
  end
  end
end
