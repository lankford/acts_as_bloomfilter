module ActsAsBloomfilter

  require 'bloomfilter-rb'

  def self.included base
    base.extend(ClassMethods)
  end

  module ClassMethods

    def acts_as_bloomfilter *args
      args.each do |arg|

        self.instance_eval "after_save     { #{self}.#{arg}_bloom.insert #{arg} }"
        self.instance_eval "before_destroy { #{self}.#{arg}_bloom.delete #{arg} }"

        self.instance_eval <<~EVAL
          def #{arg}_bloom
            @@#{arg}_bloom ||= BloomFilter::Native.new(size: (self.count * 100))
          end
        EVAL

        self.instance_eval <<~EVAL
          def #{arg}_bloom_load
            #{self}.find_by_sql('SELECT #{arg} FROM #{self.table_name}').each { |record| #{arg}_bloom.insert record.#{arg} }
            sleep 1 # Letting the filter settle out to prevent false negatives
          end
        EVAL

        self.instance_eval "#{arg}_bloom_load"

      end
    end
  end

end
