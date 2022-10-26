class ApplicationController < ActionController::API
    SECRET = "albertKarley"

    def authentication
        token = request.headers["HTTP_AUTHORIZATION"]
        if token.nil?
            render json: {message: "Missing Token, Please add token to the headers to access"}, status: :unauthorized
        else
            theResp = decode_token(token)
            if !theResp[0]
                render json: {message: theResp[1]}, status: :unauthorized
            end
        end
    end

    def encode_token(user,valid_for_minutes)
        exp = Time.now.to_i + (valid_for_minutes*60)
        payload = { "iss": "albertlawer",
                "exp": exp,
                "aud": "238d4793-70de-4183-9707-48ed8ecd19d9",
                "sub": "19016b73-3ffa-4b26-80d8-aa9287738677",
                "name": user.fullname,
                "user_id": user.id,
                "user_email": user.email
        }
        token = JWT.encode payload, SECRET, 'HS256'
        return token
    end



    def decode_token(token)
        unless token
          return [false,""]
        end
    
        token.gsub!('Bearer ','')
        begin
          decoded_token = JWT.decode token, SECRET, true
          return [true,""]
        rescue JWT::DecodeError => e
            return [false,"Error decoding the JWT: "+ e.to_s]
        end
    end

    def token_data(token)
        token.gsub!('Bearer ','')
        decoded_token = JWT.decode token, SECRET, true
        return decoded_token
    end

end
