var imgname = "";

/**
 展示图片
 */
function ShowImg(newfilename) {
    $("#spanImgInfo").append("<div class='d-inline-block'><img id='pic' width='100' height='100' src='/image/Course/" + newfilename + "'/>")
    $("#btUpload").attr("disabled", "disabled");
    imgname = newfilename;
}

/**
 上传课程
 */
function UpCourse() {
    var name = $("#C_Name").val();
    var desc = $("#C_Desc").val();
    if ((name.length != 0) & (desc.length != 0) & (imgname.length != 0)) {
        $.ajax({
            url: "/Member/AddCourse",
            type: "post",
            data: { cName: name, CDesc: desc, imgname: imgname },
            success: (data) => {
                if (data == 200) {
                    alert('上传成功');
                    window.location.href = "/Member/SelCouser";
                } else {
                    alert('服务器繁忙');
                }
            }
        });
    }

    if (name.length == 0)
        $("#name").text('请填写课程名称');
    if (desc.length == 0)
        $("#desc").text('请填写课程简介');
    if (imgname.length == 0)
        $("#img").text('请上传课程图片');
}

/**
清除lable标签内容
*/
$("#C_Name,#C_Desc").focus(() => {
    $("#name").text("");
    $("#desc").text("");
    $("#img").text("");
});