json.user @users do |user|
  json.id @user.id
  json.email @user.email
  json.username @user.username
  json.signedIn @user.signed_in
  json.userprofile @user.userprofile
end