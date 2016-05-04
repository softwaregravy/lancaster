class PhoneNumberFormatter
  class << self
    def valid_format
      /\A\+1\d{10}\z/
    end

    def format(phone_number)
      ret_val = phone_number.to_s
      return ret_val if valid_format =~ ret_val

      # trim whitespace
      ret_val = phone_number.to_s.gsub(/\D/, '')
      return ret_val if valid_format =~ ret_val

      # prepend +1
      if 10 == ret_val.length
        ret_val = "+1" + ret_val
      elsif 11 == ret_val.length
        ret_val = "+" + ret_val
      end

      return ret_val if valid_format =~ ret_val
      return nil
    end

    def format!(phone_number)
      ret_val = format(phone_number)
      raise ArgumentError, "unable to properly format phone number #{phone_number}" unless ret_val
      ret_val
    end

  end
end
