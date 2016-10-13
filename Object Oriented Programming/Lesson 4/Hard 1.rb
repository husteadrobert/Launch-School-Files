# Question 1
class SecretFile
  def data
    @logger.create_log_entry
    @data
  end

  def initialize(secret_data)
    @data = secret_data
    @logger = SecurityLogger.new
  end
end



class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end

# Question 2
