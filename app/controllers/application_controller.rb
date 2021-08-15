class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    lists_path
  end

  private
  # botアカウント(クライアント)設定
  def client
    case Rails.env
    when "production"
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_MESSAGE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_MESSAGE_CHANNEL_TOKEN"]
      }
    when "test", "development"
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["DEV_LINE_MESSAGE_CHANNEL_SECRET"]
        config.channel_token = ENV["DEV_LINE_MESSAGE_CHANNEL_TOKEN"]
      }
    end
  end
end
