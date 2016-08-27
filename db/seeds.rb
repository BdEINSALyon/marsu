# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1...5).each do |year|
  StudyYear.find_or_create_by(year: year, name: "#{year}A")
end

[
    {
        name: 'Premier Cycle',
        code: 'PC',
        active: true
    },
    {
        name: 'Télécommunication',
        code: 'TC',
        active: true
    },
    {
        name: 'Informatique',
        code: 'IF',
        active: true
    },
    {
        name: 'Génie Mécanique',
        code: 'GM',
        active: true
    },
    {
        name: 'Génie Civil Urbanisme',
        code: 'GCU',
        active: true
    },
    {
        name: 'Génie Electrique',
        code: 'GE',
        active: true
    },
    {
        name: 'Génie Industriel',
        code: 'GI',
        active: true
    },
    {
        name: 'Génie Energétique Environnement',
        code: 'GEN',
        active: true
    },
    {
        name: 'Biochime',
        code: 'BB',
        active: true
    },
    {
        name: 'Bio-Informatique Modélisation',
        code: 'BIM',
        active: true
    },
    {
        name: 'Génie Mécanique Conception',
        code: 'GMC',
        active: false
    },
    {
        name: 'Génie Mécanique Développement',
        code: 'GMD',
        active: false
    },
    {
        name: 'Génie Mécanique Procédés Plasturgiques',
        code: 'GMPP',
        active: false
    },
].each {|d|Department.find_or_create_by d}


PaymentMethod.all.update_all enabled: false
[
    'Carte Bancaire',
    'Espèces',
    'Chèque'
].each do |p|
  p = PaymentMethod.find_or_create_by name: p do |m|
    m.enabled = true
  end
  p.update enabled: true
end