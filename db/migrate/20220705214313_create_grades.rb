class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.references :student, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.string :quarter
      t.integer :score
      t.boolean :status
      t.timestamps
    end
  end
end
