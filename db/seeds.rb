# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
AuthenticationProvider.create!(id: 1, name: 'facebook')
AuthenticationProvider.create!(id: 2, name: 'twitter')
AuthenticationProvider.create!(id: 3, name: 'google')

Payment.create!(:id => 1, :title => '현금결제')
Payment.create!(:id => 2, :title => '카드결제')
Payment.create!(:id => 3, :title => '포인트결제')
Payment.create!(:id => 4, :title => '추후청구')
Payment.create!(:id => 5, :title => '핸드폰결제')
Payment.create!(:id => 6, :title => '계좌이체')
Payment.create!(:id => 7, :title => '가상계좌')
Payment.create!(:id => 8, :title => '무통장입금')

PeriodType.create!(:id => 1, :title => 'month')
PeriodType.create!(:id => 2, :title => 'week')
PeriodType.create!(:id => 3, :title => 'day')

MessageSendType.create!(:id => 1, :title => 'SMS')
MessageSendType.create!(:id => 2, :title => 'Push')
MessageSendType.create!(:id => 3, :title => 'Available Push Or SMS')

Company.create!(id: 1, title: '제대로웹')
Company.create!(id: 2, title: '헬스클럽')
Company.create!(id: 3, title: '피트니스')
Company.create!(id: 4, title: '필라테스')

Branch.create!(id: 1, company_id: 1, title: '클럽미정', sample: 1, branch_setting_attributes: { use_unique_number: true, branch_setting_payments_attributes: [{ payment_id: 1 }, { payment_id: 2 }]})
Branch.create!(id: 2, company_id: 2, title: '헬스클럽1', sample: 1, branch_setting_attributes: { use_unique_number: true, branch_setting_payments_attributes: [{ payment_id: 1 }, { payment_id: 2 }]})
Branch.create!(id: 3, company_id: 3, title: '피트니스', branch_setting_attributes: { use_unique_number: true, branch_setting_payments_attributes: [{ payment_id: 1 }, { payment_id: 2 }]})
Branch.create!(id: 4, company_id: 4, title: '필라테스', branch_setting_attributes: { use_unique_number: true, branch_setting_payments_attributes: [{ payment_id: 1 }, { payment_id: 2 }]})

Role.create!(id: 1, title: '최고관리자', role: 'super_administrator')
Role.create!(id: 2, title: '센터관리자', role: 'administrator')
Role.create!(id: 3, title: '지점관리자', role: 'sub_administrator')
Role.create!(id: 4, title: '팀장', role: 'operator')
Role.create!(id: 5, title: '직원', role: 'sub_operator')
Role.create!(id: 6, title: '알바생', role: 'reader')

Job.create!(:id => 1, :title => '경영-사무')
Job.create!(:id => 2, :title => '광고-홍보')
Job.create!(:id => 3, :title => 'IT-정보통신-관련설비')
Job.create!(:id => 4, :title => '디자인')
Job.create!(:id => 5, :title => '무역-유통')
Job.create!(:id => 6, :title => '영업-고객관리')
Job.create!(:id => 7, :title => '서비스')
Job.create!(:id => 8, :title => '연구개발-설계')
Job.create!(:id => 9, :title => '생산제조')
Job.create!(:id => 10, :title => '교육')
Job.create!(:id => 11, :title => '건설')

VisitRoute.create!(:id => 1, :title => '지인추천')
VisitRoute.create!(:id => 2, :title => '간판')
VisitRoute.create!(:id => 3, :title => '전단지')
VisitRoute.create!(:id => 4, :title => '쿠폰')
VisitRoute.create!(:id => 5, :title => '기프티콘')
VisitRoute.create!(:id => 6, :title => 'SNS')
VisitRoute.create!(:id => 7, :title => '인터넷검색')
VisitRoute.create!(:id => 8, :title => '기타')

AccountCategory.create!(id: 1, title: '구입', enable: true)
AccountCategory.create!(id: 2, title: '수정', enable: true)
AccountCategory.create!(id: 3, title: '환불', enable: true)
AccountCategory.create!(id: 4, title: '포인트충전', enable: true)
AccountCategory.create!(id: 5, title: '포인트환불', enable: true)

ProductCategory.create!(id: 1, branch_id: 1, title: '헬스', enable: true)
ProductCategory.create!(id: 2, branch_id: 1, title: 'PT', enable: true)
ProductCategory.create!(id: 3, branch_id: 1, title: '락커', enable: true)

ProductCategory.create!(id: 4, branch_id: 2, title: '헬스', enable: true)
ProductCategory.create!(id: 5, branch_id: 2, title: 'PT', enable: true)
ProductCategory.create!(id: 6, branch_id: 2, title: '락커', enable: true)

ProductCategory.create!(id: 7, branch_id: 3, title: '음료', enable: true)
ProductCategory.create!(id: 8, branch_id: 3, title: '과자', enable: true)

Product.create!(id: 1, branch_id: 1, product_category_id: 1, title: '헬스정기권 1달', price: 20000, enable: true)
Product.create!(id: 2, branch_id: 1, product_category_id: 1, title: '헬스정기권 3달', price: 40000, enable: true)
Product.create!(id: 3, branch_id: 1, product_category_id: 1, title: '헬스정기권 6달', price: 100000, enable: true)
Product.create!(id: 4, branch_id: 1, product_category_id: 1, title: '헬스정기권 1년', price: 200000, enable: true)
Product.create!(id: 5, branch_id: 1, product_category_id: 2, title: 'PT', price: 2000, enable: true)
Product.create!(id: 6, branch_id: 1, product_category_id: 3, title: '락커 1달', price: 2000, enable: true)
Product.create!(id: 7, branch_id: 1, product_category_id: 3, title: '락커 3달', price: 4000, enable: true)
Product.create!(id: 8, branch_id: 1, product_category_id: 3, title: '락커 6달', price: 10000, enable: true)
Product.create!(id: 9, branch_id: 1, product_category_id: 3, title: '락커 1년', price: 20000, enable: true)

Course.create!(id: 1, product_id: 1)
Course.create!(id: 2, product_id: 2)
Course.create!(id: 3, product_id: 3)
Course.create!(id: 4, product_id: 4)
Course.create!(id: 5, product_id: 5)

Locker.create!(id: 1, product_id: 6)
Locker.create!(id: 2, product_id: 7)
Locker.create!(id: 3, product_id: 8)
Locker.create!(id: 4, product_id: 9)

Group.create!(id: 1, branch_id: 1, title: 'VIP')
Group.create!(id: 2, branch_id: 1, title: 'Special')
Group.create!(id: 3, branch_id: 1, title: 'Normal')

User.create!(id: 1, branch_id: 1, email: 'user1@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자1', phone: '111-1111', registration_date: '2020-11-23')
User.create!(id: 2, branch_id: 1, email: 'user2@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자2', phone: '222-2222', registration_date: '2020-11-23')
User.create!(id: 3, branch_id: 1, email: 'user3@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자3', phone: '333-3333', registration_date: '2020-11-23')
User.create!(id: 4, branch_id: 1, email: 'user4@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자4', phone: '444-4444', registration_date: '2020-11-23')

User.create!(id: 5, branch_id: 2, email: 'user5@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자4', phone: '555-5555', registration_date: '2020-11-23')
User.create!(id: 6, branch_id: 2, email: 'user6@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자4', phone: '666-6666', registration_date: '2020-11-23')
User.create!(id: 7, branch_id: 2, email: 'user7@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자4', phone: '777-7777', registration_date: '2020-11-23')
User.create!(id: 8, branch_id: 2, email: 'user8@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자4', phone: '888-8888', registration_date: '2020-11-23')

User.create!(id: 9, branch_id: 3, email: 'user9@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자4', phone: '999-9999', registration_date: '2020-11-23')
User.create!(id: 10, branch_id: 3, email: 'user10@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자4', phone: '121-1211', registration_date: '2020-11-23')
User.create!(id: 11, branch_id: 3, email: 'user11@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자4', phone: '333-4444', registration_date: '2020-11-23')
User.create!(id: 12, branch_id: 3, email: 'user12@jedaeroweb.co.kr', password: 'a12345', password_confirmation: 'a12345', name: '사용자4', phone: '444-5555', registration_date: '2020-11-23')

Admin.create!(:id => 1, :branch_id => 1, :name => '잠자는-사자', role_admin_attributes: { role_id: 3 })
Admin.create!(:id => 2, :branch_id => 1, :name => '트레이너', :is_trainer => 1, role_admin_attributes: { role_id: 3 })
Admin.create!(:id => 3, :branch_id => 1, :name => 'FC', :is_fc => 1, role_admin_attributes: { role_id: 3 })

RoleAdmin.create!(role_id: 1, admin_id: 1)

UserGroup.create!(user_id: 1, group_id: 1)
UserGroup.create!(user_id: 2, group_id: 3)
UserGroup.create!(user_id: 3, group_id: 3)

UserAdmin.create!(user_id: 1, admin_id: 1)
UserAdmin.create!(user_id: 5, admin_id: 2)
UserAdmin.create!(user_id: 9, admin_id: 3)

PreparedMessage.create!(id: 1, branch_id: 1, title: '준비된 메세지', prepared_message_content_attributes: { content: 'asdgasdgasdg' })


Notice.create!(id:1 ,branch_id: 1,title: '교환/반품 규정',notice_content_attributes: {
  content: "1. 교환/반품이 가능한 경우"})
Notice.create!(id: 2,branch_id: 1,title: '교환/반품 규정',notice_content_attributes: {
  content: "1. 교환/반품이 가능한 경우"})
Notice.create!(id: 3,branch_id: 1,title: '교환/반품 규정',notice_content_attributes: {
  content: "1. 교환/반품이 가능한 경우"})



ExerciseCategory.create!(id: 1, branch_id: 1, title: '가슴')
ExerciseCategory.create!(id: 2, branch_id: 1, title: '등')
ExerciseCategory.create!(id: 3, branch_id: 1, title: '팔')
ExerciseCategory.create!(id: 4, branch_id: 1, title: '어깨')
ExerciseCategory.create!(id: 5, branch_id: 1, title: '복근')
ExerciseCategory.create!(id: 6, branch_id: 1, title: '하체')
ExerciseCategory.create!(id: 7, branch_id: 1, title: '전신')
ExerciseCategory.create!(id: 8, branch_id: 1, title: '유산소')
ExerciseCategory.create!(id: 9, branch_id: 1, title: '밴드')


Exercise.create!(id: 1, branch_id: 1,exercise_category_id:1,:title=>'교환/반품 규정',exercise_content_attributes: {
  content: "1. 교환/반품이 가능한 경우"})
Exercise.create!(id: 2, branch_id: 1,exercise_category_id:1,:title=>'교환/반품 규정',exercise_content_attributes: {
  content: "1. 교환/반품이 가능한 경우"})
Exercise.create!(id: 3, branch_id: 1,exercise_category_id:1,:title=>'교환/반품 규정',exercise_content_attributes: {
  content: "1. 교환/반품이 가능한 경우"})