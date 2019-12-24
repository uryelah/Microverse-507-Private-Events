class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invites, dependent: :destroy
  has_many :attendees, through: :invites, foreign_key: 'event_id', class_name: 'User', source: :user

  # escopes
  scope :future, ->(time) { where('date > ?', time) }
  scope :past, ->(time) { where('date < ?', time) }

  # class methods
  def self.upcoming_events
    Event.all.future(Time.current)
  end

  def self.prev_events
    all.past(Time.current)
  end
end
