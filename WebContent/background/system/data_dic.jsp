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
	
	function searchDataDic(){
		$('#dg').datagrid('load',{
			"s_dataDic.ddValue":$("#s_ddValue").val(),
			"s_dataDic.dataDicType.ddTypeId":$('#s_ddTypeId').combobox("getValue")
		});
	}
	
	function formatDdTypeId(val,row){
		return row.dataDicType.ddTypeId;
	}
	
	function formatDdTypeName(val,row){
		return row.dataDicType.ddTypeName;
	}
	
	
	function deleteDataDic(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].ddId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath }/back/dataDic_delete.action",{ids:ids},function(result){
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
	
	
	function openDataDicAddDialog(){
		
		$("#dlg").dialog("open").dialog("setTitle","添加数据字典");
		$('#dlg').window('center'); //居中显示
		url="${pageContext.request.contextPath }/back/dataDic_save.action";
	}
	
	function openDataDicModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑数据字典");
		//$("#fm").form("load",row);
		$("#ddId").val(row.ddId);
		$("#ddTypeId").combobox('setValue', row.dataDicType.ddTypeId);
		$("#ddValue").textbox("setValue",row.ddValue);
		$("#ddDesc").textbox("setValue",row.ddDesc);
		url="${pageContext.request.contextPath }/back/dataDic_save.action";
	}
	
	function closeDataDicDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function resetValue(){
		$("#ddId").val("");
		$("#ddTypeId").combobox('select', '请选择...');
		$("#ddValue").textbox("setValue","");
		$("#ddDesc").textbox("setValue","");
	}
	
	function saveDataDic(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($('#ddTypeId').combobox("getValue")==""){
					$.messager.alert("系统提示","请选择所属类别");
					return false;
				}
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

<table id="dg" class="easyui-datagrid" fitColumns="true" fit="true" border="true" 
 pagination="true" rownumbers="true" url="${pageContext.request.contextPath }/back/dataDic_list.action" toolbar="#tb">
	<thead>
		<tr>
			<th field="cb" checkbox="true"></th>
			<th field="ddId" width="10" hidden="true">编号</th>
			<th field="ddValue" width="100">数据字典值</th>
			<th field="dataDicType.ddTypeId" width="100" formatter="formatDdTypeId" hidden="true">数据字典类别ID</th>
			<th field="dataDicType.ddTypeName" width="100" formatter="formatDdTypeName">所属类别</th>
			<th field="ddDesc" width="120">数据字典描述</th>
		</tr>
	</thead>
</table>

<div id="tb">
	<div>
		<a href="javascript:openDataDicAddDialog()" class="easyui-linkbutton" iconCls="icon-page-page-add" plain="true">添加</a>
		<a href="javascript:openDataDicModifyDialog()" class="easyui-linkbutton" iconCls="icon-page-page-edit" plain="true">修改</a>
		<a href="javascript:deleteDataDic()" class="easyui-linkbutton" iconCls="icon-page-page-delete" plain="true">删除</a>
	</div>
	<div>
		<label style="margin-left: 5px;">数据字典值：</label>
		<input class="easyui-textbox" id="s_ddValue" name="s_ddValue"/>
		<label style="margin-left: 5px;">所属类别：</label>
		<input class="easyui-combobox" id="s_ddTypeId"  name="s_ddTypeId" size="20" 
			data-options="panelHeight:'auto',
				editable:false,
				valueField:'ddTypeId',
				textField:'ddTypeName',
				url:'${pageContext.request.contextPath }/back/dataDicType_comboList.action'"/>
		<a href="javascript:searchDataDic()" class="easyui-linkbutton" iconCls="icon-zoom-zoom-in" plain="true">搜索</a>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 400px;height: 280px; padding: 10px;"
	closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table>
			<tr>
				<td>数据字典值：<input type="hidden" name="dataDic.ddId" id="ddId"/></td>
				<td><input class="easyui-textbox" name="dataDic.ddValue" id="ddValue" class="easyui-validatebox" required="true"/></td>
			</tr>
			<tr>
				<td>所属类别：</td>
				<td><input class="easyui-combobox" id="ddTypeId" name="dataDic.dataDicType.ddTypeId"  
						data-options="panelHeight:'auto',
						editable:false,
						valueField:'ddTypeId',
						textField:'ddTypeName',
						url:'${pageContext.request.contextPath }/back/dataDicType_comboList.action'"/></td>
			</tr>
			<tr>
				<td valign="top">数据字典描述：</td>
				<td>
					<input class="easyui-textbox" data-options="multiline:true" id="ddDesc" name="dataDic.ddDesc" style="height:100px"/>
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:saveDataDic()" class="easyui-linkbutton" iconCls="icon-page-page-save">保存</a>
	<a href="javascript:closeDataDicDialog()" class="easyui-linkbutton" iconCls="icon-folder-folder-wrench">关闭</a>
</div>

</body>
</html>