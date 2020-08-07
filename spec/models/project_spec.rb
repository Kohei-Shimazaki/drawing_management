require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'プロジェクトモデルテスト' do
    before do
      @company = create(:company)
      @customer = create(:customer, company: @company)
    end
    context 'プロジェクト名バリデーション' do
      it 'nameが空ならバリデーションが通らない' do
        project = Project.new(customer: @customer)
        expect(project).not_to be_valid
      end
      it 'nameが101文字以上ならバリデーションが通らない' do
        project = Project.new(name: "a"*101, customer: @customer)
        expect(project).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'nameのバリデーションが通る' do
        project = Project.new(name: "sample", customer: @customer)
        expect(project).to be_valid
      end
    end
  end
end
