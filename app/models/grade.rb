class Grade < ApplicationRecord
    belongs_to :student
    belongs_to :course
    before_save :set_status
    enum quarter: {q1: 'q1', q2: 'q2', q3: 'q3',q4: 'q4'}

    def set_status
        self.status = self.score > 5 ? true : false
    end
end
