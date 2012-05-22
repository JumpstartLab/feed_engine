class Api::ItemsController < Api::BaseController
  def index
    @posts = current_user.posts
    headers["Link"] = create_link_header
  end

  def create
    klass      = params[:type].constantize
    attributes = params.slice(*klass.accessible_attributes)
    attributes.delete("scheme")
    post       = current_user.send(klass.table_name).create(attributes)

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

  def create_link_header(user_name, current_page, total_pages)
    page      = (params[:page] || 1).to_i
    next_page = [page+1, @posts.pages].min

    next_page_url = api_items_url(user_display_name: current_user.display_name, page: next_page)
    last_page_url = api_items_url(user_display_name: current_user.display_name, page: @posts.pages)

    link_header =
      "<#{next_page_url}>; rel=\"next\", <#{last_page_url}>; rel=\"last\""
  end
end
