// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import 'bootstrap';
import '../stylesheets/application';

window.$ = jQuery;

$(document).on('turbolinks:load', function() {
  $(function() {
    $(".back-btn").on('click', function() {
      $(".form").slideUp('fast', function() {
        $(this).remove();
      });
      $(".back-btn").css('display', 'none');
      $(".new-list-btn").fadeIn();
    })
  })
})

$(document).on('turbolinks:load', function() {
  $(function(){
    $('input[class*="word-checkbox"]').change(function(){
      var word_id = $(this).attr('name'); //チェックボックスのname属性
      $.ajax({ //ajax通信
        url: '/word/update_status', 
        type: 'PATCH',
        data: {
          id: word_id  //prams[:id] に格納
        },
        dataType: 'json' //データはjson形式
      });
    });
  });
});

$(document).on('turbolinks:load', function() {
  $(function(){
    $('.user_config_form').change(function(){
      var question_list_id = $("#user_question_list_id").val();
      var question_limit = $("#user_question_limit").val();
      var is_remember_word_question = $('input[name="is_remember_word_question"]:checked').val();
      var is_question = $('input[name="is_question"]:checked').val();
      $.ajax({ //ajax通信
        url: '/users/config', 
        type: 'PATCH',
        data: {
          user: {
            question_list_id: question_list_id,
            question_limit: question_limit,
            is_remember_word_question: is_remember_word_question,
            is_question: is_question
          }
        },
        dataType: 'json' //データはjson形式
      });
    });
  });
});