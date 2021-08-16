class LinebotController < ApplicationController
  require 'line/bot'
   require 'json'

   # callbackアクションのCSRFトークン認証を無効
   protect_from_forgery :except => [:callback]

   # botアカウント(クライアント)設定
   def client
     super
   end


   def callback
     # bodyに打ち込まれた値の格納(JSON)
     body = request.body.read

     #アカウントによっては(課金の都合？)送信できなこともあるため、このチェックが必要
     signature = request.env['HTTP_X_LINE_SIGNATURE']
     unless client.validate_signature(body, signature)
       head :bad_request
     end

     # gem line-bot-apiのメソッド。ハッシュに変更
     events = client.parse_events_from(body)

     events.each { |event|
      if event.message['text'] != nil
        user = User.find_by(uid: event['source']['userId'])
        user_message = event.message['text']

        case user_message.to_i
        when 1..4 
          if user.questions.exists?
            if user.questions.where(is_sent: false).exists?
              user.check_answer(user_message)
              response = user.send_question
            else
              user.check_answer(user_message)
              response = user.result_message
            end
          else
            response = "「" + user_message + "」は読み込めませんでした... \n ゴメン！"
          end
        else
          if user_message == "テスト"
            if user.question_list_id.present?
              user.set_questions
              response = user.send_question
            else
              response = "設定からリストを選択してね！"
            end

          elsif user_message == "やめる"
            if user.questions.exists?
              response = user.result_message
            else
              response = "テストをしたいときは「テスト」と入力してね！"
            end

          elsif user_message == "リスト"
            response = user.list_index
          else
            response = "「" + user_message + "」は読み込めませんでした... \n ゴメンネ！"
          end
        end
      end

       case event
       when Line::Bot::Event::Message
         case event.type
         when Line::Bot::Event::MessageType::Text,Line::Bot::Event::MessageType::Location
           message = {
             type: 'text',
             text: response
           }
           client.reply_message(event['replyToken'], message)
         end
       end
     }

     head :ok
   end

end
