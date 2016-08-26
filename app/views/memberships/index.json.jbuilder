json.array! @memberships do |membership|
  json.extract! membership, :id, :name, :start_date, :end_date
end