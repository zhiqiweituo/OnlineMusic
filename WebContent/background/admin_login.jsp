<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.1/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
<title>Insert title here</title>
<title>Insert title here</title>
</head>
<body>

<div class="easyui-panel" title="在线音乐平台后台登录" style="width:400px;padding:20px;">
	<div style="padding:10px 0 10px 60px">
    <form id="ff" method="post">
    	<table>
    		<tr>
    			<td>用户名:</td>
    			<td><input class="easyui-textbox easyui-validatebox" id="adminName" name="admin.adminName" data-options="iconCls:'icon-user-user-comment',required:true"></input></td>
    		</tr>
    		<tr>
    			<td>密码:</td>
    			<td><input class="easyui-textbox easyui-validatebox" id="password" name="admin.password" data-options="iconCls:'icon-lock-lock-open',required:true"></input></td>
    		</tr>
    	</table>
    </form>
    </div>
    <div style="text-align:center;padding:5px">
    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" data-options="iconCls:'icon-house-house-go'">提交</a>
    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" data-options="iconCls:'icon-folder-folder-wrench'">重置</a>
    </div>
</div>
<script>
	function submitForm(){
		$.messager.progress();
		$('#ff').form('submit',{
			url:'${pageContext.request.contextPath}/back/admin_login.action',
			onSubmit: function(){
				var isValid = $(this).form('validate');
				if (!isValid){
					$.messager.progress('close'); //如果表单是无效的则隐藏进度条
				}
				return isValid; //返回false终止表单提交
			},
			success: function(r){
				$.messager.progress('close'); //如果提交成功则隐藏进度条					
				var data=eval("("+r+")");
				if(data.flag!="true"){
					$.messager.alert('错误信息',data.info);    
				}else{
					window.location.href="${pageContext.request.contextPath}/background/main.jsp";
				}
			}
		});
	}
	function clearForm(){
		$('#ff').form('clear');
	}
</script>
</body>
</html>