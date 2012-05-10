class Array
  @@per_page_default = 10

  def page(page_num, per_page = @@per_page_default)
    start_item = page_num * per_page
    start_item = -10 if self[start_item] == nil
    self.slice(start_item, per_page -1) 
  end

end