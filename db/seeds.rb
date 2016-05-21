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

Dir[APP_ROOT.join("spec/fixtures/job_ads/*.yml")].each do |file|
  job_yaml = YAML.load_file(file)
  job_attrs = job_yaml.extract!(*JobAd.column_names)
  job_attrs.merge(other: job_yaml.to_a.join(": "))

  city_and_state = job_attrs["city_and_state"].split(", ")

  lat_and_long = GeoLookup.get_coordinates(city: city_and_state[0], state: city_and_state[1])

  JobAd.create!(job_attrs.merge(latitude: lat_and_long[0], longitude: lat_and_long[1]))
end

JobAd.__elasticsearch__.create_index! index: JobAd.index_name, force: true
JobAd.import
