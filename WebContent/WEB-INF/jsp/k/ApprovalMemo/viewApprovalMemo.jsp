<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="APPROVAL_MEMO" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	//获取url中的入参
	var PROC_ID_ = null;
	var hideButtonPanel = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.PROC_ID_ != undefined) ? PROC_ID_ = parameters.PROC_ID_ : 0;
		(parameters.hideButtonPanel != undefined) ? hideButtonPanel = parameters.hideButtonPanel : 0;
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

		var APPROVAL_MEMO_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'APPROVAL_MEMO_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var approvalMemoStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'approvalMemoStore',
			autoLoad : false,
			loading : false,
			root : {},//保证autoload有效
			pageSize : -1,
			fields : [ 'APPROVAL_MEMO_ID_', 'TASK_ID_', 'PREVIOUS_TASK_ID_', 'NODE_ID_', 'NODE_NAME_', 'PARENT_NODE_ID_', 'PROC_ID_', 'BIZ_ID_', 'ASSIGNEE_', 'ASSIGNEE_CODE_', 'ASSIGNEE_NAME_', 'EXECUTOR_', 'EXECUTOR_CODE_', 'EXECUTOR_NAME_', 'ORG_ID_', 'ORG_NAME_', 'COM_ID_', 'COM_NAME_', 'CREATION_DATE_', 'DUE_DATE_', 'APPROVAL_MEMO_TYPE_', 'APPROVAL_MEMO_', 'APPROVAL_DATE_', 'APPROVAL_MEMO_STATUS_' ],
			proxy : {
				url : 'selectApprovalMemo.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'PROC_ID_' : PROC_ID_,
					'APPROVAL_MEMO_STATUS_LIST' : '0,1,2,7,8'
				},
				reader : {
					type : 'json',
					root : 'children',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, node, records, successful, eOpts) {
					_expandApprovalMemo();
					//setTimeout('_expandApprovalMemo()', 200);//延迟展开树
				}
			}
		});

		var approvalMemoPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'approvalMemoPanel',
			store : approvalMemoStore,
			title : '<spring:message code="APPROVAL_MEMO" />',
			rootVisible : false,//根节点是否可见
			hideHeaders : false,//是否隐藏表头
			rowLines : false,//是否显示表格横线
			columnLines : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度 
			columns : [ {
				xtype : 'treecolumn',
				text : '<spring:message code="APPROVAL_MEMO.NODE_NAME_" />',
				dataIndex : 'NODE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			}, {
				text : '<spring:message code="APPROVAL_MEMO.ASSIGNEE_" />',
				dataIndex : 'ASSIGNEE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 64
			}, {
				text : '<spring:message code="APPROVAL_MEMO.EXECUTOR_" />',
				dataIndex : 'EXECUTOR_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80
			}, {
				text : '<spring:message code="APPROVAL_MEMO.ORG_NAME_" />',
				dataIndex : 'ORG_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="APPROVAL_MEMO.APPROVAL_MEMO_" />',
				dataIndex : 'APPROVAL_MEMO_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 2
			}, {
				text : '<spring:message code="APPROVAL_MEMO.APPROVAL_DATE_" />',
				dataIndex : 'APPROVAL_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="APPROVAL_MEMO.APPROVAL_MEMO_STATUS_" />',
				dataIndex : 'APPROVAL_MEMO_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? APPROVAL_MEMO_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			} ],
			dockedItems : [ {//所属按钮面板
				xtype : 'panel',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					margin : '2'
				},
				items : [ {
					xtype : 'button',
					text : '<spring:message code="close" />',
					icon : 'image/icon/close.png',
					hidden : (hideButtonPanel == 'true') ? true : false,
					handler : _close
				}, {
					xtype : 'checkboxfield',
					boxLabel : '隐藏驳回',
					listeners : {
						'change' : function(cmp, newValue, oldValue, eOpts) {
							_switchRejectHidden(newValue);
						}
					}
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
								html : '<spring:message code="view" /><spring:message code="DOC" /><br /><br /><spring:message code="help.viewDoc" />'
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
								if (dataIndex == 'APPROVAL_MEMO_' || dataIndex == 'NODE_NAME_' || dataIndex == 'ORG_NAME_') {
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
				items : [ approvalMemoPanel ]
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
		var APPROVAL_MEMO_STATUS_CodeStore = Ext.data.StoreManager.lookup('APPROVAL_MEMO_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^APPROVAL_MEMO_STATUS$'));
		APPROVAL_MEMO_STATUS_CodeStore.add(codeStore.getRange());
		APPROVAL_MEMO_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		_selectApprovalMemo();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectApprovalMemo() {//查询主表数据
		var approvalMemoStore = Ext.data.StoreManager.lookup('approvalMemoStore');
		approvalMemoStore.currentPage = 1;
		approvalMemoStore.load();
	}

	function _expandApprovalMemo() {
		Ext.data.StoreManager.lookup('approvalMemoStore').getRootNode().expand();
	}

	function _switchRejectHidden(hidden) {
		var approvalMemoStore = Ext.data.StoreManager.lookup('approvalMemoStore');

		if (hidden) {
			var reject = false;
			var rejectNodes = new Array();
			var childNodes = approvalMemoStore.getRoot().childNodes;

			for (var i = childNodes.length - 1; i >= 0; i--) {
				if (reject == false && childNodes[i].get('APPROVAL_MEMO_STATUS_') == '8') {
					reject = true;
				}
				if (reject) {
					rejectNodes.push(childNodes[i]);
				}
			}

			approvalMemoStore.filterBy(function(record, scope) {
				for (var i = 0; i < rejectNodes.length; i++) {
					if (rejectNodes[i] == record) {
						return false;
					}
				}
				return true;
			});
		} else {
			approvalMemoStore.clearFilter();
		}
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>