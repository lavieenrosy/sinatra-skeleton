class CreateTables < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.timestamps
    end

    create_table :posts do |t|
      t.string :title
      t.references :user
      t.timestamps
    end

    create_table :comments do |t|
      t.text :comment
      t.string :byline
      t.references :post
      t.references :user
      t.timestamps
    end
  end

end