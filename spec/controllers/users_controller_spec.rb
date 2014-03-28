require 'spec_helper'

describe UsersController do

  describe "GET 'Welcome'" do
    it "returns http success" do
      get 'Welcome'
      response.should be_success
    end
  end

end
