require 'rails_helper'

RSpec.describe "IdTypes", type: :request do

  let(:the_type){build :id_type}

  let(:the_valid_params){
    {name: "Drivers License", description: "THe drivers license"}
  }

  let(:the_invalid_params){
    {name: "", description: ""}
  }

  describe "GET /index" do
    it "returns http success" do
      get "/id_types"
      expect(response).to have_http_status(:ok)
    end

    it "returns a valid JSON" do
      get "/id_types"
      expect(response.content_type).to match(a_string_including("application/json"))
    end
  end

  describe "GET /show" do
    it "returns http success" do
      the_type_two = build :id_type
      get "/id_types/#{the_type_two.id}"
      expect(response).to have_http_status(:ok)
    end

    it "returns json" do
      the_type_two = create :id_type
      get "/id_types/#{the_type_two.id}"
      expect(response.content_type).to match(a_string_including("application/json"))
    end
    
    it "returns valid data" do
      the_type_two = create :id_type
      get "/id_types/#{the_type_two.id}"
      body = JSON.parse(response.body)
      the_id = body["data"]["id"]
      expect(the_id).to eq the_type_two.id.to_s
    end
  end

  describe "POST /create" do
    it "returns http created for valid data" do
      post "/id_types", params: the_valid_params, as: :json
      expect(response).to have_http_status(:created)
    end

    it "save the data and change the count by 1 for valid data" do
      expect{post "/id_types", params: the_valid_params, as: :json}.to change(IdType, :count).by(1)
    end
    
    it "returns no count update" do
      expect{post "/id_types", params: the_invalid_params, as: :json}.to change(IdType, :count).by(0)
    end
    
    it "returns unprocessable for invalid data" do
      post "/id_types", params: the_invalid_params, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "Put /update" do
    it "should update a transaction" do
      type_one = create :id_type
      type_two = IdType.create(name: "Health Insurance", description: "my health insurance")
      put "/id_types/#{type_two.id}", params: the_valid_params, as: :json
      expect(response).to have_http_status(:ok) 
    end
    
  end
  
end
