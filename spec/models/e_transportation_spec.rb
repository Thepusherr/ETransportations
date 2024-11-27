require 'rails_helper'

RSpec.describe ETransportation, type: :model do
  it { should validate_presence_of(:e_transportation_type) }
  it { should validate_presence_of(:sensor_type) }
  it { should validate_presence_of(:owner_id) }
  it { should validate_inclusion_of(:in_zone).in_array([true, false]) }
  it { should validate_inclusion_of(:lost_sensor).in_array([true, false]) }

  it "should not allow medium sensor for e_scooter" do
    e_transportation = ETransportation.new(
      e_transportation_type: "e_scooter",
      sensor_type: "medium",
      owner_id: 1,
      in_zone: true,
      lost_sensor: false
    )

    e_transportation.valid?
    expect(e_transportation.errors.full_messages).to include("E transportation type is not included in the list")
  end
end