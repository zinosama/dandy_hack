require 'test_helper'

class VaccineTest < ActiveSupport::TestCase
	def setup
		@vaccine = Vaccine.new(name: "neww vaccine")
	end

	test 'should be valid' do
		assert @vaccine.valid?		
	end

	test 'name should not be too longer' do
		@vaccine.name = "a" * 101
		assert_not @vaccine.valid?
	end

	test 'name should be unique' do
		duplicate_vaccine = @vaccine.dup
		@vaccine.save
		assert_not duplicate_vaccine.valid?
	end
end
