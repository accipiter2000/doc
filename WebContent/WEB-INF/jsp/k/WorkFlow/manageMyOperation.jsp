<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="OPERATION" /></title>
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

		var OPERATION_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'OPERATION_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var OPERATION_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'OPERATION_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ],
			data : [ {
				CODE_ : null,
				NAME_ : null
			}, {
				CODE_ : '1',
				NAME_ : '可取消'
			}, {
				CODE_ : '0',
				NAME_ : '不可取消'
			}, {
				CODE_ : '9',
				NAME_ : '已取消'
			} ]
		});

		var operationStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'operationStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'OPERATION_ID_', 'OPERATION_', 'PROC_ID_', 'NODE_ID_', 'TASK_ID_', 'MEMO_', 'OPERATOR_', 'OPERATOR_NAME_', 'OPERATION_DATE_', 'OPERATION_STATUS_', 'BIZ_ID_', 'BIZ_TYPE_', 'BIZ_CODE_', 'BIZ_NAME_', 'NODE_NAME_', 'APPROVAL_MEMO_' ],
			proxy : {
				url : 'selectMyOperation.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'myOperationList',
					totalProperty : 'total'
				}
			}
		});

		var operationPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'operationPanel',
			store : operationStore,
			title : '<spring:message code="OPERATION" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="OPERATION.OPERATION_ID_" />',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					if (record.get('OPERATION_STATUS_') == '1') {
						return '<a href="javascript:_undoOperation(\'' + record.get('OPERATION_ID_') + '\');"><spring:message code="undo" /></a>';
					}
				}
			}, {
				text : '<spring:message code="OPERATION.OPERATION_" />',
				dataIndex : 'OPERATION_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 128,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? OPERATION_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="DOC.DOC_NAME_" />',
				dataIndex : 'BIZ_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 2
			}, {
				text : '<spring:message code="DOC.DOC_CODE_" />',
				dataIndex : 'BIZ_CODE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="NODE.NODE_NAME_" />',
				dataIndex : 'NODE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="APPROVAL_MEMO.APPROVAL_MEMO_" />',
				dataIndex : 'APPROVAL_MEMO_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="OPERATION.OPERATION_DATE_" />',
				dataIndex : 'OPERATION_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="OPERATION.OPERATION_STATUS_" />',
				dataIndex : 'OPERATION_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? OPERATION_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
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
					handler : _selectOperation
				}, {
					id : 'viewNextNodeTaskInfo',
					xtype : 'button',
					text : '<spring:message code="adjust" /><spring:message code="next" /><spring:message code="assignee" />',
					icon : 'image/icon/view.png',
					handler : _viewNextNodeTaskInfo
				}, {
					xtype : 'button',
					text : '<spring:message code="view" /><spring:message code="DOC" />',
					icon : 'image/icon/view.png',
					handler : _viewDoc
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
								html : '<spring:message code="manage" /><spring:message code="OPERATION" /><br /><br /><spring:message code="help.manageOperation" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'operationFormPanel',
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
					name : 'OPERATION_',
					store : OPERATION_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="OPERATION.OPERATION_" />'
				}, {
					xtype : 'combo',
					name : 'OPERATION_STATUS_LIST',
					store : OPERATION_STATUS_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="OPERATION.OPERATION_STATUS_" />'
				}, {
					xtype : 'hiddenfield',
					name : 'dataScope',
					value : 'PROC'
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : operationStore,
				displayInfo : true,
				dock : 'bottom'
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			},
			listeners : {
				'itemclick' : function(gridPanel, record, item, index, e, eOpts) {
					_updateButtonStatus();
				},
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
				items : [ operationPanel ]
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
		var OPERATION_CodeStore = Ext.data.StoreManager.lookup('OPERATION_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^OPERATION$'));
		OPERATION_CodeStore.add(codeStore.getRange());
		OPERATION_CodeStore.insert(0, {});
		codeStore.clearFilter();

		_selectOperation();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectOperation() {//查询主表数据
		var operationStore = Ext.data.StoreManager.lookup('operationStore');
		var item;
		for (var i = 0; i < Ext.getCmp('operationFormPanel').items.length; i++) {
			item = Ext.getCmp('operationFormPanel').items.get(i);
			operationStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		operationStore.currentPage = 1;
		operationStore.load();
	}

	function _viewNextNodeTaskInfo() {
		var records = Ext.getCmp('operationPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="OPERATION" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="adjust" /><spring:message code="next" /><spring:message code="assignee" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewNextNodeTaskInfo.do?OPERATION_ID_=' + records[0].get('OPERATION_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _viewDoc() {//查看
		var records = Ext.getCmp('operationPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="OPERATION" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="DOC" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewDoc.do?DOC_ID_=' + records[0].get('BIZ_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _undoOperation(OPERATION_ID_) {
		var records = Ext.getCmp('operationPanel').getSelectionModel().getSelection();

		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="undo" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'undoOperation.do',
						async : false,
						params : {
							'OPERATION_ID_' : OPERATION_ID_
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var operation = data.operation;
									for ( var key in operation) {
										records[0].set(key, operation[key]);
									}

									Ext.MessageBox.alert('<spring:message code="info" />', '<spring:message code="undo" /><spring:message code="success" />', Ext.MessageBox.INFO);
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

	function _updateButtonStatus() {
		var records = Ext.getCmp('operationPanel').getSelectionModel().getSelection();
		if (records.length == 0) {
			return;
		}

		var viewNextNodeTaskInfoButton = Ext.getCmp('viewNextNodeTaskInfo');
		var OPERATION_ = records[0].get('OPERATION_');

		viewNextNodeTaskInfoButton.setDisabled(true);
		if (OPERATION_ == 'completeTask' || OPERATION_ == 'startProcByProcDefCode') {
			viewNextNodeTaskInfoButton.setDisabled(false);
		}
	}
</script>
</head>
<body>
</body>
</html>