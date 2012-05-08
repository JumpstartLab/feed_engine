module WorldExtensions
  def flash_text
    find("#flash").text
  end
end

World(WorldExtensions)
