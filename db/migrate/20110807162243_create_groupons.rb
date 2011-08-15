class CreateGroupons < ActiveRecord::Migration
  def change
    create_table :daily_mails do |t|
      t.text :message

      t.timestamps
    end
  end
end
