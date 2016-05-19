class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :college
      t.string :degree
      t.string :about_me
    end
  end
end
