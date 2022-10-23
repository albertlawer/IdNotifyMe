require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){build(:user)}

  it "should validate user factory" do
    expect(user).to be_valid
  end

  it "should validate user attributes" do
    new_user = User.new
    expect(new_user).not_to be_valid
  end
  
  it "should vaidate unique email" do
    user_one = User.create(fullname: "my Alb", email: "alb@alb.com", password:"123456")
    user_two = User.create(fullname: "my Aldab", email: "alb@alb.com", password:"123dad456")
    expect(user_two).not_to be_valid
  end
  

end
