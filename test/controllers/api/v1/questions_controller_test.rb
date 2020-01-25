require 'test_helper'

class Api::V1::QuestionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'get_response_for_question' do
    process :list, method: :get, headers: api_key_header,
    params: {exam_id: exams(:one).id}
    assert_response :ok
    assert_template 'api/v1/questions/list'
    [:exam].each do |key|
    assert json_response.has_key?(key.to_s)
    end
  end
end
