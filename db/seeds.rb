5.times do |m|
  company_name = Faker::Company.name
  phone_number = Faker::Company.duns_number
  location = Faker::Address.city
  overview = Faker::Company.industry
  company = Company.create!(
    name: company_name,
    phone_number: phone_number,
    location: location,
    overview: overview,
  )
  10.times do |n|
    name = Faker::Name.name
    employee_number = Faker::Number.number(digits: 6)
    email = Faker::Internet.email
    password = "password"
    user = User.create!(
      name: name,
      email: email,
      employee_number: employee_number,
      password: password,
      password_confirmation: password,
      company_id: company.id,
    )
    if n == 0
      company.update!(admin_id: user.id)
    end
  end
end
