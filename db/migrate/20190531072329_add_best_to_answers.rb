class AddBestToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :accepted, :boolean, default: false
  end
end
