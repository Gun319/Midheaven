selpage();

/**
 显示已选课程
 */
function selpage() {
    $.ajax({
        url: "/Member/SelCourse",
        type: "post",
        data: {},
        success: function (data) {
            var str = "";
            $.each(data, function (index, item) {
                str += "<tr>";
                str += "<td>" + item.C_ID + "</td>";
                str += "<td>" + item.C_Name + "</td>";
                str += "<td>" + item.C_Desc + "</td>";
                str += "<td><button type='button' class='btn btn-danger'id='btnup' onclick='Del(" + item.ID + ");'>退课</button></td>";
                str += "</tr>";
            })
            $("#dg tbody tr").remove();
            $("#dg tbody").append(str);
            return;
        }
    });
}

/**
 退课
 */
function Del(id) {
    $.ajax({
        url: "/Member/DelStudentCourse",
        type: "post",
        data: { id: id },
        success: function (data) {
            if (data = 200) {
                alert('退课完成');
                return;
            }
            else {
                alert('退课失败，请检查网络连接');
            }
        }
    });
}