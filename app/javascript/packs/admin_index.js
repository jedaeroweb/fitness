/**
 * This jQuery plugin displays pagination links inside the selected elements.
 *
 * @author Gabriel Birke (birke *at* d-scribe *dot* de)
 * @version 1.2
 * @param {int} maxentries Number of entries to paginate
 * @param {Object} opts Several options (see README for documentation)
 * @return {Object} jQuery Object
 */
jQuery.fn.pagination = function(maxentries, opts){
    opts = jQuery.extend({
        items_per_page:10,
        num_display_entries:10,
        current_page:0,
        num_edge_entries:0,
        link_to:"#",
        prev_text:"<<",
        next_text:">>",
        ellipse_text:"...",
        prev_show_always:true,
        next_show_always:true,
        callback:function(){return false;}
    },opts||{});

    return this.each(function() {
        /**
         * Calculate the maximum number of pages
         */
        function numPages() {
            return Math.ceil(maxentries/opts.items_per_page);
        }

        /**
         * Calculate start and end point of pagination links depending on
         * current_page and num_display_entries.
         * @return {Array}
         */
        function getInterval()  {
            var ne_half = Math.ceil(opts.num_display_entries/2);
            var np = numPages();
            var upper_limit = np-opts.num_display_entries;
            var start = current_page>ne_half?Math.max(Math.min(current_page-ne_half, upper_limit), 0):0;
            var end = current_page>ne_half?Math.min(current_page+ne_half, np):Math.min(opts.num_display_entries, np);
            return [start,end];
        }

        /**
         * This is the event handling function for the pagination links.
         * @param {int} page_id The new page number
         */
        function pageSelected(page_id, evt){
            current_page = page_id;
            drawLinks();
            var continuePropagation = opts.callback(page_id, panel);
            if (!continuePropagation) {
                if (evt.stopPropagation) {
                    evt.stopPropagation();
                }
                else {
                    evt.cancelBubble = true;
                }
            }
            return continuePropagation;
        }

        /**
         * This function inserts the pagination links into the container element
         */
        function drawLinks() {
            panel.empty();
            var interval = getInterval();
            var np = numPages();
            // This helper function returns a handler function that calls pageSelected with the right page_id
            var getClickHandler = function(page_id) {
                return function(evt){ return pageSelected(page_id,evt); }
            }
            // Helper function for generating a single link (or a span tag if it's the current page)
            var appendItem = function(page_id, appendopts){
                page_id = page_id<0?0:(page_id<np?page_id:np-1); // Normalize page id to sane value
                appendopts = jQuery.extend({text:page_id+1, classes:""}, appendopts||{});
                if(page_id == current_page){
                    var lnk = jQuery("<span class='active'>"+(appendopts.text)+"</span>");
                }
                else
                {
                    var lnk = jQuery("<a>"+(appendopts.text)+"</a>")
                        .bind("click", getClickHandler(page_id))
                        .attr('href', opts.link_to.replace(/__id__/,page_id));


                }
                if(appendopts.classes){lnk.addClass(appendopts.classes);}
                panel.append(lnk);
            }
            // Generate "Previous"-Link
            if(opts.prev_text && (current_page > 0 || opts.prev_show_always)){
                appendItem(current_page-1,{text:opts.prev_text, classes:"prev"});
            }
            // Generate starting points
            if (interval[0] > 0 && opts.num_edge_entries > 0)
            {
                var end = Math.min(opts.num_edge_entries, interval[0]);
                for(var i=0; i<end; i++) {
                    appendItem(i);
                }
                if(opts.num_edge_entries < interval[0] && opts.ellipse_text)
                {
                    jQuery("<span>"+opts.ellipse_text+"</span>").appendTo(panel);
                }
            }
            // Generate interval links
            for(var i=interval[0]; i<interval[1]; i++) {
                appendItem(i);
            }
            /*
            // Generate ending points
            if (interval[1] < np && opts.num_edge_entries > 0)
            {
                if(np-opts.num_edge_entries > interval[1]&& opts.ellipse_text)
                {
                    jQuery("<span>"+opts.ellipse_text+"</span>").appendTo(panel);
                }
                var begin = Math.max(np-opts.num_edge_entries, interval[1]);
                for(var i=begin; i<np; i++) {
                    appendItem(i);
                }

            } */

            // Generate "Next"-Link
            if(opts.next_text && (current_page < np-1 || opts.next_show_always)){
                appendItem(current_page+1,{text:opts.next_text, classes:"next"});
            }

        }

        // Extract current_page from options
        var current_page = opts.current_page;
        // Create a sane value for maxentries and items_per_page
        maxentries = (!maxentries || maxentries < 0)?1:maxentries;
        opts.items_per_page = (!opts.items_per_page || opts.items_per_page < 0)?1:opts.items_per_page;
        // Store DOM element for easy access from all inner functions
        var panel = jQuery(this);
        // Attach control functions to the DOM element
        this.selectPage = function(page_id){ pageSelected(page_id);}
        this.prevPage = function(){
            if (current_page > 0) {
                pageSelected(current_page - 1);
                return true;
            }
            else {
                return false;
            }
        }
        this.nextPage = function(){
            if(current_page < numPages()-1) {
                pageSelected(current_page+1);
                return true;
            }
            else {
                return false;
            }
        }
        // When all initialisation is done, draw the links
        drawLinks();
        // call callback function
        opts.callback(current_page, this);
    });
}


$(document).ready(function() {
    //conn.onopen = function(e) {
    //  conn.send('Hello World!');
    //};

    if(typeof conn != "undefined") {
        conn.onmessage = function(message) {
            try {
                var json = JSON.parse(message.data);
                if(json.user.branch_id==branch_id) {
                    var new_toast=$("#default-toast").clone();
                    new_toast.removeAttr('id');
                    new_toast.show();
                    $("#default-toast").after(new_toast);
                    new_toast.find('.text-muted').text(json.user.in_time);
                    new_toast.find('.toast-body .text').text(json.user.name);
                    new_toast.toast('show');
                }
            } catch(err) {
                console.log(err);
            }
        };
    }

    $("a.simple_image").fancybox({
        'opacity'   : true,
        'overlayShow'        : true,
        'overlayColor': '#000000',
        'overlayOpacity'     : 0.9,
        'titleShow':true,
        'openEffect'  : 'elastic',
        'closeEffect' : 'elastic'
    });

    initPagination();

    $('.input-group-prepend .input-group-text').click(function(){
        $(this).parent().find('input').trigger('focus');
    });

    $('input[name="show_only_my_user"]').change(function(){
        if($(this).is(":checked")) {
            var cval=1;
        } else {
            var cval=0;
        }

        $.post('/home/show-omu',{'show_omu':cval,'format':'json'},function(data){
            if(data.result=='success') {
                location.reload();
            } else {

            }
        },'json');
    });

    $("#is_today").change(function(){
        if($(this).prop('checked')) {
            $("#o_transaction_date_layer").hide();
            $("#today_display").show();
        } else {
            $("#o_transaction_date_layer").show();
            $("#today_display").hide();
        }
    });

    $("#o_dc_rate,#o_dc_price,#o_cash,#o_credit").focus(function(){
        if($(this).val()==0) {
            $(this).val('');
        }
    });

    $("#o_dc_rate,#o_dc_price,#o_cash,#o_credit").blur(function(){
        if($.trim($(this).val())=='') {
            $(this).val(0);
        }
    });

    $('.sub_nav a.disabled').click(function(event){
        event.preventDefault();
        alert('준비중입니다.');
    });

    // 메세지 닫기
    $('#message .m_close').click(function(){
        $(this).parent().remove();
    });

    $("#messages .alert-success").fadeOut(5000,function(){
        var as=$(this);
        $("#messages").slideUp('slow',function(){
            as.remove();
            $("#messages").slideDown();
        });
    });

    $('.btn-popup').click(btn_popup_click);

    $('.popup_close').click(function(){
        window.close();
    });

    $('.btn-delete-confirm').click(function(e){
        e.preventDefault();
        var tr=$(this).closest('tr');
        if(confirm('정말로 삭제합니까?')) {
            var url=$(this).attr('href').replace('/delete-confirm/','/delete/');
            $.post(url,{'format':'json'},function(data){
                if(data.result=='success') {
                    display_message(data.message,'success');
                    if($('#list_count').length) {
                        $('#list_count').text(Number($('#list_count').text()-1));
                    }

                    tr.effect('highlight',function() {
                        $(this).remove();
                    });
                } else {
                    alert(data.message);
                }
            },'json');
        }
    });

    // 몇개씩 보기 바뀌었을때, 리스트 갱신
    $("#perpage").change(function(){
        $(".sl_pagination").empty();
        getList();
        $(this).blur();
        return true;
    });

    // 기간 선택시 날짜 채워지기
    $('input[name="date_p"]').change(function(){
        if($("#future_search").length) {
            if($("#future_search").val()==1) {
                if($(this).val()=='all') {
                    $('input[name="start_date"]').val('').effect("highlight");
                    $('input[name="end_date"]').val('').effect("highlight");
                } else {
                    setDateFutureInput($(this).val());
                }
                return true;
            }
        }

        if($(this).val()=='all') {
            $('input[name="start_date"]').val('').effect("highlight");
            $('input[name="end_date"]').val('').effect("highlight");
        } else {
            setDateInput($(this).val());
        }
    });

    $(".card .card-header .nav-item .nav-link").click(function(event){
        event.preventDefault();
        event.stopPropagation();

        var card=$(this).closest('.card');
        card.find(".card-header .nav-item .nav-link").removeClass('active');

        $(this).addClass('active');
        var index=card.find('.card-header .nav-item .nav-link').index($(this));
        card.find('.card-block').hide();
        card.find('.card-block:eq('+index+')').show();
        $(this).blur();

        var card_header=$(this).closest('.card-header');
        if(card_header.find('.buttons i').text()=='keyboard_arrow_down') {
            card_header.find('.buttons i').text('keyboard_arrow_up');
            card_header.closest('.card').find('.card-body:not(.no_common)').slideDown();
        }
    });

    $('.card-header .buttons').closest('.card').find('.card-header').css('cursor','pointer');
    $('.card-header').click(function(){
        if(!$(this).find('.buttons').length) {
            return true;
        }

        if($(this).find('.no_common').length) {
            return true;
        }

        if($(this).find('.buttons i').text()=='keyboard_arrow_down') {
            var index=0;

            $(this).find('.buttons i').text('keyboard_arrow_up');
            $(this).closest('.card').find('.card-body:not(.no_common)').slideDown();

            var card=$(this).closest('.card');
            if(card.find('.card-block:visible').length) {
                var v_card=card.find('.card-block:visible');
                index=card.find('.card-block').index(v_card);
            }
            card.find('.card-header .nav-item .nav-link:eq('+index+')').addClass('active');
        } else {
            $(this).find('.nav-item .nav-link').removeClass('active');

            $(this).find('.buttons i').text('keyboard_arrow_down');
            $(this).closest('.card').find('.card-body:not(.no_common)').slideUp();
        }
    });

    $(".select-user").click(function(event){
        event.preventDefault();
        $('#myModal').removeData("modal");
        $('#myModal').load('/users/select/single?popup=no',function(){
            $('#myModal').modal();
        });
    });

    $(".select-employee").click(function(event){
        event.preventDefault();
        $('#myModal').removeData("modal");

        var load_url='/employees/select/single?popup=no';
        if($(this).parent().find('input.default_position').length) {
            load_url+='&default_position='+$(this).parent().find('input.default_position').val();
        }

        $('#myModal').load(load_url,function(){
            $('#myModal').modal();
        });
    });

    $(".select-fc").click(function(event){
        event.preventDefault();
        $('#myModal').removeData("modal");
        var popup_url='/employees/select/single?popup=no&position=fc';

        if($(this).hasClass('no-search')) {
            popup_url+='&no-search=1';
        }

        $('#myModal').load(popup_url,function(){
            $('#myModal').modal();
        });
    });

    $(".select-trainer").click(function(event){
        event.preventDefault();
        $('#myModal').removeData("modal");
        var popup_url='/employees/select/single?popup=no&position=trainer';

        if($(this).hasClass('no-search')) {
            popup_url+='&no-search=1';
        }

        $('#myModal').load(popup_url,function(){
            $('#myModal').modal();
        });
    });
}); // document.ready end


// 정수형으로 받기
function getIntVal (field) {
    return ($(field).val() == '') ? 0 : parseInt(strip_number_comma($(field).val()));
}

// 콤마가 포함된 숫자에서 콤마 제거하기
function strip_number_comma (v) {
    if (v == null) return v;
    return (v.match(/[^0-9.,]/g) == null) ? v.replace(/,/g, '') : v;
}

/* function urldecode(url) {
    return decodeURIComponent(url.replace(/\+/g, ' '));
} */

function exercise_change(){
    if($(this).val()=='') {
        $("#exercise").empty().append('<option selected="selected">카테고리를 선택하세요!</option>').effect("highlight", {}, 1000);
        return false;
    }

    $.getJSON('/exercises?json=true',{'category_id':$(this).val(),'per_page':100},function(data){
        if(data.result=='success') {
            $("#exercise").empty();
            $.each(data.list,function(key,value){
                $("#exercise").append('<option value="'+value.id+'">'+value.title+'</option>');
            });
            $("#exercise").effect("highlight", {}, 1000);
        } else {
            alert(data.message);
        }
    });
}

function btn_popup_click(e){
    e.preventDefault();

    if($(this).attr('href').indexOf('?')=='-1') {
        var url=$(this).attr('href')+'?popup=true';
    } else {
        var url=$(this).attr('href')+'&popup=true';
    }

    var win = window.open(url,$(this).attr('title'), "top=0,left=0,width=900px, height=650px");
    win.focus();
}

function nl2br (str, is_xhtml) {
    var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br ' + '/>' : '<br>'; // Adjust comment to avoid issue on phpjs.org display

    return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
}

function isEmpty(value){
    if( value == ""  || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
        return true
    }else{
        return false
    }
}

function setDateInput(obj) {
    if (obj != undefined) {
        var datediff = -(parseInt(obj));
        var newDate = new Date();
        var now = new Date();
        newDate.setDate(now.getDate()+datediff);
        var newYear = newDate.getFullYear();
        var newMonth = newDate.getMonth()+1;
        if (newMonth.toString().length == 1) newMonth = "0" + newMonth;

        endMonth=now.getMonth() +1;
        if (endMonth.toString().length == 1) endMonth = "0" + endMonth;

        var newDay = newDate.getDate();
        if (newDay.toString().length == 1) { newDay = "0" + newDay};

        var txtSDate = newYear + "-" + newMonth +'-'+ newDay;
        endDay=now.getDate();

        if (endDay.toString().length == 1) {endDay = "0" + endDay; };
        var txtEDate = now.getFullYear() + '-' + endMonth + "-" + endDay;

        $('input[name="start_date"]').val(txtSDate).effect("highlight");
        $('input[name="end_date"]').val(txtEDate).effect("highlight");
    } else {alert("잠시 후 이용해 주시기 바랍니다."); return false;}
}

function setDateFutureInput(obj) {
    if (obj != undefined) {
        var datediff = -(parseInt(obj));
        var newDate = new Date();
        var now = new Date();
        newDate.setDate(now.getDate()-datediff);
        var newYear = newDate.getFullYear();
        var newMonth = newDate.getMonth()+1;
        if (newMonth.toString().length == 1) newMonth = "0" + newMonth;

        endMonth=now.getMonth() +1;
        if (endMonth.toString().length == 1) endMonth = "0" + endMonth;

        var newDay = newDate.getDate();
        if (newDay.toString().length == 1) newDay = "0" + newDay;
        var txtEDate  = newYear + "-" + newMonth +'-'+ newDay;
        endDay=now.getDate();
        if (endDay.toString().length == 1) endDay = "0" + endDay;
        var txtSDate = now.getFullYear() + '-' + endMonth + "-" + endDay;
        $('input[name="start_date"]').val(txtSDate).effect("highlight");
        $('input[name="end_date"]').val(txtEDate).effect("highlight");
    } else {alert("잠시 후 이용해 주시기 바랍니다."); return false;}
}

//layer popup
function commonLayerOpen(thisClass){
    $('.'+thisClass).fadeIn();
}
function commonLayerClose(thisClass){
    $('.'+thisClass).fadeOut();
}

function list_count_minus() {
    var s_count=Number($('#list_count').text())-1;

    if(s_count<0)
        s_count=0;

    $('#list_count').text(s_count).parent().effect("highlight", {}, 1000);

    return s_count;
}


function delete_form_submit(data, statusText, xhr, $form) {
    if(data.result=='success') {
        var tr=$form.parent().parent();
        tr.effect("highlight", {}, 500,function(){
            getList();
            if(opener) {
                remove_prepare_select(data.deleted_id);
            }
        });
    } else {
        alert(data.message);
    }
}

function delete_m_form_submit(data, statusText, xhr, $form) {
    if(data.result=='success') {
        if(data.delete_parent) {
            var tr=$form.parent().parent();
            $form.remove();
            tr.effect("highlight", {}, 200,function(){
                var count=list_count_minus();
                if(count<$('#perpage').val()) {
                    if(count<1) {
                        var th_length=$(this).parent().parent().find('th').length;
                        var new_tr=$('<tr><td colspan="'+(th_length+1)+'" style="text-align:center">해당 데이터가 없습니다.</td></tr>');
                        new_tr.appendTo($(this).parent()).effect("highlight", {}, 800);
                    }
                } else {
                    getList();
                    if(opener) {
                        remove_prepare_select(data.deleted_parent_id);
                    }
                }
                $(this).remove();
            });
        } else {
            $form.parent().parent().effect("highlight", {}, 1000);
            $form.fadeOut(function(){
                $(this).remove();
            });
        }
    } else {
        display_message(data.message);
    }
}

function date_format(f_date) {
    var date_a=f_date.split(' ')[0].split('-');

    return date_a[0]+'년 '+Number(date_a[1])+'월 '+Number(date_a[2])+'일';
}

function delete_f_form_submit(data, statusText, xhr, $form) {
    if(data.result=='success') {
        if(data.delete_parent) {
            var tr=$form.parent().parent();
            $form.remove();
            tr.effect("highlight", {}, 200,function(){
                var count=list_count_minus();
                if(count<$('#perpage').val()) {
                    if(count<1) {
                        var th_length=$(this).parent().parent().find('th').length;
                        var new_tr=$('<tr><td colspan="'+(th_length+1)+'" style="text-align:center">해당 데이터가 없습니다.</td></tr>');
                        new_tr.appendTo($(this).parent()).effect("highlight", {}, 800);
                    }
                } else {
                    getList();
                    if(opener) {
                        remove_prepare_select(data.deleted_parent_id);
                    }
                }
                $(this).remove();
            });
        } else {
            $form.parent().parent().effect("highlight", {}, 1000);
            $form.fadeOut(function(){
                var calorie=$(this).find('input[name="calorie"]').val();
                var r_cal=parseFloat($(this).parent().parent().find('td.t_calorie').text())-parseFloat(calorie);
                $(this).parent().parent().find('td.t_calorie').text(r_cal.toFixed(2));
                $(this).remove();
            });
        }
    } else {
        display_message(data.message);
    }
}

function add_m_form_submit(data, statusText, xhr, $form) {
    if(data.result=='success') {
        var tr=$form.parent().parent();
        tr.effect("highlight", {}, 200,function(){
            /*if($('#list_count').text()<$('#perpage').val()) {
            } else {
            } */
            $("#leftMemberList tbody tr").removeClass('selected').find('input').prop('checked',false);
            $('.members_input li input[name="members[]"]').parent().remove();
            getList();
        });
    } else {
        display_message(data.message);
    }
}

function display_message(message,alert_type) {
    var alert_type = alert_type || 'danger';

    if($("#messages").length) {
        $("#messages").empty();
        $("#messages").html('<div class="alert alert-'+alert_type+'"><button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">×</span><span class="sr-only">닫기</span></button>'+message+'</div>');
        $("#messages .m_close").click(function(){
            $(this).parent().remove();
        });
    }
}

function pageselectCallback(page_index, jq) {
    if ($(jq).data("load") == true)
        getList(page_index, jq);
    else
        $(jq).data("load", true);

    return false;
}

function initPagination(num_entries, items_per_page, current_page) {
    if(!current_page) {
        var current_page=0;
    }

    if(num_entries<=items_per_page) {
        return false;
    }

    $(".sl_pagination").pagination(num_entries, {
        current_page : current_page,
        num_edge_entries : 2,
        num_display_entries : 8,
        callback : pageselectCallback,
        items_per_page : items_per_page
    });
    return false;
}

function viewKorean(num) {
    var hanA = new Array("","일","이","삼","사","오","육","칠","팔","구","십");
    var danA = new Array("","십","백","천","","십","백","천","","십","백","천","","십","백","천");
    var result = ""; for(i=0; i<num.length; i++) { str = ""; han = hanA[num.charAt(num.length-(i+1))]; if(han != "") str += han+danA[i]; if(i == 4) str += "만"; if(i == 8) str += "억"; if(i == 12) str += "조"; result = str + result; } if(num != 0) result = result + "원";
    return result;
}

function add_day(strDate, numberOfDays) {
    var startDate=new Date(strDate);
    xDate=new Date(startDate.getTime() + ((numberOfDays-1) * 24 *60 * 60 * 1000));
    return $.datepicker.formatDate('yy-mm-dd', xDate);
}

// 날짜 계산하기 - 규칙이 독특해서 따로 만듦. - 더하기에서만 정상 동작함.
// PHP도 똑같은 이름으로 동일한 결과를 얻도록 함수를 만든다.
function add_month (strDate, interval) {
    if (typeof(interval) == 'string') interval = parseInt(interval);
    if (interval <= 0) return strDate; // 빼기 및 0인 경우에는 처리하지 않는다.

    var sDate = new Date(strDate);
    sDate.setDate(sDate.getDate() - 1); // 기준일: 맨 처음 오늘 날짜에서 하루 뺀 날짜를 구한다.

    var kDate = new Date(sDate.toString());
    kDate.setDate(1); // 기준월
    kDate.setMonth(kDate.getMonth() + interval); // 비교월
    var kMonth = kDate.getMonth();

    var xDate = new Date(sDate.toString());
    xDate.setMonth(xDate.getMonth() + interval); // 변경일자

    // 변경일자의 월이 비교월과 같아야 한다.
    while (kMonth != xDate.getMonth()) {
        xDate.setDate(xDate.getDate() - 1);
    }

    return $.datepicker.formatDate('yy-mm-dd', xDate);
}

function dowtostr(dow)
{
    if(dow.length==0 || dow.length==7) {
        return '전요일';
    }

    return dow.replace("0", "일").replace("1", "월").replace("2", "화").replace("3", "수").replace("4", "목").replace("5", "금").replace("6", "토").split('').join(',');
    //return , dow.// 유니코드는 3바이트
}

function convertDate(date) {
    var yyyy = date.getFullYear().toString();
    var mm = (date.getMonth()+1).toString();
    var dd  = date.getDate().toString();

    var mmChars = mm.split('');
    var ddChars = dd.split('');

    return yyyy + '-' + (mmChars[1]?mm:"0"+mmChars[0]) + '-' + (ddChars[1]?dd:"0"+ddChars[0]);
}

function user_select_cancel() {
    $("aside").removeAttr('class').attr('class','col-12 col-lg-6 col-xl-5');
    $("#right_data_form").removeAttr('class').attr('class','col-12 col-lg-6 col-xl-7');
    $("#user_info").hide();
    $("#user_search").show();
    $("#o_user_id").val('');

    $("#user_find_form h3 span:first").show();
    $("#user_find_form h3 span:eq(1)").hide();
    $('#rent_add_form input[type="submit"]').attr('disabled','disabled');

    if($("#rent_info_layer").length) {
        $("#rent_info_layer").hide();
        $("#rent_info").empty();
    }

    $(".use_list").hide();

    if($("#anon").length) {
        $("#anon").prop('checked',false);
    }
}

function calculatorPayment() {
    var sell_price=$("#hidden_sell_price").val();

    if($("#o_payment_method").val()=='4') {
        var cash=$("#o_mix_cash").val();
        var credit=$("#o_mix_credit").val();
    } else {
        switch($("#o_payment_method").val()) {
            case '1':
                $("#o_cash").val($("#o_payment").val());
                break;
            default :
                $("#o_credit").val($("#o_payment").val());
        }
        var cash=$("#o_cash").val();
        var credit=$("#o_credit").val();
    }
}

function display_gender(gender)
{
    if(gender==null) {
        return '미입력';
    }

    if (gender==1) {
        return '남자';
    } else {
        return '여자';
    }
}


function stripComma(str) {
    var re = /,/g;
    return str.replace(re, "");
}

function add_hyphen(v) {
    v = v.replace(/[^0-9]/g, '');
    return v.replace(/^(0(?:2|[0-9]{2}))([0-9]+)([0-9]{4}$)/, "$1-$2-$3");
}



var memo_perpage=3;
var memo_page=2;

$(document).ready(function(){
    // 자바스크립트가 지원될때 Tr 커서 선택
    $("#user-list tbody tr,#employee-list tbody tr").css('cursor','pointer');

    $("#user-list tbody td,#employee-list tbody td").click(function(){
        location.href=$(this).parent().find('a').attr('href');
    });

    $('#photo_load').click(function () {
        $(this).parent().find('input:file').prop('capture', '');
        $(this).parent().find('input:file').trigger('click');
    });

    $('#form_photo input:file').change(function () {
        var formData = new FormData();
        formData.append('authenticity_token', $('meta[name="csrf-token"]').attr('content'));

        if($('#form_photo input[name="admin_id"]').length) {
            formData.append('admin_picture[admin_id]',$('#form_photo').find('input[name="admin_id"]').val());
            formData.append('admin_picture[picture]', $('input:file')[0].files[0]);
            var delete_path='/admin_pictures/destroy/';
        } else {
            formData.append('user_picture[user_id]', $('#form_photo').find('input[name="user_id"]').val());
            formData.append('user_picture[picture]', $('input:file')[0].files[0]);
            var delete_path='/user_pictures/destroy/';
        }

        $.ajax({
            url :$('#form_photo').attr('action')+'.json',
            type: "POST",
            data : formData,
            processData: false,
            contentType: false,
            success:function(data, textStatus, jqXHR){
                var json = data;

                if(json.id!=true) {
                    var form=$('<form action="'+delete_path+json.id+'.json" method="post" accept-charset="utf-8">');
                    form.append('<input value="'+$("#delete-photo-layer span").text()+'" class="btn btn-sm btn-outline-secondary btn-block" type="submit">');
                    $("#delete-photo-layer").empty().append(form);
                }

                $('#profile_photo').attr('src',json.picture.medium_thumb.url);
            },
            error: function(jqXHR, textStatus, errorThrown){
                //if fails
            }
        });
    });

    $('#user_enroll_list tbody tr td,#user_end_enroll_list tbody tr td').click(function() {
        var tr=$(this).parent();

        if(tr.hasClass('no-event')) {
            return false;
        }

        if(!$(this).hasClass('link')) {
            if(tr.hasClass('table-primary')) {
                return false;
            }
        }

        var use_auto_extend=0;
        var oaee_id=0;
        var enroll_id=tr.find('td.enroll_transaction_date input:first').val();
        var stopped=tr.find('td.enroll_transaction_date input:eq(1)').val();
        var order_id=tr.find('td.enroll_transaction_date input:eq(2)').val();
        var end_date=tr.find('td.enroll_end_date input').val();
        var type=tr.find('td.enroll_category_name input').val();
        $('#user_enroll_edit').attr('href','/enrolls/edit/'+enroll_id);



        var is_delete=tr.find('td.enroll_transaction_date input:eq(3)').val();
        var end_text=tr.find('td.enroll_transaction_date input:eq(4)').val();

        if(type==1) {
            $('#user_enroll_extend').attr('href','/enrolls/extend/'+enroll_id).addClass('btn-modal').removeClass('disabled');
        } else {
            $('#user_enroll_extend').attr('href','#').addClass('disabled').removeClass('btn-modal');
        }

        if(stopped=='1') {
            $('#user_enroll_edit').attr('href','/enrolls/edit/'+enroll_id).addClass('btn-modal').addClass('disabled');
            $('#user_enroll_transfer').attr('href','#').addClass('disabled').removeClass('btn-modal');
        } else {
            $('#user_enroll_edit').attr('href','/enrolls/edit/'+enroll_id).addClass('btn-modal').removeClass('disabled');
            $('#user_enroll_transfer').attr('href','/enrolls/transfer/'+enroll_id).addClass('btn-modal').removeClass('disabled');
        }

        $('#user_enroll_delete').text(end_text);
        if(is_delete) {
            if($('#user_enroll_delete').length) {
                $('#user_enroll_delete').attr('href','/enrolls/delete/'+enroll_id).show();
            } else {
                $('#user_enroll_delete').attr('href','').hide();
            }
            $('#user_enroll_end').attr('href','').hide();
        } else {
            $('#user_enroll_end').attr('href','/enrolls/end/'+enroll_id).show();
            if($('#user_enroll_delete').length) {
                $('#user_enroll_delete').attr('href','').hide();
            }
        }


        tr.parent().find('tr').removeClass('table-primary');
        tr.addClass('table-primary');
        var enroll_category_name=tr.find('.enroll_category_name').text();
        var order_id=tr.find('input[name="order_id[]"]').val();
        $.getJSON('/accounts/get_order_list/'+order_id,{'format':'json'},function(data){
            if(data.result=='success') {
                $('#user_enroll_log_list tbody').empty();
                $("#enroll_log_title").text(enroll_category_name).effect('highlight');
                $("#export_enroll_account").attr('href','/accounts/export_enroll_account/'+order_id);
                if(data.total) {
                    $.each(data.list,function(index,value) {
                        var amount=Number(value.cash)+Number(value.credit);

                        var fee='-';
                        var dc='-';

                        if(value.account_category_id==1) {
                            fee=Number(value.original_price).toLocaleString()+'원';
                            dc=Number(Number(value.original_price * value.dc_rate / 100)+Number(value.dc_price)).toLocaleString()+'원';
                        }

                        $('<tr><td class="text-center">'+date_format(value.transaction_date)+'</td><td class="text-center">'+value.category_name.replace('수강','')+'</td><td class="text-right">'+fee+'</td><td class="text-right">'+dc+'</td><td class="text-right" style="background-color:powderblue;">'+Number(amount).toLocaleString()+'원</td><td class="text-right">'+Number(value.cash).toLocaleString()+'원</td><td class="text-right">'+Number(value.credit).toLocaleString()+'원</td></tr>').appendTo('#user_enroll_log_list tbody').effect('highlight');
                    });
                } else {
                    $('#user_enroll_log_list tbody').append('<tr><td colspan="8">해당 데이터가 없습니다.</td></tr>');
                }

            } else {

            }
        });
    }).css('cursor','pointer');

    $('#user_rent_list tbody tr td').click(function() {
        var tr=$(this).parent();
        if(tr.hasClass('table-primary')) {
            return false;
        }

        if(!tr.find('td.rent_transaction_date input').length) {
            return false;
        }

        var rent_id=tr.find('td.rent_transaction_date input:eq(0)').val();
        var stopped=tr.find('td.rent_transaction_date input:eq(1)').val();
        var order_id=tr.find('td.rent_transaction_date input:eq(2)').val();
        var expired=tr.find('td.rent_transaction_date input:eq(3)').val();
        $('#user_rent_edit').attr('href','/rents/edit/'+rent_id+'?user-page=true');
        $('#user_rent_move').attr('href','/rents/move/'+rent_id);
        $('#user_rent_transfer').attr('href','/rents/transfer/'+rent_id);
        $('#user_rent_extend').attr('href','/rents/extend/'+rent_id);
        $('#user_rent_delete').attr('href','/rents/delete/'+rent_id);

        if(stopped=='1') {
            $('#user_rent_stop_resume').text($("#text_resume_order").val()).attr('href','/rents/resume/'+rent_id).removeClass('disabled');
        } else {
            $('#user_rent_stop_resume').text($("#text_stop_order").val()).attr('href','/rents/stop/'+rent_id).removeClass('disabled');
        }

        if(expired=='1') {
            $("#user_rent_delete").text($("#text_delete_rent").val()).attr('href','/rents/end/'+rent_id+'?return=true');
        } else {
            $("#user_rent_delete").text($("#text_end_order").val()).attr('href','/rents/end/'+rent_id);
        }

        tr.parent().find('tr').removeClass('table-primary');
        tr.addClass('table-primary');
    }).css('cursor','pointer');


    $('#user_rent_sw_list tbody tr td').click(function() {
        var tr=$(this).parent();
        if(tr.hasClass('table-primary')) {
            return false;
        }

        if(!tr.find('td:first input').length) {
            return false;
        }

        var rent_sw_id=tr.find('td:first input:eq(0)').val();
        var stopped=tr.find('td:first input:eq(1)').val();
        $('#user_rent_sw_edit').attr('href','/rent-sws/edit/'+rent_sw_id+'?user-page=true');
        $('#user_rent_sw_move').attr('href','/rent-sws/move/'+rent_sw_id);
        $('#user_rent_sw_delete').attr('href','/rent-sws/delete/'+rent_sw_id);

        if(stopped=='1') {
            $('#user_rent_sw_stop_resume').text($("#text_rent_resume").val()).attr('href','/rent-sws/resume/'+rent_sw_id).removeClass('disabled');
        } else {
            $('#user_rent_sw_stop_resume').text($("#text_rent_stop").val()).attr('href','/rent-sws/stop/'+rent_sw_id).removeClass('disabled');
        }

        tr.parent().find('tr').removeClass('table-primary');
        tr.addClass('table-primary');
    }).css('cursor','pointer');

    $("#more-user-addtional").click(function(){
        if($('.additional-info').is(':visible')) {
            $('.additional-info').hide();
            $("#more-user-addtional").find('i').text('keyboard_arrow_down');
        } else {
            $('.additional-info').show().effect("highlight");
            $("#more-user-addtional").find('i').text('keyboard_arrow_up');
        }

        return false;
    });

    $("#more-user-memo").click(function(){
        var c_body=$(this).closest('.card').find('.card-body');
        $.getJSON('/user-contents',{'per_page':memo_perpage,'page':memo_page,'parent_id':$("#home_user_id").val(),'format':'json'},function(data){
            if(data.result=='success') {
                memo_page++;

                if(data.total) {
                    var c_body_content=c_body.find('.col-12');
                    $.each(data.list,function(index,value){
                        var div_node=$('<div style="margin-bottom:20px"></div>');
                        var a_node=$('<a href="/user-contents/view/'+value.id+'" class="btn-modal more">'+nl2br(value.content)+'</a>');
                        c_body_content.append(div_node.append(a_node));

                        var ta=value.updated_at.split(' ')[0].split('-');
                        console.log(ta);
                        var update_date=Number(ta[0])+'년 '+Number(ta[1])+'월 '+Number(ta[2])+'일';

                        div_node.append($('<span>('+update_date+')</span>'));
                        div_node.effect("highlight");
                        a_node.click(function(){
                            event.preventDefault();
                            $('#myModal').removeData("modal");
                            if($(this).attr('href').indexOf('?')=='-1') {
                                var url=$(this).attr('href')+'?popup=true';
                            } else {
                                var url=$(this).attr('href')+'&popup=true';
                            }
                            $('#myModal').load(url,function(){
                                $('#myModal').modal();
                            });
                            return false
                        });
                    });
                    c_body.scrollTop(c_body.height());
                }

            } else {

            }
        });

        return false;
    });

    $('#user_end_enroll_list tbody tr td').click(function() {
        var tr=$(this).parent();
        if(tr.hasClass('table-primary')) {
            return false;
        }

        if(!tr.find('td:first input').length) {
            return false;
        }

        var re_id=tr.find('td:first input:eq(0)').val();

        $("#user_re_enroll").attr('href',$("#user_re_enroll").attr('href').split('after=')[0]+'after='+re_id);
        $("#user_enroll_edit_expire_log").attr('href',$("#user_enroll_edit_expire_log").attr('href').split('/edit')[0]+'/edit/'+re_id);
        $("#user_enroll_delete_expire_log").attr('href',$("#user_enroll_delete_expire_log").attr('href').split('/disable')[0]+'/disable/'+re_id);

        tr.parent().find('tr').removeClass('table-primary');
        tr.addClass('table-primary');
    }).css('cursor','pointer');

    $('#user_end_rent_list tbody tr td').click(function() {
        var tr=$(this).parent();
        if(tr.hasClass('table-primary')) {
            return false;
        }

        if(!tr.find('td:first input').length) {
            return false;
        }

        var re_id=tr.find('td:first input:eq(0)').val();

        $("#user_re_rent").attr('href',$("#user_re_rent").attr('href').split('after=')[0]+'after='+re_id);
        $("#user_rent_edit_expire_log").attr('href',$("#user_rent_edit_expire_log").attr('href').split('/edit')[0]+'/edit/'+re_id);
        $("#user_rent_delete_expire_log").attr('href',$("#user_rent_delete_expire_log").attr('href').split('/disable')[0]+'/disable/'+re_id);

        tr.parent().find('tr').removeClass('table-primary');
        tr.addClass('table-primary');
    }).css('cursor','pointer');

    $("#user_order_stop_resume,#user_order_stop_edit").css('visibility','visible');
});
