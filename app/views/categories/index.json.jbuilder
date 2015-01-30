json.categories @categories do |category|
  json.name category.name
  json.link category.simplified_name
  json.id category.id
end

