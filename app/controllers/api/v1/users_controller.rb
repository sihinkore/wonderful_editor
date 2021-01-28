class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(name: params[:name],
                    email: params[:email],
                    password: params[:password]
                  )

    user.save!
  end
end
