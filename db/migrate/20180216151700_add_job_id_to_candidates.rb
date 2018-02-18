class AddJobIdToCandidates < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :job_id, :integer
  end
end
