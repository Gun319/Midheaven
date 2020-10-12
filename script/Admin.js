SelInfo();

$("#Sel").click(() => {
    SelInfo();
});

$("#RealName").keydown((event) => {
    SelInfo();
})

/**
 显示所有成员信息
 */
function SelInfo() {
    var name = $("#RealName").val();
    var flog = $("input[type='radio']:checked").val();
    $.ajax({
        url: '/Admin/AdminIndex',
        data: { username: name, flog: flog },
        type: 'post',
        dataType: 'json',
        success: (data) => {
            var tab = "";
            $.each(data, (index, item) => {
                tab += "<tr>";
                tab += "<td>" + item.M_ID + "</td>";
                tab += "<td>" + item.UserName + "</td>";
                tab += "<td>" + item.Password + "</td>";
                tab += "<td>" + item.RealName + "</td>";
                tab += "<td>" + item.Sex + "</td>";
                tab += "<td>" + item.Age + "</td>";
                tab += "<td>" + item.PhoneNum + "</td>";
                tab += "<td>" + item.Address + "</td>";
                tab += "<td>" + (item.R_ID == 2 ? "教师" : "学生") + "</td>";
                tab += "<td><button class='btn btn-primary' onclick='Edit(" + item.M_ID + ")'>" + (item.M_Flog == 0 ? "未注销" : "已注销") + "</button></td>";
                tab += "<td><button type='button' class='btn btn-danger' onclick='Del(" + item.M_ID + ")'>删除</button>";
                tab += "</tr>";
            })
            $("#dg tbody tr").remove();
            $("#dg tbody").append(tab);
        }
    });
}

/**
 更改成员注销状态
 */
function Edit(mid) {
    $.ajax({
        url: '/Admin/Editflag',
        data: { mid: mid },
        type: 'post',
        dataType: 'json',
        success: (data) => {
            if (data == 200) {
                SelInfo();
            } else {
                alert('修改失败，请检查网络连接');
            }
        }
    });
}

/**
 真是删除成员信息
 */
function Del(mid) {
    $.ajax({
        url: '/Admin/DelMemberByCID',
        data: { mid: mid },
        type: 'post',
        dataType: 'json',
        success: (data) => {
            if (data == 200) {
                alert('删除成功');
                SelInfo();
            } else {
                alert('删除失败，请检查网络连接');
            }
        }
    });
}