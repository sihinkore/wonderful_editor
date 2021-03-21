# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :string           default("draft"), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Article, type: :model do
  context "タイトルと本文が入力されたとき" do
    let(:article){build(:article, :published)}
    it "公開記事が作成される" do
    expect(article).to be_valid
    end
  end

  context "タイトルと本文が入力されたとき" do
    let(:article){build(:article, :draft)}
    it "下書き記事が作成される" do
    expect(article).to be_valid
    end
  end

  context "タイトルが書かれていないとき" do
    let(:article){build(:article, title:nil)}
    it "エラーが発生する" do
      expect(article).to be_invalid
      expect(article.errors.details[:title][0][:error]).to eq :blank
    end
  end
end
