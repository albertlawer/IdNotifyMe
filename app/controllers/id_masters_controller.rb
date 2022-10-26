class IdMastersController < ApplicationController
  before_action :authentication
  before_action :get_user

  def index
    @id_masters = IdMaster.where(user_id: @user.id)
    render json: serialize.new(@id_masters)
  end

  def create
    _id_masters = IdMaster.new(id_masters_params)
    _id_masters.user_id = @user.id
    _id_masters.status = true
    if _id_masters.save
      render json: serialize.new(_id_masters), status: :created
    else
      render json: {message: "Cannot save", errors: _id_masters.errors }, status: :unprocessable_entity
    end
  end



  private
    def serialize
      IdMasterSerializer
    end

    def get_user
      token = request.headers["HTTP_AUTHORIZATION"]
      _user_data = token_data(token)
      @user = User.find(_user_data[0]["user_id"])
    end

    def id_masters_params
      params.permit(:id_type_id, :name_on_id, :id_number, :reference_number, :issue_date, :first_intermidiary_expiry, :second_intermidiary_expiry, :third_intermidiary_expiry, :exipry_date, :user_id, :front_image, :back_image )
    end
end
