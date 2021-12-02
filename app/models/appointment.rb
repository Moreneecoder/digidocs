class Appointment < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :time, presence: true

  

  belongs_to :user
  belongs_to :doctor, class_name: 'User'
end
