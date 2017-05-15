# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Skill.create(name: 'Разговорный английский', accepted: true)
Skill.create(name: 'Умение плясать', accepted: false)
Skill.create(name: 'Водительские права категории В', accepted: true)
Skill.create(name: 'Презентабельная внешность', accepted: true)
Skill.create(name: 'Опыт работы в торговле', accepted: true)

User.create(name: 'Иванов Иван Иванович', email: 'i@example.com', password: '1')
User.create(name: 'Петров Петр Петрович', email: 'p@example.com', password: '1')
User.create(name: 'Непомнящих Ольга Васильевна', email: 'o@example.com', password: '1', ka_staff: true)