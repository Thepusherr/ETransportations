class ETransportation < ApplicationRecord
  validates :e_transportation_type, presence: true, inclusion: { in: ["e-scooter", "e-bike"] }
  validates :sensor_type, presence: true, inclusion: { in: ["small", "medium", "big"] }
  validates :owner_id, presence: true, numericality: { only_integer: true }
  validates :in_zone, inclusion: { in: [true, false] }
  validates :lost_sensor, inclusion: { in: [true, false] }, if: :e_scooter?

  validate :sensor_type_restriction_for_e_scooter
  validate :lost_sensor_restriction_for_e_bike

  private

  def e_scooter?
    e_transportation_type == "e-scooter"
  end

  def sensor_type_restriction_for_e_scooter
    if e_transportation_type == "e-scooter" && sensor_type == "medium"
      errors.add(:sensor_type, "cannot be 'medium' for e-scooter")
    end
  end

  def lost_sensor_restriction_for_e_bike
    if e_transportation_type == "e-bike" && lost_sensor
      errors.add(:lost_sensor, "lost_sensor not supported for e-bike")
    end
  end
end
