User.destroy_all
Item.destroy_all
Merchant.destroy_all


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#merchants
creature_shop = Merchant.create!(name: 'Megans Creatures', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
zoo_shop = Merchant.create!(name: 'Brians Animals', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

#creature_shop items
creature_shop.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 1000 )
creature_shop.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTVWz5K80lL8stwijdEXT7OBcAUKnh5_TSIx2kxYW0alF2O5Zw6', active: true, inventory: 1000 )
creature_shop.items.create!(name: 'Elf', description: "I'm a Elf!", price: 40, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSLT05x0-z7F4JKHQKSUcvF-BaJ85ZMOgdFlD_T_MYlvGrDGWfp', active: true, inventory: 1000 )

#zoo_shop items
zoo_shop.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSO1rcFQq_7THYVeQF8MszkXFcEGS8NtNfknH26eHNPBTSI2qNq', active: true, inventory: 1000 )
zoo_shop.items.create!(name: 'Zebra', description: "I'm a Zebra!", price: 40, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRyQFyGTrh7RSVBUJAyhJl8jtU6QE19cAf3sxzuiF3ig3tSyqxZ', active: true, inventory: 1000)
zoo_shop.items.create!(name: 'Lion', description: "I'm a Lion!", price: 60, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQnWmobflAog4dIU5vPkBeGMK4L3E89KYZgg_f6DHO0sDMHl4Fq', active: true, inventory: 1000 )


#users
user1 = User.create(name: 'Denny', address: '1234 Main St.', city: 'Denver', state: 'CO', zip: '80220', role: 0, email: 'user@email.com', password: 'password', password_confirmation: 'password')
user2 = User.create(name: 'Paul', address: '1234 Main St.', city: 'Denver', state: 'CO', zip: '80220',role: 0, email: 'user2@email.com', password: 'password', password_confirmation: 'password')
user3 = User.create(name: 'Kate', address: '1234 Main St.', city: 'Denver', state: 'CO', zip: '80220', role: 0, email: 'user3@email.com', password: 'password', password_confirmation: 'password')

#merchant
merchant_1 = User.create(name: 'Amy', address: '1234 Main St.', city: 'Denver', state: 'CO', zip: '80220', role: 1, email: 'merchant@email.com', password: 'password', password_confirmation: 'password')
creature_shop.users << merchant_1
merchant_2 = User.create(name: 'Benny', address: '1234 Main St.', city: 'Denver', state: 'CO', zip: '80220', role: 1, email: 'merchant@email.com', password: 'password', password_confirmation: 'password')
zoo_shop.users << merchant_2

#admin
admin = User.create(name: 'Jenny', address: '1234 Main St.', city: 'Denver', state: 'CO', zip: '80220', role: 2, email: 'admin@email.com', password: 'password', password_confirmation: 'password')
