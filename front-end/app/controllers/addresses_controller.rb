class AddressesController < ApplicationController
  # GET /addresses
  # GET /addresses.json
  def index
    # raise "error"
    render :text => HTTParty.get("http://address-api:3000/addresses.json")
  end
end
