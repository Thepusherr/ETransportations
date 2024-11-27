class DataStorageAdapter
  def initialize(adapter)
    @adapter = case adapter
               when :redis
                 RedisStorage.new
               when :active_record
                 ActiveRecordStorage.new
               else
                 raise NotImplementedError, "Adapter #{adapter} is not implemented"
               end
  end

  def save_e_transportation(data)
    @adapter.save_transportation(data)
  end

  def e_transportations
    @adapter.e_transportations
  end

  def e_transportations_out_of_zone
    @adapter.e_transportations_out_of_zone
  end
end
