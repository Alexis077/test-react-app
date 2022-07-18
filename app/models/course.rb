class Course < ApplicationRecord
    has_many :grades
    validates :name, uniqueness: true
    validates :name, presence: true
end
