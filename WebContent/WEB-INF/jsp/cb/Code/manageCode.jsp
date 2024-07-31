<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="CODE" /></title>
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

		var codeCategoryStore = Ext.create('Ext.data.Store', {
			storeId : 'codeCategoryStore',
			autoLoad : true,//true为自动加载
			loading : true,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'CATEGORY_' ],
			proxy : {
				url : 'selectCodeCategory.do',
				type : 'ajax',
				async : true,//false为同步
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'codeCategoryList',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, records, successful, eOpts) {
					store.insert(0, {});

					_init();//自动加载时必须调用
				}
			}
		});

		var codeStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'codeStore',
			autoLoad : false,
			loading : false,
			root : {},//保证autoload有效
			pageSize : -1,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ],
			proxy : {
				url : 'selectCode.do',
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
					setTimeout('_expandAllCode()', 200);//延迟展开树
				}
			}
		});

		var codePanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'codePanel',
			store : codeStore,
			title : '<spring:message code="CODE" />',
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
				text : '<spring:message code="CODE.CODE_" />',
				dataIndex : 'CODE_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			}, {
				text : '<spring:message code="CODE.NAME_" />',
				dataIndex : 'NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="CODE.CATEGORY_" />',
				dataIndex : 'CATEGORY_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="CODE.EXT_ATTR_1_" />',
				dataIndex : 'EXT_ATTR_1_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="CODE.EXT_ATTR_2_" />',
				dataIndex : 'EXT_ATTR_2_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="CODE.EXT_ATTR_3_" />',
				dataIndex : 'EXT_ATTR_3_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="CODE.EXT_ATTR_4_" />',
				dataIndex : 'EXT_ATTR_4_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="CODE.EXT_ATTR_5_" />',
				dataIndex : 'EXT_ATTR_5_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="CODE.EXT_ATTR_6_" />',
				dataIndex : 'EXT_ATTR_6_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="CODE.ORDER_" />',
				dataIndex : 'ORDER_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 48
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
					text : '<spring:message code="insert" /><spring:message code="root" /><spring:message code="CODE" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertRootCode
				}, {
					xtype : 'button',
					text : '<spring:message code="insert" /><spring:message code="child" /><spring:message code="CODE" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertChildCode
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateCode
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteCode
				}, {
					xtype : 'button',
					text : '<spring:message code="view" />',
					icon : 'image/icon/view.png',
					handler : _viewCode
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
								html : '<spring:message code="manage" /><spring:message code="CODE" /><br /><br /><spring:message code="help.manageCode" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'codeFormPanel',
				xtype : 'form',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 360,
					margin : '4'
				},
				items : [ {
					xtype : 'combo',
					name : 'CATEGORY_LIST',
					store : codeCategoryStore,
					queryMode : 'local',
					valueField : 'CATEGORY_',
					displayField : 'CATEGORY_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="CODE.CATEGORY_" />',
					listeners : {
						'select' : function(combo, records, eOpts) {
							_selectCode();
						}
					}
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
				items : [ codePanel ]
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

		_selectCode();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectCode() {//查询主表数据
		var codeStore = Ext.data.StoreManager.lookup('codeStore');
		var item;
		for (var i = 0; i < Ext.getCmp('codeFormPanel').items.length; i++) {
			item = Ext.getCmp('codeFormPanel').items.get(i);
			codeStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		codeStore.currentPage = 1;
		codeStore.load();
	}

	function _preInsertRootCode() {//新增
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="root" /><spring:message code="CODE" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertCode.do?CATEGORY_=' + Ext.getCmp('codeFormPanel').getForm().findField('CATEGORY_LIST').getSubmitValue() + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var code = returnValue;
						var rootNode = Ext.data.StoreManager.lookup('codeStore').getRootNode();
						code.loaded = true;
						code.expandable = false;
						rootNode.appendChild(code);
						rootNode.expand();

						var codeCategoryStore = Ext.data.StoreManager.lookup('codeCategoryStore');
						if (codeCategoryStore.findExact('CATEGORY_', code.CATEGORY_) == -1) {
							codeCategoryStore.add({
								'CATEGORY_' : code.CATEGORY_
							});
						}

						var categoryField = Ext.getCmp('codeFormPanel').getForm().findField('CATEGORY_LIST');
						categoryField.select(code.CATEGORY_);
						categoryField.fireEvent('select', categoryField, codeCategoryStore.data);

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preInsertChildCode() {//新增
		var records = Ext.getCmp('codePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="parent" /><spring:message code="CODE" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="child" /><spring:message code="CODE" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertCode.do?PARENT_CODE_ID_=' + records[0].get('CODE_ID_') + '&CATEGORY_=' + records[0].get('CATEGORY_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var code = returnValue;
						code.loaded = true;
						code.expandable = false;
						records[0].appendChild(code);
						records[0].expand();

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdateCode() {//修改
		var records = Ext.getCmp('codePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="CODE" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="CODE" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preUpdateCode.do?CODE_ID_=' + records[0].get('CODE_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var code = returnValue;
						for ( var key in code) {
							records[0].set(key, code[key]);
						}

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _deleteCode() {//删除
		var records = Ext.getCmp('codePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="CODE" />', Ext.MessageBox.WARNING);
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
						url : 'deleteCode.do',
						async : false,
						params : {
							'CODE_ID_' : records[0].get('CODE_ID_')
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

	function _viewCode() {
		var records = Ext.getCmp('codePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="CODE" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="CODE" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewCode.do?CODE_ID_=' + records[0].get('CODE_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _expandAllCode() {
		Ext.getCmp('codePanel').expandAll();
	}
</script>
</head>
<body>
</body>
</html>