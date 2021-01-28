class Api::V1::BaseApiController < ApplicationController

  def current_user
    # テーブルの最初のユーザーを入れる
    @current_user ||= User.first
  end
end
