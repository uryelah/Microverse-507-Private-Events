require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get login_url
    assert_response :success
  end

  test 'should post login' do
    post login_url, params: { session: { name: 'test1', email: 'test1@mail.com' } }, xhr: true
    assert_response :success
  end

  test 'should delete logout' do
    delete logout_url, xhr: true
    assert_response :success
  end
end
