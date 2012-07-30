# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CostType.create([
    {name: "KM"}, 
    {name: "Duration"}
])

# PaymentType.create([
#      {type: "Check"},
#      {type: "Credit Card"},
#      {type: "Money"}, 
#      {type: "Sexual Favour"}
# ])

# TruckType.create([
#     {type: "12 Wheelers"}, 
#     {type: "18 Wheelers"}
# ])

# Truck.create([
#     {truck_type_id: 1}, 
#     {truck_type_id: 2}
# ])

# Address.create([
#     {id: 1. street_name: "Main Street", city: "Montreal", postal_code: "A1A1A1" }
# ])

# Person.create([
#     {first_name: "Stan", last_name: "Marsh",      telephone: "5145550001", address_id: 1},
#     {first_name: "Eric", last_name: "Cartman",    telephone: "5145550002", address_id: 1},
#     {first_name: "Kyle", last_name: "Broflovski", telephone: "5145550003", address_id: 1},
#     {first_name: "Kenny", last_name: "McCornick", telephone: "5145550004", address_id: 1}
# ])

# TaxType.create([
#     { name: "TPS" },
#     { name: "TVQ" }
# ])

# Tax.create([
#     { start_date: Date.parse("2012-1-1 12:00:00"), end_date: nil, percentage: 0.085, tax_type_id: 1 },
#     { start_date: Date.parse("2012-1-1 12:00:00"), end_date: nil, percentage: 0.075, tax_type_id: 2 }
# ])

# Invoice.create([ {date: Date.parse("2012-7-28 12:00:00")} ])
