ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  def self.logged_in(&block)
    logged_in_as(Factory(:user), &block)
  end

  def self.logged_in_as(user, &block)
    context "logged in as #{user.name}" do
      setup do
        @user = user
        session[:user_id] = @user.id
      end
      merge_block &block
    end
  end

  def self.should_require_admin(actions = nil, &block)
    actions ||= [:index]
    actions.each do |a|
      should "require admin for #{a}" do
        get a
        assert_response :redirect
      end
    end
    logged_in_as(Factory(:admin), &block)
  end
end
