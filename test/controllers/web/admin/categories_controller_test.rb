# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    sign_in users(:two)
    @attributes = { name: Faker::IndustrySegments.industry }
  end

  test 'authorized admin should get index' do
    get admin_categories_url
    assert_response :success
  end

  test 'unauthorized users cannot get index' do
    sign_out

    get admin_categories_url
    assert_response :redirect
  end

  test 'should get new' do
    get new_admin_category_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_category_url(@category)
    assert_response :success
  end

  test 'should update category' do
    patch admin_category_url(@category), params: { category: @attributes }

    @category.reload

    assert(@category.name == @attributes[:name])
    assert_redirected_to admin_category_url(@category)
  end

  test 'should create a category' do
    post admin_categories_url, params: { category: @attributes }

    category = Category.find_by(name: @attributes[:name])
    assert_not_nil category
    assert_redirected_to admin_categories_url
  end

  test 'should destroy a category' do
    delete admin_category_url(@category)

    assert_not(Category.exists?(@category.id))

    assert_redirected_to admin_categories_url
  end
end
