$(function () {
    getCookie();

    Victor("container", "output");   //登录背景函数
    $("#UserName").focus(); //默认选中

    $("#Password,#UserName").keydown((event) => {
        if (event.keyCode == "13") {
            // 调用Ajax方法
            if (($("#UserName").val().length != 0) & $("#Password").val().length != 0)
                PostData();
            // 非空提示
            if ($("#UserName").val().length == 0)
                $("#namePrompt").text("用户名不能为空");

            if ($("#Password").val().length == 0)
                $("#pwdPrompt").text("密码不能为空");
        }
    })
});

$("#entry_btn").click(() => {
    PostData();
});

/**
登录异步验证
*/
function PostData() {
    var uName = $("#UserName").val();
    var uPwd = $("#Password").val();
    var chk1 = $("#chkTrue").is(":checked");
    $.ajax({
        url: '/Login/Login',
        data: { username: uName, userpwd: uPwd, chk1: chk1 },
        type: 'post',
        dataType: 'json',
        success: (data) => {
            if (data != 0) {
                $.each(data, (index, item) => {
                    if (item.M_Flog == 0) {
                        if (item.R_ID == 1)
                            window.location.href = "/Admin/AdminIndex";
                        if (item.R_ID == 2)
                            window.location.href = "/Member/MemberByTeacher";
                        if (item.R_ID == 3)
                            window.location.href = "/Member/MemberByStudent";
                    } else {
                        $("#prompt").text("账户已注销请联系管理员");
                    }
                });
            } else {
                $("#prompt").text("用户名或密码错误");
            }
        }
    });
}

/**
清除lable标签内容
*/
$("#UserName,#Password").focus(() => {
    $("#prompt").text("");
    $("#namePrompt").text("");
    $("#pwdPrompt").text("");
});

/**
 有Cookie对象则选中复选框
 */
function getCookie() {
    $.ajax({
        url: '/Login/GetCookie',
        data: {},
        type: 'post',
        dataType: 'json',
        success: (data) => {
            if (data == 200) {
                $("#chkTrue").prop("checked", true);
            } else {
                $("#chkTrue").prop("checked", false);
            }
        }
    })
}