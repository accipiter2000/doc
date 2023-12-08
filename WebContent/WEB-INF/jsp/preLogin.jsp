<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="height: 100%;">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="login" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<link rel="stylesheet" type="text/css" href="css/antd/global.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdLogin.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdSpin.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdTabs.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdForm.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdInput.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdGrid.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdButton.css" />
<link rel="stylesheet" type="text/css" href="css/antd/antdLayout.css" />

<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
<style type="text/css">
.loginForm {
	height: 100%;
	background: url(https://gw.alipayobjects.com/zos/rmsportal/TVYTbAXWheQpRcWDaDMu.svg) no-repeat;
}

.ant-pro-form-login-container {
	margin-top: 40px;
}
</style>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	var EMP_CODE_ = '';
	var password = '';

	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.EMP_CODE_ == undefined) ? EMP_CODE_ = '' : EMP_CODE_ = parameters.EMP_CODE_;
		(parameters.password == undefined) ? password = '' : password = parameters.password;
	}

	if (EMP_CODE_ != '' && password != '') {
		Ext.Ajax.request({
			url : 'login.do',
			type : 'ajax',
			method : 'POST',
			async : false,
			params : {
				'EMP_CODE_' : EMP_CODE_,
				'PASSWORD_' : password
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
	}

	function _login() {
		var EMP_CODE_ = document.getElementById('EMP_CODE_').value.replace(/\s+/g, "");
		var PASSWORD_ = document.getElementById('PASSWORD_').value.replace(/\s+/g, "");

		if (EMP_CODE_ == '') {
			Ext.MessageBox.show({
				title : '<fmt:message key="warning" />',
				msg : '请输入用户名和密码',
				buttons : Ext.MessageBox.OK,
				icon : Ext.MessageBox.WARNING
			});
			return;
		}

		Ext.Ajax.request({
			url : 'login.do',
			type : 'ajax',
			method : 'POST',
			params : {
				'EMP_CODE_' : EMP_CODE_,
				'PASSWORD_' : hex_md5(PASSWORD_)
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

					if (operator.posiEmpList[0].PASSWORD_RESET_REQ_ == '1') {
						returnValue = null;
						win = Ext.create('Ext.window.Window', {
							title : '<spring:message code="update" /><spring:message code="EMP.PASSWORD_" />',
							modal : true,
							autoShow : true,
							maximized : false,
							maximizable : true,
							width : 800,
							height : '80%',
							html : '<iframe src="preUpdateOmMyEmpPassword.do" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
							listeners : {
								'close' : function(panel, eOpts) {
									if (returnValue != null) {
										var success = returnValue;
										if (success) {
											Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
											window.location.href = 'index.do';
										}
									}
								}
							}
						});
					} else {
						window.location.href = 'index.do';
					}
				} else {
					Ext.MessageBox.show({
						title : '<fmt:message key="warning" />',
						msg : data.message,
						buttons : Ext.MessageBox.OK,
						icon : Ext.MessageBox.WARNING
					});
				}
			},
			failure : function(response) {
				Ext.MessageBox.show({
					title : '<fmt:message key="error" />',
					msg : response.responseText,
					buttons : Ext.MessageBox.OK,
					icon : Ext.MessageBox.ERROR
				});
			}
		});
	}

	function _onKeypress(e) {
		var keynum;
		if (window.event) // IE
		{
			keynum = e.keyCode
		} else if (e.which) // Netscape/Firefox/Opera
		{
			keynum = e.which
		}

		if (keynum == 13) {
			_login();
		}
	}

	function _init() {
		$('#wordDemo').attr('href', 'office://word$open$' + document.getElementById('base').href + '/resource/demo.docx');
	}
</script>
</head>
<body style="height: 100%;" onload="_init()">
	<div class="ant-pro-form-login-container">
		<div class="ant-pro-form-login-top">
			<div class="ant-pro-form-login-header">
				<span class="ant-pro-form-login-title">公文管理系统</span>
			</div>
		</div>
		<div class="ant-pro-form-login-main" style="width: 328px;">
			<form autocomplete="off" data-inspector-line="95" data-inspector-column="8" data-inspector-relative-path="src\pages\user\Login\index.tsx" class="ant-form ant-form-vertical">
				<input type="text" style="display: none;"><div class="ant-tabs ant-tabs-top" data-inspector-line="118" data-inspector-column="10" data-inspector-relative-path="src\pages\user\Login\index.tsx">
						<div role="tablist" class="ant-tabs-nav">
							<div class="ant-tabs-nav-wrap">
								<div class="ant-tabs-nav-list" style="transform: translate(0px, 0px);">
									<div class="ant-tabs-tab ant-tabs-tab-active">
										<div role="tab" aria-selected="true" class="ant-tabs-tab-btn" tabindex="0" id="rc-tabs-0-tab-account" aria-controls="rc-tabs-0-panel-account">系统登录</div>
									</div>
									<div class="ant-tabs-ink-bar ant-tabs-ink-bar-animated" style="left: 0px; width: 72px;"></div>
								</div>
							</div>
							<div class="ant-tabs-nav-operations ant-tabs-nav-operations-hidden">
								<button type="button" class="ant-tabs-nav-more" tabindex="-1" aria-hidden="true" aria-haspopup="listbox" aria-controls="rc-tabs-0-more-popup" id="rc-tabs-0-more" aria-expanded="false" style="visibility: hidden; order: 1;">
									<span role="img" aria-label="ellipsis" class="anticon anticon-ellipsis"><svg viewBox="64 64 896 896" focusable="false" data-icon="ellipsis" width="1em" height="1em" fill="currentColor" aria-hidden="true"> <path d="M176 511a56 56 0 10112 0 56 56 0 10-112 0zm280 0a56 56 0 10112 0 56 56 0 10-112 0zm280 0a56 56 0 10112 0 56 56 0 10-112 0z"></path></svg></span>
								</button>
							</div>
						</div>
						<div class="ant-tabs-content-holder">
							<div class="ant-tabs-content ant-tabs-content-top">
								<div role="tabpanel" tabindex="0" aria-hidden="false" class="ant-tabs-tabpane ant-tabs-tabpane-active" id="rc-tabs-0-panel-account" aria-labelledby="rc-tabs-0-tab-account"></div>
							</div>
						</div>
					</div>
					<div class="ant-row ant-form-item">
						<div class="ant-col ant-form-item-control">
							<div class="ant-form-item-control-input">
								<div class="ant-form-item-control-input-content">
									<span class="ant-input-affix-wrapper ant-input-affix-wrapper-lg"><span class="ant-input-prefix"><span role="img" aria-label="user" data-inspector-line="136" data-inspector-column="26" data-inspector-relative-path="src\pages\user\Login\index.tsx" class="anticon anticon-user"><svg viewBox="64 64 896 896" focusable="false" data-icon="user" width="1em" height="1em" fill="currentColor" aria-hidden="true"> <path
													d="M858.5 763.6a374 374 0 00-80.6-119.5 375.63 375.63 0 00-119.5-80.6c-.4-.2-.8-.3-1.2-.5C719.5 518 760 444.7 760 362c0-137-111-248-248-248S264 225 264 362c0 82.7 40.5 156 102.8 201.1-.4.2-.8.3-1.2.5-44.8 18.9-85 46-119.5 80.6a375.63 375.63 0 00-80.6 119.5A371.7 371.7 0 00136 901.8a8 8 0 008 8.2h60c4.4 0 7.9-3.5 8-7.8 2-77.2 33-149.5 87.8-204.3 56.7-56.7 132-87.9 212.2-87.9s155.5 31.2 212.2 87.9C779 752.7 810 825 812 902.2c.1 4.4 3.6 7.8 8 7.8h60a8 8 0 008-8.2c-1-47.8-10.9-94.3-29.5-138.2zM512 534c-45.9 0-89.1-17.9-121.6-50.4S340 407.9 340 362c0-45.9 17.9-89.1 50.4-121.6S466.1 190 512 190s89.1 17.9 121.6 50.4S684 316.1 684 362c0 45.9-17.9 89.1-50.4 121.6S557.9 534 512 534z"></path></svg></span></span><input placeholder="用户名:" id="EMP_CODE_" class="ant-input ant-input-lg" type="text" value=""><span
											class="ant-input-suffix"><span class="ant-input-clear-icon ant-input-clear-icon-hidden" role="button" tabindex="-1"><span role="img" aria-label="close-circle" class="anticon anticon-close-circle"><svg viewBox="64 64 896 896" focusable="false" data-icon="close-circle" width="1em" height="1em" fill="currentColor" aria-hidden="true"> <path d="M512 64C264.6 64 64 264.6 64 512s200.6 448 448 448 448-200.6 448-448S759.4 64 512 64zm165.4 618.2l-66-.3L512 563.4l-99.3 118.4-66.1.3c-4.4 0-8-3.5-8-8 0-1.9.7-3.7 1.9-5.2l130.1-155L340.5 359a8.32 8.32 0 01-1.9-5.2c0-4.4 3.6-8 8-8l66.1.3L512 464.6l99.3-118.4 66-.3c4.4 0 8 3.5 8 8 0 1.9-.7 3.7-1.9 5.2L553.5 514l130 155c1.2 1.5 1.9 3.3 1.9 5.2 0 4.4-3.6 8-8 8z"></path></svg></span></span></span></span>
								</div>
							</div>
						</div>
					</div>
					<div class="ant-row ant-form-item">
						<div class="ant-col ant-form-item-control">
							<div class="ant-form-item-control-input">
								<div class="ant-form-item-control-input-content">
									<span class="ant-input-affix-wrapper ant-input-password ant-input-password-large ant-input-affix-wrapper-lg"><span class="ant-input-prefix"><span role="img" aria-label="lock" data-inspector-line="150" data-inspector-column="26" data-inspector-relative-path="src\pages\user\Login\index.tsx" class="anticon anticon-lock"><svg viewBox="64 64 896 896" focusable="false" data-icon="lock" width="1em" height="1em" fill="currentColor" aria-hidden="true"> <path
													d="M832 464h-68V240c0-70.7-57.3-128-128-128H388c-70.7 0-128 57.3-128 128v224h-68c-17.7 0-32 14.3-32 32v384c0 17.7 14.3 32 32 32h640c17.7 0 32-14.3 32-32V496c0-17.7-14.3-32-32-32zM332 240c0-30.9 25.1-56 56-56h248c30.9 0 56 25.1 56 56v224H332V240zm460 600H232V536h560v304zM484 701v53c0 4.4 3.6 8 8 8h40c4.4 0 8-3.6 8-8v-53a48.01 48.01 0 10-56 0z"></path></svg></span></span><input placeholder="密码:" id="PASSWORD_" onkeypress="_onKeypress(event)" action="click" type="password" class="ant-input ant-input-lg"><span class="ant-input-suffix"><span role="img" aria-label="eye-invisible" tabindex="-1" class="anticon anticon-eye-invisible ant-input-password-icon"><svg viewBox="64 64 896 896" focusable="false" data-icon="eye-invisible" width="1em" height="1em" fill="currentColor"
														aria-hidden="true"> <path d="M942.2 486.2Q889.47 375.11 816.7 305l-50.88 50.88C807.31 395.53 843.45 447.4 874.7 512 791.5 684.2 673.4 766 512 766q-72.67 0-133.87-22.38L323 798.75Q408 838 512 838q288.3 0 430.2-300.3a60.29 60.29 0 000-51.5zm-63.57-320.64L836 122.88a8 8 0 00-11.32 0L715.31 232.2Q624.86 186 512 186q-288.3 0-430.2 300.3a60.3 60.3 0 000 51.5q56.69 119.4 136.5 191.41L112.48 835a8 8 0 000 11.31L155.17 889a8 8 0 0011.31 0l712.15-712.12a8 8 0 000-11.32zM149.3 512C232.6 339.8 350.7 258 512 258c54.54 0 104.13 9.36 149.12 28.39l-70.3 70.3a176 176 0 00-238.13 238.13l-83.42 83.42C223.1 637.49 183.3 582.28 149.3 512zm246.7 0a112.11 112.11 0 01146.2-106.69L401.31 546.2A112 112 0 01396 512z"></path> <path
														d="M508 624c-3.46 0-6.87-.16-10.25-.47l-52.82 52.82a176.09 176.09 0 00227.42-227.42l-52.82 52.82c.31 3.38.47 6.79.47 10.25a111.94 111.94 0 01-112 112z"></path></svg></span></span></span>
								</div>
							</div>
						</div>
					</div>
					<div style="float: right; padding-right: 10px;">
						<a href="resource/officePlugin.zip"> <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor"> <path
								d="M928 161H699.2c-49.1 0-97.1 14.1-138.4 40.7L512 233l-48.8-31.3A255.2 255.2 0 00324.8 161H96c-17.7 0-32 14.3-32 32v568c0 17.7 14.3 32 32 32h228.8c49.1 0 97.1 14.1 138.4 40.7l44.4 28.6c1.3.8 2.8 1.3 4.3 1.3s3-.4 4.3-1.3l44.4-28.6C602 807.1 650.1 793 699.2 793H928c17.7 0 32-14.3 32-32V193c0-17.7-14.3-32-32-32zM324.8 721H136V233h188.8c35.4 0 69.8 10.1 99.5 29.2l48.8 31.3 6.9 4.5v462c-47.6-25.6-100.8-39-155.2-39zm563.2 0H699.2c-54.4 0-107.6 13.4-155.2 39V298l6.9-4.5 48.8-31.3c29.7-19.1 64.1-29.2 99.5-29.2H888v488zM396.9 361H211.1c-3.9 0-7.1 3.4-7.1 7.5v45c0 4.1 3.2 7.5 7.1 7.5h185.7c3.9 0 7.1-3.4 7.1-7.5v-45c.1-4.1-3.1-7.5-7-7.5zm223.1 7.5v45c0 4.1 3.2 7.5 7.1 7.5h185.7c3.9 0 7.1-3.4 7.1-7.5v-45c0-4.1-3.2-7.5-7.1-7.5H627.1c-3.9 0-7.1 3.4-7.1 7.5zM396.9 501H211.1c-3.9 0-7.1 3.4-7.1 7.5v45c0 4.1 3.2 7.5 7.1 7.5h185.7c3.9 0 7.1-3.4 7.1-7.5v-45c.1-4.1-3.1-7.5-7-7.5zm416 0H627.1c-3.9 0-7.1 3.4-7.1 7.5v45c0 4.1 3.2 7.5 7.1 7.5h185.7c3.9 0 7.1-3.4 7.1-7.5v-45c.1-4.1-3.1-7.5-7-7.5z"></path></svg>下载客户端
						</a><a id="wordDemo" href="office://word$open$http://10.18.2.242:8080/DOC/resource/demo.docx"> <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor"> <path d="M880 112H144c-17.7 0-32 14.3-32 32v736c0 17.7 14.3 32 32 32h736c17.7 0 32-14.3 32-32V144c0-17.7-14.3-32-32-32zm-40 464H528V448h312v128zm0 264H184V184h656v200H496c-17.7 0-32 14.3-32 32v192c0 17.7 14.3 32 32 32h344v200zM580 512a40 40 0 1080 0 40 40 0 10-80 0z"></path></svg>公文查看测试
						</a>
					</div>
					<button type="button" class="ant-btn ant-btn-primary ant-btn-lg" onclick="_login()" style="width: 100%; background-color: #0c8a72; border: 1px solid #0c8a72">
						<span>登 录</span>
					</button>
			</form>
		</div>
		<footer class="ant-layout-footer" style="padding: 0px;"> </footer>
	</div>
</body>
</html>

