# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthenticationsController, type: :controller do


  describe 'POST #create' do
    let!(:user){FactoryBot.create(:user)}
    let!(:params) do 
        { email: user.email, password: '1234567890' } 
    end

    context 'create token' do
      it 'success response' do
        post(:login,params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(200)
        expect(json_response['token'].present?).to eq(true)
      end
      
      it 'error response' do 
        params[:password] = '123'
        post(:login,params: params)      
        json_response = JSON.parse(response.body)  
        expect(response.status).to eq(401)
        expect(json_response['error']).to eq('unauthorized')
      end
    end
  end
end
