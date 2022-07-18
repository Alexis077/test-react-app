# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GradesController, type: :controller do
  describe 'GET #index' do
    let!(:student) { FactoryBot.create(:student) }
    let!(:student_2) { FactoryBot.create(:student) }
    let!(:course) { FactoryBot.create(:course) }
    let!(:course_2) { FactoryBot.create(:course) }
    let!(:grade) { FactoryBot.create(:grade, student: student, course: course, quarter: 'q1', score: 6) }
    let!(:grade_2) { FactoryBot.create(:grade, student: student_2, course: course_2, quarter: 'q1', score: 6) }

    context 'Get all information of grade' do
      it 'success response' do
        get(:index)        
        json_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json_response.size).to eq(2)
      end
    end
  end

  describe 'GET #show' do
    let!(:student) { FactoryBot.create(:student) }
    let!(:course) { FactoryBot.create(:course) }
    let!(:grade) { FactoryBot.create(:grade, student: student, course: course, quarter: 'q1', score: 6) }

    context 'Get all information of a grade' do
      it 'success response' do
        get(:index, params: {id: grade.id})
        json_response = JSON.parse(response.body)        
        expect(response.status).to eq(200)
        expect(json_response[0]['id']).to eq(grade.id) 
      end
    end
  end

  describe 'POST #create' do

    let!(:student) { FactoryBot.create(:student) }
    let!(:course) { FactoryBot.create(:course) }
    let!(:params) do 
      { grade: { student_id: student.id, course_id: course.id, quarter: 'q1', score: 6} } 
    end

    context 'create new grade' do
      it 'success response' do
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(json_response['student']['id']).to eq(student.id)
        expect(json_response['course']['id']).to eq(course.id)
        expect(json_response['quarter']).to eq('q1')
        expect(json_response['score']).to eq(6)
      end
    end

    context 'create new grade with an invalid score' do
      it 'error response when score is greater than 10' do
        params[:grade][:score] = 11
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['score'][0]).to eq('must be less than or equal to 10')
      end

      it 'error response when score is less than 0' do
        params[:grade][:score] = -1
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['score'][0]).to eq('must be greater than or equal to 0')
      end
    end

    context 'create new grade with an invalid quarter' do
      let!(:grade) { FactoryBot.create(:grade, student: student, course: course, quarter: 'q1', score: 6)}
  
      it 'error response' do
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['quarter'][0]).to eq('has already been taken')
      end
    end
  end

  describe 'POST #update' do
    let!(:course) { FactoryBot.create(:course) }
    let!(:student) { FactoryBot.create(:student) }
    let!(:student_2) { FactoryBot.create(:student) }
    let!(:grade) {FactoryBot.create(:grade, student: student, course: course, quarter: 'q1', score: 7)}
    let!(:params) do 
      { id: grade.id,
        grade: { student_id: student_2.id, course_id: course.id, score: 5} } 
    end
        
    context 'update grade' do
      it 'success response' do
        put(:update, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(json_response['student']['id']).to eq(student_2.id)
      end
    end

    context 'create new grade with an invalid score' do
      it 'error response when score is greater than 10' do
        params[:grade][:score] = 11
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['score'][0]).to eq('must be less than or equal to 10')
      end

      it 'error response when score is less than 0' do
        params[:grade][:score] = -1
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['score'][0]).to eq('must be greater than or equal to 0')
      end
    end

    context 'create new grade with an invalid quarter' do
      let!(:grade) {FactoryBot.create(:grade, student: student_2, course: course, quarter: 'q2', score: 7)}
      it 'error response' do
        params[:grade][:quarter] = 'q2'
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['quarter'][0]).to eq('has already been taken')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:student) { FactoryBot.create(:student) }
    let!(:course) { FactoryBot.create(:course) }
    let!(:grade) { FactoryBot.create(:grade, student: student, course: course, quarter: 'q1', score: 7)}

    context 'Delete register' do
      it 'success response' do
        delete(:destroy, params: { id: grade.id })      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(Grade.all.size).to eq(0)
      end
    end
  end
end
