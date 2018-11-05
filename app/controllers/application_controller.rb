require 'will_paginate/array'

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_model_errors
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  protected

  def render_model_errors(exception)
    render json: { error: exception }, status: :unprocessable_entity
  end

  def render_not_found(exception)
    render json: { error: exception }, status: :not_found
  end
end
