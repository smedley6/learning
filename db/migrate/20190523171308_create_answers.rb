class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :body
      t.references :question, index: true
      t.timestamps
    end
  end
end
