<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="POSI_MENU" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	//获取url中的入参
	var ORG_ID_ = null;//根机构ID
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.ORG_ID_ != undefined) ? ORG_ID_ = parameters.ORG_ID_ : 0;
	}

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

		var omCodeStore = Ext.create('Ext.data.Store', {//代码表
			storeId : 'omCodeStore',
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

		var ORG_LEADER_TYPE_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'ORG_LEADER_TYPE_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var POSI_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'POSI_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
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

		var orgStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'orgStore',
			autoLoad : false,
			loading : false,
			root : {},//保证autoload有效
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'MEMO_', 'ORG_TAG_', 'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_', 'ORG_EXT_ATTR_8_', 'ORDER_', 'ORG_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_' ],
			proxy : {
				url : 'selectOmOrg.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'ORGN_SET_ID_' : orgnSet.ORGN_SET_ID_
				},
				reader : {
					type : 'json',
					root : 'orgList',
					totalProperty : 'total'
				}
			}
		});

		var posiStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'posiStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'POSI_ID_', 'POSI_CODE_', 'POSI_NAME_', 'ORG_LEADER_TYPE_', 'POSI_CATEGORY_', 'MEMO_', 'POSI_TAG_', 'POSI_EXT_ATTR_1_', 'POSI_EXT_ATTR_2_', 'POSI_EXT_ATTR_3_', 'POSI_EXT_ATTR_4_', 'POSI_EXT_ATTR_5_', 'POSI_EXT_ATTR_6_', 'POSI_EXT_ATTR_7_', 'POSI_EXT_ATTR_8_', 'ORDER_', 'POSI_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'DUTY_ID_', 'DUTY_CODE_', 'DUTY_NAME_', 'DUTY_CATEGORY_', 'DUTY_TAG_', 'DUTY_EXT_ATTR_1_', 'DUTY_EXT_ATTR_2_', 'DUTY_EXT_ATTR_3_', 'DUTY_EXT_ATTR_4_', 'DUTY_EXT_ATTR_5_', 'DUTY_EXT_ATTR_6_', 'DUTY_EXT_ATTR_7_', 'DUTY_EXT_ATTR_8_', 'DUTY_STATUS_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'ORG_TAG_', 'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_', 'ORG_EXT_ATTR_8_', 'ORG_STATUS_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_' ],
			proxy : {
				url : 'selectOmPosi.do',
				type : 'ajax',
				async : true,//false为同步
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'posiList',
					totalProperty : 'total'
				}
			}
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
					store.getRootNode().cascadeBy(function(node) {//显示树内置选择框
						node.set('checked', false);
					});

					setTimeout('_expandAllMenu()', 200);//延迟展开树
				}
			}
		});

		var posiMenuStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'posiMenuStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'POSI_MENU_ID_', 'POSI_ID_', 'POSI_NAME_', 'MENU_ID_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'PARENT_MENU_ID_', 'MENU_NAME_', 'MENU_TYPE_', 'URL_', 'ICON_', 'ORDER_', 'MENU_STATUS_', 'PARENT_MENU_CODE_', 'PARENT_MENU_NAME_' ],
			proxy : {
				url : 'selectPosiMenu.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'posiMenuList',
					totalProperty : 'total'
				}
			},
			listeners : {
				load : function(store, records, successful, eOpts) {
					var rootNode = menuStore.getRootNode();
					rootNode.cascadeBy(function(node) {//清空选择
						node.set('checked', false);
					});
					for (var i = 0; i < records.length; i++) {//设置选中
						var MENU_ID_ = records[i].get('MENU_ID_');
						var node = rootNode.findChild('MENU_ID_', MENU_ID_, true);
						if (node != null) {
							node.set('checked', true);
						}
					}
				}
			}
		});

		var buttonPanel = Ext.create('Ext.Panel', {//按钮
			id : 'buttonPanel',
			layout : 'column',
			defaults : {
				labelAlign : 'right',
				margin : '2'
			},
			items : [ {
				xtype : 'button',
				text : '<spring:message code="save" />',
				icon : 'image/icon/save.png',
				handler : _updatePosiMenu
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
							html : '<spring:message code="manage" /><spring:message code="POSI_MENU" /><br /><br /><spring:message code="help.managePosiMenu" />'
						});
					}
				}
			} ]
		});

		var orgPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'orgPanel',
			store : orgStore,
			title : '<spring:message code="ORG" />',
			rootVisible : false,//根节点是否可见
			hideHeaders : true,//是否隐藏表头
			rowLines : false,//是否显示表格横线
			columnLines : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度
			columns : [ {
				xtype : 'treecolumn',
				text : '<spring:message code="ORG.ORG_NAME_" />',
				dataIndex : 'ORG_NAME_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
			},
			listeners : {
				'beforeitemexpand' : function(node, eOpts) {
					orgStore.proxy.extraParams.PARENT_ORG_ID_ = node.get('ORG_ID_');
				},
				'itemclick' : function(view, record, item, index, e, eOpts) {
					_selectPosi();
				}
			}
		});

		var posiPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'posiPanel',
			store : posiStore,
			title : '<spring:message code="POSI" />',
			headerBorders : false,//是否显示表格竖线
			columns : [ {
				text : '<spring:message code="POSI.POSI_NAME_" />',
				dataIndex : 'POSI_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DUTY.DUTY_NAME_" />',
				dataIndex : 'DUTY_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="POSI.ORG_LEADER_TYPE_" />',
				dataIndex : 'ORG_LEADER_TYPE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? ORG_LEADER_TYPE_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="POSI.POSI_TAG_" />',
				dataIndex : 'POSI_TAG_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="POSI.POSI_STATUS_" />',
				dataIndex : 'POSI_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? POSI_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
			},
			listeners : {
				'itemclick' : function(view, record, item, index, e, eOpts) {
					_selectPosiMenu();
				}
			}
		});

		var centerPanel = Ext.create('Ext.Panel', {
			id : 'centerPanel',
			layout : 'border',
			defaults : {
				border : false
			},
			items : [ {
				region : 'north',
				layout : 'fit',
				height : '60%',
				items : [ orgPanel ]
			}, {
				region : 'center',
				layout : 'fit',
				items : [ posiPanel ]
			} ]
		});

		var menuPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'menuPanel',
			store : menuStore,
			title : '<spring:message code="MENU" />',
			rootVisible : false,//根节点是否可见
			hideHeaders : false,//是否隐藏表头
			rowLines : false,//是否显示表格横线
			columnLines : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度
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
				text : '<spring:message code="MENU.MENU_STATUS_" />',
				dataIndex : 'MENU_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? MENU_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			},
			listeners : {
				'checkchange' : function(node, checked, eOpts) {
					menuPanel.lockedCheckChange = true;
					node.cascadeBy(function(node) {//向下级联选择
						node.set('checked', checked);
					});
					if (checked) {
						node.bubble(function(node) {//向上级联选中
							node.set('checked', true);
						});
					} else {
						node.bubble(function(node) {//向上级联取消选中
							var childNodes = node.childNodes;
							for (var i = 0; i < childNodes.length; i++) {
								if (childNodes[i].get('checked')) {
									return;
								}
							}
							node.set('checked', false);
						});
					}
					menuPanel.lockedCheckChange = false;
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
				region : 'north',
				items : [ buttonPanel ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ centerPanel ]
			}, {
				region : 'east',
				layout : 'fit',//充满
				width : 600,
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

		var omCodeStore = Ext.data.StoreManager.lookup('omCodeStore');//组装子代码数据，过滤注入。
		var ORG_LEADER_TYPE_CodeStore = Ext.data.StoreManager.lookup('ORG_LEADER_TYPE_CodeStore');
		omCodeStore.filter('CATEGORY_', new RegExp('^ORG_LEADER_TYPE$'));
		ORG_LEADER_TYPE_CodeStore.add(omCodeStore.getRange());
		ORG_LEADER_TYPE_CodeStore.insert(0, {});
		omCodeStore.clearFilter();
		var POSI_STATUS_CodeStore = Ext.data.StoreManager.lookup('POSI_STATUS_CodeStore');
		omCodeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		POSI_STATUS_CodeStore.add(omCodeStore.getRange());
		POSI_STATUS_CodeStore.insert(0, {});
		omCodeStore.clearFilter();

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

		_switchToOrg();

		Ext.data.StoreManager.lookup('menuStore').load();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _switchToOrg() {
		var orgRootOnly = false;
		if (ORG_ID_ == null) {
			orgRootOnly = true;
		}
		Ext.Ajax.request({//加载机构根节点
			url : 'selectOmOrg.do',
			async : false,//同步加载
			params : {
				'ORGN_SET_ID_' : orgnSet.ORGN_SET_ID_,
				'ORG_ID_' : ORG_ID_,
				'orgRootOnly' : orgRootOnly
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success && data.orgList.length > 0) {
						var rootNode = Ext.data.StoreManager.lookup('orgStore').getRootNode();
						rootNode.removeAll();
						rootNode.appendChild(data.orgList, false, false, true);
						rootNode.expandChildren();
						rootNode.expand();

						var orgPanel = Ext.getCmp('orgPanel');
						orgPanel.getSelectionModel().select(rootNode.getChildAt(0));//选中新增记录
						orgPanel.fireEvent('itemclick', orgPanel, rootNode.getChildAt(0));
					}
				}
			}
		});
	}

	function _selectPosi() {
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();
		var posiStore = Ext.data.StoreManager.lookup('posiStore');
		posiStore.proxy.extraParams.ORGN_SET_ID_ = orgnSet.ORGN_SET_ID_;
		posiStore.proxy.extraParams.ORG_ID_ = records[0].get('ORG_ID_');
		posiStore.currentPage = 1;
		posiStore.load();
	}

	function _selectPosiMenu() {
		var records = Ext.getCmp('posiPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="POSI" />', Ext.MessageBox.WARNING);
			return;
		}

		var posiMenuStore = Ext.data.StoreManager.lookup('posiMenuStore');
		posiMenuStore.proxy.extraParams.POSI_ID_ = records[0].get('POSI_ID_');
		posiMenuStore.currentPage = 1;
		posiMenuStore.load();
	}

	function _updatePosiMenu() {
		var records = Ext.getCmp('posiPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="POSI" />', Ext.MessageBox.WARNING);
			return;
		}

		var MENU_ID_LIST = new Array();
		var nodes = Ext.getCmp('menuPanel').getChecked();
		for (var i = 0; i < nodes.length; i++) {
			if (nodes[i].get('MENU_ID_') != null && nodes[i].get('MENU_ID_') != '') {
				MENU_ID_LIST.push(nodes[i].get('MENU_ID_'));
			}
		}
		Ext.Ajax.request({
			url : 'updatePosiMenuByMenuIdList.do',
			async : false,
			params : {
				'POSI_ID_' : records[0].get('POSI_ID_'),
				'POSI_NAME_' : records[0].get('POSI_NAME_'),
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

	function _expandAllMenu() {
		Ext.getCmp('menuPanel').expandAll();
	}
</script>
</head>
<body>
</body>
</html>