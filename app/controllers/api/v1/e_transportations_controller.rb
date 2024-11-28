class Api::V1::ETransportationsController < ApplicationController
  def create
    e_transportation = ETransportation.new(e_transportation_params)

    if e_transportation.valid?
      data = storage.save_e_transportation(e_transportation_params.to_h)
      render json: data, status: :created
    else
      render json: { errors: e_transportation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    data = storage.e_transportations
    render json: data
  end

  def out_of_zone
    data = storage.e_transportations_out_of_zone
    render json: data
  end

  private

  def e_transportation_params
    params.require(:e_transportation).permit(:e_transportation_type, :sensor_type, :owner_id, :in_zone, :lost_sensor)
  end

  def storage
    # :redis or :active_record
    @storage ||= DataStorageAdapter.new(:active_record) # ENV.fetch('STORAGE_ADAPTER', 'redis').to_sym
  end
end
