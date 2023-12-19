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
<style>
.x-tree-icon-parent-expanded:before {
	content: '' !important;
}
</style>
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script type="text/javascript" src="js/pdf.js"></script>
<script type="text/javascript" src="js/pdf.worker.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	//获取url中的入参
	var DOC_ID_ = null;
	var TASK_ID_ = null;
	var rejectable = 'T';
	var fakeReject = 'F';
	var updatable = 'F';
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.DOC_ID_ != undefined) ? DOC_ID_ = parameters.DOC_ID_ : 0;
		(parameters.TASK_ID_ != undefined) ? TASK_ID_ = parameters.TASK_ID_ : 0;
		(parameters.rejectable != undefined) ? rejectable = parameters.rejectable : 'T';
		(parameters.fakeReject != undefined) ? fakeReject = parameters.fakeReject : 'F';
		(parameters.updatable != undefined) ? updatable = parameters.updatable : 'F';
	}

	var doc;
	var task;
	var nextRunningNodeDefList;
	var emptyAssignee;
	var approvalMemo;
	var orgnSet;
	var sessionId;

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'loadDoc.do',
			async : false,//同步加载
			params : {
				'DOC_ID_' : DOC_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						doc = data.doc;
					}
				}
			}
		});

		Ext.Ajax.request({//加载被修改对象
			url : 'loadTask.do',
			async : false,//同步加载
			params : {
				'TASK_ID_' : TASK_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						task = data.task;
					}
				}
			}
		});

		Ext.Ajax.request({//加载被修改对象
			url : 'loadLastApprovalMemoByTaskId.do',
			async : false,//同步加载
			params : {
				'TASK_ID_' : TASK_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						approvalMemo = data.approvalMemo;
					}
				}
			}
		});

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

		Ext.Ajax.request({//加载被修改对象
			url : 'getSessionId.do',
			async : false,//同步加载
			params : {},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						sessionId = data.sessionId;
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

		var BOOLEAN_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'BOOLEAN_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

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

		var indexStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'indexStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'PAGE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ],
			data : []
		});

		var customApprovalMemoStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'customApprovalMemoStore',
			autoLoad : true,//true为自动加载
			loading : true,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'CUSTOM_APPROVAL_MEMO_ID_', 'EMP_ID_', 'APPROVAL_MEMO_', 'DEFAULT_', 'ORDER_' ],
			proxy : {
				url : 'selectCustomApprovalMemo.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'customApprovalMemoList',
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

		var nextRunningNodeInfoStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'nextRunningNodeInfoStore',
			autoLoad : false,
			loading : false,
			root : {},
			pageSize : -1,
			fields : [ 'NODE_CODE_', 'NODE_NAME_', 'subProcPath', 'expression', 'candidate', 'subProcDef' ]
		});

		var docDataStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'docDataStore',
			autoLoad : true,//true为自动加载
			loading : true,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'DOC_DATA_ID_', 'DOC_ID_', 'BOOKMARK_', 'VALUE_' ],
			proxy : {
				url : 'selectDocData.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'DOC_ID_' : DOC_ID_
				},
				reader : {
					type : 'json',
					root : 'docDataList',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, records, successful, eOpts) {
					_init();//自动加载时必须调用
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
				text : '<spring:message code="approve" />',
				icon : 'image/icon/choose.png',
				handler : _approveTask
			}, {
				xtype : 'button',
				text : '<spring:message code="reject" />',
				icon : 'image/icon/close.png',
				hidden : (task.TASK_TYPE_ == 'FORWARD_TASK' || rejectable == 'F' || fakeReject == 'T') ? true : false,
				handler : _rejectTask
			}, {
				xtype : 'button',
				text : '<spring:message code="reject" />',
				icon : 'image/icon/close.png',
				hidden : (fakeReject == 'F') ? true : false,
				handler : _fakeRejectTask
			}, {
				xtype : 'button',
				text : '<spring:message code="forward" />',
				icon : 'image/icon/transferOut.png',
				hidden : (task.FORWARDABLE_ == '1') ? false : true,
				handler : _forward
			}, {
				xtype : 'button',
				text : '暂存审批意见',
				icon : 'image/icon/save.png',
				handler : _saveApprovalMemo
			}, {
				xtype : 'button',
				text : '<spring:message code="view" /><spring:message code="DOC.DOC_FILE_" />',
				icon : 'image/icon/view.png',
				handler : _viewDocFile
			}, {
				xtype : 'button',
				text : '<spring:message code="view" /><spring:message code="DOC_RIDER" />',
				icon : 'image/icon/view.png',
				handler : _viewDocRider
			}, {
				xtype : 'button',
				text : '<spring:message code="view" /><spring:message code="APPROVAL_MEMO" />',
				icon : 'image/icon/view.png',
				handler : _viewApprovalMemo
			}, {
				xtype : 'button',
				text : '<spring:message code="view" /><spring:message code="PROC_DIAGRAM" />',
				icon : 'image/icon/view.png',
				handler : _viewRunningProcDiagram
			}, {
				xtype : 'button',
				text : '选择其它分支',
				icon : 'image/icon/choose.png',
				hidden : task.NODE_TYPE_ != 'CENTER_FORWARD_TASK',
				handler : _preChooseCenterForwardStep
			}, {
				xtype : 'button',
				text : '<spring:message code="view" />版本差异',
				icon : 'image/icon/view.png',
				handler : _viewDocDiff
			}, {
				id : 'updateDocButton',
				xtype : 'button',
				text : '<spring:message code="update" /><spring:message code="DOC" />',
				icon : 'image/icon/update.png',
				hidden : true,
				handler : _preUpdateDoc
			}, {
				xtype : 'button',
				text : '<spring:message code="close" />',
				icon : 'image/icon/close.png',
				handler : _close
			}, {
				xtype : 'combo',
				store : indexStore,
				queryMode : 'local',
				valueField : 'PAGE_',
				displayField : 'NAME_',
				forceSelection : true,
				fieldLabel : '公文定位',
				style : 'position: absolute; right: 30px;',
				width : 200,
				listeners : {
					select : function(combo, records, eOpts) {
						_jumpToPage(combo.getValue());
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
							html : '<spring:message code="approve" /><spring:message code="DOC" /><br /><br /><spring:message code="help.approveDoc" />'
						});
					}
				}
			} ]
		});

		var approvalFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'approvalFormPanel',
			layout : 'column',
			border : false,
			scrollable : 'y',
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 680,
				margin : '4'
			},
			items : [ {
				xtype : 'hiddenfield',
				name : 'TASK_ID_',
				value : TASK_ID_
			}, {
				xtype : 'hiddenfield',
				name : 'CENTER_FORWARD_STEP'
			}, {
				xtype : 'combo',
				store : customApprovalMemoStore,
				queryMode : 'local',
				valueField : 'APPROVAL_MEMO_',
				displayField : 'APPROVAL_MEMO_',
				forceSelection : true,
				fieldLabel : '<spring:message code="CUSTOM_APPROVAL_MEMO" />',
				style : 'clear: left',
				listeners : {
					select : function(combo, records, eOpts) {
						approvalFormPanel.getForm().findField('APPROVAL_MEMO_').setValue(combo.getValue());
					}
				}
			}, {
				xtype : 'textareafield',
				name : 'APPROVAL_MEMO_',
				fieldLabel : '<spring:message code="APPROVAL_MEMO.APPROVAL_MEMO_" />',
				height : 90,
				allowBlank : false
			} ]
		});

		var nextRunningNodeInfoPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'nextRunningNodeInfoPanel',
			store : nextRunningNodeInfoStore,
			rootVisible : false,//根节点是否可见
			hideHeaders : true,
			rowLines : false,//是否显示表格横线
			columnLines : false,//是否显示表格竖线
			border : false,
			animate : false,//取消动画，加快显示速度
			columns : [ {
				xtype : 'treecolumn',
				text : '<spring:message code="NODE_NAME_" />',
				dataIndex : 'NODE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			}, {
				text : '<spring:message code="ASSIGNEE_" />',
				dataIndex : 'expression',
				cellWrap : true,
				style : 'text-align: center; font-weight: bold;',
				flex : 3
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
			},
			listeners : {
				'checkchange' : function(node, checked, eOpts) {
					_toggleSubProcDefChoosable(node, checked);
				}
			}
		});

		var topPanel = Ext.create('Ext.Panel', {
			id : 'topPanel',
			layout : 'border',
			defaults : {
				border : false
			},
			items : [ {
				region : 'north',
				items : [ buttonPanel ]
			}, {
				region : 'west',
				layout : 'fit',
				width : 720,
				items : [ approvalFormPanel ]
			}, {
				region : 'center',
				layout : 'fit',
				items : [ nextRunningNodeInfoPanel ]
			} ]
		});

		var pdfPanel = Ext.create('Ext.Panel', {
			id : 'pdfPanel',
			frame : true,
			autoScroll : true,
			dockedItems : [ {
				xtype : 'panel',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					margin : '2'
				},
				items : [ {
					xtype : 'button',
					text : '<spring:message code="switch" />',
					icon : 'image/icon/refresh.png',
					handler : _switch
				} ],
				dock : 'top',
			} ]
		});

		var docDataPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'docDataPanel',
			store : docDataStore,
			headerBorders : false,//是否显示表格竖线 
			hidden : true,
			columns : [ {
				text : '<spring:message code="DOC_DATA.BOOKMARK_" />',
				dataIndex : 'BOOKMARK_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DOC_DATA.VALUE_" />',
				dataIndex : 'VALUE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 2
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
					text : '<spring:message code="switch" />',
					icon : 'image/icon/refresh.png',
					handler : _switch
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
								if (dataIndex == 'DOC_DATA_') {
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

		var docFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'docFormPanel',
			title : '公文基本信息',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 360,
				margin : '4',
				readOnly : true
			},
			items : [ {
				xtype : 'fieldset',
				title : '<spring:message code="DOC_TYPE" />',
				layout : 'column',
				width : '99%',
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 360,
					margin : '4'
				},
				items : [ {
					xtype : 'textfield',
					name : 'DOC_TYPE_NAME_',
					fieldLabel : '<spring:message code="DOC.DOC_TYPE_NAME_" />',
					editable : false,
					allowBlank : false
				} ]
			}, {
				id : 'basicDocInfo',
				xtype : 'fieldset',
				title : '公文基本信息',
				layout : 'column',
				width : '99%',
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 360,
					margin : '4',
					readOnly : true
				},
				items : [ {
					xtype : 'textfield',
					name : 'DOC_CODE_',
					fieldLabel : '<spring:message code="DOC.DOC_CODE_" />',
					maxLength : 20,
					allowBlank : true
				}, {
					xtype : 'textfield',
					name : 'DOC_NAME_',
					fieldLabel : '<spring:message code="DOC.DOC_NAME_" />',
					maxLength : 20,
					allowBlank : false
				}, {
					xtype : 'textfield',
					name : 'OWNER_NAME_',
					fieldLabel : '<spring:message code="DOC.OWNER_NAME_" />',
					maxLength : 20,
					allowBlank : false
				}, {
					xtype : 'textfield',
					name : 'OWNER_ORG_NAME_',
					fieldLabel : '<spring:message code="DOC.OWNER_ORG_NAME_" />',
					maxLength : 20,
					allowBlank : false
				}, {
					xtype : 'textfield',
					name : 'MEMO_',
					fieldLabel : '<spring:message code="DOC.MEMO_" />',
					maxLength : 20,
					allowBlank : false
				}, {
					xtype : 'combo',
					name : 'USING_TEMPLATE_',
					store : BOOLEAN_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="DOC.USING_TEMPLATE_" />'
				}, {
					xtype : 'textfield',
					name : 'VERSION_',
					fieldLabel : '<spring:message code="DOC.VERSION_" />',
					maxLength : 20,
					allowBlank : false
				}, {
					xtype : 'textfield',
					name : 'CREATION_DATE_',
					fieldLabel : '<spring:message code="DOC.CREATION_DATE_" />',
					maxLength : 20,
					allowBlank : false
				} ]
			} ]
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
				layout : 'fit',//充满
				height : 200,
				items : [ topPanel ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ pdfPanel, docDataPanel ]
			}, {
				region : 'west',
				layout : 'fit',//充满
				width : 800,
				items : [ docFormPanel ]
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

		if (approvalMemo != null) {
			Ext.getCmp('approvalFormPanel').getForm().findField("APPROVAL_MEMO_").setValue(approvalMemo.APPROVAL_MEMO_);
		}
		if (Ext.getCmp('approvalFormPanel').getForm().findField("APPROVAL_MEMO_").getValue() == null || Ext.getCmp('approvalFormPanel').getForm().findField("APPROVAL_MEMO_").getValue() == '') {
			var customApprovalMemoStore = Ext.data.StoreManager.lookup('customApprovalMemoStore');
			var customApprovalMemo;
			for (var i = 0; i < customApprovalMemoStore.getCount(); i++) {
				customApprovalMemo = customApprovalMemoStore.getAt(i);
				if (customApprovalMemo.get('DEFAULT_') == '1') {
					Ext.getCmp('approvalFormPanel').getForm().findField("APPROVAL_MEMO_").setValue(customApprovalMemo.get('APPROVAL_MEMO_'));
					break;
				}
			}
		}

		_loadPdfDocFile();

		var nextRunningNodeInfoStore = Ext.data.StoreManager.lookup('nextRunningNodeInfoStore');//组装子代码数据，过滤注入。
		var rootNode = nextRunningNodeInfoStore.getRoot();
		rootNode.appendChild({
			'NODE_NAME_' : '<spring:message code="current" /><spring:message code="NODE" />',
			'expression' : task.NODE_NAME_
		});
		rootNode.appendChild({
			'NODE_NAME_' : '<spring:message code="next" /><spring:message code="NODE" />'
		});

		_updateNextRunningNodeInfoPanel();

		var form = Ext.getCmp('docFormPanel').getForm();//设置初始值，初始验证。
		for ( var key in doc) {
			(form.findField(key) != null) ? form.findField(key).setValue(doc[key]) : 0;
		}

		Ext.getCmp('approvalFormPanel').getForm().isValid();

		if (updatable == 'T') {
			Ext.getCmp('updateDocButton').setHidden(false);
		}

		Ext.data.StoreManager.lookup('indexStore').setData(eval(doc.INDEX_));

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _updateNextRunningNodeInfoPanel() {
		var params;
		var CENTER_FORWARD_STEP = Ext.getCmp('approvalFormPanel').getForm().findField('CENTER_FORWARD_STEP').getSubmitValue();
		if (CENTER_FORWARD_STEP == null || CENTER_FORWARD_STEP == '') {
			var params = {
				'TASK_ID_' : TASK_ID_
			};
		} else {
			var params = {
				'TASK_ID_' : TASK_ID_,
				'CENTER_FORWARD_STEP' : CENTER_FORWARD_STEP
			};
		}

		Ext.Ajax.request({//加载被修改对象
			url : 'getNextRunningNodeDefList.do',
			async : false,//同步加载
			params : params,
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						nextRunningNodeDefList = data.nextRunningNodeDefList;
						var nextRunningNodeInfoStore = Ext.data.StoreManager.lookup('nextRunningNodeInfoStore');//组装子代码数据，过滤注入。
						var node = nextRunningNodeInfoStore.getRoot().childNodes[1];
						node.removeAll();
						emptyAssignee = false;

						if (nextRunningNodeDefList.length == 0) {
							node.appendChild({
								'NODE_NAME_' : '<spring:message code="none" />'
							});
						} else {
							_buildNextRunningNodeInfoPanel(node, nextRunningNodeDefList);
						}

						Ext.getCmp('nextRunningNodeInfoPanel').expandAll();

						//默认子流程定义未被选择时，其下的候选人设置为disable状态
						var nodes = Ext.data.StoreManager.lookup('nextRunningNodeInfoStore').getData();//组装子代码数据，过滤注入。
						var node;
						for (var i = 0; i < nodes.getCount(); i++) {
							node = nodes.getAt(i);
							if (node.get('candidate') && node.get('subProcDef') && !node.get('checked'))
								_toggleSubProcDefChoosable(node, false);
						}
					}
				}
			}
		});
	}

	//构建候选树形表现
	function _buildNextRunningNodeInfoPanel(node, nextRunningNodeDefList) {
		for (var i = 0; i < nextRunningNodeDefList.length; i++) {
			if (nextRunningNodeDefList[i].candidateAssigneeList != null) {//候选人，显示为checkbox列表，单行，
				if (nextRunningNodeDefList[i].candidateAssigneeList.length == 0 && nextRunningNodeDefList[i].autoCompleteEmptyAssignee != '1') {//未配置候选人，且节点的自动完成空办理人的属性不为1，设置空办理人为true
					emptyAssignee = true;
				}

				var candidateAssignee = '';
				for (var j = 0; j < nextRunningNodeDefList[i].candidateAssigneeList.length; j++) {
					if (nextRunningNodeDefList[i].candidateAssigneeList.length == 1) {
						candidateAssignee = candidateAssignee + '<input type="checkbox" data-subprocpath="' + nextRunningNodeDefList[i].subProcPath + '" data-nodecode="' + nextRunningNodeDefList[i].nodeCode + '" value = "' + nextRunningNodeDefList[i].candidateAssigneeList[j].id + '" checked>' + nextRunningNodeDefList[i].candidateAssigneeList[j].userName + '</input>';
					} else {
						candidateAssignee = candidateAssignee + '<input type="checkbox" data-subprocpath="' + nextRunningNodeDefList[i].subProcPath + '" data-nodecode="' + nextRunningNodeDefList[i].nodeCode + '" value = "' + nextRunningNodeDefList[i].candidateAssigneeList[j].id + '">' + nextRunningNodeDefList[i].candidateAssigneeList[j].userName + '</input>';
					}
				}

				node.appendChild({
					'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
					'NODE_NAME_' : nextRunningNodeDefList[i].nodeName,
					'expression' : candidateAssignee,
					'candidate' : true
				});
			}
			if (nextRunningNodeDefList[i].candidateSubProcDefList != null) {//候选子流程，显示为树形结构，每个候选子流程定义为一个带checkbox的节点。
				if (nextRunningNodeDefList[i].candidateSubProcDefList.length == 0) {//未配置候选子流程定义，设置空办理人为true
					emptyAssignee = true;
				}

				var nextNode = node.appendChild({//该候选子流程定义所在的节点
					'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
					'NODE_NAME_' : nextRunningNodeDefList[i].nodeName,
					'subProcDef' : true
				});

				for (var j = 0; j < nextRunningNodeDefList[i].candidateSubProcDefList.length; j++) {//候选子流程定义
					var subProcDefNode = nextNode.appendChild({
						'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
						'NODE_NAME_' : nextRunningNodeDefList[i].candidateSubProcDefList[j].procDefName,
						'subProcPath' : nextRunningNodeDefList[i].subProcPath,
						'expression' : nextRunningNodeDefList[i].candidateSubProcDefList[j].procDefCode,
						'subProcDef' : true,
						'candidate' : true,
						'checked' : nextRunningNodeDefList[i].candidateSubProcDefList.length == 1 ? true : false
					});

					_buildNextRunningNodeInfoPanel(subProcDefNode, nextRunningNodeDefList[i].candidateSubProcDefList[j].nextRunningNodeDefList);//级联处理嵌套的子流程定义
				}
			}
			if (nextRunningNodeDefList[i].assigneeList != null) {//办理人
				if (nextRunningNodeDefList[i].assigneeList.length == 0 && nextRunningNodeDefList[i].autoCompleteEmptyAssignee != '1') {//未配置办理人，且节点的自动完成空办理人的属性不为1，设置空办理人为true
					emptyAssignee = true;
				}

				var assignee = '';
				for (var j = 0; j < nextRunningNodeDefList[i].assigneeList.length; j++) {
					assignee += nextRunningNodeDefList[i].assigneeList[j].userName + ' ';
				}

				node.appendChild({
					'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
					'NODE_NAME_' : nextRunningNodeDefList[i].nodeName,
					'expression' : assignee
				});
			}
			if (nextRunningNodeDefList[i].assignSubProcDefList != null) {//办理子流程定义
				if (nextRunningNodeDefList[i].assignSubProcDefList.length == 0) {//未配置办理子流程定义，设置空办理人为true
					emptyAssignee = true;
				}

				var nextNode = node.appendChild({//该子流程定义所在的节点
					'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
					'NODE_NAME_' : nextRunningNodeDefList[i].nodeName,
					'subProcDef' : true
				});

				for (var j = 0; j < nextRunningNodeDefList[i].assignSubProcDefList.length; j++) {//子流程定义
					var subProcDefNode = nextNode.appendChild({
						'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
						'NODE_NAME_' : nextRunningNodeDefList[i].assignSubProcDefList[j].procDefName,
						'subProcPath' : nextRunningNodeDefList[i].subProcPath,
						'expression' : nextRunningNodeDefList[i].assignSubProcDefList[j].procDefCode,
						'subProcDef' : true
					});

					_buildNextRunningNodeInfoPanel(subProcDefNode, nextRunningNodeDefList[i].assignSubProcDefList[j].nextRunningNodeDefList);//级联处理嵌套的子流程定义
				}
			}
		}
	}

	//切换子流程定义下的候选人disable状态。
	function _toggleSubProcDefChoosable(node, checked) {
		var checkboxes = Ext.getCmp('nextRunningNodeInfoPanel').getEl().select('input').elements;
		var subProcPath = node.data.subProcPath;
		if (subProcPath == null || subProcPath == '') {
			subProcPath = node.data.NODE_CODE_ + ':' + node.data.expression;
		} else {
			subProcPath = subProcPath + '.' + node.data.NODE_CODE_ + ':' + node.data.expression;
		}
		for (var i = 0; i < checkboxes.length; i++) {
			if (checkboxes[i].dataset.subprocpath == subProcPath) {
				if (checked) {
					checkboxes[i].disabled = false;
				} else {
					checkboxes[i].disabled = true;
				}
			}
		}
	}

	function _loadPdfDocFile() {
		var pdfPanelRenderTargetId = Ext.getCmp('pdfPanel').getLayout().getRenderTarget().id;
		var pdfPanel = document.getElementById(pdfPanelRenderTargetId);
		pdfPanel.innerHTML = '';

		var pdfUrl = 'loadPdfDocFile.do?DOC_ID_=' + DOC_ID_;
		PDFJS.getDocument(pdfUrl).then(function getPdf(pdf) {
			for (var i = 0; i < pdf.numPages; i++) {
				_renderPage(pdf, i + 1);
			}
		});
	}

	function _renderPage(pdf, number) {
		pdf.getPage(number).then(function(page) {
			var scale = 1.5;
			var viewport = page.getViewport(scale);
			var canvas = document.createElement('canvas');
			var context = canvas.getContext('2d');
			canvas.id = 'canvas' + number;
			canvas.height = viewport.height;
			canvas.width = viewport.width;
			var pdfPanelRenderTargetId = Ext.getCmp('pdfPanel').getLayout().getRenderTarget().id;
			document.getElementById(pdfPanelRenderTargetId).appendChild(canvas);
			page.render({
				canvasContext : context,
				viewport : viewport
			});
		});
	}

	function _jumpToPage(page) {
		document.getElementById("canvas" + page).scrollIntoView();
	}

	function _approveTask() {
		var form = Ext.getCmp('approvalFormPanel').getForm();
		if (form.findField('APPROVAL_MEMO_').getValue() == '') {
			Ext.MessageBox.alert('<spring:message code="error" />', '请填写审批意见！', Ext.MessageBox.ERROR);
			return;
		}

		if (emptyAssignee) {
			Ext.MessageBox.alert('<spring:message code="error" />', '下一步审批未配置人员，请联系管理员', Ext.MessageBox.ERROR);
			return;
		}

		var candidateList = _buildCandidateList();//构建候选数据

		//有候选但一个都未选，错误提示。
		if (!candidateList) {
			Ext.MessageBox.alert('<spring:message code="error" />', '请选择下一步审批人或子流程！', Ext.MessageBox.ERROR);
			return;
		}

		Ext.Ajax.request({//加载被修改对象
			url : 'completeDocTask.do',
			async : false,//同步加载
			params : {
				'TASK_ID_' : TASK_ID_,
				'CENTER_FORWARD_STEP' : form.findField('CENTER_FORWARD_STEP').getSubmitValue(),
				'APPROVAL_MEMO_' : form.findField('APPROVAL_MEMO_').getSubmitValue(),
				'CANDIDATE_LIST' : JSON.stringify(candidateList)
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						parent.returnValue = true;

						var msg = '<spring:message code="success" />!';
						if (data.completeProc) {
							msg = msg + ' 流程办结！';
						} else if (data.nextAssigneeNameList != '[]') {
							msg = msg + ' 下一步审批人是 ' + data.nextAssigneeNameList;
						}
						Ext.MessageBox.show({
							title : '<spring:message code="info" />',
							msg : msg,
							buttons : Ext.MessageBox.OK,
							icon : Ext.MessageBox.INFO,
							fn : function(btn) {
								_close();
							}
						});
					}
				}
			}
		});
	}

	function _buildCandidateList() {
		var checkboxes = Ext.getCmp('nextRunningNodeInfoPanel').getEl().select('input').elements;
		var candidateList = new Array();

		//候选人，从checkbox input中获取。
		for (var i = 0; i < checkboxes.length; i++) {
			if (checkboxes[i].disabled) {
				continue;
			}

			var candidate = null;
			candidateList.forEach(function(item, index, arr) {
				if (item['subProcPath'] == checkboxes[i].dataset.subprocpath && item['nodeCode'] == checkboxes[i].dataset.nodecode) {
					candidate = item;
				}
			});
			if (candidate == null) {
				candidate = new Object();
				candidate['subProcPath'] = checkboxes[i].dataset.subprocpath;
				candidate['nodeCode'] = checkboxes[i].dataset.nodecode;
				candidateList.push(candidate);
			}

			if (checkboxes[i].checked && !checkboxes[i].disabled) {
				if (candidate['candidateExpression'] == null) {
					candidate['candidateExpression'] = checkboxes[i].value;
				} else {
					candidate['candidateExpression'] = candidate['candidateExpression'] + ',' + checkboxes[i].value;
				}
			}
		}

		//候选子流程，从datastore中获取。
		var nodes = Ext.data.StoreManager.lookup('nextRunningNodeInfoStore').getData();//组装子代码数据，过滤注入。
		var node;
		for (var i = 0; i < nodes.getCount(); i++) {
			node = nodes.getAt(i);
			if (node.get('checked') == null) {
				continue;
			}

			var candidate = null;
			candidateList.forEach(function(item, index, arr) {
				if (item['subProcPath'] == node.get('subProcPath') && item['nodeCode'] == node.get('NODE_CODE_')) {
					candidate = item;
				}
			});
			if (candidate == null) {
				candidate = new Object();
				candidate['subProcPath'] = node.get('subProcPath');
				candidate['nodeCode'] = node.get('NODE_CODE_');
				candidateList.push(candidate);
			}

			if (node.get('checked')) {
				if (candidate['candidateExpression'] == null) {
					candidate['candidateExpression'] = node.get('expression');
				} else {
					candidate['candidateExpression'] = candidate['candidateExpression'] + ',' + node.get('expression');
				}
			}
		}

		//有候选人但一个都未选，提示异常。
		for (var i = 0; i < candidateList.length; i++) {
			if (candidateList[i]['candidateExpression'] == null) {
				return false;
			}
		}

		return candidateList;
	}

	function _rejectTask() {//驳回
		var form = Ext.getCmp('approvalFormPanel').getForm();
		if (form.findField('APPROVAL_MEMO_').getValue() == '') {
			Ext.MessageBox.alert('<spring:message code="error" />', '请填写审批意见！', Ext.MessageBox.ERROR);
			return;
		}

		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="reject" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.getCmp('approvalFormPanel').getForm().submit({//提交表单
						url : 'rejectDocTask.do',
						submitEmptyText : false,
						waitMsg : '<spring:message code="processing" />',
						success : function(form, action) {
							parent.returnValue = true;

							Ext.MessageBox.show({
								title : '<spring:message code="info" />',
								msg : '<spring:message code="success" />! 任务已回到起草人',
								buttons : Ext.MessageBox.OK,
								icon : Ext.MessageBox.INFO,
								fn : function(btn) {
									_close();
								}
							});
						},
						failure : function(form, action) {
							switch (action.failureType) {
								case Ext.form.action.Action.CLIENT_INVALID:
									Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.inputRequired" />', Ext.MessageBox.ERROR);
									break;
								case Ext.form.action.Action.SERVER_INVALID:
									Ext.MessageBox.alert('<spring:message code="error" />', action.result.message, Ext.MessageBox.ERROR);
									break;
								case Ext.form.action.Action.CONNECT_FAILURE:
									Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
							}
						}
					});
				}
			}
		});
	}

	function _fakeRejectTask() {//假驳回，操作仍为同意
		var form = Ext.getCmp('approvalFormPanel').getForm();
		if (form.findField('APPROVAL_MEMO_').getValue() == '') {
			Ext.MessageBox.alert('<spring:message code="error" />', '请填写审批意见！', Ext.MessageBox.ERROR);
			return;
		}

		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="reject" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.getCmp('approvalFormPanel').getForm().submit({//提交表单
						url : 'fakeRejectDocTask.do',
						submitEmptyText : false,
						waitMsg : '<spring:message code="processing" />',
						success : function(form, action) {
							parent.returnValue = true;

							Ext.MessageBox.show({
								title : '<spring:message code="info" />',
								msg : '<spring:message code="success" />',
								buttons : Ext.MessageBox.OK,
								icon : Ext.MessageBox.INFO,
								fn : function(btn) {
									_close();
								}
							});
						},
						failure : function(form, action) {
							switch (action.failureType) {
								case Ext.form.action.Action.CLIENT_INVALID:
									Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.inputRequired" />', Ext.MessageBox.ERROR);
									break;
								case Ext.form.action.Action.SERVER_INVALID:
									Ext.MessageBox.alert('<spring:message code="error" />', action.result.message, Ext.MessageBox.ERROR);
									break;
								case Ext.form.action.Action.CONNECT_FAILURE:
									Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
							}
						}
					});
				}
			}
		});
	}

	function _forward() {//内部流转
		var form = Ext.getCmp('approvalFormPanel').getForm();
		if (form.findField('APPROVAL_MEMO_').getValue() == '') {
			Ext.MessageBox.alert('<spring:message code="error" />', '请填写审批意见！', Ext.MessageBox.ERROR);
			return;
		}

		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="EMP" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmPosiEmp.do?ORG_ID_=' + Ext.util.Cookies.get('COM_ID_') + '&ORGN_SET_ID_=' + orgnSet.ORGN_SET_ID_ + '&rootVisible=T&multipul=T" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var posiEmpList = returnValue;

						var assigneeList = new Array();
						var assigneeNameList = new Array();
						for (var i = 0; i < posiEmpList.length; i++) {
							assigneeList.push(posiEmpList[i].POSI_EMP_ID_);
							assigneeNameList.push(posiEmpList[i].EMP_NAME_);
						}
						var form = Ext.getCmp('approvalFormPanel').getForm();//设置初始值，初始验证。
						Ext.Ajax.request({
							url : 'forwardDocTask.do',
							async : false,
							params : {
								'TASK_ID_' : TASK_ID_,
								'assigneeList' : assigneeList,
								'APPROVAL_MEMO_' : form.findField('APPROVAL_MEMO_').getValue()
							},
							callback : function(options, success, response) {
								if (success) {
									var data = Ext.decode(response.responseText);
									if (data.success) {//更新页面数据
										parent.returnValue = true;

										Ext.MessageBox.show({
											title : '<spring:message code="info" />',
											msg : '<spring:message code="success" />! 任务已转发给' + assigneeNameList,
											buttons : Ext.MessageBox.OK,
											icon : Ext.MessageBox.INFO,
											fn : function(btn) {
												_close();
											}
										});
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
			}
		});
	}

	function _saveApprovalMemo() {//查看
		Ext.Ajax.request({
			url : 'saveApprovalMemo.do',
			async : false,
			params : {
				'TASK_ID_' : TASK_ID_,
				'APPROVAL_MEMO_' : Ext.getCmp('approvalFormPanel').getForm().findField("APPROVAL_MEMO_").getValue()
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

	function _viewDocFile() {//查看
		var url = 'office://word$open$' + document.getElementById('base').href + 'loadDocFile.do;jsessionid=' + sessionId + '?DOC_ID_=' + DOC_ID_
		window.open(url);
	}

	function _viewDocRider() {
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="DOC_RIDER" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewDocRider.do?DOC_ID_=' + DOC_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _viewApprovalMemo() {//查看
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="APPROVAL_MEMO" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 1200,
			height : '80%',
			html : '<iframe src="viewApprovalMemo.do?PROC_ID_=' + task.PROC_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _preChooseCenterForwardStep() {
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '选择其它分支',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseCenterForwardStep.do?PROC_ID_=' + task.PROC_ID_ + '&TASK_ID_=' + task.TASK_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						Ext.getCmp('approvalFormPanel').getForm().findField("CENTER_FORWARD_STEP").setValue(returnValue);
						_updateNextRunningNodeInfoPanel();
					}
				}
			}
		});
	}

	function _viewRunningProcDiagram() {//查看
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="PROC_DIAGRAM" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 1000,
			height : '80%',
			html : '<iframe src="viewRunningProcDiagram.do?PROC_ID_=' + task.PROC_ID_ + '&TASK_ID_=' + task.TASK_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _viewDocDiff() {//查看
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" />版本差异',
			modal : false,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 1000,
			height : '80%',
			html : '<iframe src="viewDocDiff.do?DOC_ID_=' + task.BIZ_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _preUpdateDoc() {//修改
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="DOC" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="compileDoc.do?DOC_ID_=' + DOC_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						doc = returnValue;

						var form = Ext.getCmp('docFormPanel').getForm();//设置初始值，初始验证。
						for ( var key in doc) {
							(form.findField(key) != null) ? form.findField(key).setValue(doc[key]) : 0;
						}

						Ext.data.StoreManager.lookup('docDataStore').reload();

						_loadPdfDocFile();

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _switch() {
		var pdfPanel = Ext.getCmp('pdfPanel');
		var docDataPanel = Ext.getCmp('docDataPanel');
		if (pdfPanel.isHidden()) {
			pdfPanel.setHidden(false);
			docDataPanel.setHidden(true);
		} else {
			pdfPanel.setHidden(true);
			docDataPanel.setHidden(false);
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