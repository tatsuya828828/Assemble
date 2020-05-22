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
			password: 'aaaaaa',
			valid_status: "active"
		},
		{
			email: 'jiro@gmail.com',
			name: '次郎',
			self_id: 'taro2',
			password: 'aaaaaa',
			valid_status: "active"
		},
		{
			email: 'saburo@gmail.com',
			name: '三郎',
			self_id: 'taro3',
			password: 'aaaaaa',
			valid_status: "active"
		},
		{
			email: 'siro@gmail.com',
			name: '四郎',
			self_id: 'taro4',
			password: 'aaaaaa',
			valid_status: "active"
		},
		{
			email: 'goro@gmail.com',
			name: '五郎',
			self_id: 'taro5',
			password: 'aaaaaa',
			valid_status: "active"
		},
		{
			email: 'rokuro@gmail.com',
			name: '六郎',
			self_id: 'taro6',
			password: 'aaaaaa',
			valid_status: "active"
		},
		{
			email: 'sichiro@gmail.com',
			name: '七郎',
			self_id: 'taro7',
			password: 'aaaaaa',
			valid_status: "active"
		},
		{
			email: 'hachiro@gmail.com',
			name: '八郎',
			self_id: 'taro8',
			password: 'aaaaaa',
			valid_status: "active"
		},
		{
			email: 'kuro@gmail.com',
			name: '九郎',
			self_id: 'taro9',
			password: 'aaaaaa',
			valid_status: "active"
		},
		{
			email: 'toro@gmail.com',
			name: '十郎',
			self_id: 'taro10',
			password: 'aaaaaa',
			valid_status: "active"
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
		},
		{
			group_id: '1',
			user_id: '6',
			join_status: 'joined'
		},
		{
			group_id: '1',
			user_id: '2',
			join_status: 'joined'
		},
		{
			group_id: '1',
			user_id: '3',
			join_status: 'joined'
		},
		{
			group_id: '1',
			user_id: '4',
			join_status: 'joined'
		},
		{
			group_id: '1',
			user_id: '5',
			join_status: 'joined'
		},
		{
			group_id: '2',
			user_id: '7',
			join_status: 'joined'
		},
		{
			group_id: '2',
			user_id: '8',
			join_status: 'joined'
		},
		{
			group_id: '3',
			user_id: '9',
			join_status: 'joined'
		},
		{
			group_id: '4',
			user_id: '10',
			join_status: 'joined'
		},
		{
			group_id: '5',
			user_id: '10',
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