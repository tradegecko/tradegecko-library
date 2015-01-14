# Tradegecko::Styles

Shared styles library for TradeGecko apps

Examples: http://tradegecko-examples.herokuapp.com

CSS Style Guide: https://gist.github.com/wongpeiyi/87cee67a2c2dd0215b0e

## Installation

```ruby
  gem 'tradegecko-styles', git: "https://tradegecko-admin:L3AcU=yki9G-DNoh@github.com/tradegecko/tradegecko-styles.git"
```

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

## Making Changes

1. Always make your changes in a junk.css file in your app first.

2. **Test & update the gem**

  - Copy the styles to the wip.css file in the [tradegecko-examples](https://github.com/tradegecko/tradegecko-examples) repo.

  - Run locally to make sure everything still looks ok after updating. If the affected components and their interactions didn't break anything, bump the tradegecko-styles version in version.rb then push tradegecko-styles to github.

3. **Update the examples**

  - Run `bundle update tradegecko-styles` in the tradegecko-examples repo. You will have to restart your local server and clear the SASS cache (or modify and save any scss file). Remove the temporary styles in wip.css

  - Add any new examples and documentation. Push tradegecko-examples to github and deploy to heroku.

4. `bundle update tradegecko-styles` in your app.
