class PostsController < ApplicationController
  def create
    klass = Module.const_get(params[:type].capitalize)
    klass_name = klass.to_s.downcase
    @post = klass.create(params[klass_name])
    unless @post.errors.any?
      render "create",
              :status => :ok,
              :handlers => [:jbuilder]
    else
      render "create",
              :status => :unprocessable_entity,
              :handlers => [:jbuilder]
    end
  end
end
