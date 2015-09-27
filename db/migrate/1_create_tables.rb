class CreateTables < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.timestamps
    end

    create_table :courses do |t|
      t.string :title
      t.string :start_date
      t.string :end_date
      t.string :description
      t.belongs_to :user_id
      t.timestamps
    end

    create_table :enrolment do |t|
      t.belongs_to :user_id
      t.belongs_to :course_id

  end

end