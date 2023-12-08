<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="DASHBOARD_MODULE" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

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

		var DASHBOARD_MODULE_TYPE_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'DASHBOARD_MODULE_TYPE_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var DASHBOARD_MODULE_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'DASHBOARD_MODULE_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var dashboardModuleStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'dashboardModuleStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'DASHBOARD_MODULE_ID_', 'DASHBOARD_MODULE_NAME_', 'DASHBOARD_MODULE_TYPE_', 'DEFAULT_URL_', 'DEFAULT_WIDTH_', 'DEFAULT_HEIGHT_', 'DASHBOARD_MODULE_TAG_', 'ORDER_', 'DASHBOARD_MODULE_STATUS_' ],
			proxy : {
				url : 'selectDashboardModule.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'dashboardModuleList',
					totalProperty : 'total'
				}
			}
		});

		var dashboardModulePanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'dashboardModulePanel',
			store : dashboardModuleStore,
			title : '<spring:message code="DASHBOARD_MODULE" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_NAME_" />',
				dataIndex : 'DASHBOARD_MODULE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_TYPE_" />',
				dataIndex : 'DASHBOARD_MODULE_TYPE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 128,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? DASHBOARD_MODULE_TYPE_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="DASHBOARD_MODULE.DEFAULT_URL_" />',
				dataIndex : 'DEFAULT_URL_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DASHBOARD_MODULE.DEFAULT_WIDTH_" />',
				dataIndex : 'DEFAULT_WIDTH_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DASHBOARD_MODULE.DEFAULT_HEIGHT_" />',
				dataIndex : 'DEFAULT_HEIGHT_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_TAG_" />',
				dataIndex : 'DASHBOARD_MODULE_TAG_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DASHBOARD_MODULE.ORDER_" />',
				dataIndex : 'ORDER_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 48
			}, {
				text : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_STATUS_" />',
				dataIndex : 'DASHBOARD_MODULE_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 128,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? DASHBOARD_MODULE_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			} ],
			dockedItems : [ {
				xtype : 'panel',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					margin : '2'
				},
				items : [ {
					xtype : 'button',
					text : '<spring:message code="select" />',
					icon : 'image/icon/select.png',
					handler : _selectDashboardModule
				}, {
					xtype : 'button',
					text : '<spring:message code="insert" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertDashboardModule
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateDashboardModule
				}, {
					xtype : 'button',
					text : '<spring:message code="disable" />',
					icon : 'image/icon/disable.png',
					handler : _disableDashboardModule
				}, {
					xtype : 'button',
					text : '<spring:message code="enable" />',
					icon : 'image/icon/enable.png',
					handler : _enableDashboardModule
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteDashboardModule
				}, {
					xtype : 'button',
					text : '<spring:message code="view" />',
					icon : 'image/icon/view.png',
					handler : _viewDashboardModule
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
								html : '<spring:message code="manage" /><spring:message code="DASHBOARD_MODULE" /><br /><br /><spring:message code="help.manageDashboardModule" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'dashboardModuleFormPanel',
				xtype : 'form',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 360,
					margin : '4'
				},
				items : [ {
					xtype : 'textfield',
					name : 'DASHBOARD_MODULE_NAME_',
					fieldLabel : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'combo',
					name : 'DASHBOARD_MODULE_TYPE_LIST',
					store : DASHBOARD_MODULE_TYPE_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_TYPE_" />'
				}, {
					xtype : 'textfield',
					name : 'DASHBOARD_MODULE_TAG_',
					fieldLabel : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_TAG_" />',
					maxLength : 20
				}, {
					xtype : 'combo',
					name : 'DASHBOARD_MODULE_STATUS_LIST',
					store : DASHBOARD_MODULE_STATUS_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_STATUS_" />'
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : dashboardModuleStore,
				displayInfo : true,
				dock : 'bottom'
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;">没有数据</div>',
				enableTextSelection : true
			},
			listeners : {
				'render' : function(gridPanel, eOpts) {
					var view = gridPanel.getView();
					var toolTip = Ext.create('Ext.tip.ToolTip', {
						target : gridPanel.getEl(),
						delegate : view.getCellSelector(),//单元格触发
						listeners : {
							beforeshow : function(sender, eOpts) { // 动态切换提示内容
								var dataIndex = view.getHeaderByCell(sender.triggerElement).dataIndex;
								if (dataIndex == 'MEMO_') {
									toolTip.update(view.getRecord(sender.triggerElement).get(dataIndex));
								} else {
									return false;
								}
							}
						}
					});
				}
			}
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
				items : [ dashboardModulePanel ]
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
		var DASHBOARD_MODULE_TYPE_CodeStore = Ext.data.StoreManager.lookup('DASHBOARD_MODULE_TYPE_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^DASHBOARD_MODULE_TYPE$'));
		DASHBOARD_MODULE_TYPE_CodeStore.add(codeStore.getRange());
		DASHBOARD_MODULE_TYPE_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var DASHBOARD_MODULE_STATUS_CodeStore = Ext.data.StoreManager.lookup('DASHBOARD_MODULE_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		DASHBOARD_MODULE_STATUS_CodeStore.add(codeStore.getRange());
		DASHBOARD_MODULE_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		_selectDashboardModule();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectDashboardModule() {//查询主表数据
		var dashboardModuleStore = Ext.data.StoreManager.lookup('dashboardModuleStore');
		var item;
		for (var i = 0; i < Ext.getCmp('dashboardModuleFormPanel').items.length; i++) {
			item = Ext.getCmp('dashboardModuleFormPanel').items.get(i);
			dashboardModuleStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		dashboardModuleStore.currentPage = 1;
		dashboardModuleStore.load();
	}

	function _preInsertDashboardModule() {//新增
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="DASHBOARD_MODULE" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertDashboardModule.do" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var dashboardModule = returnValue;
						Ext.data.StoreManager.lookup('dashboardModuleStore').add(dashboardModule);//前台新增数据

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdateDashboardModule() {//修改
		var records = Ext.getCmp('dashboardModulePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DASHBOARD_MODULE" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="DASHBOARD_MODULE" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preUpdateDashboardModule.do?DASHBOARD_MODULE_ID_=' + records[0].get('DASHBOARD_MODULE_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var dashboardModule = returnValue;
						for ( var key in dashboardModule) {
							records[0].set(key, dashboardModule[key]);
						}

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _disableDashboardModule() {//废弃
		var records = Ext.getCmp('dashboardModulePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DASHBOARD_MODULE" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="disable" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'disableDashboardModule.do',
						async : false,
						params : {
							'DASHBOARD_MODULE_ID_' : records[0].get('DASHBOARD_MODULE_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var dashboardModule = data.dashboardModule;
									for ( var key in dashboardModule) {
										records[0].set(key, dashboardModule[key]);
									}

									Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
								} else {
									Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
								}
							} else {
								Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
							}
						}
					});
				}
			}
		});
	}

	function _enableDashboardModule() {//恢复
		var records = Ext.getCmp('dashboardModulePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DASHBOARD_MODULE" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="enable" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'enableDashboardModule.do',
						async : false,
						params : {
							'DASHBOARD_MODULE_ID_' : records[0].get('DASHBOARD_MODULE_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var dashboardModule = data.dashboardModule;
									for ( var key in dashboardModule) {
										records[0].set(key, dashboardModule[key]);
									}

									Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
								} else {
									Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
								}
							} else {
								Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
							}
						}
					});
				}
			}
		});
	}

	function _deleteDashboardModule() {//删除
		var records = Ext.getCmp('dashboardModulePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DASHBOARD_MODULE" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="delete" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'deleteDashboardModule.do',
						async : false,
						params : {
							'DASHBOARD_MODULE_ID_' : records[0].get('DASHBOARD_MODULE_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('dashboardModuleStore').remove(records[0]);//前台删除被删除数据

									Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
								} else {
									Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
								}
							} else {
								Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
							}
						}
					});
				}
			}
		});
	}

	function _viewDashboardModule() {//查看
		var records = Ext.getCmp('dashboardModulePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DASHBOARD_MODULE" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="DASHBOARD_MODULE" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewDashboardModule.do?DASHBOARD_MODULE_ID_=' + records[0].get('DASHBOARD_MODULE_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}
</script>
</head>
<body>
</body>
</html>