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
<title>歌手列表</title>
<script type="text/javascript">
	var url;
	
	function searchSinger(){
		$('#dg').datagrid('load',{
			s_singerName:$("#s_singerName").textbox('getValue')
		});
	}
	
	function deleteSinger(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].singerId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath }/back/singer_delete.action",{ids:ids},function(result){
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
	
	
	function openSingerAddDialog(){
		
		$("#dlg").dialog("open").dialog("setTitle","添加歌手信息");
		$('#dlg').window('center'); //居中显示
		url="${pageContext.request.contextPath }/back/singer_save.action";
	}
	
	function openSingerModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑歌手信息");
		//$("#fm").form("load",row);
		$("#singerId").val(row.singerId);
		$("#singerName").textbox("setValue",row.singerName);
		if(row.sex){
			$("#sex").combobox('setValue', '男');
		}else{
			$("#sex").combobox('setValue', '女');
		}
		$("#region").combobox('setValue', row.region);
		url="${pageContext.request.contextPath }/back/singer_save.action";
	}
	
	function closeSingerDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function resetValue(){
		$("#singerId").val("");
		$("#singerName").textbox("setValue","");
		$("#sex").combobox('select', '请选择...');
		$("#region").combobox('select', '请选择...');
	}
	
	function saveSinger(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($('#sex').combobox("getValue")==""){
					$.messager.alert("系统提示","请选择性别");
					return false;
				}
				if($('#region').combobox("getValue")==""){
					$.messager.alert("系统提示","请选择所属地区");
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
<body>

<!-- easyUI的panel -> dataGrid数据表格 -->
<div class="easyui-panel" style="width:100%;height:420px;padding:10px;">
	<!-- 使用Javascript去创建dataGrid控件 -->
	<table id="dg" fitColumns="true" pagination="true" rownumbers="true" fit="true" toolbar="#tb"></table>

	<div id="tb">
		<div>
			<a href="javascript:openSingerAddDialog()" class="easyui-linkbutton" iconCls="icon-group-group-add" plain="true">添加</a>
			<a href="javascript:openSingerModifyDialog()" class="easyui-linkbutton" iconCls="icon-group-group-edit" plain="true">修改</a>
			<a href="javascript:deleteSinger()" class="easyui-linkbutton" iconCls="icon-group-group-delete" plain="true">删除</a>
		</div>
		<div>
			<label style="margin-left: 5px;">歌手姓名：</label>
			<input class="easyui-textbox" id="s_singerName" name="s_singerName"/>
			<a href="javascript:searchSinger()" class="easyui-linkbutton" iconCls="icon-zoom-zoom" plain="true">搜索</a>
		</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 400px;height: 280px; padding: 10px;"
	closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table>
			<tr>
				<td>歌手姓名：<input type="hidden" id="singerId" name="singer.singerId"/></td>
				<td><input class="easyui-textbox easyui-validatebox" id="singerName" name="singer.singerName" required="true"/></td>
			</tr>
			<tr>
				<td>性别：</td>
				<td>
					<select class="easyui-combobox" id="sex" name="singer.sex" editable="false" panelHeight="auto">
					    <option value="">请选择...</option>
						<option value="true">男</option>
						<option value="false">女</option>
					</select>
				</td>
			</tr>
			<tr>
				<td valign="top">所属地区：</td>
				<td><input class="easyui-combobox" id="region" name="singer.region"  
						data-options="panelHeight:'auto',
						value:'请选择...',
						editable:false,
						valueField:'ddValue', <!-- 数据库里存储数据字典里本身的值 -->
						textField:'ddValue',
						url:'${pageContext.request.contextPath }/back/dataDic_regionComboList.action'"/></td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:saveSinger()" class="easyui-linkbutton" iconCls="icon-page-page-save">保存</a>
	<a href="javascript:closeSingerDialog()" class="easyui-linkbutton" iconCls="icon-folder-folder-wrench">关闭</a>
</div>

</body>
<script type="text/javascript">
	$('#dg').datagrid({    
	    url:'${pageContext.request.contextPath }/back/singer_list.action',    
	    columns:[[
			{field:'cb',checkbox:true},
			{field:'singerId',title:'ID',hidden:true},
	        {field:'singerName',title:'歌手姓名',width:100},
	        {field:'sex',title:'性别',width:50,align:'left',
	        	formatter: function(value,row,index){
					if(row.sex){
						return "男";
					}else{
						return "女";
					}
				}
			},
	        {field:'region',title:'地区',width:100,align:'left'}
	    ]]    
	});
</script>
</html>