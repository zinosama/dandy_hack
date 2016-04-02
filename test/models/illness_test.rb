require 'test_helper'

class IllnessTest < ActiveSupport::TestCase
	def setup
		@illness = Illness.new(name: "Cold")
	end

	test 'should be valid' do
		assert @illness.valid?
	end

	test 'should have a name' do
		@illness.name = ""
		assert_not @illness.valid?
	end
end
