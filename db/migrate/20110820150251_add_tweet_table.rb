class AddTweetTable < ActiveRecord::Migration
  def up
    create_table :tweets do |t|
      t.references :offer
    end
  end

  def down
    drop_table :tweets
  end
end
