# frozen_string_literal: true

require 'test_helper'

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:two)
  end

  test 'should get index' do
    get profile_url
    assert_response :success
  end

  test 'should not get index' do
    delete sign_out_path

    get profile_url
    assert_response :redirect
  end
end
