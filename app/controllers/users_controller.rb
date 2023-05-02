class UsersController < ApplicationController
  def index
    matching_users = User.all
    @list_of_users = matching_users
    render({ template: "users_templates/index.html.erb" })
  end

  def create
    user = User.new

    user.username = params.fetch("input_username")

    user.save

    redirect_to("/users/#{user.username}")
  end

  def show
    @user = User.find_by(username: params[:username])

    render({ template: "users_templates/show.html.erb" })
  end

  def update
    id = params.fetch("the_user_id")
    user = User.where({ id: id }).at(0)

    user.username = params.fetch("username")

    user.save
    redirect_to("/users/#{user.username}")
  end
end
