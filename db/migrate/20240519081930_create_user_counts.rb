class CreateUserCounts < ActiveRecord::Migration[7.1]
  def change
    create_table :user_counts do |t|
      t.string :ip_address

      t.timestamps
    end
    add_index :user_counts, :ip_address, unique: true
  end
end
