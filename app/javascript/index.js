var ready=function(){
    $('#sl_main_gallery').on('slide.bs.carousel', function(e) {
        var $nextImage = $(e.relatedTarget).find('img');

        $nextImage.each(function(){
            if($(this).attr('data-original')) {
                $(this).attr('src', $(this).attr('data-original'));
                $(this).removeAttr('data-original');
            }
        });
    });

    $('#sl_main_gallery .carousel-inner .active img').each(function(){
        if($(this).attr('data-original')) {
            $(this).attr('src', $(this).attr('data-original'));
            $(this).removeAttr('data-original');
        }
    });

    $('#sl_main_gallery .carousel-inner .active img,#sl_main_blog img').each(function() {
        if ($(this).attr('data-original')) {
            $(this).attr('src', $(this).attr('data-original'));
            $(this).removeAttr('data-original');
        }
    });

    if (document.getElementById('myCanvas')) {
        TagCanvas.Start('myCanvas', 'tags', {
            outlineThickness : 1,
            maxSpeed : 0.05,
            textFont: null,
            textColour: null,
            weight: true,
            depth : 1
        });
    } else {
        // TagCanvas failed to load
        $('#myCanvasContainer').hide();
        $("#tags ul").css({'margin':0,'padding':0,'list-style':'none'});
        $("#tags ul li").css({'float':'left','margin':'0 10px'});
    }

    $('#myModal').on('hidden.bs.modal', function () {
        $(this).removeData('bs.modal');
    });

    $('.modal_link').click(function(event){
        event.preventDefault();
        $('#myModal').removeData("modal");
        $('#myModal').load($(this).attr('href')+'?no_layout=true',function(){
            $('#myModal').modal();
        });
        return false;
    });

   // $('[data-toggle="tooltip"]').tooltip();

    $(".btn_minimize").click(function(){
        var i=$(this).find('i:first');
        if(i.text()=='expand_more') {
            i.text('expand_less');
            $(this).parent().parent().parent().find('.box_content').slideDown();
        } else {
            i.text('expand_more');
            $(this).parent().parent().parent().find('.box_content').slideUp();
        }
        return false;
    });

    $(".btn_close").click(function(){
        $(this).parent().parent().parent().remove();
        if(!$(".sl_aside").length) {
            $('.sub_main').css('width','100%');
        }
        return false;
    });

    $("#sl_blog_categories .box_content ul span.c_pointer").click(function(){
        if($(this).parent().find('ul').is(':visible')) {
            $(this).parent().find('ul').hide();
            $(this).find('span:eq(1)').html('&nbsp;&lt;&lt;');
        } else {
            $(this).parent().find('ul').show();
            $(this).find('span:eq(1)').html('&nbsp;&gt;&gt;');
        }
    });

    /*$("#sl_blog_index article.media").click(function(event){

    }).css('cursor','pointer'); */

};

function nl2br (str, is_xhtml) {
    var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br ' + '/>' : '<br>';
    return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
}

document.addEventListener("turbo:load", ready);
