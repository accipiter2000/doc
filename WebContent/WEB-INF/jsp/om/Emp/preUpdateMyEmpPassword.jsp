<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="update" /><spring:message code="EMP.PASSWORD_" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
<script>
	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		var empFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'empFormPanel',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 360,
				margin : '4'
			},
			items : [ {
				xtype : 'hiddenfield',
				name : 'OLD_PASSWORD_',
				inputType : 'password',
				fieldLabel : '<spring:message code="EMP.OLD_PASSWORD_" />',
				maxLength : 40,
				allowBlank : false
			}, {
				xtype : 'hiddenfield',
				name : 'NEW_PASSWORD_',
				inputType : 'password',
				fieldLabel : '<spring:message code="EMP.NEW_PASSWORD_" />',
				maxLength : 40,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'PASSWORD0_',
				inputType : 'password',
				fieldLabel : '<spring:message code="EMP.OLD_PASSWORD_" />',
				style : 'clear: both',
				maxLength : 40,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'PASSWORD1_',
				inputType : 'password',
				fieldLabel : '<spring:message code="EMP.NEW_PASSWORD_" />',
				style : 'clear: both',
				maxLength : 40,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'PASSWORD2_',
				inputType : 'password',
				fieldLabel : '<spring:message code="EMP.REPEAT_PASSWORD_" />',
				style : 'clear: both',
				maxLength : 40,
				allowBlank : false
			} ],
			dockedItems : [ {//所属按钮面板
				xtype : 'panel',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					margin : '2'
				},
				items : [ {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _updateMyEmpPassword
				}, {
					xtype : 'box',
					style : 'position: absolute; top: 6px; right: 6px;',
					autoEl : {
						tag : 'img',
						src : 'image/icon/help.png'
					},
					listeners : {
						'render' : function(cmp, eOpts) {
							Ext.create('Ext.tip.ToolTip', {
								target : cmp.getEl(),
								dismissDelay : 60000,
								html : '<spring:message code="view" /><spring:message code="EMP" /><br /><br /><spring:message code="help.viewEmp" />'
							});
						}
					}
				} ],
				dock : 'top',
			} ]
		});

		Ext.create('Ext.container.Viewport', {//整体布局
			layout : {
				type : 'border',//border布局
				regionWeights : {//四个角的归属
					west : -1,
					north : 1,
					south : 1,
					east : -1
				}
			},
			padding : '1 1 1 1',
			defaults : {
				border : false,
				frame : true
			},
			items : [ {
				region : 'center',
				layout : 'fit',//充满
				items : [ empFormPanel ]
			} ]
		});

		_init();
	});

	function _init() {//初始化。页面和所有自动加载数据全部加载完成后调用。
		for (var i = 0; i < Ext.data.StoreManager.getCount(); i++) {//检查是否所有自动加载数据已经全部加载完成
			if (Ext.data.StoreManager.getAt(i).isLoading()) {
				return;
			}
		}

		var form = Ext.getCmp('empFormPanel').getForm();//设置初始值，初始验证。
		form.isValid();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _updateMyEmpPassword() {//新增
		var form = Ext.getCmp('empFormPanel').getForm();

		if (form.findField('PASSWORD1_').getSubmitValue() != form.findField('PASSWORD2_').getSubmitValue()) {
			Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.passwordNotMatch" />', Ext.MessageBox.ERROR);
			return;
		}

		var oldPassword = form.findField('PASSWORD0_').getSubmitValue();
		var newPassword = form.findField('PASSWORD1_').getSubmitValue();
		var regex = new RegExp('(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[^a-zA-Z0-9]).{8,30}');
		if (!regex.test(newPassword)) {
			Ext.MessageBox.alert('<spring:message code="error" />', '密码中必须包含大小写字母、数字、特殊字符，至少8个字符，最多30个字符，', Ext.MessageBox.ERROR);
			return;
		}

		form.findField('OLD_PASSWORD_').setValue(hex_md5(oldPassword));
		form.findField('NEW_PASSWORD_').setValue(hex_md5(newPassword));
		Ext.getCmp('empFormPanel').getForm().submit({//提交表单
			url : 'updateOmMyEmpPassword.do',
			submitEmptyText : false,
			waitMsg : '<spring:message code="processing" />',
			success : function(form, action) {
				var data = action.result;
				if (data.success) {
					Ext.MessageBox.show({
						title : '<spring:message code="info" />',
						msg : '<spring:message code="update" /><spring:message code="success" />',
						buttons : Ext.MessageBox.OK,
						icon : Ext.MessageBox.INFO,
						fn : function(btn) {
							if (parent.win) {
								parent.returnValue = data.success;

								_close();
							}
						}
					});
				}
			},
			failure : function(form, action) {
				switch (action.failureType) {
					case Ext.form.action.Action.CLIENT_INVALID:
						Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.inputRequired" />', Ext.MessageBox.ERROR);
						break;
					case Ext.form.action.Action.SERVER_INVALID:
						Ext.MessageBox.alert('<spring:message code="error" />', action.result.message, Ext.MessageBox.ERROR);
						break;
					case Ext.form.action.Action.CONNECT_FAILURE:
						Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
				}
			}
		});

	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>