require 'rails_helper'

RSpec.describe IdMaster, type: :model do
  
  let(:a_user){create(:user)}
  let(:theMaster){build(:id_master, user: a_user)}

  it 'should validate factory' do
    expect(theMaster).to be_valid
  end

  it 'should validate attributes' do
    new_data = IdMaster.new
    expect(new_data).not_to be_valid
  end

  it 'should validate an actual user' do
    new_build = build(:id_master, user_id: 125)
    expect(new_build).not_to be_valid
  end

end
