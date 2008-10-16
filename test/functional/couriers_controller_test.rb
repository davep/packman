require File.dirname(__FILE__) + '/../test_helper'
require 'couriers_controller'

# Re-raise errors caught by the controller.
class CouriersController; def rescue_action(e) raise e end; end

class CouriersControllerTest < Test::Unit::TestCase
  def setup
    @controller = CouriersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
