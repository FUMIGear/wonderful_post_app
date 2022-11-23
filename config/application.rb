require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WonderfulPostApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    #以下を追記
    config.generators do |g|
      g.jbuilder false
      g.javascripts false
      g.stylesheets false
      g.helper false
      g.test_framework false
    end
    #タイムゾーンをTokyoにする
    #https://zenn.dev/ryouzi/articles/dda18594f2dbd3を参考に
    config.time_zone = 'Tokyo' #Rails自体のアプリケーションの時刻の設定
    # config.time_zone = 'Eastern Time (US & Canada)' #タイムゾーンの動作確認用（ニューヨーク）
    # config.time_zone = 'Sydney' #タイムゾーンの動作確認用（シドニー）
    # config.time_zone = 'Osaka' #タイムゾーンの動作確認用（大阪）
    # config.time_zone = 'Paris' #タイムゾーンの動作確認用（パリ）
    # config.active_record.default_timezone = 'Tokyo' #DBを読み書きする際に、DBに記録するタイムゾーンの設定
    # config.active_record.default_timezone = 'Eastern Time (US & Canada)' #DBタイムゾーンテスト（ニューヨーク）←変わらんかった。
    # config.active_record.default_timezone = :local #なくてもTimezoneの設定問題なし？
    # config.time_zone = :local #railsメソッドでも可能か？
    # :locale＝OSのタイムゾーンを参照、'Tokyo'にするといいのか？
    #協定世界時刻はUTC,日本はTokyo。他の国の時刻は国と地域名で多数あるため、その時調べた方が効率いいかも

    #localeで日本語ファイルを読み込む→config/locale/ja.yml
    config.i18n.default_locale = :ja #ロケールの初期設定

    # config.i18n.available_locales = %i(ja en zh) #言語選択（今回はJaなので、不要）
    # config.i18n.enforce_available_locales = true
    # localeに関するエラーが発生した場合、下記のサイトを参照
    # https://qiita.com/katsuyuki/items/9f9f202047cdef7f11a6
    # Ruby3とRuby4で存在しないlocaleだった場合、エラーにするかどうかの処理？（true）無視する場合はfalse？
    # 存在しない場合はdefault_localeが適用されるのか？よくわからないから問題が起きたら対処しよ！
    # config.i18n.default_locale = :ja #デフォルトの言語選択（:ja→ja.yml）
  end
end
