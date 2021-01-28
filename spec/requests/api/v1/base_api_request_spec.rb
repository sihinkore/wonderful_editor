require 'rails_helper'

RSpec.describe "Api::V1::BaseApis", type: :request do
  describe "POST//api/v1/base_api" do
    subject{post(api_v1_base_api_index_path, params: params)}
  context "ユーザーがログインしてるとき" do
    let!(:params){create(:article)}
  it "新しい記事がつくられる" do
    subject

    end
   end
  end

end
