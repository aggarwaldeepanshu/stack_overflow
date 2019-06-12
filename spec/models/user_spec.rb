RSpec.describe User, type: :model do
	subject do
		build(:user)
	end

  it 'is valid' do
    expect(subject.valid?).to be(true)
  end

  describe 'Validations' do
    #Basic Validations

    it 'Email is present' do
      expect(subject.email.empty?).to be(false)
    end

    it 'Name is present' do
      expect(subject.name.empty?).to be(false)
    end

    it 'Password is present' do
      expect(subject.password.empty?).to be(false)
    end

    #Format validations

    it { expect(subject).to_not allow_value('deepanshu@gmail').for(:email) }

    #Inclusion/acceptance of values

    it 'Email has length less than 255 characters' do
      expect(subject.email.length < 255).to be(true)
    end

    it 'Name has length less than 50 characters' do
      expect(subject.name.length < 50).to be(true)
    end

    it 'Password has minimum 5 characters' do
      expect(subject.password.length >= 5).to be(true)
    end
  end

  describe 'Associations' do 
    #Associations

    #user has_many questions
    it { expect(subject).to have_many(:questions).dependent(:destroy) }
  end
end
















