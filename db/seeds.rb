industries = [
"Basic Industries",
"Capital Goods",
"Consumer Durables",
"Consumer Non-Durables",
"Consumer Services",
"Energy",
"Finance",
"Health Care",
"Miscellaneous",
"Public Utilities",
"Technology",
"Transportation",
"n/a"
]

industries.each do |industry|
  Industry.create({
    name: industry,
    description: Faker::Lorem.sentences(3)
    })
end











User.create(email:"test@gmail.com", password:"1234")
