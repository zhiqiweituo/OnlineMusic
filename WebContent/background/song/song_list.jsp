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
<title>歌曲列表</title>
<script type="text/javascript">
	var url;
	
	function searchSong(){
		$('#dg').datagrid('load',{
			s_songName:$("#s_songName").textbox('getValue')
		});
	}
	
	//选择歌手（歌手ID使用DOM操作至文本框）
	function selectSinger(){
		//弹出一个对话框，在对话框里可以从数据表格中查询歌手
		//...
	}
	
	function deleteSong(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].SongId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath }/back/Song_delete.action",{ids:ids},function(result){
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
	
	
	function openSongAddDialog(){
		
		$("#dlg").dialog("open").dialog("setTitle","添加歌曲信息");
		$('#dlg').window('center'); //居中显示
		url="${pageContext.request.contextPath }/back/song_save.action";
	}
	
	function openSongModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑歌曲信息");
		//$("#fm").form("load",row);
		$("#SongId").val(row.SongId);
		$("#SongName").textbox("setValue",row.SongName);
		if(row.sex){
			$("#sex").combobox('setValue', '男');
		}else{
			$("#sex").combobox('setValue', '女');
		}
		$("#region").combobox('setValue', row.region);
		url="${pageContext.request.contextPath }/back/song_save.action";
	}
	
	function closeSongDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function resetValue(){
		$("#SongId").val("");
		$("#SongName").textbox("setValue","");
		$("#sex").combobox('select', '请选择...');
		$("#region").combobox('select', '请选择...');
	}
	
	function saveSong(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($('#fb').textbox("getValue")==""){
					$.messager.alert("系统提示","请选择本地音乐文件");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","音乐上传成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","音乐上传失败");
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
			<a href="javascript:openSongAddDialog()" class="easyui-linkbutton" iconCls="icon-image-image-add" plain="true">添加歌曲</a>
			<a href="javascript:openSongModifyDialog()" class="easyui-linkbutton" iconCls="icon-image-image-edit" plain="true">修改歌曲</a>
			<a href="javascript:deleteSong()" class="easyui-linkbutton" iconCls="icon-image-image-delete" plain="true">删除歌曲</a>
		</div>
		<div>
			<label style="margin-left: 5px;">歌曲名称：</label>
			<input class="easyui-textbox" id="s_songName" name="s_songName"/>
			<a href="javascript:searchSong()" class="easyui-linkbutton" iconCls="icon-zoom-zoom" plain="true">搜索</a>
		</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 400px;height: 200px; padding: 10px;"
	closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>选择歌手：<input type="hidden" id="SongId" name="Song.SongId"/></td>
				<td>
					<input class="easyui-textbox easyui-validatebox" id="singerId" name="singerId" editable="false" required="true"/>
					<a href="javascript:selectSinger()" class="easyui-linkbutton" iconCls="icon-zoom-zoom">选择歌手</a>
				</td>
			</tr>
			<tr>
				<td>选择音乐：</td>
				<td>
					<input id="fb" type="text" name="musicFile" style="width:240px">
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:saveSong()" class="easyui-linkbutton" iconCls="icon-page-page-save">上传音乐</a>
	<a href="javascript:closeSongDialog()" class="easyui-linkbutton" iconCls="icon-folder-folder-wrench">关闭窗口</a>
</div>

</body>
<script type="text/javascript">
	$('#dg').datagrid({    
	    url:'${pageContext.request.contextPath }/back/song_list.action',    
	    columns:[[
			{field:'cb',checkbox:true},
			{field:'songId',title:'ID',hidden:true},
	        {field:'songName',title:'歌曲名称',width:100},
	        {field:'singer.singerName',title:'歌手姓名',width:100,
				formatter: function(value,row,index){
					return row.singer.singerName;
				}
			},
	        {field:'songLanguage',title:'语种',width:100},
	        {field:'songStyle',title:'风格',width:100}
	    ]]    
	});
	
	//文件上传
	$('#fb').filebox({    
	    buttonText: '本地文件', 
	    buttonAlign: 'left' 
	});
</script>
</html>