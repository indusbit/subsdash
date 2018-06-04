module Api::V1
  class ApiController < ApplicationController
    respond_to :json

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { error: e.message }, status: :not_found
    end

    rescue_from ActionController::ParameterMissing do |e|
      # You can even render a jbuilder template too!
      render json: {error: e.message }, status: :unprocessable_entity
    end

  end
end
