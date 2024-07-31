<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="MIRROR_SERVER" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
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

		var MIRROR_SERVER_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'MIRROR_SERVER_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var mirrorServerStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'mirrorServerStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'MIRROR_SERVER_ID_', 'MIRROR_SERVER_NAME_', 'DRIVER_CLASS_NAME_', 'URL_', 'USERNAME_', 'PASSWORD_', 'MEMO_', 'LAST_SYNC_DATE_', 'ORDER_', 'MIRROR_SERVER_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectOmMirrorServer.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'mirrorServerList',
					totalProperty : 'total'
				}
			}
		});

		var mirrorServerPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'mirrorServerPanel',
			store : mirrorServerStore,
			title : '<spring:message code="MIRROR_SERVER" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="MIRROR_SERVER.MIRROR_SERVER_NAME_" />',
				dataIndex : 'MIRROR_SERVER_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="MIRROR_SERVER.DRIVER_CLASS_NAME_" />',
				dataIndex : 'DRIVER_CLASS_NAME_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			}, {
				text : '<spring:message code="MIRROR_SERVER.URL_" />',
				dataIndex : 'URL_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			}, {
				text : '<spring:message code="MIRROR_SERVER.USERNAME_" />',
				dataIndex : 'USERNAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="MIRROR_SERVER.PASSWORD_" />',
				dataIndex : 'PASSWORD_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="MIRROR_SERVER.MEMO_" />',
				dataIndex : 'MEMO_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="MIRROR_SERVER.LAST_SYNC_DATE_" />',
				dataIndex : 'LAST_SYNC_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="MIRROR_SERVER.ORDER_" />',
				dataIndex : 'ORDER_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 48
			}, {
				text : '<spring:message code="MIRROR_SERVER.MIRROR_SERVER_STATUS_" />',
				dataIndex : 'MIRROR_SERVER_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 182,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? MIRROR_SERVER_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="MIRROR_SERVER.CREATION_DATE_" />',
				dataIndex : 'CREATION_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="MIRROR_SERVER.UPDATE_DATE_" />',
				dataIndex : 'UPDATE_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="MIRROR_SERVER.OPERATOR_NAME_" />',
				dataIndex : 'OPERATOR_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 100
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
					handler : _selectMirrorServer
				}, {
					xtype : 'button',
					text : '<spring:message code="insert" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertMirrorServer
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateMirrorServer
				}, {
					xtype : 'button',
					text : '<spring:message code="disable" />',
					icon : 'image/icon/disable.png',
					handler : _disableMirrorServer
				}, {
					xtype : 'button',
					text : '<spring:message code="enable" />',
					icon : 'image/icon/enable.png',
					handler : _enableMirrorServer
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteMirrorServer
				}, {
					xtype : 'button',
					text : '<spring:message code="view" />',
					icon : 'image/icon/view.png',
					handler : _viewMirrorServer
				}, {
					xtype : 'button',
					text : '<spring:message code="manage" /><spring:message code="sync" />',
					icon : 'image/icon/manage.png',
					handler : _manageServerPushOrgnSetSync
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
								html : '<spring:message code="manage" /><spring:message code="MIRROR_SERVER" /><br /><br /><spring:message code="help.manageMirrorServer" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'mirrorServerFormPanel',
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
					name : 'MIRROR_SERVER_NAME_',
					fieldLabel : '<spring:message code="MIRROR_SERVER.MIRROR_SERVER_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'combo',
					name : 'MIRROR_SERVER_STATUS_LIST',
					store : MIRROR_SERVER_STATUS_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="MIRROR_SERVER.MIRROR_SERVER_STATUS_" />'
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : mirrorServerStore,
				displayInfo : true,
				dock : 'bottom'
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
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
								if (dataIndex == 'DRIVER_CLASS_NAME_' || dataIndex == 'URL_') {
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
				items : [ mirrorServerPanel ]
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
		var MIRROR_SERVER_STATUS_CodeStore = Ext.data.StoreManager.lookup('MIRROR_SERVER_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		MIRROR_SERVER_STATUS_CodeStore.add(codeStore.getRange());
		MIRROR_SERVER_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		_selectMirrorServer();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectMirrorServer() {//查询主表数据
		var mirrorServerStore = Ext.data.StoreManager.lookup('mirrorServerStore');
		var item;
		for (var i = 0; i < Ext.getCmp('mirrorServerFormPanel').items.length; i++) {
			item = Ext.getCmp('mirrorServerFormPanel').items.get(i);
			mirrorServerStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		mirrorServerStore.currentPage = 1;
		mirrorServerStore.load();
	}

	function _preInsertMirrorServer() {//新增
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="MIRROR_SERVER" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertOmMirrorServer.do" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var mirrorServer = returnValue;
						Ext.data.StoreManager.lookup('mirrorServerStore').add(mirrorServer);//前台新增数据

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdateMirrorServer() {//修改
		var records = Ext.getCmp('mirrorServerPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MIRROR_SERVER" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="MIRROR_SERVER" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preUpdateOmMirrorServer.do?MIRROR_SERVER_ID_=' + records[0].get('MIRROR_SERVER_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var mirrorServer = returnValue;
						for ( var key in mirrorServer) {
							records[0].set(key, mirrorServer[key]);
						}

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _disableMirrorServer() {//废弃
		var records = Ext.getCmp('mirrorServerPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MIRROR_SERVER" />', Ext.MessageBox.WARNING);
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
						url : 'disableOmMirrorServer.do',
						async : false,
						params : {
							'MIRROR_SERVER_ID_' : records[0].get('MIRROR_SERVER_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var mirrorServer = data.mirrorServer;
									for ( var key in mirrorServer) {
										records[0].set(key, mirrorServer[key]);
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

	function _enableMirrorServer() {//恢复
		var records = Ext.getCmp('mirrorServerPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MIRROR_SERVER" />', Ext.MessageBox.WARNING);
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
						url : 'enableOmMirrorServer.do',
						async : false,
						params : {
							'MIRROR_SERVER_ID_' : records[0].get('MIRROR_SERVER_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var mirrorServer = data.mirrorServer;
									for ( var key in mirrorServer) {
										records[0].set(key, mirrorServer[key]);
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

	function _deleteMirrorServer() {//删除
		var records = Ext.getCmp('mirrorServerPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MIRROR_SERVER" />', Ext.MessageBox.WARNING);
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
						url : 'deleteOmMirrorServer.do',
						async : false,
						params : {
							'MIRROR_SERVER_ID_' : records[0].get('MIRROR_SERVER_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('mirrorServerStore').remove(records[0]);//前台删除被删除数据

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

	function _viewMirrorServer() {//查看
		var records = Ext.getCmp('mirrorServerPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MIRROR_SERVER" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="MIRROR_SERVER" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewMirrorServer.do?MIRROR_SERVER_ID_=' + records[0].get('MIRROR_SERVER_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _manageServerPushOrgnSetSync() {
		var records = Ext.getCmp('mirrorServerPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MIRROR_SERVER" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="manage" /><spring:message code="sync" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="manageOmServerPushOrgnSetSync.do?MIRROR_SERVER_ID_=' + records[0].get('MIRROR_SERVER_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}
</script>
</head>
<body>
</body>
</html>