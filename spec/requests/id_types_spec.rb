require 'rails_helper'
SECRET = "albertKarley"

RSpec.describe "IdTypes", type: :request do

  def encode_user_data(the_user)
    exp = Time.now.to_i + (1*60)
    payload = { "iss": "albertlawer",
            "exp": exp,
            "aud": "238d4793-70de-4183-9707-48ed8ecd19d9",
            "sub": "19016b73-3ffa-4b26-80d8-aa9287738677",
            "name": the_user.fullname,
            "user_id": the_user.id,
            "user_email": the_user.email
    }
    token = JWT.encode payload, SECRET, 'HS256'
    return token
  end

  
  let(:a_user){create(:user)}

  let(:the_type){build :id_type}

  let(:the_valid_params){
    {name: "Drivers License", description: "THe drivers license"}
  }

  let(:the_invalid_params){
    {name: "", description: ""}
  }

  describe "GET /index" do

    it "returns unauthorized" do
      get "/id_types"
      expect(response).to have_http_status(:unauthorized)
    end
    

    it "returns http success" do
      get "/id_types", headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}
      expect(response).to have_http_status(:ok)
    end

    it "returns a valid JSON" do
      get "/id_types", headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}
      expect(response.content_type).to match(a_string_including("application/json"))
    end
  end

  describe "GET /show" do
    it "returns http success" do
      the_type_two = build :id_type
      get "/id_types/#{the_type_two.id}", headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}
      expect(response).to have_http_status(:ok)
    end

    it "returns json" do
      the_type_two = create :id_type
      get "/id_types/#{the_type_two.id}", headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}
      expect(response.content_type).to match(a_string_including("application/json"))
    end
    
    it "returns valid data" do
      the_type_two = create :id_type
      get "/id_types/#{the_type_two.id}", headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}
      body = JSON.parse(response.body)
      the_id = body["data"]["id"]
      expect(the_id).to eq the_type_two.id.to_s
    end
  end

  describe "POST /create" do
    it "returns http created for valid data" do
      post "/id_types", params: the_valid_params, as: :json, headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}
      expect(response).to have_http_status(:created)
    end

    it "save the data and change the count by 1 for valid data" do
      expect{post "/id_types", params: the_valid_params, as: :json, headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}}.to change(IdType, :count).by(1)
    end
    
    it "returns no count update" do
      expect{post "/id_types", params: the_invalid_params, as: :json, headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}}.to change(IdType, :count).by(0)
    end
    
    it "returns unprocessable for invalid data" do
      post "/id_types", params: the_invalid_params, as: :json, headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "Put /update" do
    it "should update a transaction" do
      type_one = create :id_type
      type_two = IdType.create(name: "Health Insurance", description: "my health insurance")
      put "/id_types/#{type_two.id}", params: the_valid_params, as: :json, headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}
      expect(response).to have_http_status(:ok) 
    end
    
  end
  
end
