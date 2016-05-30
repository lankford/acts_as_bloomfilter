require 'test_helper'

class ActsAsBloomfilterTest < ActiveSupport::TestCase

  test 'module is included' do
    assert_kind_of Module, ActsAsBloomfilter
  end

  test "should include things that exist in the database already" do
    assert Widget.name_bloom.include?('name one')
  end

  test "should include things that are added to the database" do
    new_name = 'new name'
    assert Widget.new(name:new_name).save
    assert Widget.name_bloom.include?(new_name)
  end

  test "should not find things that never existed" do
    assert_not Widget.name_bloom.include?('not exist')
  end

  test "should not include things that are destroyed" do
    widgets(:three).destroy
    assert_not Widget.name_bloom.include?('name three')
  end

end
