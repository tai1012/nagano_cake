# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'abcdyy@admin',
   password: 'tai1012'
)
#customers
customers = [
    ['test1@test.user', '山田', '花子', 'ヤマダ', 'ハナコ', '1112222', '渋谷区', '09011111111'],
    ['test2@test.user', '松尾', '光輝', 'マツオ', 'コウキ', '3334444', '新宿区', '08011111111'],
    ['test3@test.user', '山田', '花子', 'ヤマダ', 'ハナコ', '5556666', '杉並区', '07011111111']
]
customers.each do |email, first_name, last_name, first_name_kana, last_name_kana, postal_code, address, telephone_number|
    Customer.create!(
      first_name: first_name,
      last_name: last_name,
      first_name_kana: first_name_kana,
      last_name_kana: last_name_kana,
      email: email,
      postal_code: postal_code,
      address: address,
      telephone_number: telephone_number,
      password: "password"
      )
end

#genres
genre_names = ['ケーキ', 'プリン', 'キャンディ', '焼き菓子' ]
genre_names.each do |genre_name|
   Genre.create!(
      name: genre_name,
      )
end

#items
32.times do |n|
    Item.create!(
        genre_id: rand(1..4),
        name: "サンプル商品#{n + 1}",
        introduction: "sample text#{n + 1}",
        price: [300, 400, 500].sample,
        is_active: [true, false].sample
    )
end

# order
# Order.all.each do |order|
# order.update(created_at: (rand*10).days.ago)
# end