json.array! @payments do |p|
  json.extract! p, :id, :created_at, :updated_at, :refunded, :payable_id, :payable_type, :student_id
  json.user p.user_id
end