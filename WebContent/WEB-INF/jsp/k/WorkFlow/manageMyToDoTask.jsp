<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="TASK" /></title>
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

		var FORWARD_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'FORWARD_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ],
			data : [ {
				CODE_ : '0',
				NAME_ : '未转发'
			}, {
				CODE_ : '1',
				NAME_ : '转发处理中'
			}, {
				CODE_ : '9',
				NAME_ : '转发处理完成'
			} ]
		});

		var TASK_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'TASK_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ],
			data : [ {
				CODE_ : '0',
				NAME_ : '挂起中'
			}, {
				CODE_ : '1',
				NAME_ : '待办中'
			}, {
				CODE_ : '1',
				NAME_ : '异常结束'
			}, {
				CODE_ : '9',
				NAME_ : '正常结束'
			} ]
		});

		var taskStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'taskStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'TASK_ID_', 'NODE_ID_', 'PREVIOUS_TASK_ID_', 'TASK_TYPE_', 'ASSIGNEE_', 'ASSIGNEE_NAME_', 'EXECUTOR_', 'EXECUTOR_NAME_', 'ACTION_', 'CLAIM_DATE_', 'DUE_DATE_', 'COMPLETE_DATE_', 'PRIORITY_', 'FORWARD_STATUS_', 'TASK_STATUS_', 'CREATION_DATE_', 'PARENT_NODE_ID_', 'PROC_ID_', 'NODE_TYPE_', 'NODE_CODE_', 'NODE_NAME_', 'NODE_END_USER_', 'NODE_END_USER_NAME_', 'NODE_END_DATE_', 'NODE_STATUS_', 'BIZ_ID_', 'BIZ_TYPE_', 'BIZ_CODE_', 'BIZ_NAME_', 'PROC_START_USER_', 'PROC_START_USER_NAME_', 'PROC_START_DATE_', 'PROC_END_USER_', 'PROC_END_USER_NAME_', 'PROC_END_DATE_', 'PROC_STATUS_' ],
			proxy : {
				url : 'selectMyToDoTask.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'taskList',
					totalProperty : 'total'
				}
			}
		});

		var taskPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'taskPanel',
			store : taskStore,
			title : '<spring:message code="todo" /><spring:message code="TASK" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="PROC.BIZ_NAME_" />',
				dataIndex : 'BIZ_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="PROC.BIZ_CODE_" />',
				dataIndex : 'BIZ_CODE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="PROC.BIZ_TYPE_" />',
				dataIndex : 'BIZ_TYPE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="NODE.NODE_NAME_" />',
				dataIndex : 'NODE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="PROC.PROC_START_USER_NAME_" />',
				dataIndex : 'PROC_START_USER_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="TASK.DUE_DATE_" />',
				dataIndex : 'DUE_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="TASK.TASK_STATUS_" />',
				dataIndex : 'TASK_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? TASK_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="TASK.FORWARD_STATUS_" />',
				dataIndex : 'FORWARD_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 112,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? FORWARD_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="TASK.CREATION_DATE_" />',
				dataIndex : 'CREATION_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
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
					text : '<spring:message code="refresh" />',
					icon : 'image/icon/refresh.png',
					handler : _selectTask
				}, {
					xtype : 'button',
					text : '<spring:message code="handle" />',
					icon : 'image/icon/update.png',
					handler : _preHandleTask
				}, {
					id : 'forwarding',
					xtype : 'checkboxfield',
					boxLabel : '可办',
					handler : _selectTask
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
								html : '<spring:message code="manage" /><spring:message code="TASK" /><br /><br /><spring:message code="help.manageTask" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : taskStore,
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
								if (dataIndex == 'MEMO_') {
									toolTip.update(view.getRecord(sender.triggerElement).get(dataIndex));
								} else {
									return false;
								}
							}
						}
					});
				},
				'itemdblclick' : function(view, record, item, index, e, eOpts) {
					_preHandleTask();
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
				items : [ taskPanel ]
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

		_selectTask();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectTask() {//查询主表数据
		var taskStore = Ext.data.StoreManager.lookup('taskStore');
		if (Ext.getCmp('forwarding').checked) {
			taskStore.proxy.extraParams['forwardStatusList'] = null;
		} else {
			taskStore.proxy.extraParams['forwardStatusList'] = '0,9';
		}

		taskStore.currentPage = 1;
		taskStore.load();
	}

	function _preHandleTask() {//办理
		var records = Ext.getCmp('taskPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="TASK" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="handle" /><spring:message code="TASK" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="' + records[0].get('ACTION_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						Ext.data.StoreManager.lookup('taskStore').remove(records[0]);//前台删除被删除数据

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}
</script>
</head>
<body>
</body>
</html>