class AddDefaultLocalToUser < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :local, 'en'
  end
end
