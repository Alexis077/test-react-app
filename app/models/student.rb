class Student < ApplicationRecord
    has_many :grades
    validates :name, uniqueness: { scope: :last_name }
    validates :name, presence: true
    validates :last_name, presence: true
end
