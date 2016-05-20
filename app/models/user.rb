class User < ActiveRecord::Base
  has_many :jobs_users
  has_many :jobs, through: :jobs_users

  validates :name, :email, presence: true

  def current_job
    jobs.first
  end
end
