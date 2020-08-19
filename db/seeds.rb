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
  5.times do |n|
    category_name = Faker::Color.color_name
    explanation = "category_explanation"
    @category = Category.create!(
      name: category_name,
      explanation: explanation,
      company_id: company.id,
    )
  end
  5.times do |n|
    customer_name = Faker::Company.name
    phone_number = Faker::Company.duns_number
    location = Faker::Address.city
    overview = Faker::Company.industry
    customer = Customer.create!(
      name: customer_name,
      phone_number: phone_number,
      location: location,
      overview: overview,
      company_id: company.id,
    )
    5.times do |l|
      project_name = Faker::App.name
      explanation = "project_explanation"
      location = Faker::Address.city
      @project = Project.create!(
        name: project_name,
        explanation: explanation,
        location: location,
        customer_id: customer.id,
      )
    end
  end
  5.times do |n|
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
    team_name = Faker::Team.name
    team_profile = "team_profile"
    team = Team.create!(
      name: team_name,
      profile: team_profile,
      owner_id: user.id,
      company_id: company.id,
    )
    team_assign = TeamAssign.create!(
      user_id: user.id,
      team_id: team.id,
    )
    5.times do |l|
      title = Faker::Job.field
      drawing_number = Faker::Number.number(digits: 6)
      explanation = "drawing_explanation"
      drawing = Drawing.create!(
        title: title,
        drawing_number: drawing_number,
        explanation: explanation,
        team_id: team.id,
        project_id: @project.id
      )
      if l.even?
        CategoryAssign.create!(
          drawing_id: drawing.id,
          category_id: @category.id,
        )
      end
      2.times do |t|
        title = Faker::Job.title
        content = "task_content"
        status = 0
        deadline = Faker::Date.between(from: Date.today, to: 7.days.from_now)
        task = Task.create!(
          title: title,
          content: content,
          status: status,
          deadline: deadline,
          drawing_id: drawing.id,
          staff_id: user.id,
          approver_id: user.id,
        )
        comment = "evidence_comment"
        evidence = Evidence.create!(
          comment: comment,
          task_id: task.id,
        )
        comment = "reference_comment"
        reference = Reference.create!(
          comment: comment,
          task_id: task.id,
        )
      end
    end
  end
end
