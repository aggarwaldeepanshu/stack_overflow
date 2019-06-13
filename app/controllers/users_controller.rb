class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  # def create
  # 	@user = User.create(params)
  # end
end
