@results.each do |k,v|
  json.set! k do
    json.array! v do |s|
      json.extract! s, :id, :card, :first_name, :last_name, :phone, :email, :member?
      json.study_year s.study_year&.name
      json.department s.department&.name
      json.memberships do
        json.array! s.memberships do |membership|
          json.extract! membership, :name, :price, :start_date, :end_date
        end
      end
    end
  end
end