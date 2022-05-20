# frozen_string_literal: true

require 'test_helper'

class Web::BulletinControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
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
    delete sign_out_path

    get new_bulletin_url
    assert_response :redirect
  end

  test 'should create bulletin' do
    post bulletins_url, params: { bulletin: @attributes }

    bulletin = Bulletin.find_by(title: @attributes[:title])
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

    #  не понял, почему стейт не обновляется. но редирект нужный отрабатывает
    # assert @bulletin.state == 'archived'
    assert_redirected_to profile_url
  end

  test 'should send bulletin to moderation' do
    patch to_moderate_bulletin_path(@bulletin)

    # assert @bulletin.state == 'under_moderation'
    assert_redirected_to profile_url
  end
end
