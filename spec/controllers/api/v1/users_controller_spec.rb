# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  include JsonWebToken
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { jwt_encode(user_id: user.id) }
  let!(:headers) { { 'Authorization': token } }

  describe 'GET #index' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user_2) { FactoryBot.create(:user) }

    context 'Get all information of users' do
      it 'success response' do
        request.headers.merge!(headers)
        get(:index)        
        json_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json_response.size).to eq(2)
      end
    end
  end

  describe 'GET #show' do
    let!(:user) { FactoryBot.create(:user) }
    context 'Get all information of a user' do
      it 'success response' do
        request.headers.merge!(headers)
        get(:index, params: {id: user.id})
        json_response = JSON.parse(response.body)        
        expect(response.status).to eq(200)
        expect(json_response[0]['id']).to eq(user.id) 
      end
    end
  end

  describe 'POST #create' do
    let!(:params) do 
        { user: { username: Faker::Internet.username, email: Faker::Internet.email, password: '1234567890' } } 
    end

    context 'create new user' do
      it 'success response' do
        request.headers.merge!(headers)
        post(:create,params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(json_response['username']).to eq(params[:user][:username])
        expect(json_response['email']).to eq(params[:user][:email])
      end
    end
  end

  describe 'POST #update' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:params) do 
        {  
          id: user.id,
          user: { username: 'John90', email: 'John90@example.com', password: '123456780'} 
        } 
    end
        
    context 'update user' do
      it 'success response' do
        request.headers.merge!(headers)
        put(:update,params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)        
        expect(json_response['username']).to eq(params[:user][:username])
        expect(json_response['email']).to eq(params[:user][:email])        
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { FactoryBot.create(:user) }
        
    context 'Delete register' do
      it 'success response' do
        request.headers.merge!(headers)
        delete(:destroy, params: { id: user.id })      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(User.all.size).to eq(0)
      end
    end
  end
end
