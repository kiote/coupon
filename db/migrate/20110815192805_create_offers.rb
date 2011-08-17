class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :title
      t.string :href
      t.references :daily_mail

      t.timestamps
    end
    add_index :offers, :daily_mail_id
  end
end
