module Feeder
  class FeederData

    def self.init
      #DataMapper::Logger.new($stdout, :debug)
      #DataMapper.setup(:default, 'sqlite:///usr/app/data/feeder.db')
      DataMapper.setup(:default, 'postgres://feeder@feederdb/feeder')
      DataMapper.finalize
      DataMapper.auto_upgrade!
      #DataMapper.auto_migrate!
    end

    def save
    end

  end
end
