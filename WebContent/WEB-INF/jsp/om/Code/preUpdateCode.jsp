<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="update" /><spring:message code="CODE" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var CODE_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.CODE_ID_ != undefined) ? CODE_ID_ = parameters.CODE_ID_ : 0;
	}

	var code;//被修改对象

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'loadOmCode.do',
			async : false,//同步加载
			params : {
				'CODE_ID_' : CODE_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						code = data.code;
					}
				}
			}
		});

		var codeFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'codeFormPanel',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 360,
				margin : '4'
			},
			items : [ {
				xtype : 'hiddenfield',//隐藏的主键，提交表单时使用
				name : 'CODE_ID_'
			}, {
				xtype : 'textfield',
				name : 'CODE_',
				fieldLabel : '<spring:message code="CODE.CODE_" />',
				maxLength : 60,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'NAME_',
				fieldLabel : '<spring:message code="CODE.NAME_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'EXT_ATTR_1_',
				fieldLabel : '<spring:message code="CODE.EXT_ATTR_1_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'EXT_ATTR_2_',
				fieldLabel : '<spring:message code="CODE.EXT_ATTR_2_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'EXT_ATTR_3_',
				fieldLabel : '<spring:message code="CODE.EXT_ATTR_3_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'EXT_ATTR_4_',
				fieldLabel : '<spring:message code="CODE.EXT_ATTR_4_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'EXT_ATTR_5_',
				fieldLabel : '<spring:message code="CODE.EXT_ATTR_5_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'EXT_ATTR_6_',
				fieldLabel : '<spring:message code="CODE.EXT_ATTR_6_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'numberfield',
				name : 'ORDER_',
				fieldLabel : '<spring:message code="CODE.ORDER_" />',
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
					handler : _updateCode
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
								html : '<spring:message code="update" /><spring:message code="CODE" /><br /><br /><spring:message code="help.updateCode" />'
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
				items : [ codeFormPanel ]
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
		if (code == null) {//检查被修改对象是否加载成功
			Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.loadDataFailed" />', Ext.MessageBox.ERROR);
			return;
		}

		var form = Ext.getCmp('codeFormPanel').getForm();//设置初始值，初始验证。
		for ( var key in code) {
			(form.findField(key) != null) ? form.findField(key).setValue(code[key]) : 0;
		}
		form.isValid();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _updateCode() {//修改
		Ext.getCmp('codeFormPanel').getForm().submit({//提交表单
			url : 'updateOmCode.do',
			submitEmptyText : false,
			waitMsg : '<spring:message code="processing" />',
			success : function(form, action) {
				var data = action.result;
				parent.returnValue = data.code;

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