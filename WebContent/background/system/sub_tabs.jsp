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
<title>Insert title here</title>
</head>
<body>

<div class="easyui-tabs" style="width:100%;height:420px;padding:0px;">
	<div title="数据字典类别">
		<iframe scrolling="yes" frameborder="0" src="${pageContext.request.contextPath }/background/system/data_dic_type.jsp" style="width:100%;height:100%;"></iframe>
	</div>
	<div title="数据字典">
		<iframe scrolling="yes" frameborder="0" src="${pageContext.request.contextPath }/background/system/data_dic.jsp" style="width:100%;height:100%;"></iframe>
	</div>
</div>

</body>
</html>