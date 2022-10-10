# spec/factories/post.rb

FactoryBot.define do 
  factory :post do
    association :user

    title { FFaker::Book.title }
    body {FFaker::Book.description }
  end
end