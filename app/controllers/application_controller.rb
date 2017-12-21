class ApplicationController < ActionController::API
    # Register your helpers here for the controllers to know them
    include Response
    include ExceptionHandler
end
