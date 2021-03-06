class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start_datetime,
    :client, :user, :client_id, :user_id, :ticket_id

  belongs_to :client
  belongs_to :user
  belongs_to :ticket

  validates :title, :client, :user, presence: true
  validates :client_id, presence: true

  scope :this_month, ->(year, month){
    where("start_datetime > ?", Date.new(year, month, -1).beginning_of_month)
      .where("start_datetime < ?", Date.new(year, month, -1).end_of_month)
  }
end
