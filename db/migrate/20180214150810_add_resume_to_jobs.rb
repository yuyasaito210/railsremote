class AddResumeToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :resume, :string
  end
end
