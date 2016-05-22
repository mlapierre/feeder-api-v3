module Feeder
  class FeederData

    def self.init
      #DataMapper::Logger.new($stdout, :debug)
      DataMapper.setup(:default, 'sqlite:///usr/app/data/feeder.db')
      DataMapper.finalize
      DataMapper.auto_upgrade!
    end

    def save
    end

  end
end
