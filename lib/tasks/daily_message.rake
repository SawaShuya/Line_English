namespace :daily_message do
  desc '毎朝配信'
  task :send_question => :environment do
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
    users = User.where(is_question: true)
    users.each do |user|
      if user.question_list_id.present?
        user.set_questions
        message = user.send_question

        push_message = {
          type: 'text',
          text: message
        }
        @client.push_message(user.uid, push_message)
      end
    end
  end

end
