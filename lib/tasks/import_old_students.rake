require 'csv'
require 'ruby-progressbar'
namespace :import_old_students do
  task :load => :environment do
    students = {}
    payments = {}
    map_products = {
        '12': 'VA2013A',
        '13': 'VA2013B',
        '14': 'VA2013K',
        '20': 'VA2014A',
        '21': 'VA2014B',
        '22': 'VA2014K',
        '28': 'VA2015A',
        '29': 'VA2015B',
        '30': 'VA2015K',
        '34': 'WEI'
    }.with_indifferent_access
    errors = []
    puts 'Started ...'
    CSV.foreach(ENV['STUDENT_CSV'] || '/Users/pvienne/Downloads/Etudiant.csv', :headers => true) do |row|
      students[row['id']] = row.to_hash
    end
    CSV.foreach(ENV['PAYMENT_CSV'] || '/Users/pvienne/Downloads/Payment.csv', :headers => true) do |row|
      payments[row['student_id']] = [] unless payments[row['student_id']]
      payments[row['student_id']] << row.to_hash
    end

    students.each_value do |s|
      begin
        student = Student.find_or_create_by! last_name: s['name'], first_name: s['firstName'], birthday: Date.strptime(s['birthday'], '%Y-%m-%d'), email: s['mail'], gender: (s['civilite'] == 'M' ? 'M' : 'W')
        if s['annee']
          student.study_year = StudyYear.find_by_year s['annee']
        end
        if s['departement']
          student.department = Department.find_by_code s['departement']
        end
        student.created_at = DateTime.parse(s['dateCreation'])
        student.updated_at = DateTime.parse(s['dateModification'])
        if s['remarque'].to_s == 'NULL'
          student.details = ''
        else
          student.details = s['remarque']
        end
        student.save!
        begin
          student.update! phone: PhonyRails.normalize_number(s['tel'], country_code: 'FR')
        rescue => _
          student.update! phone: ''
        end
        begin
          student.update! student_id: s['numEtudiant']
        rescue => _
          student.update! student_id: ''
        end
        if payments[s['id']]
          payments[s['id']].each do |p|
            if map_products.has_key? p['product_id'].to_s
              method = case p['method']
                         when 'CB'
                           'Carte Bancaire'
                         when 'ESP'
                           'Espèces'
                         else
                           'Chèque'
                       end
              method = PaymentMethod.find_by_name(method)
              mapped_product = map_products[p['product_id'].to_s]
              if mapped_product == 'WEI'
                WeiRegistration.create!(student: student,
                                        status: 'waiting',
                                        paid: false,
                                        caution: false,
                                        parental: false,
                                        details: student.details,
                                        registration_by: DateTime.parse(p['date']))
              else
                Payment.create!(payment_method: method,
                                student: student,
                                created_at: DateTime.parse(p['date']),
                                payable: Membership.find_by_name(mapped_product))
              end
            end
          end
        end
      rescue => _
        errors << {
            error: _,
            student: s
        }.with_indifferent_access
      end
    end

    putc '== Errors =='
    errors.each do |e|
      puts e[:student]
      puts e[:error]
    end

    puts 'Done!'
  end
end
