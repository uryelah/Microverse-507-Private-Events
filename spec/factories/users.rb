# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "user-#{n}" }
    sequence(:email) { |n| "user-#{n}@mail.com" }
  end
end
