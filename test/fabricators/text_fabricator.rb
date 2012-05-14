Fabricator(:text_post, class_name: Text) do
  content   { Faker::Lorem.paragraphs(1).join }
  user_id   { Fabricate(:user).id }
end