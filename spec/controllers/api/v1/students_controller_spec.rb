# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::StudentsController, type: :controller do
  describe 'GET #index' do
    let!(:student) { FactoryBot.create(:student) }
    let!(:student_2) { FactoryBot.create(:student) }

    context 'Get all information of students' do
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
    context 'Get all information of a student' do
      it 'success response' do
        get(:index, params: {id: student.id})
        json_response = JSON.parse(response.body)        
        expect(response.status).to eq(200)
        expect(json_response[0]['id']).to eq(student.id) 
      end
    end
  end

  describe 'POST #create' do
    let!(:params) do 
        { student: { name: Faker::Name.name, last_name: Faker::Name.first_name } } 
    end

    context 'create new student' do
      it 'success response' do
        post(:create,params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(json_response['name']).to eq(params[:student][:name])
        expect(json_response['last_name']).to eq(params[:student][:last_name])
      end
    end

    context 'try to create a duplicated student' do
      let!(:student) { FactoryBot.create(:student, name: params[:student][:name], last_name: params[:student][:last_name]) } 
      
      it 'error response' do
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['name'][0]).to eq("has already been taken")        
      end
    end

    context 'try to create with blank parameters' do      
      it 'errors with blank name' do
        params[:student][:name] = ""
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['name'][0]).to eq("can't be blank")        
      end

      it 'errors with blank last_name' do
        params[:student][:last_name] = ""
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['last_name'][0]).to eq("can't be blank")        
      end
    end
  end

  describe 'POST #update' do
    let!(:student) { FactoryBot.create(:student) }
    let!(:params) do 
        {  
          id: student.id,
          student: { name: 'John', last_name: 'Doe' } 
        } 
    end
        
    context 'update student' do
      it 'success response' do
        put(:update,params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(json_response['name']).to eq(params[:student][:name])
        expect(json_response['last_name']).to eq(params[:student][:last_name])        
      end
    end

    context 'try to update duplicating a student' do
      let!(:student_2) { FactoryBot.create(:student, name: params[:student][:name], last_name: params[:student][:last_name]) } 
      
      it 'error response' do
        put(:update, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['name'][0]).to eq("has already been taken")        
      end
    end

    context 'try to update with blank parameters' do
      it 'errors with blank name' do
        params[:student][:name] = ""
        put(:update, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['name'][0]).to eq("can't be blank")        
      end

      it 'errors with blank last_name' do
        params[:student][:last_name] = ""
        put(:update, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['last_name'][0]).to eq("can't be blank")        
      end
    end    
  end

  describe 'DELETE #destroy' do
    let!(:student) { FactoryBot.create(:student) }
        
    context 'Delete register' do
      it 'success response' do
        delete(:destroy, params: { id: student.id })      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(Student.all.size).to eq(0)
      end
    end
  end
end
