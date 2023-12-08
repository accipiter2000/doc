<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="update" /><spring:message code="CUSTOM_THEME" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var CUSTOM_THEME_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.CUSTOM_THEME_ID_ != undefined) ? CUSTOM_THEME_ID_ = parameters.CUSTOM_THEME_ID_ : 0;
	}

	var customTheme;//被修改对象

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'loadCustomThemeByOperatorId.do',
			async : false,//同步加载
			params : {},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						customTheme = data.customTheme;
					}
				}
			}
		});

		var codeStore = Ext.create('Ext.data.Store', {//代码表
			storeId : 'codeStore',
			autoLoad : true,//true为自动加载
			loading : true,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ],
			proxy : {
				url : 'selectCode.do',
				type : 'ajax',
				async : true,//false为同步
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'codeList',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, records, successful, eOpts) {
					_init();//自动加载时必须调用
				}
			}
		});

		var THEME_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'THEME_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var customThemeFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'customThemeFormPanel',
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
				name : 'CUSTOM_THEME_ID_'
			}, {
				xtype : 'combo',
				name : 'CSS_HREF_',
				store : THEME_CodeStore,
				queryMode : 'local',
				valueField : 'CODE_',
				displayField : 'NAME_',
				forceSelection : true,
				fieldLabel : '<spring:message code="CUSTOM_THEME" />',
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
					text : '<spring:message code="save" />',
					icon : 'image/icon/save.png',
					handler : _updateCustomTheme
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
								html : '<spring:message code="update" /><spring:message code="CUSTOM_THEME" /><br /><br /><spring:message code="help.updateCustomTheme" />'
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
				items : [ customThemeFormPanel ]
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

		var codeStore = Ext.data.StoreManager.lookup('codeStore');//组装子代码数据，过滤注入。
		var THEME_CodeStore = Ext.data.StoreManager.lookup('THEME_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^THEME$'));
		THEME_CodeStore.add(codeStore.getRange());
		codeStore.clearFilter();

		var form = Ext.getCmp('customThemeFormPanel').getForm();//设置初始值，初始验证。
		if (customTheme != null) {//检查被修改对象是否加载成功
			for ( var key in customTheme) {
				(form.findField(key) != null) ? form.findField(key).setValue(customTheme[key]) : 0;
			}
		}
		form.isValid();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _updateCustomTheme() {//修改
		if (customTheme == null) {
			Ext.getCmp('customThemeFormPanel').getForm().submit({//提交表单
				url : 'insertCustomTheme.do',
				submitEmptyText : false,
				waitMsg : '<spring:message code="processing" />',
				success : function(form, action) {
					var data = action.result;
					customTheme = data.customTheme;
					Ext.getCmp('customThemeFormPanel').getForm().findField('CUSTOM_THEME_ID_').setValue(customTheme['CUSTOM_THEME_ID_']);

					top.banner.location.reload();
					top.menu.location.reload();
					location.reload();

					Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
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
		} else {
			Ext.getCmp('customThemeFormPanel').getForm().submit({//提交表单
				url : 'updateCustomTheme.do',
				submitEmptyText : false,
				waitMsg : '<spring:message code="processing" />',
				success : function(form, action) {
					var data = action.result;
					customTheme = data.customTheme;

					top.banner.location.reload();
					top.menu.location.reload();
					location.reload();

					Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
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
	}
</script>
</head>
<body>
</body>
</html>