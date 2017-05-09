# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Address.destroy_all

Address.create(address_1: '5 East Wooster St', city:'Navarre', state:'OH', zip:'44662')
Address.create(address_1: '69 Forest Cove', city:'Hilton Head', state:'SC', zip:'29928')
Address.create(address_1: '274 W Irving', city:'Lincoln', state:'NE', zip:'68521')
