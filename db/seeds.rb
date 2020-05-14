# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
	[
		{
			email: 'taro1@gmail.com',
			name: '太郎',
			self_id: 'taro1',
			password: 'aaaaaa'
		},
		{
			email: 'taro2@gmail.com',
			name: '次郎',
			self_id: 'taro2',
			password: 'aaaaaa'
		},
		{
			email: 'taro3@gmail.com',
			name: '三郎',
			self_id: 'taro3',
			password: 'aaaaaa'
		}
	]
)