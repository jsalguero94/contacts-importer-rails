require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    it 'has valid factory' do
      user = build :user
      expect(user).to be_valid
    end

    it 'validates presence of attributes' do
      user = build :user, email: nil, password: nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include("can't be blank")
      expect(user.errors.messages[:password]).to include("can't be blank")
    end

    it 'validates correct email format' do
      user = build :user, email: 'jhon'
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include('is invalid')
    end

    it 'password minimum 6 characters' do
      user = build :user, password: '1'
      expect(user).not_to be_valid
      expect(user.errors.messages[:password]).to include('is too short (minimum is 6 characters)')
    end

    it 'has unique email' do
      user = create :user
      other_user = build :user, email: user.email
      expect(other_user).not_to be_valid
      expect(other_user.errors.messages[:email]).to include('has already been taken')
    end
  end
end
