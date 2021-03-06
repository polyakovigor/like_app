require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'is composed of first and second name' do
    expect(user.full_name).to eq "#{user.first_name} #{user.last_name}"
  end

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is invalid with blank attributes' do
    expect(User.create(first_name: '', last_name: '', email: '', password: '', password_confirmation: '')).not_to be_valid
  end

  describe 'User associations' do
    it { expect(user).to have_many(:categories) }
    it { expect(user).to have_many(:images).through(:categories) }
    it { expect(user).to have_many(:images) }
    it { expect(user).to have_many(:comments) }
    it { expect(user).to have_many(:chat_rooms) }
    it { expect(user).to have_many(:messages) }
    it { expect(user).to have_many(:likes) }
    it { expect(user).to have_many(:events) }
  end

  describe 'User validations' do
    it { expect(user).to validate_presence_of(:first_name) }
    it { expect(user).to validate_presence_of(:last_name) }
    it { expect(user).to validate_length_of(:first_name).is_at_most(50) }
    it { expect(user).to validate_length_of(:last_name).is_at_most(50) }
  end
end
