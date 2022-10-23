class SessionsController < ApplicationController

  def login
    user = User.find_by(email: params[:email])
    if user && user.password == params[:password]
      token = encode_token(user, valid_for_minutes = 60 )
      render json: {message: "Success", token: token}, status: :ok
    else
      render json: {message: "Invalid credentails." }
    end
  end


  def signup
    user = User.new(user_params)
    if user.save
      token = encode_token(user, valid_for_minutes = 60 )
      render json: {message: "Success", token: token}, status: :created
    else
      render json: {message: "Invalid setup.", errors: user.errors }
    end
  end

  private
    def user_params
      params.permit(:email, :fullname, :password)
    end

end
