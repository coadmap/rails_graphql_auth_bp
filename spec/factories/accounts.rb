# frozen_string_literal: true
FactoryBot.define do
  factory :account do
    sequence(:username) { |n| "#{n}太郎" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { "password" }
  end
end
