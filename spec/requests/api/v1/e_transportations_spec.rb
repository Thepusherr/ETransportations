require 'rails_helper'

RSpec.describe "Api::V1::ETransportations", type: :request do
  describe 'POST /api/v1/e_transportations' do
    it 'creates a new e-transportation' do
      valid_attributes = {
        e_transportation_type: 'e-scooter',
        sensor_type: 'small',
        owner_id: 1,
        in_zone: true,
        lost_sensor: false
      }

      post '/api/v1/e_transportations', params: { e_transportation: valid_attributes }

      expect(response).to have_http_status(:created)
    end

    it 'returns an error when sensor_type is medium for e-scooter' do
      invalid_attributes = {
        e_transportation_type: 'e-scooter',
        sensor_type: 'medium',
        owner_id: 1,
        in_zone: true,
        lost_sensor: false
      }

      post '/api/v1/e_transportations', params: { e_transportation: invalid_attributes }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include("Sensor type cannot be 'medium' for e-scooter")
    end

    it 'returns an error when e_transportation_type is wrong' do
      invalid_attributes = {
        e_transportation_type: 'e-pickup',
        sensor_type: 'medium',
        owner_id: 1,
        in_zone: true,
        lost_sensor: false
      }

      post '/api/v1/e_transportations', params: { e_transportation: invalid_attributes }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include("E transportation type is not included in the list")
    end
  end

  describe "GET /api/v1/e_transportations" do
    it "returns all e-Transportations" do
      get api_v1_e_transportations_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/v1/e_transportations/out_of_zone' do
    it 'returns grouped data for e-transportations out of the charging zone' do
      ETransportation.create!(e_transportation_type: 'e-bike', sensor_type: 'small', owner_id: 1, in_zone: false)
      ETransportation.create!(e_transportation_type: 'e-scooter', sensor_type: 'big', owner_id: 2, in_zone: false, lost_sensor: false)
      
      get '/api/v1/e_transportations/out_of_zone'
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(
        { "[\"e-bike\", \"small\"]"=>1, "[\"e-scooter\", \"big\"]"=>1 }
      )
    end
  end
end
