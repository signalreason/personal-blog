class AdminController < ApplicationController
  http_basic_authenticate_with name: "happy", password: "grandma"
end
