SeleCouser();

//点击事件
//触发后台事件
//用户输入的名称
$("#Sel").click(function () {
    SeleCouser();
})

$("#C_Name").keydown((event) => {
    SeleCouser();
});

/**
 所有课程
 */
function SeleCouser() {
    var courname = $("#C_Name").val();
    $.ajax({
        url: "/Member/SelAllCouser",
        type: "post",
        data: { courName: courname },
        success: function (data) {
            //获取后台传到前台的值
            //循环显示得到的集合
            var str = "";
            $.each(data, function (index, item) {
                str += "<tr>";
                str += "<td width='100'>" + item.C_ID + "</td>";
                str += "<td>" + item.C_Name + "</td>";
                str += "<td>" + item.C_Desc + "</td>";
                str += "<td><img src='/image/Course/" + item.C_img + "' width='50' height='50' /></td>";
                str += "<td width='100'><button type='button' class='btn btn-danger' onclick='Addcourse(" + item.C_ID + ");'>选课</button></td>";
                str += "<tr>";
            })
            //清除（之前追加的）
            $("#dg tr:gt(0)").remove();
            //追加到指定位置
            $("#dg").append(str);
        }
    })
}

/**
 选课
 */
function Addcourse(couid) {
    $.ajax({
        url: "/Member/StudentAddCouser",
        type: "post",
        data: { couid: couid },
        success: function (data) {
            if (data == 200) {
                alert("选课成功");
            }
            if (data == 201) {
                alert("已选择该课程不能再重复选择");
            }
            if (data != 200 & data != 201) {
                alert("无法选择，请查看网络连接");
            }
        }
    });
}