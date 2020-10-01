$(document).ready(function () {
    var height = $(document).height();
    $(".main").css("height", height);
});

/**
 发送邮箱验证码
 */
$("#emailCode").click(() => {
    var Email = $("#Email").val();
    if (Email.length != 0) {
        $.ajax({
            url: "/Member/sendEmail",
            type: "post",
            data: { direction: Email },
            success: (data) => {
                if (data == 200) {
                    $("#emailCode").text("验证码已发送");
                } else {
                    $("#emailPrompt").text("服务器繁忙");
                }
            },
        });
    }
    else {
        $("#emailPrompt").text("请输入邮箱");
    }
});

//还原按钮文字
$("#Email").focus(() => {
    $("#emailCode").text("获取验证码");
    $("#emailPrompt").text("");
});

$("#uPwd1").focus(() => {
    $("#pwdlPrompt").text("");
});

/**
 注册
 */
$("#ZC").click(() => {
    var code = $("#EmailCode").val();
    var role = $("#radRole:checked").val();
    var uname = $("#uName").val();
    var upwd = $("#uPwd").val();
    var upwd1 = $("#uPwd1").val();
    if (code.length != 0) {
        if (upwd == upwd1) {
            $.ajax({
                url: "/Member/Register",
                type: "post",
                data: { newcode: code, Role: role, uName: uname, uPwd: upwd },
                success: (data) => {
                    if (data == 200) {
                        $("#login").append("注册成功 <a href='/Login/Login'>去登录</a>");
                    }
                    if (data == 201)
                        $("#codePrompt").text("验证码错误");
                },
            });
        } else {
            $("#pwdlPrompt").text("两次密码不一致");
        }
    } else {
        $("#codePrompt").text("请填写验证吗");
        $("#EmailCode").focus();
    }
});