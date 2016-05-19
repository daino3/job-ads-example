class CreateJobAds < ActiveRecord::Migration
  def change
    create_table :job_ads do |t|
      t.boolean :employment_type
      t.string :company
      t.string :compensation
      t.string :experience
      t.string :industry
      t.string :job_function
      t.string :city_and_state
      t.string :title
      t.float :latitude
      t.float :longitude
      t.text :company_description
      t.text :job_description
      t.text :requirements
      t.text :other
    end
  end
end

