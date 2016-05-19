class Job < ActiveRecord::Base
  has_many :jobs_users
  has_many :users, through: :jobs_users

  validates :company,
            :industry,
            :title,
            :location,
            presence: true
end
