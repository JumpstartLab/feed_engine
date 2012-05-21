class Array
  PER_PAGE = 12

  def page(page_num, per_page = PER_PAGE)
    unless (page_num * per_page) > self.length
      start_item = page_num * per_page
      unless (start_item + per_page) > self.length
        self.slice(start_item, per_page)
      else
        self.slice(start_item..-1)
      end
    else
      []
    end
  end

end