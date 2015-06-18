require "tradegecko/library/version"

module Tradegecko
  module Library
    class Engine < ::Rails::Engine
      initializer 'tradegecko-library.assets.precompile' do |app|
        app.config.assets.precompile += [
          "TradeGecko.ttf",
          "TradeGecko.eot",
          "TradeGecko.svg",
          "TradeGecko.woff"
         ]
      end
    end
  end
end
