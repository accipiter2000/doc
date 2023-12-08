<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="insert" /><spring:message code="MIRROR_SERVER" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		var mirrorServerFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'mirrorServerFormPanel',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 360, 
				margin : '4'
			},
			items : [ {
				xtype : 'textfield',
				name : 'MIRROR_SERVER_NAME_',
				fieldLabel : '<spring:message code="MIRROR_SERVER.MIRROR_SERVER_NAME_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'DRIVER_CLASS_NAME_',
				fieldLabel : '<spring:message code="MIRROR_SERVER.DRIVER_CLASS_NAME_" />',
				maxLength : 100,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'URL_',
				fieldLabel : '<spring:message code="MIRROR_SERVER.URL_" />',
				maxLength : 200,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'USERNAME_',
				fieldLabel : '<spring:message code="MIRROR_SERVER.USERNAME_" />',
				maxLength : 40,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'PASSWORD_',
				fieldLabel : '<spring:message code="MIRROR_SERVER.PASSWORD_" />',
				maxLength : 40,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'MEMO_',
				fieldLabel : '<spring:message code="MIRROR_SERVER.MEMO_" />',
				maxLength : 100,
				allowBlank : true
			}, {
				xtype : 'datefield',
				name : 'LAST_SYNC_DATE_',
				format : 'Y-m-d H:i:s',
				submitFormat : 'Y-m-d H:i:s',
				fieldLabel : '<spring:message code="MIRROR_SERVER.LAST_SYNC_DATE_" />',
				allowBlank : true
			}, {
				xtype : 'numberfield',
				name : 'ORDER_',
				fieldLabel : '<spring:message code="MIRROR_SERVER.ORDER_" />',
				allowDecimals : false,
				allowBlank : true
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
					text : '<spring:message code="save" />',
					icon : 'image/icon/save.png',
					handler : _insertMirrorServer
				}, {
					xtype : 'button',
					text : '<spring:message code="close" />',
					icon : 'image/icon/close.png',
					handler : _close
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
								html : '<spring:message code="insert" /><spring:message code="MIRROR_SERVER" /><br /><br /><spring:message code="help.insertMirrorServer" />'
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
				items : [ mirrorServerFormPanel ]
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

		var form = Ext.getCmp('mirrorServerFormPanel').getForm();//设置初始值，初始验证。
		//form.findField('MIRROR_SERVER_TYPE_').setValue('1');
		form.isValid();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _insertMirrorServer() {//新增
		Ext.getCmp('mirrorServerFormPanel').getForm().submit({//提交表单
			url : 'insertOmMirrorServer.do',
			submitEmptyText : false,
			waitMsg : '<spring:message code="processing" />',
			success : function(form, action) {
				var data = action.result;
				parent.returnValue = data.mirrorServer;

				_close();
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