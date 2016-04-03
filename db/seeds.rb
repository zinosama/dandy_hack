# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create!(email:"Jiyong@gmail.com", first_name: "Ji-yong", last_name: "Kwon", password: "dasdaa", password_confirmation: "dasdaa" )

user1 = User.create!(email:"chricau@gmail.com", first_name: "Christopher", last_name: "Cauthen", password: "dasdaa", password_confirmation: "dasdaa" )
user2 = User.create!(email:"jamese@gmail.com", first_name: "James", last_name: "Escobar", password: "dasdaa", password_confirmation: "dasdaa" )
user3 = User.create!(email:"silvial@gmail.com", first_name: "Silvia", last_name: "Lowe", password: "dasdaa", password_confirmation: "dasdaa" )
user4 = User.create!(email:"luicillek@gmail.com", first_name: "Lucille", last_name: "Kessler", password: "dasdaa", password_confirmation: "dasdaa" )

user5 = User.create!(father: user1, mother: user2, email:"michaelk@gmail.com", first_name: "Michael", last_name: "Kean", password: "dasdaa", password_confirmation: "dasdaa" )
user6 = User.create!(father: user1, mother: user2, email:"dorisbo@gmail.com", first_name: "Doris", last_name: "Bordelon", password: "dasdaa", password_confirmation: "dasdaa" )
user7 = User.create!(father: user1, mother: user2, email:"harryro@gmail.com", first_name: "Harry", last_name: "Rosales", password: "dasdaa", password_confirmation: "dasdaa" )
user8 = User.create!(father: user3, mother: user4, email:"jacks@gmail.com", first_name: "Jack", last_name: "Scala", password: "dasdaa", password_confirmation: "dasdaa" )
user9 = User.create!(father: user3, mother: user4, email:"joshuae@gmail.com", first_name: "Joshua", last_name: "Edmonds", password: "dasdaa", password_confirmation: "dasdaa" )
user10 = User.create!(father: user3, mother: user4, email:"briand@gmail.com", first_name: "Brian", last_name: "Doss", password: "dasdaa", password_confirmation: "dasdaa" )

user11 = User.create!(father: user5, mother: user8, email:"jammied@gmail.com", first_name: "Jammie", last_name: "Day", password: "dasdaa", password_confirmation: "dasdaa" )
user12 = User.create!(father: user6, mother: user9, email:"maryw@gmail.com", first_name: "Mary", last_name: "Whitaker", password: "dasdaa", password_confirmation: "dasdaa" )
user13 = User.create!(father: user7, mother: user10, email:"lowellc@gmail.com", first_name: "Lowell", last_name: "Curtis", password: "dasdaa", password_confirmation: "dasdaa" )

user14 = User.create!(father: user5, mother: user8, email:"pinkier@gmail.com", first_name: "Pinkie", last_name: "Rubin", password: "dasdaa", password_confirmation: "dasdaa" )
user15 = User.create!(father: user6, mother: user9, email:"danielr@gmail.com", first_name: "Daniel", last_name: "Roseberry", password: "dasdaa", password_confirmation: "dasdaa" )
user16 = User.create!(father: user7, mother: user10, email:"johnc@gmail.com", first_name: "John", last_name: "Chu", password: "dasdaa", password_confirmation: "dasdaa" )
user17 = User.create!(father: user11, mother: user12, email:"johnm@gmail.com", first_name: "John", last_name: "Mayer", password: "dasdaa", password_confirmation: "dasdaa" )
user18 = User.create!(father: user11, mother: user12, email:"angelc@gmail.com", first_name: "Angel", last_name: "Conner", password: "dasdaa", password_confirmation: "dasdaa" )
user19 = User.create!(father: user13, mother: user14, email:"dominicr@gmail.com", first_name: "Dominic", last_name: "Ruiz", password: "dasdaa", password_confirmation: "dasdaa" )
user20 = User.create!(father: user13, mother: user14, email:"jessieg@gmail.com", first_name: "Jessie", last_name: "Gilmore", password: "dasdaa", password_confirmation: "dasdaa" )

['cold','flu','asthma', 'cancer', 'diabetes', 'ebola', 'arthritis', 'zika'].each do |disease|
	illness = Illness.create!(name: disease)
	User.all.each do |user|
		if rand(10) < 6
			user.illnesses_users.create!(illness: illness, date_contracted: '11/08/2013', date_recovered: '18/08/2013')
		end
	end
end

