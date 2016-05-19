require 'spec_helper'

describe User, :focus do
  def seed_users
    Dir[APP_ROOT.join("spec/fixtures/users/*.yml")].each do |file|
      usr_yaml = YAML.load_file(file)
      next unless usr_yaml.present?
      usr_attrs = usr_yaml.extract!(*User.column_names)

      user  = User.create!(usr_attrs)

      usr_yaml["experience"].each do |job_attrs|
        experience = job_attrs.delete("years")
        user.jobs_users << JobsUser.new(years: experience, job: Job.new(job_attrs))
      end
    end
  end

  before(:each) do
    seed_users
  end

  # it { is_expected.to validate_presence_of(:first_name) }
  # it { is_expected.to validate_presence_of(:last_name) }

  it 'can create a user with a job' do
    expect(User.first.jobs).to_not be_empty
    expect(User.first.jobs_users.first.years).to_not be 0
  end
end
