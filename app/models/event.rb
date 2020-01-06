# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invites, dependent: :destroy
  has_many :attendees, through: :invites, foreign_key: 'event_id', class_name: 'User', source: :user

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :date, presence: true
  validate :date_check

  # scopes
  scope :future, ->(time) { where('date > ?', time) }
  scope :past, ->(time) { where('date < ?', time) }
  scope :my_ivt_status, ->(bool, user) { joins(:invites).where(invites: { status: bool, user_id: user.id }) }

  # class methods
  def self.upcoming_events
    Event.all.future(Time.current).order(date: :asc)
  end

  def self.prev_events
    all.past(Time.current).order(date: :desc)
  end

  def self.attending_to(user)
    Event.upcoming_events.my_ivt_status(true, user)
  end

  def self.invited_to(user)
    Event.upcoming_events.my_ivt_status(false, user)
  end

  def self.attended_to(user)
    Event.prev_events.my_ivt_status(true, user)
  end

  private

  def date_check
    errors.add(:date, 'Cannot send envite to expired event') if date < Time.current
  end
end
