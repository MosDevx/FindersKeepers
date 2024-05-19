class CreateUserQueries < ActiveRecord::Migration[7.1]
  def change
    create_table :user_queries do |t|
      t.string :query
      t.string :ip_address

      t.timestamps
    end
  end
end
