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
    description: Faker::Lorem.sentences(3)
    })
end
