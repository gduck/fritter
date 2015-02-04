json.user @likes.first.user_id
json.pins @likes do |like|
  json.id like.pin.id
  json.pinterest_id like.pin.pinterest_id
  json.title like.pin.title
  json.optional_info like.pin.optional_info
  json.source_url like.pin.source_url
  json.domain_url like.pin.domain_url
  json.img_sm_url like.pin.img_sm_url
  json.like_count like.pin.like_count
  json.category_name like.pin.category.name
  json.liked_by_me true
end
 