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
			email: 'jiro@gmail.com',
			name: '次郎',
			self_id: 'taro2',
			password: 'aaaaaa'
		},
		{
			email: 'saburo@gmail.com',
			name: '三郎',
			self_id: 'taro3',
			password: 'aaaaaa'
		},
		{
			email: 'siro@gmail.com',
			name: '四郎',
			self_id: 'taro4',
			password: 'aaaaaa'
		},
		{
			email: 'goro@gmail.com',
			name: '五郎',
			self_id: 'taro5',
			password: 'aaaaaa'
		}
	]
)

Group.create!(
	[
		{
			name: '太郎のグループ',
			leader: '1',
			self_id: 'taro',
			private_status: 'open'
		},
		{
			name: '二郎のグループ',
			leader: '2',
			self_id: 'jiro',
			private_status: 'closed'
		},
		{
			name: '三郎のグループ',
			leader: '3',
			self_id: 'saburo',
			private_status: 'open'
		},
		{
			name: '三郎のグループ',
			leader: '4',
			self_id: 'siro',
			private_status: 'closed'
		},
		{
			name: '五郎のグループ',
			leader: '5',
			self_id: 'goro',
			private_status: 'open'
		}
	]
)
GroupUser.create!(
	[
		{
			group_id: '1',
			user_id: '1',
			join_status: 'joined'
		},
		{
			group_id: '2',
			user_id: '2',
			join_status: 'joined'
		},
		{
			group_id: '3',
			user_id: '3',
			join_status: 'joined'
		},
		{
			group_id: '4',
			user_id: '4',
			join_status: 'joined'
		},
		{
			group_id: '5',
			user_id: '5',
			join_status: 'joined'
		}
	]
)
Admin.create!(
	{
		self_id: ENV['ADMIN_ID'],
		email: ENV['ADMIN_MAIL'],
		password: ENV['ADMIN_PASSWORD']
	}
)