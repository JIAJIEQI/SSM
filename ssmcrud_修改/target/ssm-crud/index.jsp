<%--
  Created by IntelliJ IDEA.
  User: jiaji
  Date: 2018/8/13
  Time: 14:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="utf-8"%>

<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>员工列表</title>
    <%
        String path = request.getContextPath();
    %>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--=============================web路径=====================================-->
    <!-- 不以/开始的相对路径，找资源，以资源当前路径为基准，
         以斜线开始的相对路径，找资源，以服务器的路径为标准，想要加上当前项目名
    -->
    <!-- Bootstrap引入样式 -->
    <link href="<%=path%>/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="<%=path%>/static/js/jquery-3.3.1.min.js"></script>
    <script src="<%=path%>/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>

<!-- 员工添加Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empUser</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empUser" id="empUser_add_input"
                                   placeholder="xxx">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_add_input"
                                   placeholder="xxx@.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="deptName_add_input"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_bt">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_bt">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <td>#</td>
                        <td>empUser</td>
                        <td>gender</td>
                        <td>email</td>
                        <td>deptName</td>
                        <td>操作</td>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="page_info"></div>
        <div class="col-md-6" id="page_nav"></div>
    </div>
    <script type="text/javascript">
        var totalRecord;
        //页面加载完成后，直接发送一个ajax请求，拿到分页数据
        $(function () {
            to_page(1);
        });
        function to_page(pn) {
            $.ajax({
                url:"<%=path%>/emps",
                data:"pn="+pn,
                type:"GET",
                //请求成功回调函数
                success:function (result) {
                    //控制台打印
                    //console.log(result)
                    build_emps_table(result);
                    build_page_info(result);
                    build_page_nav(result);
                }
            });
        }
        
        function build_emps_table(result) {
            //清空表格
            $("#emps_table tbody").empty();
            var emps=result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                //弹窗 alert(item.empUser)
                var  empIdTd = $("<td></td>").append(item.empId);
                var  empUserTd = $("<td></td>").append(item.empUser);
                var  genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
                var  emailTd = $("<td></td>").append(item.email);
                var  deptNameTd = $("<td></td>").append(item.department.deptName);
                var  editbt=$("<button></button>").addClass("btn btn-primary btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                var  delbt=$("<button></button>").addClass("btn btn-danger btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                var btTd = $("<td></td>").append(editbt).append(" ").append(delbt);
                $("<tr></tr>").append(empIdTd).append(empUserTd).append(genderTd)
                    .append(emailTd).append(deptNameTd).append(btTd).appendTo("#emps_table tbody");
            });
        }
        function build_page_info(result) {
            $("#page_info").empty();
            $("#page_info").append("当前"+result.extend.pageInfo.pageNum+"页，共"+
                result.extend.pageInfo.pages+"页，"+
                result.extend.pageInfo.total+"条记录");
            totalRecord=result.extend.pageInfo.total;
        }
        function build_page_nav(result) {
             $("#page_nav").empty();
            var  ul =$("<ul></ul>").addClass("pagination");
            var  firstPageLi=$("<li></li>").append($("<a></a>").append("首页"));
            var  prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
            if (result.extend.pageInfo.hasPreviousPage==false) {
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else {
                firstPageLi.click(function () {
                    to_page(1);

                });
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum-1);

                });
            }
            var  nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
            var  lastPageLi=$("<li></li>").append($("<a></a>").append("末页"));
            if (result.extend.pageInfo.hasNextPage==false) {
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);

                });
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum+1);

                });
            }
            ul.append(firstPageLi).append(prePageLi);
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item){
                var  numLi=$("<li></li>").append($("<a></a>").append(item));
                if (result.extend.pageInfo.pageNum==item) {
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(item);
                });
                ul.append(numLi);
            });
            ul.append(nextPageLi).append(lastPageLi);
            var nav=$("<nav></nav>").append(ul);
            nav.appendTo("#page_nav");
        }
        function reset_form(ele){
            $(ele)[0].reset();
            //清空表单样式，表单下的所有
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }
        $("#emp_add_modal_bt").click(function () {

            reset_form("#empAddModal form");
            getDepts();

            $("#empAddModal").modal({
                backdrop:"static"
            });
            function getDepts() {
                $.ajax({
                    url:"<%=path%>/depts",
                    type:"GET",
                    success:function (result){
                        //console.log(result);
                        //"{code":200,"msg":"处理成功！","extend":{"depts":[{"deptId":1,"deptName":"开发部"},
                        // {"deptId":2,"deptName":"测试部"}]}}
                        $.each(result.extend.depts,function () {
                            var optionBt=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                            optionBt.appendTo("#deptName_add_input");
                        });
                    }
                });
            }
            function validate_add_form(){
                var  empUser=$("#empUser_add_input" ).val();
                var  regUser= /(^[A-Za-z0-9_]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
                if (!regUser.test(empUser)){
                    show_validate_msg("#empUser_add_input" ,"error","用户名可以是2-5位中文或者3-16位英文数字下划线组合");
                    return false;
                }
                else {
                    show_validate_msg("#empUser_add_input" ,"success"," ");
                }
                var  email=$("#email_add_input").val();
                var  regEmail= /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if (!regEmail.test(email)){
                    show_validate_msg("#email_add_input" ,"error","邮箱格式不正确");
                    return false;
                }
                else {
                    show_validate_msg("#email_add_input" ,"success"," ");
                }
                return true;
            }

            function show_validate_msg(ele,status,msg){
                //清除当前元素校验状态
                $(ele).parent
                $(ele).parent().removeClass("has-success has-error");
                $(ele).next("span").text(" ");
                if ("success"==status){
                    $(ele).parent().addClass("has-success");
                    $(ele).next("span").text(msg)
                }
                else if ("error"==status) {
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg)
                }
            }

            $("#empUser_add_input" ).change(function (){
                var  empUser=this.value;
                $.ajax({
                    url:"<%=path%>/checkUser",
                    type:"POST",
                    data:"empUser="+empUser,
                    success:function (result){
                        if (result.code==200){
                            show_validate_msg("#empUser_add_input" ,"success","用户名可用");
                            $("#emp_save_bt" ).attr("ajax_va","success");
                        }
                        else {
                            show_validate_msg("#empUser_add_input" ,"error",result.extend.va_msg);
                            $("#emp_save_bt" ).attr("ajax_va","error");
                        }
                    }
                });
            });

            $("#emp_save_bt" ).click(function () {
                // if(!validate_add_form()){
                //     return false;
                // }
                if ($(this).attr("ajax_va")=="error"){
                    return false;
                }
                $.ajax({
                    url:"<%=path%>/empSave",
                    type:"POST",
                    data:$("#empAddModal form").serialize(),
                    success:function (result){
                        if (result.code == 200) {
                            //员工保存成功；
                            //1、关闭模态框
                            $("#empAddModal").modal('hide');
                            //2、来到最后一页，显示刚才保存的数据，发送ajax请求显示最后一页数据
                            to_page(totalRecord);
                        } else {
                            if(undefined != result.extend.errorFields.email){
                                //显示邮箱错误信息
                                show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                            }
                            if(undefined != result.extend.errorFields.empUser){
                                //显示员工名字的错误信息
                                show_validate_msg("#empUser_add_input", "error", result.extend.errorFields.empUser);
                            }

                        }
                    }
                });
            });
        });
    </script>


</div>

</body>
</html>
