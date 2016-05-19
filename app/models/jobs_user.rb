class JobsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  validates :years, presence: true
end
