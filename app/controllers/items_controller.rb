class ItemsController < ApplicationController
  respond_to :xml, :json

  def index
    @posts = User.where(display_name: params[:user_display_name]).first.posts.page(params[:page])
  end

  def create
    mapper = mapper_for(params)
    post   = mapper.map(current_user, params)

    if post.save
      head status: 201
    else
      errors = post.errors.messages.values.flatten
      respond_with do |format|
        format.json { render json: {errors: errors}, status: 406 }
      end
    end
  end

  private

  def mappers
    [ImagePostMapper, TextPostMapper, LinkPostMapper]
  end

  def mapper_for(params)
    mappers.find { |mapper| mapper.can_map?(params) }
  end

  class Mapper
    def self.type(type)
      @type = type
    end

    def self.mapping(maps)
      @maps = maps
    end

    def self.association(association)
      @association = association
    end

    def self.slice_params(params)
      new_params = {}
      @maps.each do |from, to|
        to = from if to == :self
        new_params[to] = params[from]
      end

      new_params
    end

    def self.can_map?(params)
      params[:type] == @type
    end

    def self.map(current_user, params)
      new_params = slice_params(params)
      current_user.send(@association).create(new_params)
    end
  end

  class ImagePostMapper < Mapper
    association "image_posts"
    type        "ImageItem"
    mapping  :image_url   => :remote_image_url,
             :description => :self
  end

  class TextPostMapper < Mapper
    association "text_posts"
    type        "TextItem"
    mapping  :text => :body
  end

  class LinkPostMapper < Mapper
    association "link_posts"
    type        "LinkItem"
    mapping  :link_url => :url,
             :comment  => :description
  end
end
