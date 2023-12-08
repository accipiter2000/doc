<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="PROC" /></title>
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

		var procStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'procStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'PROC_ID_', 'PROC_DEF_ID_', 'ADJUST_PROC_DEF_ID_', 'BIZ_ID_', 'BIZ_TYPE_', 'BIZ_CODE_', 'BIZ_NAME_', 'PROC_START_USER_', 'PROC_START_USER_NAME_', 'PROC_START_DATE_', 'PROC_END_USER_', 'PROC_END_USER_NAME_', 'PROC_END_DATE_', 'PROC_STATUS_', 'CREATION_DATE_' ],
			proxy : {
				url : 'selectProc.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'procList',
					totalProperty : 'total'
				}
			}
		});

		var procPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'procPanel',
			store : procStore,
			title : '<spring:message code="PROC" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
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
				text : '<spring:message code="PROC.PROC_START_USER_NAME_" />',
				dataIndex : 'PROC_START_USER_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="PROC.PROC_START_DATE_" />',
				dataIndex : 'PROC_START_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="PROC.PROC_END_USER_NAME_" />',
				dataIndex : 'PROC_END_USER_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="PROC.PROC_END_DATE_" />',
				dataIndex : 'PROC_END_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="PROC.PROC_STATUS_" />',
				dataIndex : 'PROC_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? PROC_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="PROC.CREATION_DATE_" />',
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
					text : '<spring:message code="select" />',
					icon : 'image/icon/select.png',
					handler : _selectProc
				}, {
					xtype : 'button',
					text : '<spring:message code="manage" /><spring:message code="NODE" />',
					icon : 'image/icon/manage.png',
					handler : _manageNode
				}, {
					xtype : 'button',
					text : '<spring:message code="manage" /><spring:message code="APPROVAL_MEMO" />',
					icon : 'image/icon/manage.png',
					handler : _manageApprovalMemo
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
								html : '<spring:message code="manage" /><spring:message code="PROC" /><br /><br /><spring:message code="help.manageProc" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'procFormPanel',
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
					name : 'BIZ_TYPE_',
					fieldLabel : '<spring:message code="PROC.BIZ_TYPE_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'BIZ_CODE_',
					fieldLabel : '<spring:message code="PROC.BIZ_CODE_" />',
					maxLength : 100
				}, {
					xtype : 'textfield',
					name : 'BIZ_NAME_',
					fieldLabel : '<spring:message code="PROC.BIZ_NAME_" />',
					maxLength : 100
				}, {
					xtype : 'combo',
					name : 'PROC_STATUS_LIST',
					store : PROC_STATUS_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="PROC.PROC_STATUS_" />'
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : procStore,
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
				items : [ procPanel ]
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

		_selectProc();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectProc() {//查询主表数据
		var procStore = Ext.data.StoreManager.lookup('procStore');
		var item;
		for (var i = 0; i < Ext.getCmp('procFormPanel').items.length; i++) {
			item = Ext.getCmp('procFormPanel').items.get(i);
			procStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		procStore.currentPage = 1;
		procStore.load();
	}

	function _manageNode() {//查看
		var records = Ext.getCmp('procPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="PROC" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="manage" /><spring:message code="NODE" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="manageNode.do?PROC_ID_=' + records[0].get('PROC_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _manageApprovalMemo() {//查看
		var records = Ext.getCmp('procPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="PROC" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="manage" /><spring:message code="NODE" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="manageApprovalMemo.do?PROC_ID_=' + records[0].get('PROC_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}
</script>
</head>
<body>
</body>
</html>