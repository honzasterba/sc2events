require 'test_helper'

class AuthorizationTest < ActiveSupport::TestCase

  should "create from hash" do
    hash = {
        'user_info' => { 'name' => 'Dow Jones' },
        'provider' => 'test-provider',
        'uid' => '123456'
    }
    auth = Authorization.create_from_hash(hash)
    assert_equal "Dow Jones", auth.user.name
    assert_equal "123456", auth.uid
    assert !auth.new_record?
  end

  context "auth exists" do

    setup do
      @auth = Factory :authorization
    end

    should "find by hash" do
      assert_equal @auth, Authorization.find_from_hash(
          'provider' => @auth.provider, 'uid' => @auth.uid)
    end
  end

end
