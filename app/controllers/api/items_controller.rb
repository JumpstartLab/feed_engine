class Api::ItemsController < Api::BaseController
  def index
    @posts = current_user.posts
    page   = (params[:page] || 1).to_i
    next_page = [page+1, @posts.pages].min

    next_page_url = api_items_url(user_display_name: current_user.display_name, page: next_page)
    last_page_url = api_items_url(user_display_name: current_user.display_name, page: @posts.pages)

    link_header =
      "<#{next_page_url}>; rel=\"next\", <#{last_page_url}>; rel=\"last\""

    headers["Link"] = link_header
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
    mapping  :image_url   => :external_image_url,
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
