# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(email: "majorvin.tan@email.com", first_name: "First", last_name: "Last", password: "11111111", admin: true)

for i in 1..100
  User.create(email: "test-#{i}@email.com", first_name: "First", last_name: "Last", password: "11111111")
end

QuestionSet::Category.create(name: "category - 000", enabled: false, max_question: 10)

for i in 1..100
  QuestionSet::Category.create(name: "category - #{i}", enabled: true, max_question: 10)
end