class GradeSerializer < ActiveModel::Serializer
  attributes :id, :student, :course, :quarter, :score, :status

  def status
    object.status ? 'Approved' : 'Rejected' 
  end
end
