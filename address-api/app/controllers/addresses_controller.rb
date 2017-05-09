class AddressesController < ApplicationController
  # GET /addresses
  def index
    @addresses = Address.all

    render json: @addresses
  end
end
