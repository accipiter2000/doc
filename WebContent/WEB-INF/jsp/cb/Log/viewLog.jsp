<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="view" /><spring:message code="LOG" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var LOG_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.LOG_ID_ != undefined) ? LOG_ID_ = parameters.LOG_ID_ : 0;
	}

	var log;//被修改对象

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'loadLog.do',
			async : false,//同步加载
			params : {
				'LOG_ID_' : LOG_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						log = data.log;
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
				url : 'selectOmCode.do',
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

		var BOOLEAN_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'BOOLEAN_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var logFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'logFormPanel',
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
				name : 'LOG_ID_',
				fieldLabel : '<spring:message code="LOG.LOG_ID_" />',
				maxLength : 40,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'CATEGORY_',
				fieldLabel : '<spring:message code="LOG.CATEGORY_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textareafield',
				name : 'USER_AGENT_',
				fieldLabel : '<spring:message code="LOG.USER_AGENT_" />',
				width : '92%',
				maxLength : 200,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'IP_',
				fieldLabel : '<spring:message code="LOG.IP_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ACTION_',
				fieldLabel : '<spring:message code="LOG.ACTION_" />',
				maxLength : 200,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'URL_',
				fieldLabel : '<spring:message code="LOG.URL_" />',
				width : '92%',
				allowBlank : true
			}, {
				xtype : 'textareafield',
				name : 'PARAMETER_MAP_',
				fieldLabel : '<spring:message code="LOG.PARAMETER_MAP_" />',				
				width : '92%',
				height : 240,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'BUSINESS_KEY_',
				fieldLabel : '<spring:message code="LOG.BUSINESS_KEY_" />',
				maxLength : 40,
				allowBlank : true
			}, {
				xtype : 'combo',
				name : 'ERROR_',
				store : BOOLEAN_CodeStore,
				queryMode : 'local',
				valueField : 'CODE_',
				displayField : 'NAME_',
				forceSelection : true,
				fieldLabel : '<spring:message code="LOG.ERROR_" />',
				allowBlank : true
			}, {
				xtype : 'textareafield',
				name : 'MESSAGE_',
				fieldLabel : '<spring:message code="LOG.MESSAGE_" />',
				width : '92%',
				height : 160,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_ID_',
				fieldLabel : '<spring:message code="LOG.ORG_ID_" />',
				maxLength : 40,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_NAME_',
				fieldLabel : '<spring:message code="LOG.ORG_NAME_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'POSI_ID_',
				fieldLabel : '<spring:message code="LOG.POSI_ID_" />',
				maxLength : 40,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'POSI_NAME_',
				fieldLabel : '<spring:message code="LOG.POSI_NAME_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'EMP_ID_',
				fieldLabel : '<spring:message code="LOG.EMP_ID_" />',
				maxLength : 40,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'EMP_NAME_',
				fieldLabel : '<spring:message code="LOG.EMP_NAME_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'datefield',
				name : 'CREATION_DATE_',
				format : 'Y-m-d H:i:s',
				submitFormat : 'Y-m-d H:i:s',
				fieldLabel : '<spring:message code="LOG.CREATION_DATE_" />',
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
								html : '<spring:message code="view" /><spring:message code="LOG" /><br /><br /><spring:message code="help.viewLog" />'
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
				items : [ logFormPanel ]
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
		if (log == null) {//检查被修改对象是否加载成功
			Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.loadDataFailed" />', Ext.MessageBox.ERROR);
			return;
		}

		var codeStore = Ext.data.StoreManager.lookup('codeStore');//组装子代码数据，过滤注入。
		var BOOLEAN_CodeStore = Ext.data.StoreManager.lookup('BOOLEAN_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^BOOLEAN$'));
		BOOLEAN_CodeStore.add(codeStore.getRange());
		BOOLEAN_CodeStore.insert(0, {});
		codeStore.clearFilter();

		var form = Ext.getCmp('logFormPanel').getForm();//设置初始值，初始验证。
		for ( var key in log) {
			(form.findField(key) != null) ? form.findField(key).setValue(log[key]) : 0;
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