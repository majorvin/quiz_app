# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Certification::Track.create(name: "Track #1", enabled: true)

User.create(email: "majorvin@example.com", first_name: "First", last_name: "Last", password: "11111111", admin: true, track_id: 1)

# for i in 1..50
#   User.create(email: "test-#{i}@email.com", first_name: "First", last_name: "Last", password: "11111111")
#   puts "Creating User - #{i}"
# end

for i in 0..50
  params = { category: {
    name: "#{i} - Category",
    enabled: true,
    max_question: 10,
    questions_attributes: []
  }}

  for j in 1..50
    params[:category][:questions_attributes].push(
      {
        text: "Q#{j} - Question",
        choices_attributes: [
          { text: "Q1 - Choice1", answer: false},
          { text: "Q2 - Choice2", answer: true},
        ]
      },
    )
  end

  qc1 = QuestionSet::Category.create(params[:category])

  qc2 = QuestionSet::Category.create({ name: "#{i} - Category", enabled: false, max_question: 30 })

  puts "Question Category ##{i} is created."
end

