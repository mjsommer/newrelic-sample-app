class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :string
      t.string :event_addr
      t.string :domain
      t.string :subdomain

      t.timestamps null: false
    end
  end
end
