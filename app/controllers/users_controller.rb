# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in

  def index
    @user = current_user # Set the @user instance variable to the currently logged-in user
  end
end
