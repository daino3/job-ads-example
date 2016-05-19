class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :company
      t.string :industry
      t.string :title
      t.string :location
    end

    create_join_table :jobs, :users do |t|
      t.index [:user_id, :job_id]
      t.integer :years
    end
  end
end

