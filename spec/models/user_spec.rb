require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーモデルテスト' do
    context 'Eメールアドレスバリデーション' do
      it 'emailが空ならバリデーションが通らない' do
        user = User.new(name: '失敗テスト', email:"", password: 'password')
        expect(user).not_to be_valid
      end
      it 'emailのフォーマットに従っていない場合、バリデーションが通らない' do
        user = User.new(name: '失敗テスト', email:"email", password: 'password')
        expect(user).not_to be_valid
      end
      it 'emailが91文字以上ならバリデーションが通らない' do
        user = User.new(name: '失敗テスト', email: "#{'a'*77}user@email.com", password: 'password')
        expect(user).not_to be_valid
      end
    end
    context '名前バリデーション' do
      it 'nameが空ならバリデーションが通らない' do
        user = User.new(email: 'user@example.com', employee_number: 100001, password: 'password')
        expect(user).not_to be_valid
      end
      it 'nameが26文字以上ならバリデーションが通らない' do
        user = User.new(name: 'a'*26, email: 'user@example.com', employee_number: 100001, password: 'password')
        expect(user).not_to be_valid
      end
    end
    context 'パスワードバリデーション' do
      it 'passwordが空ならバリデーションが通らない' do
        user = User.new(name: '失敗テスト', email: 'user@example.com', employee_number: 100001)
        expect(user).not_to be_valid
      end
    end
    context '社員番号バリデーション' do
      it 'employee_numberが空ならバリデーションが通らない' do
        user = User.new(name: '失敗テスト', email: 'user@example.com', password: 'password')
        expect(user).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'name,email,passwordをフォーマットに従って入力した場合、バリデーションが通る' do
        user = User.new(name: '成功テスト', email: 'user@example.com', employee_number: 100001, password: 'password')
        expect(user).to be_valid
      end
    end
  end
end
