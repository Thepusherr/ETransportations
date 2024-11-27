class ActiveRecordStorage
  def save_transportation(data)
    e_transportation = ETransportation.new(data)
    if e_transportation.save
      { message: 'Data saved successfully' }
    else
      { errors: e_transportation.errors.full_messages }
    end
  end

  def transportations
    ETransportation.all.as_json
  end

  def e_transportations_out_of_zone
    transportations.where(in_zone: false)
                   .group(:e_transportation_type, :sensor_type)
                   .count
  end
end