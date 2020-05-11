require 'test_helper'

class OntarioControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ontario_index_url
    assert_response :success
  end

end
