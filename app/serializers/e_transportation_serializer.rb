class ETransportationSerializer < ActiveModel::Serializer
  attributes :id, :e_transportation_type, :sensor_type, :owner_id, :in_zone, :lost_sensor
end
