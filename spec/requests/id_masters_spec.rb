require 'rails_helper'

RSpec.describe "IdMasters", type: :request do

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
  let(:valid_params){
    {id_type_id: 1, name_on_id: Faker::Name.unique.name, id_number: Faker::IDNumber.valid, reference_number: Faker::IDNumber.south_african_id_number, issue_date: Faker::Date.between(from: '2014-09-23', to: '2014-09-25'), first_intermidiary_expiry: Faker::Date.between(from: '2017-09-23', to: '2017-09-25'), second_intermidiary_expiry: Faker::Date.between(from: '2019-09-23', to: '2019-09-25'), third_intermidiary_expiry: Faker::Date.between(from: '2021-09-23', to: '2021-09-25'), exipry_date: Faker::Date.between(from: '2023-09-23', to: '2023-09-25'), front_image: Faker::String.random(length: 28), back_image: Faker::String.random(length: 28)}
  }
  let(:invalid_params){
    {id_type_id: 1, name_on_id: Faker::Name.unique.name, id_number: "", reference_number: Faker::IDNumber.south_african_id_number, issue_date: Faker::Date.between(from: '2014-09-23', to: '2014-09-25'), first_intermidiary_expiry: Faker::Date.between(from: '2017-09-23', to: '2017-09-25'), second_intermidiary_expiry: Faker::Date.between(from: '2019-09-23', to: '2019-09-25'), third_intermidiary_expiry: Faker::Date.between(from: '2021-09-23', to: '2021-09-25'), exipry_date: Faker::Date.between(from: '2023-09-23', to: '2023-09-25'), front_image: Faker::String.random(length: 28), back_image: Faker::String.random(length: 28)}
  }

  describe "GET /index" do
    it "returns http success" do
      get "/id_masters", headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}
      expect(response).to have_http_status(:success)
    end

    it "returns unauthorized without the header" do
      get "/id_masters"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "Create /" do
    it "returns http created" do
      post "/id_masters", params: valid_params, headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}, as: :json
      expect(response).to have_http_status(:created)
    end

    it "increases count by 1" do
      expect{
              post "/id_masters", params: valid_params, headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}, as: :json
            }.to change(IdMaster, :count).by 1
    end

    it 'returns a failed creation' do
      post "/id_masters", params: invalid_params, headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not increase by 1' do
      expect{
        post "/id_masters", params: invalid_params, headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)}, as: :json
      }.to change(IdMaster, :count).by(0)
    end
  end

  describe 'show /id_master' do
    it 'returns http success' do
      new_user = create :user
      new_card = create(:id_master, user: new_user)
      get "/id_masters/#{new_card.id}", headers: {HTTP_AUTHORIZATION: encode_user_data(new_user)}
      expect(response).to have_http_status(:success)
    end
  end

  describe 'update /id_master' do
    it "retuns http success" do
      a_new_card = create(:id_master, user: a_user)
      puts "+++++++++++++++++++++++++++++++"
      puts a_new_card.inspect
      puts ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
      puts valid_params
      puts "+++++++++++++++++++++++++++++++"
      put "/id_masters/#{a_new_card.id}", params: valid_params, headers: {HTTP_AUTHORIZATION: encode_user_data(a_user)} ,as: :json
      expect(response).to have_http_status(:success)
    end
  end

end
