# frozen_string_literal: true

FactoryBot.define do
  factory :invite do
    sequence(:id) { |n| n }
    sequence(:status) { |n| false }
    association :user, factory: :user
    association :event, factory: :event
  end
end
