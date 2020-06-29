FactoryBot.define do
  factory :revision do
    revision_number { 1 }
    content { "MyText" }
    comment { "MyText" }
  end
end
