industries = [
"Food",
"Health",
"Beauty",
"Technology",
"Sports + Fitness",
"Telecommunication",
"Waste Management",
"Toys + Games",
"Steel + Iron",
"Textiles",
"Oil + Gas"
]

industries.each do |industry|
  Industry.create({
    name: industry,
    description: Faker::Lorem.sentence
    })
end

User.create(email: "test@gmail.com", password:"123456")
Stock.create(symbol:"FB", name:"Facebook Inc.")
