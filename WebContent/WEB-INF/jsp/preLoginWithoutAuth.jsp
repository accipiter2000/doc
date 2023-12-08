<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="login" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var EMP_CODE_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.EMP_CODE_ != undefined) ? EMP_CODE_ = parameters.EMP_CODE_ : 0;
	}

	Ext.onReady(function() {
		Ext.Ajax.request({
			url : 'loginWithoutAuth.do',
			type : 'ajax',
			method : 'POST',
			async : false,
			params : {
				'EMP_CODE_' : EMP_CODE_
			},
			success : function(response) {
				var data = Ext.decode(response.responseText);
				if (data.success) {
					var operator = data.operator;
					Ext.util.Cookies.set('EMP_ID_', operator.EMP_ID_);
					Ext.util.Cookies.set('EMP_CODE_', operator.EMP_CODE_);
					Ext.util.Cookies.set('EMP_NAME_', operator.EMP_NAME_);
					Ext.util.Cookies.set('ORG_ID_', operator.ORG_ID_);
					Ext.util.Cookies.set('ORG_CODE_', operator.ORG_CODE_);
					Ext.util.Cookies.set('ORG_NAME_', operator.ORG_NAME_);
					Ext.util.Cookies.set('COM_ID_', operator.COM_ID_);
					Ext.util.Cookies.set('COM_CODE_', operator.COM_CODE_);
					Ext.util.Cookies.set('COM_NAME_', operator.COM_NAME_);
					Ext.util.Cookies.set('POSI_ID_', operator.POSI_ID_);
					Ext.util.Cookies.set('POSI_CODE_', operator.POSI_CODE_);
					Ext.util.Cookies.set('POSI_NAME_', operator.POSI_NAME_);
					Ext.util.Cookies.set('POSI_EMP_ID_', operator.POSI_EMP_ID_);

					window.location.href = 'index.do';
				}
			}
		});
	});
</script>
</head>
<body>
</body>
</html>

