class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name, :null => false
      t.date :starts_at, :null => false
      t.date :ends_at
      t.string :homepage
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
