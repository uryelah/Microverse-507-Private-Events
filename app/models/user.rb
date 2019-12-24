class User < ApplicationRecord
    has_many :hosted_events, foreign_key: 'creator_id', class_name: 'Event', dependent: :nullify
    has_many :invites, dependent: :destroy
    has_many :attended_event, through: :invites, foreign_key: 'user_id', class_name: 'Event', source: :event
end
