require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  let(:login_params){
    {email: "albertlawer@gmail.com", password: "123456"}
  }

  let(:singup_params){
    {fullname: "Albert Lawer", email: "albertlawer@gmail.com", password: "123456"}
  }

  describe "GET /login" do


    it "returns http success" do
      post "/login", params: login_params, as: :json
      expect(response).to have_http_status(:success)
    end


  end

  describe "GET /signup" do
    it "returns http success" do
      post "/signup", params: singup_params, as: :json
      expect(response).to have_http_status(:created)
    end

  end

end
