require 'test_helper'

class IllnessesUserTest < ActiveSupport::TestCase

	def setup
		illness = illnesses(:one)
		user = users(:one)
		@record = IllnessesUser.new( illness: illness, user: user, date_contracted: "01/01/2011", date_recovered: "01/02/2011")
	end
	test 'should be valid' do
		assert @record.valid?
	end

	test 'should have an illness' do
		@record.illness = nil
		assert_not @record.valid?
	end

	test 'should have a user' do
		@record.user = nil
		assert_not @record.valid?
	end

	test 'should have date_contracted' do
		@record.date_contracted = nil
		assert_not @record.valid?
	end

	test 'should have date_recovered' do
		@record.date_recovered = ""
		assert_not @record.valid?
	end

	test 'date date_contracted should be prior to date_recovered' do
		date_recovered = @record.date_recovered
		@record.date_recovered = @record.date_contracted
		@record.date_contracted = date_recovered
		assert_not @record.valid?
	end

	test 'symptoms can be nil' do
		@record.symptoms = nil
		assert @record.valid?
	end

	test 'symptoms cannot be too long' do
		@record.symptoms = "a" * 256
		assert_not @record.valid?
	end

end
