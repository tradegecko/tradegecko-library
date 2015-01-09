# Tradegecko::Styles

Shared styles library for TradeGecko apps

Examples: http://tradegecko-examples.herokuapp.com

CSS Style Guide: https://gist.github.com/wongpeiyi/87cee67a2c2dd0215b0e

## Installation

For local usage using SSH:

```ruby
  gem 'tradegecko-styles', git: "git@github.com:tradegecko/tradegecko-styles.git"
```

For Heroku, use:

```ruby
  gem 'tradegecko-styles', git: "https://#{ENV['GEM_USERNAME']}:#{ENV['GEM_PASSWORD']}@github.com/tradegecko/tradegecko-styles.git"
```

And set the appropriate heroku config ENV variables.

## Usage

In application.scss:

```scss
@import "tradegecko-styles";
```

Or include only specific modules:

```scss
@import "tradegecko-styles/core";
@import "tradegecko-styles/core/variables";
```

## Structure

```
└── core
    └── variables
    └── reset
    └── ...
└── ...
```