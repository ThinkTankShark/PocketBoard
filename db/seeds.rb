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


User.create(email:"test@gmail.com", password:"1234")
Stock.create(symbol:"FB", name:"Facebook Inc.")
Stock.create(symbol:"AAPL", name:"Apple Inc.")

