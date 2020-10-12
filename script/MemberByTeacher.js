//MemberByTeacher
funCourse();

$("#courseName").keydown((event) => {
    funCourse();
})

$("#Sel").click(() => {
    funCourse();
});

/**
 显示当前教师所属课程信息
 */
function funCourse() {
    var cName = $("#courseName").val();
    var tname = $("#tname").val();
    $.ajax({
        url: "/Member/MemberByTeacher",
        type: "post",
        data: { cName: cName },
        success: (data) => {
            var str = "";
            $.each(data, (idnex, item) => {
                str += '<div class="courseItem shadow-sm mt-3"><div class="img">' +
                    '<img src="/image/Course/' + item["name"]["C_img"] + '" style="width: 80px; height: 80px; border-radius: 8px; vertical-align: middle;" /></div >' +
                    '<div class="inline-info1"><label class="title">课程名称：</label><label>' + item["name"]["C_Name"] + '</label><br /><label class="title">上传教师：</label><label>' + tname + '</label></div>' +
                    '<div class="inline-info"><span class="title">简介：</span><span>' + item["name"]["C_Desc"] + '</span></div>' +
                    '<div class="inline-info2"><label class="title">选课人数：</label>' +
                    '<label>' + item["count"] + '<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-cart-plus" fill="currentColor" xmlns="http://www.w3.org/2000/svg">' +
                    '<path fill-rule="evenodd" d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm7 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" />' +
                    '<path fill-rule="evenodd" d="M8.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H9v1.5a.5.5 0 0 1-1 0V8H6.5a.5.5 0 0 1 0-1H8V5.5a.5.5 0 0 1 .5-.5z" /></svg>' +
                    '</label></div><div class="inline-info2"><span class="title">变更可选状态：</span><button id="Del" class="btn btn-primary" onclick="Updete(' + item["name"]["C_ID"] + ');">' + (item["name"]["C_flog"] == 0 ? "可选" : "维护中") + '</button></div>' +
                    '<div class="inline-info2"><button class="btn btn-danger" onclick="DelByIdAndFlog(' + item["name"]["C_ID"] + ');">清除该课程</button></div></div >';
            })
            $("#course div div").remove();
            $("#course div").append(str);
        }
    });
}

/**
 更改成员注销状态
 */
function Updete(cid) {
    $.ajax({
        url: '/Member/EditCourseById',
        data: { cid: cid },
        type: 'post',
        success: (data) => {
            if (data == 200) {
                funCourse();
            } else {
                alert('修改失败，请检查网络连接');
            }
        }
    });
}

/**
 真是删除课程信息
*/
function DelByIdAndFlog(cid) {
    $.ajax({
        url: '/Member/DelCourseById',
        data: { cid: cid },
        type: 'post',
        success: (data) => {
            if (data == 200) {
                alert('删除成功');
                funCourse();
            }
            if (data == 201) {
                alert('删除失败，请检查网络连接');
            }
            if (data == 202) {
                alert('当前课程无法删除，学生正在进行学习');
            }
        }
    });
}