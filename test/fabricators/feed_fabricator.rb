Fabricator(:feed, :class_name => Feed) do
  user_id     { Fabricate(:user).id }
end