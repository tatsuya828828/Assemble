// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require popper
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require froala_editor.min.js
//= require languages/ja.js
//= require plugins/align.min.js
//= require plugins/char_counter.min.js
//= require plugins/code_beautifier.min.js
//= require plugins/code_view.min.js
//= require plugins/colors.min.js
//= require plugins/emoticons.min.js
//= require plugins/entities.min.js
//= require plugins/file.min.js
//= require plugins/font_family.min.js
//= require plugins/font_size.min.js
//= require plugins/fullscreen.min.js
//= require plugins/image.min.js
//= require plugins/image_manager.min.js
//= require plugins/inline_style.min.js
//= require plugins/line_breaker.min.js
//= require plugins/link.min.js
//= require plugins/lists.min.js
//= require plugins/paragraph_format.min.js
//= require plugins/paragraph_style.min.js
//= require plugins/quick_insert.min.js
//= require plugins/quote.min.js
//= require plugins/save.min.js
//= require plugins/table.min.js
//= require plugins/url.min.js
//= require plugins/video.min.js
//= require bootstrap-sprockets
//= require_tree .

// topページの見出し
$(document).on('turbolinks:load', function () {
    $('.title').slideDown(2000);
});

// 一部のページで横のスペースを削除
$(document).on('turbolinks:load', function() {
    $("#side-delete").parent().removeClass("side-space")
});

// admin側の問い合わせ一覧のtab-menu
$(document).on('turbolinks:load', function(){
    $('.table-tabs tbody[id != "already_replyed"]').hide();

    $('.tab-menu a').on('click', function() {
        $(".table-tabs tbody").hide();
        $(".tab-menu .active").removeClass("active");
        $(this).addClass("active");
        $($(this).attr("href")).show();
        return false;
    });
});

// マイページの申請通知のtab-menu
$(document).on('turbolinks:load', function(){
    $('.tab .tab-content[id != "waiting_other"]').hide();

    $('.tab-menu a').on('click', function() {
        $(".tab .tab-content").hide();
        $(".tab-menu .active").removeClass("active");
        $(this).addClass("active");
        $($(this).attr("href")).slideDown(1000);
        return false;
    });
});

// マイページの日記のtab-menu
$(document).on('turbolinks:load', function(){
    $('.diary-tab .diary-tab-content[id != "all"]').hide();

    $('.diary-tab-menu a').on('click', function(){
        $(".diary-tab .diary-tab-content").hide();
        $(".diary-tab-menu .active").removeClass("active");
        $(this).addClass("active");
        $($(this).attr("href")).slideDown(1000);
        return false;
    });
});

// メッセージ一覧のtab-menu
$(document).on('turbolinks:load', function(){
    $('.message-tab .scroll[id != "dm-tab"]').hide();

    $('.message-tab-menu a').on('click', function(){
        $(".message-tab .scroll").hide();
        $(this).addClass("active").removeClass("active");
        $($(this).attr("href")).slideDown(1000);
        return false;
    });
});

// グループ新規登録時のIDチェック
$(document).on('turbolinks:load', function(){
    $(document).on('keyup', '#group-self-id', function(e){
        e.preventDefault();
        var input = $.trim($(this).val());
        $.ajax({
            url: '/groups',
            type: 'GET',
            data: ('group_self_id=' + input),
            processData: false,
            contentType: false,
            dataType: 'json'
        })
        .done(function(data){
            $('#group-result').find('p').remove();
            $(data).show(function(){
                $('#group-result').append('<p style="color: red;">' + '既に使われています' + '</p>')
            });
        })
    });
});

// 新規登録時のself_idチェック
$(document).on('turbolinks:load', function(){
    $(document).on('keyup', '#user-self-id', function(e){
        e.preventDefault();
        var input = $.trim($(this).val());
        $.ajax({
            url: '/users/sign_up',
            type: 'GET',
            data: ('user_self_id=' + input),
            processData: false,
            contentType: false,
            dataType: 'json'
        })
        .done(function(data){
            $('#user-result').find('p').remove();
            $(data).show(function(){
                $('#user-result').append('<p style="color: red;">' + '既に使われています' + '</p>')
            });
        })
    });
});

// 新規登録時のemailチェック
$(document).on('turbolinks:load', function(){
    $(document).on('keyup', '#user-email', function(e){
        e.preventDefault();
        var input = $.trim($(this).val());
        $.ajax({
            url: '/users/sign_up',
            type: 'GET',
            data: ('user_email=' + input),
            processData: false,
            contentType: false,
            dataType: 'json'
        })
        .done(function(data){
            $('#email-result').find('p').remove();
            $(data).show(function(){
                $('#email-result').append('<p style="color: red;">' + '既に使われています' + '</p>')
            });
        })
    });
});

