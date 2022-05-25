# frozen_string_literal: true

require 'test_helper'

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  test 'signed in user should get index' do
    sign_in users(:two)

    get profile_url
    assert_response :success
  end

  test 'guest cannot get profile page' do
    get profile_url
    assert_response :redirect
  end
end
