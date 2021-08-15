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