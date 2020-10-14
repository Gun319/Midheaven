$("#Edit").click(() => {
    var Uname = $("#UserName").val();
    var pwd = $("#Password").val();
    var Rame = $("#RealName").val();
    var sex = $("#Sex:checked").val();
    var age = $("#Age").val();
    var phoneNum = $("#PhoneNum").val();
    var address = $("#Address").val();
    $.ajax({
        url: '/Member/MemberUpdateInfo',
        data: { Uname: Uname, pwd: pwd, Rame: Rame, sex: sex, age: age, phoneNum: phoneNum, address: address },
        type: 'post',
        dataType: 'json',
        success: (data) => {
            if (data == 200) {
                alert('更新成功,请重新登录');
                window.location.href = '/Login/Login';
            } else {
                alert('修改失败，请查看网络连接');
            }
        }
    });
});