# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(2013..2016).each do |year|
  %w(A B K).each do |code|
    Membership.find_or_create_by! start_date: Date.new(year,9,1),
                                  end_date: Date.new(year+1,8,31),
                                  name: "VA#{year}#{code}",
                                  price: code == 'B' ? 95 : (code == 'A' ? 20 : 17)
  end
end
(1..5).each do |year|
  StudyYear.find_or_create_by(year: year, name: "#{year}A")
end
StudyYear.find_or_create_by(year: 8, name: "Doctorant INSA")
StudyYear.find_or_create_by(year: 15, name: "Doctorant non-INSA")
StudyYear.find_or_create_by(year: 16, name: "Personnel INSA")
StudyYear.find_or_create_by(year: 13, name: "Etudiant IUT")
StudyYear.find_or_create_by(year: 14, name: "Etudiant CPE")
StudyYear.find_or_create_by(year: 17, name: "Autre")

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
    {
        name: 'Autre',
        code: 'OTHER',
        active: true
    }
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