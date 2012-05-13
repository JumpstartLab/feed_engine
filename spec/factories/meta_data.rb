# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meta_datum, :class => 'MetaData' do
    title "Pandas"
    description "A fleet of pandas."
    thumbnail_url "http://i.imgur.com/qcbwG.jpg"
  end
end
