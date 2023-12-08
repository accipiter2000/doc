<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="NODE" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	var PROC_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.PROC_ID_ != undefined) ? PROC_ID_ = parameters.PROC_ID_ : 0;
	}

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

		var BOOLEAN_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'BOOLEAN_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
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

		var nodeStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'nodeStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'NODE_ID_', 'PARENT_NODE_ID_', 'PROC_ID_', 'PREVIOUS_NODE_IDS_', 'LAST_COMPLETE_NODE_IDS_', 'SUB_PROC_DEF_ID_', 'ADJUST_SUB_PROC_DEF_ID_', 'NODE_TYPE_', 'NODE_CODE_', 'NODE_NAME_', 'PARENT_NODE_CODE_', 'ASSIGNEE_', 'CANDIDATE_ASSIGNEE_', 'ACTION_', 'DUE_DATE_', 'COMPLETE_EXPRESSION_', 'COMPLETE_RETURN_', 'EXCLUSIVE_', 'AUTO_COMPLETE_SAME_ASSIGNEE_', 'AUTO_COMPLETE_EMPTY_ASSIGNEE_', 'PRIORITY_', 'NODE_END_USER_', 'NODE_END_USER_NAME_', 'NODE_END_DATE_', 'NODE_STATUS_', 'CREATION_DATE_' ],
			proxy : {
				url : 'selectNode.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'PROC_ID_' : PROC_ID_
				},
				reader : {
					type : 'json',
					root : 'nodeList',
					totalProperty : 'total'
				}
			}
		});

		var nodePanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'nodePanel',
			store : nodeStore,
			title : '<spring:message code="NODE" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="NODE.NODE_TYPE_" />',
				dataIndex : 'NODE_TYPE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 160
			}, {
				text : '<spring:message code="NODE.NODE_NAME_" />',
				dataIndex : 'NODE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="NODE.ASSIGNEE_" />',
				dataIndex : 'ASSIGNEE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="NODE.CANDIDATE_ASSIGNEE_" />',
				dataIndex : 'CANDIDATE_ASSIGNEE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="NODE.COMPLETE_EXPRESSION_" />',
				dataIndex : 'COMPLETE_EXPRESSION_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="NODE.COMPLETE_RETURN_" />',
				dataIndex : 'COMPLETE_RETURN_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 176,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? BOOLEAN_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="NODE.EXCLUSIVE_" />',
				dataIndex : 'EXCLUSIVE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 48,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? BOOLEAN_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="NODE.AUTO_COMPLETE_SAME_ASSIGNEE_" />',
				dataIndex : 'AUTO_COMPLETE_SAME_ASSIGNEE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 192,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? BOOLEAN_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="NODE.AUTO_COMPLETE_EMPTY_ASSIGNEE_" />',
				dataIndex : 'AUTO_COMPLETE_EMPTY_ASSIGNEE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 192,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? BOOLEAN_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
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
				text : '<spring:message code="NODE.CREATION_DATE_" />',
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
					text : '<spring:message code="adjust" /><spring:message code="PROC_DEF" />',
					icon : 'image/icon/update.png',
					handler : _preAdjustBranchProcDef
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
								html : '<spring:message code="manage" /><spring:message code="NODE" /><br /><br /><spring:message code="help.manageNode" />'
							});
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
								if (dataIndex == 'ASSIGNEE_' || dataIndex == 'CANDIDATE_ASSIGNEE_' || dataIndex == 'COMPLETE_EXPRESSION_') {
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
				items : [ nodePanel ]
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
		var BOOLEAN_CodeStore = Ext.data.StoreManager.lookup('BOOLEAN_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^BOOLEAN$'));
		BOOLEAN_CodeStore.add(codeStore.getRange());
		BOOLEAN_CodeStore.insert(0, {});
		codeStore.clearFilter();

		_selectNode();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectNode() {//查询主表数据
		var nodeStore = Ext.data.StoreManager.lookup('nodeStore');
		nodeStore.currentPage = 1;
		nodeStore.load();
	}

	function _preAdjustBranchProcDef() {
		var records = Ext.getCmp('nodePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="NODE" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="adjust" /><spring:message code="PROC_DEF" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preAdjustBranchProcDef.do?NODE_ID_=' + records[0].get('NODE_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>