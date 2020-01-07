# frozen_string_literal: true

FactoryBot.define do
    factory :event do
      sequence(:id) { |n| n }
      sequence(:title) { |n| "event-#{n}" }
      sequence(:description) { |n| "event-#{n} description" }
      sequence(:location) { |n| "event-#{n} location" }
      sequence(:date) { |n| Time.current + rand(1..100).days}
      association :creator, factory: :user
    end
  end
  