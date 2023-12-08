<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="view" /><spring:message code="MIRROR_SERVER" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var MIRROR_SERVER_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.MIRROR_SERVER_ID_ != undefined) ? MIRROR_SERVER_ID_ = parameters.MIRROR_SERVER_ID_ : 0;
	}

	var mirrorServer;//被修改对象

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'loadOmMirrorServer.do',
			async : false,//同步加载
			params : {
				'MIRROR_SERVER_ID_' : MIRROR_SERVER_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						mirrorServer = data.mirrorServer;
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

		var MIRROR_SERVER_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'MIRROR_SERVER_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var mirrorServerFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'mirrorServerFormPanel',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 360, 
				margin : '4',
				readOnly : true
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
			}, {
				xtype : 'combo',
				name : 'MIRROR_SERVER_STATUS_',
				store : MIRROR_SERVER_STATUS_CodeStore,
				queryMode : 'local',
				valueField : 'CODE_',
				displayField : 'NAME_',
				forceSelection : true,
				fieldLabel : '<spring:message code="MIRROR_SERVER.MIRROR_SERVER_STATUS_" />',
				allowBlank : false
			}, {
				xtype : 'datefield',
				name : 'CREATION_DATE_',
				format : 'Y-m-d H:i:s',
				submitFormat : 'Y-m-d H:i:s',
				fieldLabel : '<spring:message code="MIRROR_SERVER.CREATION_DATE_" />',
				allowBlank : true
			}, {
				xtype : 'datefield',
				name : 'UPDATE_DATE_',
				format : 'Y-m-d H:i:s',
				submitFormat : 'Y-m-d H:i:s',
				fieldLabel : '<spring:message code="MIRROR_SERVER.UPDATE_DATE_" />',
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'OPERATOR_NAME_',
				fieldLabel : '<spring:message code="MIRROR_SERVER.OPERATOR_NAME_" />',
				maxLength : 20,
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
								html : '<spring:message code="view" /><spring:message code="MIRROR_SERVER" /><br /><br /><spring:message code="help.viewMirrorServer" />'
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
		if (mirrorServer == null) {//检查被修改对象是否加载成功
			Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.loadDataFailed" />', Ext.MessageBox.ERROR);
			return;
		}

		var codeStore = Ext.data.StoreManager.lookup('codeStore');//组装子代码数据，过滤注入。
		var MIRROR_SERVER_STATUS_CodeStore = Ext.data.StoreManager.lookup('MIRROR_SERVER_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		MIRROR_SERVER_STATUS_CodeStore.add(codeStore.getRange());
		MIRROR_SERVER_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		var form = Ext.getCmp('mirrorServerFormPanel').getForm();//设置初始值，初始验证。
		for ( var key in mirrorServer) {
			(form.findField(key) != null) ? form.findField(key).setValue(mirrorServer[key]) : 0;
		}

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>