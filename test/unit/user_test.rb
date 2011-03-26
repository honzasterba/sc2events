require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should "create from hash" do
    user = User.create_from_hash!('user_info' => { 'name' => 'Dow Jones' })
    assert !user.new_record?
    assert_equal "Dow Jones", user.name
  end

end
