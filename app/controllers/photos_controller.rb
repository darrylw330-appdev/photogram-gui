
 

class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "photo_templates/index.html.erb"})
  end

  def show
    # Params = {"path_id"=>"777"}
    url_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => url_id })
    @the_photo = matching_photos.first

    photo_comments = @the_photo.comments
    @the_comments = photo_comments.order({ :created_at => :desc })

    render({ :template => "photo_templates/show.html.erb"})
  end

  def baii
    # params = {"toast_id"=>"785"}

    the_id = params.fetch("toast_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo = matching_photos.at(0)

    the_photo.destroy

    # render({ :template => "photo_templates/baii.html.erb"})
    redirect_to("/photos")
  end

  def create
    # params = {"query_image"=>"image goes here", "query_caption"=>"caption", "query_owner_id"=>"owner id"}

    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")
    input_owner_id = params.fetch("query_owner_id")

    a_new_photo = Photo.new
    a_new_photo.image = input_image
    a_new_photo.caption = input_caption
    a_new_photo.owner_id = input_owner_id

    a_new_photo.save

    # render({ :template => "photo_templates/create.html.erb" })
    redirect_to("/photos/#{a_new_photo.id}")
  end

  def update
    # params = {"query_image"=>"image goes here", "query_caption"=>"caption", "modify_id"=>"id"}

    the_id = params.fetch("modify_id")
    
    matching_photos = Photo.where({ :id => the_id })
    
    the_photo = matching_photos.first

    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")

    the_photo.image = input_image
    the_photo.caption= input_caption

    the_photo.save
    
    #render({ :template => "photo_templates/update.html.erb" })

    redirect_to("/photos/#{the_photo.id}")
  end

  def create_comment
    #params = {"query_photo_id"=>"777", "query_author_id"=>"117", "query_comment"=>"That's so cool!", "path_id"=>"777"}
    input_author_id = params.fetch("query_author_id")
    input_comment = params.fetch("query_comment")
    input_photo_id = params.fetch("query_photo_id")

    new_comment = Comment.new
    new_comment.author_id = input_author_id
    new_comment.body = input_comment
    new_comment.photo_id = input_photo_id
    new_comment.save

    redirect_to("/photos/#{input_photo_id}")
  end
end
