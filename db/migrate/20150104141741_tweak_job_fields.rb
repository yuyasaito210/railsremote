class TweakJobFields < ActiveRecord::Migration
  def change
    remove_column :jobs, :employees_in
    add_column :jobs, :timezone_preferences, :text
    add_column :jobs, :agencies_ok, :boolean, default: false, null: false
  end
end
