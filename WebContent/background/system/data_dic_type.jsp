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

<script type="text/javascript">
	var url;
	
	function searchDataDicType(){
		$('#dg').datagrid('load',{
			"s_dataDicType.ddTypeName":$("#s_ddTypeName").val()
		});
	}
	
	function deleteDataDicType(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].ddTypeId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath }/back/dataDicType_delete.action",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据已成功删除！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","数据删除失败！");
					}
				},"json");
			}
		});
	}
	
	
	function openDataDicTypeAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加数据字典类别");
		url="${pageContext.request.contextPath }/back/dataDicType_save.action";
	}
	
	function openDataDicTypeModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑数据字典类别");
		//$("#fm").form("load",row); //不能load表单了，需要一个一个设置值
		$("#ddTypeId").val(row.ddTypeId);
		$("#ddTypeName").textbox("setValue",row.ddTypeName);
		$("#ddTypeDesc").textbox("setValue",row.ddTypeDesc);
		url="${pageContext.request.contextPath }/back/dataDicType_save.action";
	}
	
	function closeDataDicTypeDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function resetValue(){
		$("#ddTypeId").val("");
		$("#ddTypeName").textbox("setValue","");
		$("#ddTypeDesc").textbox("setValue","");
	}
	
	function saveDataDicType(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
</script>

</head>
<body style="padding: 2px;">
<!-- easyUI的dataGrid数据表格 -->
<table id="dg" class="easyui-datagrid" fitColumns="true" fit="true" border="true" 
 pagination="true" rownumbers="true" url="${pageContext.request.contextPath }/back/dataDicType_list.action" toolbar="#tb">
	<thead>
		<tr>
			<th field="cb" checkbox="true"></th>
			<th field="ddTypeId" width="10" hidden="true">编号</th>
			<th field="ddTypeName" width="100">数据字典类别名称</th>
			<th field="ddTypeDesc" width="200">数据字典类别描述</th>
		</tr>
	</thead>
</table>

<!-- 数据表格的toolbar -->
<div id="tb">
	<div>
		<a href="javascript:openDataDicTypeAddDialog()" class="easyui-linkbutton" iconCls="icon-table-table-add" plain="true">添加</a>
		<a href="javascript:openDataDicTypeModifyDialog()" class="easyui-linkbutton" iconCls="icon-table-table-edit" plain="true">修改</a>
		<a href="javascript:deleteDataDicType()" class="easyui-linkbutton" iconCls="icon-table-table-delete" plain="true">删除</a>
	</div>
	<div>
		<label style="margin-left: 5px;">数据字典类别名称：</label>
		<input class="easyui-textbox" id="s_ddTypeName" name="s_ddTypeName"/>
		<a href="javascript:searchDataDicType()" class="easyui-linkbutton" iconCls="icon-zoom-zoom-in" plain="true">搜索</a>
	</div>
</div>
<!-- 对话框 -->
<div id="dlg" class="easyui-dialog" style="width: 400px;height: 240px;padding: 10px;"
	closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table>
			<tr>
				<td>数据字典类别名称：<input type="hidden" id="ddTypeId" name="dataDicType.ddTypeId"/></td>
				<td><input class="easyui-textbox easyui-validatebox" id="ddTypeName" name="dataDicType.ddTypeName" required="true"/></td>
			</tr>
			<tr>
				<td valign="top">数据字典类别描述：</td>
				<td><input class="easyui-textbox" data-options="multiline:true" id="ddTypeDesc" name="dataDicType.ddTypeDesc" style="height:80px"/></td>
			</tr>
		</table>
	</form>
</div>
<!-- 对话框的buttons -->
<div id="dlg-buttons">
	<a href="javascript:saveDataDicType()" class="easyui-linkbutton" iconCls="icon-page-page-save">保存</a>
	<a href="javascript:closeDataDicTypeDialog()" class="easyui-linkbutton" iconCls="icon-folder-folder-wrench">关闭</a>
</div>

</body>
</html>