class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :resume

      t.timestamps
    end
  end
end
