class RedisStorage
  def save_transportation(data)
    key = "e_transportation:#{SecureRandom.uuid}"
    $redis.set(key, data.to_json, ex: 3600)
    { message: "Data saved successfully" }
  end

  def e_transportations
    keys = $redis.keys("e_transportation:*")
    keys.map { |key| JSON.parse($redis.get(key)) }
  end

  def e_transportations_out_of_zone
    e_transportations
      .select { |data| data["in_zone"] == false }
      .group_by { |data| [data["e_transportation_type"], data["sensor_type"]] }
      .transform_values { |records| records.count }
  end
end
