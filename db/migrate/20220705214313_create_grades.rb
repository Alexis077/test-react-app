class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.references :students, index: true, foreign_key: true
      t.references :courses, index: true, foreign_key: true
      t.string :quarter
      t.integer :score
      t.boolean :status
      t.timestamps
    end
  end
end
