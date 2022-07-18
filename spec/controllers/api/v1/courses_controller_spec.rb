# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  describe 'GET #index' do
    let!(:course) { FactoryBot.create(:course) }
    let!(:course_2) { FactoryBot.create(:course) }

    context 'Get all information of courses' do
      it 'success response' do
        get(:index)        
        json_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json_response.size).to eq(2)
      end
    end
  end

  describe 'GET #show' do
    let!(:course) { FactoryBot.create(:course) }
    context 'Get all information of a course' do
      it 'success response' do
        get(:index, params: {id: course.id})
        json_response = JSON.parse(response.body)        
        expect(response.status).to eq(200)
        expect(json_response[0]['id']).to eq(course.id) 
      end
    end
  end

  describe 'POST #create' do
    let!(:params) do 
        { course: { name: Faker::Educator.subject } } 
    end

    context 'create new course' do
      it 'success response' do
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(json_response['name']).to eq(params[:course][:name])
      end
    end

    context 'try to create a duplicated course' do
      let!(:course) { FactoryBot.create(:course, name: params[:course][:name]) } 
      
      it 'error response' do
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['name'][0]).to eq("has already been taken")        
      end
    end

    context 'try to create with blank parameters' do      
      it 'errors with blank name' do
        params[:course][:name] = ""
        post(:create, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['name'][0]).to eq("can't be blank")        
      end
    end
  end

  describe 'POST #update' do
    let!(:course) { FactoryBot.create(:course) }
    let!(:params) do 
        {  
          id: course.id,
          course: { name: 'History of Mexico'} 
        } 
    end
        
    context 'update course' do
      it 'success response' do
        put(:update,params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(json_response['name']).to eq(params[:course][:name])
      end
    end

    context 'try to update duplicating a course' do
      let!(:course_2) { FactoryBot.create(:course, name: params[:course][:name]) } 
      
      it 'error response' do
        put(:update, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['name'][0]).to eq("has already been taken")        
      end
    end

    context 'try to update with blank parameters' do
      it 'errors with blank name' do
        params[:course][:name] = ""
        put(:update, params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(422)
        expect(json_response['name'][0]).to eq("can't be blank")        
      end
    end    
  end

  describe 'DELETE #destroy' do
    let!(:course) { FactoryBot.create(:course) }
        
    context 'Delete register' do
      it 'success response' do
        delete(:destroy, params: { id: course.id })      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(Course.all.size).to eq(0)
      end
    end
  end
end
