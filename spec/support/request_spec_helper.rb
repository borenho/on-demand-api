# Custom request helpers

module RequestSpecHelper
    # Parse JSON response to a ruby hash (easier to work with in the tests)
    def json
        JSON.parse(response.body)
    end
end
