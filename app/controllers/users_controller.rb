class UsersController < ApplicationController

  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })

    render({ :template => "user_templates/index.html.erb"})
  end

  def show
    # Parameters: {"path_username"=>"anisa"}
    url_username = params.fetch("path_username")

    matching_usernames = User.where({ :username => url_username })

    @the_user = matching_usernames.first

    #if @the_user == nil
    #  redirect_to("/404")
    #else
      render({ :template => "user_templates/show.html.erb"})
    #end
  end

  def create_username
    # Parameters: {"query_image"=>"a", "query_caption"=>"b", "query_ownder_id"=>"c"}
    input_username = params.fetch("input_username")

    new_username = User.new

    new_username.username = input_username

    new_username.save

    next_url = "/users/" + new_username.username
    redirect_to(next_url)
  end

  def update_user
    # Parameters: {"query_image"=>"a", "query_caption"=>"b", "modify_id"=>"c"}

    user_id = params.fetch("user_id")

    matching_user = User.where({ :id => user_id })

    the_user = matching_user.first

    update_user = params.fetch("input_username")

    the_user.username = update_user

    the_user.save

    #render({ :template => "/photo_templates/update.html.erb" })
    next_url = "/users/" + the_user.username

    redirect_to(next_url)
  end

end
