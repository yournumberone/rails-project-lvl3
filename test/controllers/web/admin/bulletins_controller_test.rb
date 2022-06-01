# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:under_moderation)
    # admin is not bulletin's owner
    sign_in users(:two)
  end

  test 'authorized admin should get index' do
    get admin_bulletins_url
    assert_response :success
  end

  test 'unauthorized users cannot get index' do
    sign_out

    get admin_bulletins_url
    assert_response :redirect
  end

  test 'should archive a bulletin' do
    patch archive_admin_bulletin_path(@bulletin)

    @bulletin.reload

    assert @bulletin.archived?
    assert_redirected_to admin_bulletins_path
  end

  test 'should reject a bulletin' do
    patch reject_admin_bulletin_path(@bulletin)

    @bulletin.reload

    assert @bulletin.rejected?
    assert_redirected_to admin_bulletins_path
  end

  test 'should publish a bulletin' do
    patch publish_admin_bulletin_path(@bulletin)

    @bulletin.reload

    assert @bulletin.published?
    assert_redirected_to admin_bulletins_path
  end

  test 'cannot publish bulletin which is not under moderation' do
    bulletin = bulletins(:draft)
    # naive attempt to publish
    patch publish_admin_bulletin_path(bulletin)

    @bulletin.reload

    assert bulletin.draft?
    assert_redirected_to bulletin_path(bulletin)
  end
end
