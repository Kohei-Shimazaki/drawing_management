require 'rails_helper'

RSpec.describe Drawing, type: :model do
  describe '図面モデルテスト' do
    before do
      @company = create(:company)
      @customer = create(:customer, company: @company)
      @project = create(:project, customer: @customer)
      @user = create(:user)
      @team = create(:team, company: @company, owner: @user)
      @drawing = create(:drawing, team: @team, project: @project)
    end
    context '図面タイトルバリデーション' do
      it 'titleが空ならバリデーションが通らない' do
        drawing = Drawing.new(drawing_number: 1001, team: @team, project: @project)
        expect(drawing).not_to be_valid
      end
      it 'titleが101文字以上ならバリデーションが通らない' do
        drawing = Drawing.new(title: "d"*101, drawing_number: 1001, team: @team, project: @project)
        expect(drawing).not_to be_valid
      end
    end
    context '図番バリデーション' do
      it 'drawing_numberが空ならバリデーションが通らない' do
        drawing = Drawing.new(title: "sample", team: @team, project: @project)
        expect(drawing).not_to be_valid
      end
      it 'drawing_numberが21桁以上ならバリデーションが通らない' do
        drawing = Drawing.new(title: "sample", drawing_number: 10**20, team: @team, project: @project)
        expect(drawing).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'title,drawing_numberのバリデーションが通る' do
        drawing = Drawing.new(title: "sample", drawing_number: 1001, team: @team, project: @project)
        expect(drawing).to be_valid
      end
    end
  end
end
