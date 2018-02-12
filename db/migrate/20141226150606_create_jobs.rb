class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.timestamps null: false

      t.string :token
      t.string :title
      t.string :job_type
      t.string :company_name
      t.string :salary
      t.string :company_url
      t.string :email
      t.text :description
      t.text :how_to_apply
      t.text :employees_in
      t.datetime :visible_until
      t.boolean :published
    end
  end
end
