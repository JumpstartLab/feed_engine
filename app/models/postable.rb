module Postable
  def message?
    is_a? Message
  end

  def image?
    is_a? Image
  end

  def link?
    is_a? Link
  end
end
