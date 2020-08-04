require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'カテゴリーモデルテスト' do
    before do
      @company = create(:company)
    end
    context 'カテゴリー名バリデーション' do
      it 'nameが空ならバリデーションが通らない' do
        category = Category.new(explanation: "Mytext", company: @company)
        expect(category).not_to be_valid
      end
      it 'nameが101文字以上ならバリデーションが通らない' do
        category = Category.new(name: "M"*101, company: @company)
        expect(category).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'nameが1文字以上100字以内ならバリデーションが通る' do
        category = Category.new(name: "Mytext", company: @company)
        expect(category).to be_valid
      end
    end
  end
end
