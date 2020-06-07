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
//= require popper
//= require_tree .

// topページの見出し
$(document).on('turbolinks:load', function () {
    $('.title').slideDown(2000);
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


$(document).on('turbolinks:load', function(){
    $('.tab .tab-content[id != "waiting_other"]').hide();

    $('.tab-menu a').on('click', function() {
        $(".tab .tab-content").hide();
        $(".tab-menu .active").removeClass("active");
        $(this).addClass("active");
        $($(this).attr("href")).slideDown(2000);
        return false;
    });
});
