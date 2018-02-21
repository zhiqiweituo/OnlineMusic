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
<title>用户列表</title>
<script type="text/javascript">
	var url;

	function searchUser(){
		$('#dg').datagrid('load',{
			"s_elecDevice.devName":$("#s_devName").val()
		});
	}

	function deleteUser(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath }/back/user_deleteSelected.action",{selectedRow:ids},function(result){
					if(result.success){
						if(result.exist){
							$.messager.alert("系统提示",result.exist);
						}else{
							$.messager.alert("系统提示","数据已成功删除！");							
						}
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","数据删除失败！");
					}
				},"json");
			}
		});
	}
	
	function userAdd(){
		window.location.href="${pageContext.request.contextPath }/back/user_addUI.action";
	}
	function userModify(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		window.location.href="${pageContext.request.contextPath }/back/user_editUI.action?user.userNo="+row.userNo;
	}
	
</script>
</head>
<body>

<!-- easyUI的panel -> dataGrid数据表格 -->
<div class="easyui-panel" style="width:100%;height:420px;padding:10px;">
	<!-- 使用Javascript去创建dataGrid控件 -->
	<table id="dg" fitColumns="true" pagination="true" rownumbers="true" fit="true" toolbar="#tb"></table>

	<div id="tb">
		<div>
			<a href="javascript:userAdd()" class="easyui-linkbutton" iconCls="icon-group-group-add" plain="true">添加</a>
			<a href="javascript:userModify()" class="easyui-linkbutton" iconCls="icon-group-group-edit" plain="true">修改</a>
			<a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-group-group-delete" plain="true">删除</a>
		</div>
		<div>
			<label style="margin-left: 5px;">用户名：</label>
			<input class="easyui-textbox" id="" name=""/>
			<label style="margin-left: 5px;">性别：</label>
			<input class="easyui-textbox" id="" name=""/>
			<label style="margin-left: 5px;">手机：</label>
			<input class="easyui-textbox" id="" name=""/>
			<label style="margin-left: 5px;">邮箱：</label>
			<input class="easyui-textbox" id="" name=""/>
			<a href="javascript:searchUser()" class="easyui-linkbutton" iconCls="icon-zoom-zoom" plain="true">搜索</a>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	$('#dg').datagrid({    
	    url:'${pageContext.request.contextPath }/back/user_list.action',    
	    columns:[[
			{field:'cb',checkbox:true},
			{field:'userNo',title:'ID',hidden:true},
	        {field:'userType',title:'用户类别',width:100},   
	        {field:'userName',title:'用户名',width:80,align:'left'},
	        {field:'password',title:'密码',width:80,align:'left',hidden:true},
	        {field:'headImg',title:'头像',width:100,align:'left',hidden:true},
	        {field:'gender',title:'性别',width:50,align:'left',
	        	formatter: function(value,row,index){
					if(row.gender){
						return "男";
					}else{
						return "女";
					}
				}
			},
	        {field:'userState',title:'状态',width:50,align:'left',
				formatter: function(value,row,index){
					if(row.state==1){
						return "有效";
					}else{
						return "无效";
					}
				}
			},
	        {field:'mobileNo',title:'手机',width:80,align:'left'},
	        {field:'email',title:'邮箱',width:80,align:'left'},
	        {field:'birthday',title:'生日',width:100,align:'left'},
	        {field:'note',title:'备注',width:100,align:'left',hidden:true}
	    ]]    
	});
</script>
</html>