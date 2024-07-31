<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="DUTY_MENU" /></title>
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

		var dutyStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'dutyStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'DUTY_ID_', 'DUTY_CODE_', 'DUTY_NAME_', 'DUTY_CATEGORY_', 'MEMO_', 'DUTY_TAG_', 'DUTY_EXT_ATTR_1_', 'DUTY_EXT_ATTR_2_', 'DUTY_EXT_ATTR_3_', 'DUTY_EXT_ATTR_4_', 'DUTY_EXT_ATTR_5_', 'DUTY_EXT_ATTR_6_', 'DUTY_EXT_ATTR_7_', 'DUTY_EXT_ATTR_8_', 'ORDER_', 'DUTY_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectOmDuty.do',
				type : 'ajax',
				async : true,//false为同步
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'dutyList',
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

		var dutyMenuStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'dutyMenuStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'DUTY_MENU_ID_', 'DUTY_ID_', 'DUTY_NAME_', 'MENU_ID_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'PARENT_MENU_ID_', 'MENU_NAME_', 'MENU_TYPE_', 'URL_', 'ICON_', 'ORDER_', 'MENU_STATUS_', 'PARENT_MENU_CODE_', 'PARENT_MENU_NAME_' ],
			proxy : {
				url : 'selectDutyMenu.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'dutyMenuList',
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
				handler : _updateDutyMenu
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
							html : '<spring:message code="manage" /><spring:message code="DUTY_MENU" /><br /><br /><spring:message code="help.manageDutyMenu" />'
						});
					}
				}
			} ]
		});

		var dutyPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'dutyPanel',
			store : dutyStore,
			title : '<spring:message code="DUTY" />',
			headerBorders : false,//是否显示表格竖线
			columns : [ {
				text : '<spring:message code="DUTY.DUTY_NAME_" />',
				dataIndex : 'DUTY_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
			},
			listeners : {
				'itemclick' : function(view, record, item, index, e, eOpts) {
					_selectDutyMenu();
				}
			}
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
				items : [ dutyPanel ]
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

		_selectDuty();

		Ext.data.StoreManager.lookup('menuStore').load();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectDuty() {
		var dutyStore = Ext.data.StoreManager.lookup('dutyStore');
		dutyStore.proxy.extraParams.ORGN_SET_ID_ = orgnSet.ORGN_SET_ID_;
		dutyStore.currentPage = 1;
		dutyStore.load();
	}

	function _selectDutyMenu() {
		var records = Ext.getCmp('dutyPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DUTY" />', Ext.MessageBox.WARNING);
			return;
		}

		var dutyMenuStore = Ext.data.StoreManager.lookup('dutyMenuStore');
		dutyMenuStore.proxy.extraParams.DUTY_ID_ = records[0].get('DUTY_ID_');
		dutyMenuStore.currentPage = 1;
		dutyMenuStore.load();
	}

	function _updateDutyMenu() {
		var records = Ext.getCmp('dutyPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DUTY" />', Ext.MessageBox.WARNING);
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
			url : 'updateDutyMenuByMenuIdList.do',
			async : false,
			params : {
				'DUTY_ID_' : records[0].get('DUTY_ID_'),
				'DUTY_NAME_' : records[0].get('DUTY_NAME_'),
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