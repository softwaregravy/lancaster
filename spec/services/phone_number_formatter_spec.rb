require 'rails_helper'

RSpec.describe PhoneNumberFormatter do 

  let(:purely_valid_phone_numbers){[
    '+12223334444'
  ]}
  let(:valid_formattable_phone_numbers) {[
    '+5554443333',
    '15554443333',
    '5554443333',
    '  3334445555',
    '333 444 5555 ',
    '3334445555 ',
    '(222)555-5555',
    '(212) 555-4534',
    '212.555.4534',
    2223334444
  ]}
  let(:invalid_phone_numbers){[
    '+23334445555', #+1 only
    '22223334444',
    '3334444',
    '223334444',
    '223334445555'
  ]}

  describe "valid_format" do
    it "should match purely valid phone numbers" do 
      purely_valid_phone_numbers.each do |phone_number|
        expect(phone_number).to match(PhoneNumberFormatter.valid_format), "failed on input of #{phone_number}"
      end
    end
    it "should not match invalid phone numbers" do 
      invalid_phone_numbers.each do |phone_number|
        expect(phone_number).not_to match(PhoneNumberFormatter.valid_format), "failed on input of #{phone_number}"
      end
    end
  end

  describe "#format and format!" do 
    context "with purely valid input" do
      it "should return valid phone numbers (format)" do 
        purely_valid_phone_numbers.each do |phone_number|
          test_number = PhoneNumberFormatter.format(phone_number)
          expect(test_number).to match(PhoneNumberFormatter.valid_format), "failed on input of #{phone_number}"
          expect(test_number).to eql(PhoneNumberFormatter.format!(phone_number))
        end
      end
    end
    context "with valid input" do
      it "should return valid phone numbers " do 
        valid_formattable_phone_numbers.each do |phone_number|
          test_number = PhoneNumberFormatter.format(phone_number)
          expect(test_number).to match(PhoneNumberFormatter.valid_format), "failed on input of #{phone_number}"
          expect(test_number).to eql(PhoneNumberFormatter.format!(phone_number))
        end
      end
    end
    context "with invalid input" do
      it "should fail" do 
        invalid_phone_numbers.each do |phone_number|
          expect(PhoneNumberFormatter.format(phone_number)).to be_nil
          expect {
            test_number = PhoneNumberFormatter.format!(phone_number)
          }.to raise_error ArgumentError
        end
      end
    end
  end
end

