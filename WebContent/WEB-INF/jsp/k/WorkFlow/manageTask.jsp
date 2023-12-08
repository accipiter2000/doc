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
<Style>
.selection-disabled .x-selmodel-column {
	visibility: hidden;
}
</Style>
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

		var TASK_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'TASK_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ],
			data : [ {}, {
				CODE_ : '1',
				NAME_ : '待办中'
			}, {
				CODE_ : '0',
				NAME_ : '挂起中'
			}, {
				CODE_ : '8',
				NAME_ : '异常结束'
			}, {
				CODE_ : '9',
				NAME_ : '正常结束'
			} ]
		});

		var NODE_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'NODE_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ],
			data : [ {}, {
				CODE_ : '1',
				NAME_ : '运行中'
			}, {
				CODE_ : '0',
				NAME_ : '挂起中'
			}, {
				CODE_ : '8',
				NAME_ : '异常结束'
			}, {
				CODE_ : '9',
				NAME_ : '正常结束'
			} ]
		});

		var PROC_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'PROC_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ],
			data : [ {}, {
				CODE_ : '1',
				NAME_ : '运行中'
			}, {
				CODE_ : '0',
				NAME_ : '挂起中'
			}, {
				CODE_ : '8',
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
			fields : [ 'TASK_ID_', 'NODE_ID_', 'PREVIOUS_TASK_ID_', 'TASK_TYPE_', 'ASSIGNEE_', 'ASSIGNEE_NAME_', 'EXECUTOR_', 'EXECUTOR_NAME_', 'ACTION_', 'CLAIM_DATE_', 'DUE_DATE_', 'COMPLETE_DATE_', 'PRIORITY_', 'FORWARD_STATUS_', 'TASK_STATUS_', 'CREATION_DATE_', 'PARENT_NODE_ID_', 'PROC_ID_', 'NODE_TYPE_', 'NODE_CODE_', 'NODE_NAME_', 'EXCLUSIVE_', 'NODE_END_USER_', 'NODE_END_USER_NAME_', 'NODE_END_DATE_', 'NODE_STATUS_', 'BIZ_ID_', 'BIZ_TYPE_', 'BIZ_CODE_', 'BIZ_NAME_', 'PROC_START_USER_', 'PROC_START_USER_NAME_', 'PROC_START_DATE_', 'PROC_END_USER_', 'PROC_END_USER_NAME_', 'PROC_END_DATE_', 'PROC_STATUS_' ],
			proxy : {
				url : 'selectTask.do',
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
			title : '<spring:message code="TASK" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SIMPLE',
				showHeaderCheckbox : false,
				listeners : {
					beforeselect : function(grid, record) {
						if (record.get('TASK_STATUS_') != '1') {
							return false;
						}
					}
				}
			},
			columns : [ {
				text : '<spring:message code="TASK.ASSIGNEE_" />',
				dataIndex : 'ASSIGNEE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 96
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
				text : '<spring:message code="TASK.CREATION_DATE_" />',
				dataIndex : 'CREATION_DATE_',
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
				text : '<spring:message code="NODE.NODE_STATUS_" />',
				dataIndex : 'NODE_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? NODE_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="PROC.BIZ_ID_" />',
				dataIndex : 'BIZ_ID_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="PROC.BIZ_TYPE_" />',
				dataIndex : 'BIZ_TYPE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="PROC.BIZ_CODE_" />',
				dataIndex : 'BIZ_CODE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="PROC.BIZ_NAME_" />',
				dataIndex : 'BIZ_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="PROC.PROC_STATUS_" />',
				dataIndex : 'PROC_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? PROC_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
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
					handler : _selectTask
				}, {
					xtype : 'button',
					text : '<spring:message code="update" /><spring:message code="TASK.ASSIGNEE_" />',
					icon : 'image/icon/update.png',
					handler : _updateAssignee
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
				id : 'taskFormPanel',
				xtype : 'form',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 360,
					margin : '4'
				},
				items : [ {
					xtype : 'hiddenfield',
					name : 'ASSIGNEE_',
					fieldLabel : '<spring:message code="TASK.ASSIGNEE_" />',
					maxLength : 40,
					allowBlank : false
				}, {
					xtype : 'textfield',
					name : 'ASSIGNEE_NAME_',
					fieldLabel : '<spring:message code="TASK.ASSIGNEE_" />',
					maxLength : 20
				}, {
					xtype : 'button',
					text : '<spring:message code="choose" /><spring:message code="TASK.ASSIGNEE_" />',
					width : null,
					handler : _chooseAssignee
				}, {
					xtype : 'combo',
					name : 'TASK_STATUS_LIST',
					store : TASK_STATUS_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="TASK.TASK_STATUS_" />'
				}, {
					xtype : 'textfield',
					name : 'BIZ_CODE_',
					fieldLabel : '<spring:message code="PROC.BIZ_CODE_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'BIZ_NAME_',
					fieldLabel : '<spring:message code="PROC.BIZ_NAME_" />',
					maxLength : 20
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
				enableTextSelection : true,
				getRowClass : function(record) {
					var classes = '';
					if (record.get('TASK_STATUS_') != '1') {
						classes += ' selection-disabled';
					}
					return classes;
				}
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
								if (dataIndex == 'BIZ_NAME_') {
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

		Ext.getCmp('taskFormPanel').getForm().findField('TASK_STATUS_LIST').setValue(1);

		_selectTask();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectTask() {//查询主表数据
		var taskStore = Ext.data.StoreManager.lookup('taskStore');
		var item;
		for (var i = 0; i < Ext.getCmp('taskFormPanel').items.length; i++) {
			item = Ext.getCmp('taskFormPanel').items.get(i);
			if (item.xtype != 'button') {
				taskStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
			}
		}
		taskStore.currentPage = 1;
		taskStore.load();
	}

	function _chooseAssignee() {
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="TASK.ASSIGNEE_" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmPosiEmp.do?ORGN_SET_ID_=' + orgnSet.ORGN_SET_ID_ + '&rootVisible=T&multipul=T" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var posiEmpList = returnValue;
						var posiEmp = posiEmpList[0];

						var form = Ext.getCmp('taskFormPanel').getForm();//设置初始值，初始验证。
						form.findField('ASSIGNEE_').setValue(posiEmp.POSI_EMP_ID_);
						form.findField('ASSIGNEE_NAME_').setValue(posiEmp.EMP_NAME_);
					}
				}
			}
		});
	}

	function _updateAssignee() {
		var records = Ext.getCmp('taskPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="TASK" />', Ext.MessageBox.WARNING);
			return;
		}

		var taskIdList = new Array();
		for (var i = 0; i < records.length; i++) {
			taskIdList.push(records[i].get('TASK_ID_'));
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="TASK.ASSIGNEE_" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmPosiEmp.do?ORGN_SET_ID_=' + orgnSet.ORGN_SET_ID_ + '&rootVisible=T&multipul=T" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var posiEmpList = returnValue;
						var posiEmp = posiEmpList[0];

						Ext.MessageBox.show({
							title : '<spring:message code="pleaseConfirm" />',
							msg : '<spring:message code="update" />',
							buttons : Ext.MessageBox.YESNO,
							icon : Ext.MessageBox.QUESTION,
							fn : function(btn) {
								if (btn == 'yes') {
									Ext.Ajax.request({
										url : 'updateAssignee.do',
										async : false,
										params : {
											'taskIdList' : taskIdList,
											'assignee' : posiEmp.POSI_EMP_ID_,
											'assigneeName' : posiEmp.EMP_NAME_
										},
										callback : function(options, success, response) {
											if (success) {
												var data = Ext.decode(response.responseText);
												if (data.success) {//更新页面数据
													for (var i = 0; i < records.length; i++) {
														records[i].set('ASSIGNEE_', posiEmp.POSI_EMP_ID_);
														records[i].set('ASSIGNEE_NAME_', posiEmp.EMP_NAME_);
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
				}
			}
		});
	}
</script>
</head>
<body>
</body>
</html>