<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="choose" /><spring:message code="MENU" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var rootVisible = 'F';//根节点是否可见
	var multipul = 'F';//是否为多选
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.rootVisible != undefined) ? rootVisible = parameters.rootVisible : 0;
		(parameters.multipul != undefined) ? multipul = parameters.multipul : 0;
	}

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

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
				extraParams : {
					'MENU_STATUS_' : '1'
				},
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
			rootVisible : rootVisible == 'T',//根节点是否可见
			hideHeaders : true,//是否隐藏表头
			rowLines : false,//是否显示表格横线
			columnLines : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度
			selModel : {
				selType : 'checkboxmodel',
				mode : (multipul == 'T') ? 'SIMPLE' : 'SINGLE'
			},
			columns : [ {
				xtype : 'treecolumn',
				text : '<spring:message code="MENU.MENU_NAME_" />',
				dataIndex : 'MENU_NAME_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
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
					text : '<spring:message code="choose" />',
					icon : 'image/icon/choose.png',
					handler : _chooseMenu
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
								html : '<spring:message code="choose" /><spring:message code="MENU" /><br /><br /><spring:message code="help.chooseMenu" />'
							});
						}
					}
				} ],
				dock : 'top',
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
			},
			listeners : {
				'itemdblclick' : function(panel, record, item, index, e, eOpts) {
					_chooseMenu();
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

		_selectMenu();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectMenu() {//查询主表数据
		var menuStore = Ext.data.StoreManager.lookup('menuStore');
		menuStore.currentPage = 1;
		menuStore.load();
	}

	function _chooseMenu() {//选择
		var records = Ext.getCmp('menuPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="MENU" />', Ext.MessageBox.WARNING);
			return;
		}

		if (multipul == 'T') {
			var menuList = new Array();
			for (var i = 0; i < records.length; i++) {
				menuList.push(records[i].data);
			}
			parent.returnValue = menuList;
		} else {
			parent.returnValue = records[0].data;
		}

		_close();
	}

	function _expandAllMenu() {
		Ext.getCmp('menuPanel').expandAll();
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>