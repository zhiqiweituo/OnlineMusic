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
	function toAction(text,url,iconCls){
		window.location.href=url;
	}
	function logout() {
		window.location.href="${pageContext.request.contextPath }/back/admin_logout.action";
	}
</script>
</head>
<body>
<%
Object currentAdmin=session.getAttribute("currentAdmin");
if(currentAdmin==null){
	response.sendRedirect("admin_login.jsp");
}
%>
<div class="easyui-panel" title="在线音乐管理系统面板" style="width:100%;height:550px;padding:10px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'west',split:true" style="width:15%;padding:10px">
			<div class="easyui-accordion" data-options="fit:true,border:true">
				<div title="用户信息管理"  data-options="iconCls:'icon-group-group'" style="padding:5px">
					<a href="javascript:addTab('用户信息','${pageContext.request.contextPath }/background/user/user_list.jsp')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user-user-comment'" style="width: 150px;">用户信息</a>
					<a href="javascript:addTab('用户类别','default.jsp')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user-user'" style="width: 150px;">用户类别</a>
				</div>
				<div title="音乐信息管理"  data-options="iconCls:'icon-table-table-save'" style="padding:5px">
					<a href="javascript:addTab('歌手信息','${pageContext.request.contextPath }/background/singer/singer_list.jsp')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-vcard-vcard-edit'" style="width: 150px;">歌手信息</a>
					<a href="javascript:addTab('歌曲信息','${pageContext.request.contextPath }/background/song/song_list.jsp')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-image-image-link'" style="width: 150px;">歌曲信息</a>
				</div>
				<div title="系统管理"  data-options="iconCls:'icon-cog-cog'" style="padding:5px">
					<a href="javascript:addTab('数据字典','${pageContext.request.contextPath }/background/system/sub_tabs.jsp')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-folder-folder-database'" style="width: 150px;">数据字典</a>
					<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-lock-lock-go'" style="width: 150px;">修改密码</a>
					<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-cog-cog-go'" style="width: 150px;">安全退出</a>
				</div>
			</div>
		</div>
		<div data-options="region:'center'" style="padding:10px">
			<div id="tab" class="easyui-tabs" style="width:100%;height:470px;">
				<div title="主页" style="padding: 20px;">
					<p>欢迎管理员：<span style="color:red;">${currentAdmin.realName }</span></p>
					<p style="font-size:14px">
						此项目主要练习Struts2+Hibernate4，以及图片文件的上传，之后布局一个通用性强的easyUI模板。
					</p>
					<ul>
						<li>Struts2请求处理</li>
						<li>Hibernate4的操作</li>
						<li>Spring4的操作</li>
						<li>图片文件的上传</li>
						<li>easyUI界面布局</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function addTab(title, url){
		if ($('#tab').tabs('exists', title)){
			$('#tab').tabs('select', title);
		} else {
			var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
			$('#tab').tabs('add',{
				title:title,
				content:content,
				closable:true
			});
		}
	}
</script>
</body>
</html>