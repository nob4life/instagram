# spec/factories/comment.rb

FactoryBot.define do 
  factory :comment do 
    body { FFaker::DizzleIpsum.phrase }
  end
end