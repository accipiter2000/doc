<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="banner" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	Ext.onReady(function() {
		_init();
	});

	function _init() {
		if (Ext.util.Cookies.get('EMP_NAME_') == null) {
			Ext.Ajax.request({
				url : 'getOperator.do',
				type : 'ajax',
				method : 'POST',
				async : false,
				params : {},
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
					}
				}
			});
		}

		document.getElementById('EMP_NAME_').innerHTML = Ext.util.Cookies.get('EMP_NAME_');
		document.getElementById('POSI_NAME_').innerHTML = Ext.util.Cookies.get('POSI_NAME_');
		document.getElementById('ORG_NAME_').innerHTML = Ext.util.Cookies.get('ORG_NAME_');
		document.getElementById('COM_NAME_').innerHTML = Ext.util.Cookies.get('COM_NAME_');
	}
</script>
</head>
<body>
	<table width="100%" cellspacing="0" cellpadding="0">
		<tr style="background-color: #5fa2dd;">
			<td style="text-align: left; padding-left: 14px; font: 1000 26px Microsoft YaHei; color: #fff; letter-spacing: 3px;"><spring:message code="PROJECT_NAME" /></td>
			<td width="860" height="60" line-height="60" valign="center">
				<table width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td style="color: #fff; padding-right: 10px" align="right">用户：<span id="EMP_NAME_"></span> &nbsp;&nbsp;单位：【<span id="COM_NAME_"></span>】 部门：【<span id="ORG_NAME_"></span>】岗位：【<span id="POSI_NAME_"></span>】 &nbsp;<a href="logout.do" target="_top" style="text-decoration: none; color: #ccc;">重新登录</a>&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>