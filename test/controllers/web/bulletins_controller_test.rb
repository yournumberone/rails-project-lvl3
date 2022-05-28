# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:draft)
    sign_in @bulletin.user
    @category = categories(:one)
    @attributes = {
      title: Faker::Vehicle.model,
      description: Faker::Movies::Lebowski.quote,
      category_id: @category.id,
      image: Rack::Test::UploadedFile.new('test/fixtures/files/nina.jpg', 'image/jpg')
    }
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
  end

  test 'should get new' do
    get new_bulletin_url
    assert_response :success
  end

  test 'unauthenticated users cannot get new' do
    sign_out

    get new_bulletin_url
    assert_response :redirect
  end

  test 'should create bulletin' do
    post bulletins_url, params: { bulletin: @attributes }
    bulletin = Bulletin.find_by(@attributes.except(:image))
    assert_redirected_to bulletin_path(bulletin.id)
  end

  test 'should show bulletin' do
    get bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should get edit' do
    get edit_bulletin_path(@bulletin)
    assert_response :success
  end

  test 'should update bulletin' do
    patch bulletin_url(@bulletin), params: { bulletin: @attributes }

    @bulletin.reload

    assert(@bulletin.title == @attributes[:title])
    assert_redirected_to bulletin_path(@bulletin)
  end

  test 'should destroy bulletin' do
    delete bulletin_url(@bulletin)

    assert_not(Bulletin.exists?(@bulletin.id))

    assert_redirected_to profile_url
  end

  test 'should send bulletin to archive' do
    patch archive_bulletin_path(@bulletin)

    @bulletin.reload

    assert @bulletin.archived?
    assert_redirected_to profile_url
  end

  test 'should send bulletin to moderation' do
    patch to_moderate_bulletin_path(@bulletin)

    @bulletin.reload

    assert_have_state @bulletin, :under_moderation
    assert_redirected_to profile_url
  end
end
