class Widget < ActiveRecord::Base

  include ActsAsBloomfilter

  acts_as_bloomfilter :name

end
