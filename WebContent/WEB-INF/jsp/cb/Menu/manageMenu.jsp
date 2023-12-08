<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="MENU" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	var orgnSet;

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'getOrgnSet.do',
			async : false,//同步加载
			params : {},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						orgnSet = data.orgnSet;
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

		var MENU_TYPE_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'MENU_TYPE_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var MENU_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'MENU_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var menuStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'menuStore',
			autoLoad : false,
			loading : false,
			root : {},//保证autoload有效
			pageSize : -1,
			fields : [ 'MENU_ID_', 'PARENT_MENU_ID_', 'MENU_NAME_', 'MENU_TYPE_', 'URL_', 'ICON_', 'ORDER_', 'MENU_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'PARENT_MENU_CODE_', 'PARENT_MENU_NAME_' ],
			proxy : {
				url : 'selectMenu.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'children',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, node, records, successful, eOpts) {
					setTimeout('_expandAllMenu()', 200);//延迟展开树
				}
			}
		});

		var menuPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'menuPanel',
			store : menuStore,
			title : '<spring:message code="MENU" />',
			rootVisible : false,//根节点是否可见
			hideHeaders : false,//是否隐藏表头
			rowLines : true,//是否显示表格横线
			headerBorders : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				xtype : 'treecolumn',
				text : '<spring:message code="MENU.MENU_NAME_" />',
				dataIndex : 'MENU_NAME_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			}, {
				text : '<spring:message code="MENU.MENU_TYPE_" />',
				dataIndex : 'MENU_TYPE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? MENU_TYPE_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="MENU.URL_" />',
				dataIndex : 'URL_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="MENU.ICON_" />',
				dataIndex : 'ICON_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="MENU.ORDER_" />',
				dataIndex : 'ORDER_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 48
			}, {
				text : '<spring:message code="MENU.MENU_STATUS_" />',
				dataIndex : 'MENU_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? MENU_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="MENU.CREATION_DATE_" />',
				dataIndex : 'CREATION_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="MENU.UPDATE_DATE_" />',
				dataIndex : 'UPDATE_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="MENU.OPERATOR_NAME_" />',
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
					text : '<spring:message code="insert" /><spring:message code="root" /><spring:message code="MENU" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertRootMenu
				}, {
					xtype : 'button',
					text : '<spring:message code="insert" /><spring:message code="child" /><spring:message code="MENU" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertChildMenu
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateMenu
				}, {
					xtype : 'button',
					text : '<spring:message code="move" />',
					icon : 'image/icon/move.png',
					handler : _moveMenu
				}, {
					xtype : 'button',
					text : '<spring:message code="disable" />',
					icon : 'image/icon/disable.png',
					handler : _disableMenu
				}, {
					xtype : 'button',
					text : '<spring:message code="enable" />',
					icon : 'image/icon/enable.png',
					handler : _enableMenu
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteMenu
				}, {
					xtype : 'button',
					text : '<spring:message code="view" />',
					icon : 'image/icon/view.png',
					handler : _viewMenu
				}, {
					xtype : 'button',
					text : '<spring:message code="insert" /><spring:message code="MENU" /><spring:message code="to" /><spring:message code="DUTY" />',
					icon : 'image/icon/insert.png',
					handler : _insertDutyMenu
				}, {
					xtype : 'button',
					text : '<spring:message code="insert" /><spring:message code="MENU" /><spring:message code="to" /><spring:message code="POSI" />',
					icon : 'image/icon/insert.png',
					handler : _insertPosiMenu
				}, {
					xtype : 'button',
					text : '<spring:message code="insert" /><spring:message code="MENU" /><spring:message code="to" /><spring:message code="POSI_EMP" />',
					icon : 'image/icon/insert.png',
					handler : _insertPosiEmpMenu
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
								html : '<spring:message code="manage" /><spring:message code="MENU" /><br /><br /><spring:message code="help.manageMenu" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'menuFormPanel',
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
					name : 'PARENT_MENU_ID_',
					fieldLabel : '<spring:message code="MENU.PARENT_MENU_ID_" />',
					maxLength : 40
				}, {
					xtype : 'textfield',
					name : 'MENU_NAME_',
					fieldLabel : '<spring:message code="MENU.MENU_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'combo',
					name : 'MENU_TYPE_LIST',
					store : MENU_TYPE_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="MENU.MENU_TYPE_" />'
				}, {
					xtype : 'combo',
					name : 'MENU_STATUS_LIST',
					store : MENU_STATUS_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="MENU.MENU_STATUS_" />'
				} ],
				dock : 'top',
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
								if (dataIndex == 'URL_') {
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
				items : [ menuPanel ]
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
		var MENU_TYPE_CodeStore = Ext.data.StoreManager.lookup('MENU_TYPE_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^MENU_TYPE$'));
		MENU_TYPE_CodeStore.add(codeStore.getRange());
		MENU_TYPE_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var MENU_STATUS_CodeStore = Ext.data.StoreManager.lookup('MENU_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		MENU_STATUS_CodeStore.add(codeStore.getRange());
		MENU_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		_selectMenu();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectMenu() {//查询主表数据
		var menuStore = Ext.data.StoreManager.lookup('menuStore');
		var item;
		for (var i = 0; i < Ext.getCmp('menuFormPanel').items.length; i++) {
			item = Ext.getCmp('menuFormPanel').items.get(i);
			menuStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		menuStore.currentPage = 1;
		menuStore.load();
	}

	function _preInsertRootMenu() {//新增
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="root" /><spring:message code="MENU" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertMenu.do" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var menu = returnValue;
						var rootNode = Ext.data.StoreManager.lookup('menuStore').getRootNode();
						menu.loaded = true;
						menu.expandable = false;
						rootNode.appendChild(menu);
						rootNode.expand();

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preInsertChildMenu() {//新增
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="parent" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="child" /><spring:message code="MENU" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertMenu.do?PARENT_MENU_ID_=' + records[0].get('MENU_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var menu = returnValue;
						menu.loaded = true;
						menu.expandable = false;
						records[0].appendChild(menu);
						records[0].expand();

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdateMenu() {//修改
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="MENU" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preUpdateMenu.do?MENU_ID_=' + records[0].get('MENU_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var menu = returnValue;
						for ( var key in menu) {
							records[0].set(key, menu[key]);
						}

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _moveMenu() {//移动
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="parent" /><spring:message code="MENU" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseMenu.do?rootVisible=T&multipul=F" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var parentMenu = returnValue;
						Ext.MessageBox.show({
							title : '<spring:message code="pleaseConfirm" />',
							msg : '<spring:message code="move" />',
							buttons : Ext.MessageBox.YESNO,
							icon : Ext.MessageBox.QUESTION,
							fn : function(btn) {
								if (btn == 'yes') {
									Ext.Ajax.request({
										url : 'moveMenu.do',
										async : false,
										params : {
											'MENU_ID_' : records[0].get('MENU_ID_'),
											'PARENT_MENU_ID_' : parentMenu.MENU_ID_
										},
										callback : function(options, success, response) {
											if (success) {
												var data = Ext.decode(response.responseText);
												if (data.success) {//更新页面数据
													var menu = data.menu;
													for ( var key in menu) {
														records[0].set(key, menu[key]);
													}

													var rootNode = Ext.data.StoreManager.lookup('menuStore').getRootNode();
													var parentNode = rootNode;
													if (parentMenu.MENU_ID_ != null && parentMenu.MENU_ID_ != '') {
														parentNode = rootNode.findChild('MENU_ID_', parentMenu.MENU_ID_, true);
													}
													parentNode.appendChild(records[0]);
													parentNode.expand();

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
				}
			}
		});
	}

	function _disableMenu() {//废弃
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
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
						url : 'disableMenu.do',
						async : false,
						params : {
							'MENU_ID_' : records[0].get('MENU_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var menu = data.menu;
									for ( var key in menu) {
										records[0].set(key, menu[key]);
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

	function _enableMenu() {//恢复
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
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
						url : 'enableMenu.do',
						async : false,
						params : {
							'MENU_ID_' : records[0].get('MENU_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var menu = data.menu;
									for ( var key in menu) {
										records[0].set(key, menu[key]);
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

	function _deleteMenu() {//删除
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
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
						url : 'deleteMenu.do',
						async : false,
						params : {
							'MENU_ID_' : records[0].get('MENU_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									records[0].remove();

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

	function _viewMenu() {
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="MENU" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewMenu.do?MENU_ID_=' + records[0].get('MENU_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _insertDutyMenu() {//新增岗位菜单
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="DUTY" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmDuty.do?multipul=T&ORGN_SET_ID_=' + orgnSet.ORGN_SET_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var dutyList = returnValue;
						var DUTY_ID_LIST = new Array();
						var DUTY_NAME_LIST = new Array();
						for (var i = 0; i < dutyList.length; i++) {
							DUTY_ID_LIST.push(dutyList[i].DUTY_ID_);
							DUTY_NAME_LIST.push(dutyList[i].DUTY_NAME_);
						}
						var MENU_ID_LIST = new Array();
						MENU_ID_LIST.push(records[0].get('MENU_ID_'));
						Ext.MessageBox.show({
							title : '<spring:message code="pleaseConfirm" />',
							msg : '<spring:message code="insert" />',
							buttons : Ext.MessageBox.YESNO,
							icon : Ext.MessageBox.QUESTION,
							fn : function(btn) {
								if (btn == 'yes') {
									Ext.Ajax.request({
										url : 'insertDutyMenu.do',
										async : false,
										params : {
											'DUTY_ID_LIST' : DUTY_ID_LIST,
											'DUTY_NAME_LIST' : DUTY_NAME_LIST,
											'MENU_ID_LIST' : MENU_ID_LIST
										},
										callback : function(options, success, response) {
											if (success) {
												var data = Ext.decode(response.responseText);
												if (data.success) {//更新页面数据
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
				}
			}
		});
	}

	function _insertPosiMenu() {//新增岗位菜单
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="POSI" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmPosi.do?multipul=T&ORGN_SET_ID_=' + orgnSet.ORGN_SET_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var posiList = returnValue;
						var POSI_ID_LIST = new Array();
						var POSI_NAME_LIST = new Array();
						for (var i = 0; i < posiList.length; i++) {
							POSI_ID_LIST.push(posiList[i].POSI_ID_);
							POSI_NAME_LIST.push(posiList[i].POSI_NAME_);
						}
						var MENU_ID_LIST = new Array();
						MENU_ID_LIST.push(records[0].get('MENU_ID_'));
						Ext.MessageBox.show({
							title : '<spring:message code="pleaseConfirm" />',
							msg : '<spring:message code="insert" />',
							buttons : Ext.MessageBox.YESNO,
							icon : Ext.MessageBox.QUESTION,
							fn : function(btn) {
								if (btn == 'yes') {
									Ext.Ajax.request({
										url : 'insertPosiMenu.do',
										async : false,
										params : {
											'POSI_ID_LIST' : POSI_ID_LIST,
											'POSI_NAME_LIST' : POSI_NAME_LIST,
											'MENU_ID_LIST' : MENU_ID_LIST
										},
										callback : function(options, success, response) {
											if (success) {
												var data = Ext.decode(response.responseText);
												if (data.success) {//更新页面数据
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
				}
			}
		});
	}

	function _insertPosiEmpMenu() {//新增岗位菜单
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="POSI_EMP" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmPosiEmp.do?multipul=T&ORGN_SET_ID_=' + orgnSet.ORGN_SET_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var posiEmpList = returnValue;
						var POSI_EMP_ID_LIST = new Array();
						var POSI_NAME_LIST = new Array();
						var EMP_NAME_LIST = new Array();
						for (var i = 0; i < posiEmpList.length; i++) {
							POSI_EMP_ID_LIST.push(posiEmpList[i].POSI_EMP_ID_);
							POSI_NAME_LIST.push(posiEmpList[i].POSI_NAME_);
							EMP_NAME_LIST.push(posiEmpList[i].EMP_NAME_);
						}
						var MENU_ID_LIST = new Array();
						MENU_ID_LIST.push(records[0].get('MENU_ID_'));
						Ext.MessageBox.show({
							title : '<spring:message code="pleaseConfirm" />',
							msg : '<spring:message code="insert" />',
							buttons : Ext.MessageBox.YESNO,
							icon : Ext.MessageBox.QUESTION,
							fn : function(btn) {
								if (btn == 'yes') {
									Ext.Ajax.request({
										url : 'insertPosiEmpMenu.do',
										async : false,
										params : {
											'POSI_EMP_ID_LIST' : POSI_EMP_ID_LIST,
											'POSI_NAME_LIST' : POSI_NAME_LIST,
											'EMP_NAME_LIST' : EMP_NAME_LIST,
											'MENU_ID_LIST' : MENU_ID_LIST
										},
										callback : function(options, success, response) {
											if (success) {
												var data = Ext.decode(response.responseText);
												if (data.success) {//更新页面数据
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
				}
			}
		});
	}

	function _expandAllMenu() {
		Ext.getCmp('menuPanel').expandAll();
	}
</script>
</head>
<body>
</body>
</html>