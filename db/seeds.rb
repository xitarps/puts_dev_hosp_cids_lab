# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

Faker::Config.locale = 'pt-BR'

puts 'Criando Cids'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'CID-10-CATEGORIAS.CSV'))
csv = CSV.parse(csv_text, headers: true, col_sep: ';', encoding: 'UTF-8')

csv.each do |row|
  data = {
    number: row[0],
    description: row['DESCRICAO']
  }

  Cid.create(data)
end

puts 'Cids criadas'


puts 'Criando Usuarios'

Faker::Number.between(from: 20000, to: 25000).times do
  User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 90))
end

puts 'Usuarios criados'


puts 'Criando Hospitais'

Faker::Number.between(from: 100, to: 150).times do
  Hospital.create(name: Faker::Company.name)
end

puts 'Hospitais criados'


puts 'Atrelando usuarios as cids'

cid_qtd = Cid.count
user_qtd = User.count

User.all.each do |user|
  jump = [ false, false, false, true ].sample

  next if jump

  id = Faker::Number.between(from: 1, to: cid_qtd)
  cid = Cid.find(id)

  UserCid.create(user: user, cid: cid, first_diagnosed_at: Faker::Time.between(from: '01-01-1990 00:00:00', to: '31-12-2000 23:59:59'))
end

User.count.times do
  user_id = Faker::Number.between(from: 1, to: user_qtd)
  user = User.find(user_id)

  cid_id = Faker::Number.between(from: 1, to: cid_qtd)
  cid = Cid.find(cid_id)

  UserCid.create(user: user, cid: cid, first_diagnosed_at: Faker::Time.between(from: '01-01-1990 00:00:00', to: '31-12-2000 23:59:59'))
end

puts 'Usuarios atralados as cids'


puts 'Atrelando UserCids aos Hosptiais'

hospital_qtd = Hospital.count

UserCid.all.each do |user_cid|
  hospital_id = Faker::Number.between(from: 1, to: hospital_qtd)
  hospital = Hospital.find(hospital_id)

  treatment_start_at = Faker::Time.between(from: '01-01-2000 00:00:00', to: ' 31-12-2025 23:59:59')

  time_on_treatment_in_days = Faker::Number.between(from: 15, to: (365*5))
  treatment_end_at = treatment_start_at + time_on_treatment_in_days

  HospitalUserCid.create(
    hospital: hospital,
    user_cid: user_cid,
    treatment_start_at: treatment_start_at,
    treatment_end_at: treatment_end_at
  )
end

puts 'UserCids atrelados aos Hosptiais'
