require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new( first_name: "Kyle", last_name: "Simpson", email: "Kyle@gmail.com", password: "foobar", password_confirmation: "foobar" )
	end

	test 'should be valid' do
		assert @user.valid?
	end

	test 'should have a first name' do
		@user.first_name = ""
		assert_not @user.valid?
	end

	test 'should have a last name' do
		@user.last_name = ""
		assert_not @user.valid?
	end

	test 'first name should not be too long' do
		@user.first_name = "a" * 51
		assert_not @user.valid?
	end	

	test 'last name should not be too long' do
		@user.last_name = "a" * 51
		assert_not @user.valid?
	end

	test 'email should be present' do
		@user.email = "   "
		assert_not @user.valid?
	end

	test 'email should not be too long' do
		@user.email = 'a' * 256 + "@example.com"
		assert_not @user.valid?
	end

	test 'email should accept valid addresses' do
		valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test 'email should reject invalid addresses' do
		invalid_addresses = %w[user@example,com user_at_foo.org user. name@example. foo@bar_baz.com foo@bar+baz.com]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be valid"
		end
	end

	test 'email should be unique' do
		duplicate_user = @user.dup
		@user.save
		assert_not duplicate_user.valid?
	end

	test 'email should be saved in lowercase' do
		@user.email = "ABC@example.com"
		@user.save
		assert_equal("abc@example.com", @user.reload.email)
	end

	test 'password should be present' do
		@user.password = @user.password_confirmation = " " * 6
		assert_not @user.valid?
	end

	test 'password should have a minimum length' do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end

end
