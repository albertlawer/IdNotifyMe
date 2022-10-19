class IdTypesController < ApplicationController
  before_action :set_id_type, only: [:show, :update]

  def index
    _types = IdType.all
    render json: serializer.new(_types), status: :ok 
  end

  def show
    render json: serializer.new(@id_type)
  end

  def create
    id_params=IdType.new(id_type_params)
    if id_params.save
      render json: serializer.new(id_params), status: :created
    else
      render json: id_params.errors, status: :unprocessable_entity
    end
  end

  def update
    if @id_type.update(id_type_params)
      render json: serializer.new(@id_type), status: :ok
    else
      render json: @id_type.errors, status: :unprocessable_entity
    end
  end

  private
    def serializer
      IdTypeSerializer
    end

    def set_id_type
      @id_type = IdType.find(params[:id])
    end

    def id_type_params
      params.require(:id_type).permit(:name, :description)
    end
end
