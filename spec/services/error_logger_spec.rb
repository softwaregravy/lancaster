require 'rails_helper'

RSpec.describe ErrorLogger do 
  it "should record an exception" do 
    begin
      10 / 0
    rescue => e
      ErrorLogger.log_error(e)
    end
    # will throw exception if an error happens inside log_error
  end
  it "should not fail if passed a weird type" do 
    ErrorLogger.log_error("abc")
    # will throw exception if an error happens inside log_error
  end
end
