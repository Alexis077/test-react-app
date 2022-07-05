class GradeSerializer < ActiveModel::Serializer
  attributes :id, :student, :course, :score, :status

  def status
    object.status ? 'Approved' : 'Rejected' 
  end
end
