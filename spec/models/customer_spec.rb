require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '客先モデルテスト' do
    before do
      @company = create(:company)
    end
    context '客先名バリデーション' do
      it 'nameが空ならバリデーションが通らない' do
        customer = Customer.new(phone_number: "090-1001-0001", company: @company)
        expect(customer).not_to be_valid
      end
      it 'nameが101文字以上ならバリデーションが通らない' do
        customer = Customer.new(name: "M"*101, phone_number: "090-1001-0001", company: @company)
        expect(customer).not_to be_valid
      end
    end
    context '客先連絡先バリデーション' do
      it 'phone_numberが空ならバリデーションが通らない' do
        customer = Customer.new(name: 'sample', company: @company)
        expect(customer).not_to be_valid
      end
      it 'phone_numberがフォーマットに従っていないならバリデーションが通らない' do
        customer = Customer.new(name: 'sample', phone_number: "0901010001", company: @company)
        expect(customer).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'name,phone_numberのバリデーションが通る' do
        customer = Customer.new(name: "Mytext", phone_number: "090-1001-0001", company: @company)
        expect(customer).to be_valid
      end
    end
  end
end
