module Response
    # Define the json_response helper which responds with JSON and an HTTP status code (defaults to 200 ok)
    def json_response(object, status = :ok)
        render json: object, status: status
    end
end
