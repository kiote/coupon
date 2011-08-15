class CreateGroupons < ActiveRecord::Migration
  def change
    create_table :groupons do |t|
      t.text :message

      t.timestamps
    end
  end
end
