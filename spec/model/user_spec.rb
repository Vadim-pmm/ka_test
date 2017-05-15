require 'rails_helper'

describe User do
  it 'is valid when name consists of 3 cyrillic words' do
    new_user = User.new(name: 'Иван Иванович Иванов', email: 'ii@example.com', password: '11')
    expect(new_user).to be_valid
  end
  it 'is invalid when name does not consist of 3 words' do
    new_user = User.new(name: 'Иван Иванович', email: 'ii@example.com', password: '11')
    expect(new_user).not_to be_valid
  end
  it 'is invalid when name has some different characters' do
    new_user = User.new(name: 'Ива%н Иван1ович Bd_yjd ', email: 'ii@example.com', password: '11')
    expect(new_user).not_to be_valid
  end

  it 'is invalid when name looks like non-cyrillic name' do
    new_user = User.new(name: 'Peter John Gabriel', email: 'ii@example.com', password: '11')
    expect(new_user).not_to be_valid
  end
  it 'automatically adds default fields' do
    new_user = User.create(name: 'Иван Иванович Иванов', email: 'ii@example.com', password: '11')
    expect(new_user.ka_staff).to be false
    expect(new_user.admin).to be false
  end

end