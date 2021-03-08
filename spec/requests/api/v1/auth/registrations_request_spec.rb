require 'rails_helper'

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST/api/v1/auth" do
    subject{post(api_v1_user_registration_path,params:params)}
    context "name,email,passwordが送られたとき" do
    let(:params){attributes_for(:user)}
    it "ユーザーが登録される" do
      subject
      res = JSON.parse(response.body)
      expect(res.values[0]).to eq "success"
      expect(res.values[1].values[4]).to eq params[:name]
      expect(res.values[1].values[2]).to eq params[:email]
      expect(response.status).to eq 200
     end
    end
  end
end
