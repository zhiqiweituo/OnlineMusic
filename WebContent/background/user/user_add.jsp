<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery-easyui-1.5.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery-easyui-1.5.1/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
<title>用户添加</title>
<script>
	function submitForm(){
		$("#ff").form("submit",{
			url:"${pageContext.request.contextPath}/back/user_add.action",
			onSubmit:function(){
				if($('#userType').combobox("getValue")==""){
					$.messager.alert("系统提示","请选择用户类别");
					return false;
				}
				if($('#gender').combobox("getValue")==""){
					$.messager.alert("系统提示","请选择用户性别");
					return false;
				}
				if($('#userState').combobox("getValue")==""){
					$.messager.alert("系统提示","请选择用户状态");
					return false;
				}
				if($('#password').val()!=$('#passwordConfirm').val()){
					$.messager.alert("系统提示","两次输入的密码不一致");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.flag){
					window.location.href="${pageContext.request.contextPath }/background/user/user_list.jsp";	
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
	function clearForm(){
		$('#ff').form('clear');
	}
</script>
</head>
<body>

<div class="easyui-panel" title="添加用户" style="width:400px">
	<div style="padding:10px 0 10px 60px">
	<!-- form表单 -->
    <form id="ff" method="post" enctype="multipart/form-data">
    	<table>
    		<tr>
    			<td>用户类别:</td>
    			<td>
    				<input class="easyui-combobox" id="userType" name="user.userType" data-options="
								url: '${pageContext.request.contextPath }/back/user_userTypeComboBox.action',
								valueField: 'id',
								textField: 'text',
								panelWidth: 350,
								panelHeight: 'auto',
								formatter: formatItem
							">
					<script type="text/javascript">
						function formatItem(row){
							var s = '<span style="font-weight:bold">' + row.text + '</span><br/>' +
									'<span style="color:#888">' + row.desc + '</span>';
							return s;
						}
					</script>
    			</td>
    		</tr>
    		<tr>
    			<td>用户名:</td>
    			<td><input class="easyui-textbox" name="user.userName" data-options="required:true"></input></td>
    		</tr>
    		<tr>
    			<td>密码:</td>
    			<td><input class="easyui-textbox" type="password" id="password" name="user.password" data-options="required:true"></input></td>
    		</tr>
    		<tr>
    			<td>确认密码:</td>
    			<td><input class="easyui-textbox" type="password" id="passwordConfirm" data-options="required:true"></input></td>
    		</tr>
    		<tr>
    			<td>头像:</td>
    			<td>
    				<div>
    					<!--img src="${pageContext.request.contextPath }/background/upload/user/nophoto.jpg" id="myImage" width="30" height="30"/-->
    					<input type="hidden" id="headImg" name="user.headImg">
    				</div>
    				<div style="margin-top: 5px;">
    					<input class="easyui-filebox" name="headImg" buttonText="选择文件" buttonIcon="icon-folder-folder-user"></input>
    				</div>
    			</td>
    		</tr>
    		<tr>
    			<td>性别:</td>
    			<td>
    				<select class="easyui-combobox" id="gender" name="user.gender" editable="false" panelHeight="auto">
					    <option value="">请选择...</option>
						<option value="true">男</option>
						<option value="false">女</option>
					</select>
    			</td>
    		</tr>
    		<tr>
    			<td>状态:</td>
    			<td><select class="easyui-combobox" id="userState" name="user.userState" editable="false" panelHeight="auto">
					    <option value="">请选择...</option>
						<option value="1">有效</option>
						<option value="0">无效</option>
					</select>
				</td>
    		</tr>
    		<tr>
    			<td>手机号码:</td>
    			<td><input class="easyui-textbox" name="user.mobileNo"></input></td>
    		</tr>
    		<tr>
    			<td>电子邮箱:</td>
    			<td><input class="easyui-textbox" name="user.email"></input></td>
    		</tr>
    		<tr>
    			<td>备注:</td>
    			<td>
    				<input class="easyui-textbox" name="user.note"
						data-options="multiline:true" style="height:60px;width:160px;resize:none;" />
					</input>
				</td>
    		</tr>
    	</table>
    </form>
    </div>
    <div style="text-align:center;padding:5px">
    	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-page-page-save" onclick="submitForm()">提交</a>
    	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-folder-folder-wrench" onclick="clearForm()">重置</a>
    </div>
</div>

</body>
</html>