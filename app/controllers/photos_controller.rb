class PhotosController < ApplicationController
  def index
    @photos = Photo.all

    render({ template: "photo_templates/index.html.erb" })
  end

  def create
    user_id = params.fetch("input_owner_id")
    image = params.fetch("input_image")
    caption = params.fetch("input_caption")
    photo = Photo.new
    photo.owner_id = user_id
    photo.image = image
    photo.caption = caption
    photo.save
    redirect_to("/photos/#{photo.id}")
  end

  def show
    photo_id = params.fetch("the_photo_id")
    @photo = Photo.where({ id: photo_id }).at(0)
    render({ :template => "photo_templates/show.html.erb" })
  end

  def update
    id = params.fetch("the_photo_id")
    photo = Photo.where({ id: id }).first
    photo.caption = params.fetch("input_caption")
    photo.image = params.fetch("input_image")
    photo.save

    redirect_to("/photos/#{photo.id}")
  end

  def destroy
    id = params.fetch("the_photo_id")
    photo = Photo.find(id)
    photo.destroy

    redirect_to("/photos")
  end
end
