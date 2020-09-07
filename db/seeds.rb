# frozen_string_literal: true

5.times do |_m|
  company_name = Faker::Company.name
  phone_number = Faker::Company.duns_number
  location = Faker::Address.city
  overview = Faker::Company.industry
  company = Company.create!(
    name: company_name,
    phone_number: phone_number,
    location: location,
    overview: overview
  )
  @categories = []
  5.times do |_n|
    category_name = Faker::Color.color_name
    explanation = 'category_explanation'
    category = Category.create!(
      name: category_name,
      explanation: explanation,
      company_id: company.id
    )
    @categories << category
  end
  @customers = []
  @projects = []
  5.times do |_n|
    customer_name = Faker::Company.name
    phone_number = Faker::Company.duns_number
    location = Faker::Address.city
    overview = Faker::Company.industry
    customer = Customer.create!(
      name: customer_name,
      phone_number: phone_number,
      location: location,
      overview: overview,
      company_id: company.id
    )
    @customers << customer
    5.times do |_l|
      project_name = Faker::App.name
      explanation = 'project_explanation'
      location = Faker::Address.city
      project = Project.create!(
        name: project_name,
        explanation: explanation,
        location: location,
        customer_id: customer.id
      )
      @projects << project
    end
  end
  @users = []
  5.times do |n|
    name = Faker::Name.name
    employee_number = Faker::Number.number(digits: 6)
    email = Faker::Internet.email
    password = 'password'
    user = User.create!(
      name: name,
      email: email,
      employee_number: employee_number,
      password: password,
      password_confirmation: password,
      company_id: company.id
    )
    company.update!(admin_id: user.id) if n.zero?
    @users << user
  end
  5.times do |_t|
    @members = []
    team_name = Faker::Team.name
    team_profile = 'team_profile'
    owner = @users.sample
    team = Team.create!(
      name: team_name,
      profile: team_profile,
      owner_id: owner.id,
      company_id: company.id
    )
    TeamAssign.create!(
      user_id: owner.id,
      team_id: team.id
    )
    @members << owner
    2.times do |_ta|
      loop do
        member = @users.sample
        unless @members.include?(member)
          @members << member
          break
        end
      end
      TeamAssign.create!(
        team_id: team.id,
        user_id: @members[-1].id
      )
    end
    5.times do |_l|
      title = Faker::Job.field
      drawing_number = Faker::Number.number(digits: 6)
      explanation = 'drawing_explanation'
      drawing = Drawing.create!(
        title: title,
        drawing_number: drawing_number,
        explanation: explanation,
        team_id: team.id,
        project_id: @projects.sample.id
      )
      3.times do |r|
        revision = Revision.new
        revision.revision_number = r
        revision.comment = 'revision_comment'
        revision.drawing_id = drawing.id
        revision.content.attach(io: File.open('spec/factories/test.jpg'), filename: 'test.jpg')
        revision.save!
      end
      2.times do |_t|
        title = Faker::Job.title
        content = 'task_content'
        status = 0
        deadline = Faker::Date.between(from: Date.today, to: 7.days.from_now)
        task = Task.create!(
          title: title,
          content: content,
          status: status,
          deadline: deadline,
          drawing_id: drawing.id,
          staff_id: @members.sample.id,
          approver_id: @members.sample.id
        )
        comment = 'evidence_comment'
        Evidence.create!(
          comment: comment,
          task_id: task.id
        )
        comment = 'reference_comment'
        Reference.create!(
          comment: comment,
          task_id: task.id
        )
        2.times do |_q|
          title = Faker::Job.title
          content = 'question_content'
          question = Question.create!(
            title: title,
            content: content,
            task_id: task.id
          )
          2.times do |_com|
            content = 'comment_content'
            comment = Comment.create!(
              content: content,
              user_id: @members.sample.id,
              question_id: question.id
            )
          end
        end
      end
    end
  end
end
