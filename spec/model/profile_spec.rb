require 'rails_helper'

describe Profile do
  it 'automatically adds default fields' do
    new_profile = Profile.create
    expect(new_profile.salary).to be 0
    expect(new_profile.act).to be true
    expect(new_profile.skills).to eq([])
  end

end