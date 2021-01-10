require 'rails_helper'

RSpec.describe User, type: :model do
  context "name,email,passwordを入力したとき" do
    let(:user){build(:user)}
    it "ユーザー登録ができる" do
    expect(user).to be_valid
    end
  end
  context "nameを入力していないとき" do
    let(:user){build(:user, name: "")}
    it "エラーが発生する" do
      expect(user).to be_invalid
      expect(user.errors.details[:name][0][:error]).to eq :blank
    end
  end
end
