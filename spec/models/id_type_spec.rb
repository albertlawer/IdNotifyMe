require 'rails_helper'

RSpec.describe IdType, type: :model do
  
  let(:id_type){build :id_type}
  
  it "should validate factory" do
    expect(id_type).to be_valid
  end

  it "should validate attributes" do
    a_type = IdType.new
    expect(a_type).not_to be_valid
  end
end
