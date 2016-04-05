require 'test_helper'

class IllnessTest < ActiveSupport::TestCase
	def setup
		@illness = Illness.new(name: "Flu")
	end

	test 'should be valid' do
		assert @illness.valid?
	end

	test 'should have a name' do
		@illness.name = ""
		assert_not @illness.valid?
	end

	test 'name should not be too long' do
		@illness.name = "a" * 101
		assert_not @illness.valid?
	end

	test 'name should be unique' do
		dup = Illness.new(name: @illness.name)
		@illness.save
		assert_not dup.valid?
	end
end
