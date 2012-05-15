module PageExtension
  PAGE_SIZE = 12

  def page(num)
    num ||= 1
    num = num.to_i - 1

    self.order("created_at DESC").
      limit(PAGE_SIZE).
      offset(num.to_i * PAGE_SIZE)
  end

  def pages
    ((self.count - 1) / PAGE_SIZE) + 1
  end
end

