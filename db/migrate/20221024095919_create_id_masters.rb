class CreateIdMasters < ActiveRecord::Migration[7.0]
  def change
    create_table :id_masters do |t|
      t.integer :id_type_id
      t.string :name_on_id
      t.string :id_number
      t.string :reference_number
      t.date :issue_date
      t.date :first_intermidiary_expiry
      t.date :second_intermidiary_expiry
      t.date :third_intermidiary_expiry
      t.date :exipry_date
      t.integer :user_id
      t.text :front_image
      t.text :back_image
      t.boolean :status

      t.timestamps
    end
  end
end
