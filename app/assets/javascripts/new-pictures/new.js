
$(document).ready(function() {
    // 카메라장치 존재여부 확인
    if (navigator.mediaDevices == null || navigator.mediaDevices.getUserMedia == null) {
        alert("카메라장치에 접근할 수 없습니다.");
        if (opener) window.close();
        return;
    }

    // 변수들...
    var videoInterval = null;
    var imageData = null;
    var canvas = document.getElementById("canvas");
    var context = canvas.getContext("2d");
    var video = document.getElementById("video");
    var videoObj = {video: true}; // 오디오는 사용하지 않는다. 만약 사용한다면 'audio': true 추가
    var photo = document.getElementById("photo");


    // 비디오 출력 받기
    navigator.mediaDevices.getUserMedia(videoObj).then(function (stream) {
        try {
            video.srcObject=stream;
            video.onloadedmetadata = function(e) {
                video.play();
            };
        } catch (error) {
            video.src = URL.createObjectURL(stream);
            video.play();
        }
    }).catch(function(err) {
        alert(err);
    });

    // 스냅샷 찍기
    $('#snap').click(function() {
        clearInterval(videoInterval);
        imageData = canvas.toDataURL();
        $('#snap').attr('disabled', true);
        $('#save').attr('disabled', false).removeClass('btn-secondary').addClass('btn-primary');
        $('#resume').attr('disabled', false);
    });

    function urldecode(url) {
        return decodeURIComponent(url.replace(/\+/g, ' '));
    }

    // 저장
    $('#save').click(function() {
        var r_id=$("#v_id").val();

        switch($('#v_type').val()) {
            case 'admins' :
                var r_url='/admin/admin_pictures.json';
                var params={'authenticity_token':$('meta[name="csrf-token"]').attr('content'),'admin_picture[admin_id]':r_id,'admin_picture[picture]':imageData}
                break;
            default :
                var r_url='/admin/user_pictures.json';
                var params={'authenticity_token':$('meta[name="csrf-token"]').attr('content'),'user_picture[user_id]':r_id,'user_picture[picture]':imageData}
        }

        $.post(r_url,params,function(data){
                if (opener) {
                    if(data.id!=true) {
                        var form=$('<form action="'+r_url+'" method="post" accept-charset="utf-8">');
                        form.append('<input value="'+opener.$("#delete-photo-layer span").text()+'" class="btn btn-sm btn-outline-secondary btn-block" type="submit">');
                        opener.$("#delete-photo-layer").empty().append(form);
                    }

                    opener.$('#profile_photo').attr('src',data.picture.medium_thumb.url);
                    window.close();
                }
        },'json');
    });

    // 새로
    $('#resume').click(function() {
        $('#snap').attr('disabled', false);
        $('#save').attr('disabled', true).removeClass('btn-primary').addClass('btn-secondary');
        $('#resume').attr('disabled', true);
        videoRun();
    });

    // 비디오 출력을 적당한 크기로 출력하기 위해서 사용
    function drawVideo () {
        if (!context || !context.drawImage) return;
        context.drawImage(video, 0, 0, 372, 372);
    }

    // 촬영하기
    function videoRun () {
        $('#snap').attr('disabled', false);
        $('#save').attr('disabled', true);
        $('#resume').attr('disabled', true);
        clearInterval(videoInterval);
        videoInterval = setInterval(drawVideo, 1000/30);
    }
    videoRun();
});
