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
