<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="height: 100%;">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="login" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<link rel="stylesheet" type="text/css" href="css/antd/global.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdLogin.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdSpin.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdTabs.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdForm.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdInput.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdButton.css" />

<link rel="stylesheet" type="text/css" href="css/antd/antdLayout.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdGrid.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdCard.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdPageHeaderContent.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdAvatar.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdRadio.css" />

<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
<script type="text/javascript" src="js/echarts.min.js"></script>
<style type="text/css">
.div {
	background: #FFFFFF;
}
</style>
<script>
	function _init() {
		document.getElementById('homeTitie').innerHTML = "早安，" + Ext.util.Cookies.get('EMP_NAME_') + "，祝您开心每一天！"
		document.getElementById('posiTitie').innerHTML = Ext.util.Cookies.get('ORG_NAME_') + "/" + Ext.util.Cookies.get('POSI_NAME_');
	}
</script>
</head>
<body style="height: 100%;" onload="_init()">
	<main class="ant-layout-content  ant-pro-basicLayout-has-header">
	<div class="ant-pro-page-container ant-pro-page-container-ghost">
		<div class="ant-pro-grid-content">
			<div class="ant-pro-grid-content-children">
				<div>
					<div class="ant-row">
						<div class="div ant-col ant-col-xs-24 ant-col-sm-24 ant-col-md-24 ant-col-lg-24 ant-col-xl-24" style="padding-left: 12px; padding-right: 12px;">
							<div class="ant-card" style="margin-bottom: 10px;">
								<div class="ant-card-body">
									<div class="pageHeaderContent___11cRs">
										<div class="avatar___1IChB">
											<span class="ant-avatar ant-avatar-lg ant-avatar-circle"> <span class="ant-avatar-string" style="transform: scale(1) translateX(-50%);"> <img style="width: 82px; height: 85px; margin-top: -7px;" src="image/icon/profile.png"></span>
											</span>
										</div>
										<div class="content___2B12c">
											<div class="contentTitle___bf8Bc" id="homeTitie"></div>
											<div id="posiTitie"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</main>
</body>
</html>
