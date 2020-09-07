# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '会社モデルテスト' do
    context '会社名バリデーション' do
      it 'nameが空ならバリデーションが通らない' do
        company = Company.new(phone_number: '090-000-0111')
        expect(company).not_to be_valid
      end
      it 'nameが101文字以上ならバリデーションが通らない' do
        company = Company.new(name: 'a' * 101, phone_number: '090-000-0111')
        expect(company).not_to be_valid
      end
    end
    context '電話番号バリデーション' do
      it 'phone_numberが空ならバリデーションが通らない' do
        company = Company.new(name: 'sample')
        expect(company).not_to be_valid
      end
      it 'phone_numberがフォーマットに従っていないならバリデーションが通らない' do
        company = Company.new(name: 'sample', phone_number: '0901010001')
        expect(company).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'name,phone_numberのバリデーションが通る' do
        company = Company.new(name: 'sample', phone_number: '090-101-0001')
        expect(company).to be_valid
      end
    end
  end
end
