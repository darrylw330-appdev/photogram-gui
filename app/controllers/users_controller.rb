class UsersController < ApplicationController
  def index
    matching_users = User.all
    @list_of_users = matching_users.order({ :username => :asc })

    render({ :template => "user_templates/index.html.erb"})
  end

  def show
    # Params = {"path_username"=>"anisa"}
    url_username = params.fetch("path_username")
    matching_usernames = User.where({ :username => url_username })
    @the_user = matching_usernames.first
    
    # If you want to write your code defensively!
    # if the_user == nil
      # redirect_to("/404")
    # else
      render({ :template => "user_templates/show.html.erb"})
    # end
  end

  def create
    # params = {"query_name"=>"Jazmine"}
    input_user = params.fetch("query_name")

    new_user = User.new
    new_user.username = input_user
    new_user.save

    redirect_to("/users/#{new_user.username}")
  end

  def update
    # Params = {"update_un"=>"august", "path_username"=>"augustine"}
    the_username = params.fetch("modify_name")
    matching_user = User.where({ :username => the_username })
    the_user = matching_user.first

    input_username = params.fetch("update_un")

    the_user.username = input_username
    the_user.save

    redirect_to("/users/#{the_user.username}")
  end
end
