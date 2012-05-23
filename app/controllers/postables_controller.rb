# The controller for all of the internal postable items
module PostablesController
  def self.included(base)
    base.class_eval do
      respond_to :html, :json
    end
  end

  def show
    set_instance(item_class.find(params[:id]))
    respond_with get_instance
  end

  def new
    set_instance(item_class.new)
    respond_with get_instance
  end

  def create
    initialize_post_types
    if get_instance.send(:save)
      redirect_to dashboard_path,
        notice: "#{item_class.to_s} was successfully created."
    else
      render template: "dashboard/show",
        notice: "Something went wrong."
    end
  end

  private

  def initialize_post_types
    @user = User.new
    @link = Link.new
    @image = Image.new
    @message = Message.new
    set_instance(item_class.new(params[item_class.to_s.downcase.to_sym]))
  end

  def set_instance(eval_to)
    instance_variable_set(class_as_instance, eval_to)
  end

  def get_instance
    instance_variable_get(class_as_instance)
  end

  def class_as_instance
    "@#{item_class.to_s.downcase}"
  end

  def item_class
    self.class.to_s.gsub("sController", "").constantize
  end

end
