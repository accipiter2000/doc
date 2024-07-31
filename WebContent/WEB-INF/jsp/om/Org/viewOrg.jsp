<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="view" /><spring:message code="ORG" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var ORGN_SET_ID_ = null;
	var ORG_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.ORGN_SET_ID_ != undefined) ? ORGN_SET_ID_ = parameters.ORGN_SET_ID_ : 0;
		(parameters.ORG_ID_ != undefined) ? ORG_ID_ = parameters.ORG_ID_ : 0;
	}

	var org;//被修改对象

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载机构根节点
			url : 'loadOmOrg.do',
			async : false,//同步加载
			params : {
				'ORGN_SET_ID_' : ORGN_SET_ID_,
				'ORG_ID_' : ORG_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						org = data.org;
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

		var ORG_TYPE_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'ORG_TYPE_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var CATEGORY_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'CATEGORY_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var ORG_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'ORG_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var orgnSetStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'orgnSetStore',
			autoLoad : true,//true为自动加载
			loading : true,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'PARENT_ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'ALLOW_SYNC_', 'MEMO_', 'ORDER_', 'ORGN_SET_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectOmOrgnSet.do',
				type : 'ajax',
				async : true,//false为同步
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'orgnSetList',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, records, successful, eOpts) {
					_init();//自动加载时必须调用
				}
			}
		});

		var orgFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'orgFormPanel',
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
				name : 'ORGN_SET_NAME_',
				fieldLabel : '<spring:message code="ORGN_SET.ORGN_SET_NAME_" />',
				maxLength : 20,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'ORG_CODE_',
				fieldLabel : '<spring:message code="ORG.ORG_CODE_" />',
				maxLength : 20,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'ORG_NAME_',
				fieldLabel : '<spring:message code="ORG.ORG_NAME_" />',
				maxLength : 20,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'ORG_ABBR_NAME_',
				fieldLabel : '<spring:message code="ORG.ORG_ABBR_NAME_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'combo',
				name : 'ORG_TYPE_',
				store : ORG_TYPE_CodeStore,
				queryMode : 'local',
				valueField : 'CODE_',
				displayField : 'NAME_',
				forceSelection : true,
				fieldLabel : '<spring:message code="ORG.ORG_TYPE_" />',
				allowBlank : false
			}, {
				xtype : 'combo',
				name : 'ORG_CATEGORY_',
				store : CATEGORY_CodeStore,
				queryMode : 'local',
				valueField : 'CODE_',
				displayField : 'NAME_',
				forceSelection : true,
				fieldLabel : '<spring:message code="ORG.ORG_CATEGORY_" />',
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'MEMO_',
				fieldLabel : '<spring:message code="ORG.MEMO_" />',
				maxLength : 100,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_TAG_',
				fieldLabel : '<spring:message code="ORG.ORG_TAG_" />',
				maxLength : 40,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_EXT_ATTR_1_',
				fieldLabel : '<spring:message code="ORG.ORG_EXT_ATTR_1_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_EXT_ATTR_2_',
				fieldLabel : '<spring:message code="ORG.ORG_EXT_ATTR_2_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_EXT_ATTR_3_',
				fieldLabel : '<spring:message code="ORG.ORG_EXT_ATTR_3_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_EXT_ATTR_4_',
				fieldLabel : '<spring:message code="ORG.ORG_EXT_ATTR_4_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_EXT_ATTR_5_',
				fieldLabel : '<spring:message code="ORG.ORG_EXT_ATTR_5_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_EXT_ATTR_6_',
				fieldLabel : '<spring:message code="ORG.ORG_EXT_ATTR_6_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_EXT_ATTR_7_',
				fieldLabel : '<spring:message code="ORG.ORG_EXT_ATTR_7_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'ORG_EXT_ATTR_8_',
				fieldLabel : '<spring:message code="ORG.ORG_EXT_ATTR_8_" />',
				maxLength : 20,
				allowBlank : true
			}, {
				xtype : 'numberfield',
				name : 'ORDER_',
				fieldLabel : '<spring:message code="ORG.ORDER_" />',
				allowDecimals : false,
				allowBlank : true
			}, {
				xtype : 'combo',
				name : 'ORG_STATUS_',
				store : ORG_STATUS_CodeStore,
				queryMode : 'local',
				valueField : 'CODE_',
				displayField : 'NAME_',
				forceSelection : true,
				fieldLabel : '<spring:message code="ORG.ORG_STATUS_" />',
				allowBlank : false
			}, {
				xtype : 'datefield',
				name : 'CREATION_DATE_',
				format : 'Y-m-d H:i:s',
				submitFormat : 'Y-m-d H:i:s',
				fieldLabel : '<spring:message code="ORG.CREATION_DATE_" />',
				allowBlank : true
			}, {
				xtype : 'datefield',
				name : 'UPDATE_DATE_',
				format : 'Y-m-d H:i:s',
				submitFormat : 'Y-m-d H:i:s',
				fieldLabel : '<spring:message code="ORG.UPDATE_DATE_" />',
				allowBlank : true
			}, {
				xtype : 'textfield',
				name : 'OPERATOR_NAME_',
				fieldLabel : '<spring:message code="ORG.OPERATOR_NAME_" />',
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
								html : '<spring:message code="view" /><spring:message code="ORG" /><br /><br /><spring:message code="help.viewOrg" />'
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
				items : [ orgFormPanel ]
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
		if (org == null) {//检查被修改对象是否加载成功
			Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.loadDataFailed" />', Ext.MessageBox.ERROR);
			return;
		}

		var codeStore = Ext.data.StoreManager.lookup('codeStore');//组装子代码数据，过滤注入。
		var ORG_TYPE_CodeStore = Ext.data.StoreManager.lookup('ORG_TYPE_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^ORG_TYPE$'));
		ORG_TYPE_CodeStore.add(codeStore.getRange());
		codeStore.clearFilter();
		var CATEGORY_CodeStore = Ext.data.StoreManager.lookup('CATEGORY_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^CATEGORY$'));
		CATEGORY_CodeStore.add(codeStore.getRange());
		codeStore.clearFilter();
		var ORG_STATUS_CodeStore = Ext.data.StoreManager.lookup('ORG_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		ORG_STATUS_CodeStore.add(codeStore.getRange());
		codeStore.clearFilter();

		var form = Ext.getCmp('orgFormPanel').getForm();//设置初始值，初始验证。
		for ( var key in org) {
			(form.findField(key) != null) ? form.findField(key).setValue(org[key]) : 0;
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