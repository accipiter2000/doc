<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="DOC" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	var emptyAssignee;
	var sessionId;

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

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

		var PROC_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'PROC_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var DOC_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'DOC_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var docStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'docStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'DOC_ID_', 'DOC_CODE_', 'DOC_NAME_', 'DOC_TYPE_NAME_', 'OWNER_ID_', 'OWNER_NAME_', 'OWNER_ORG_ID_', 'OWNER_ORG_NAME_', 'MEMO_', 'TEMPLATE_FILE_', 'TEMPLATE_FILE_NAME_', 'TEMPLATE_FILE_LENGTH_', 'DOC_FILE_', 'DOC_FILE_NAME_', 'DOC_FILE_LENGTH_', 'HTML_', 'BOOKMARK_', 'INDEX_', 'USING_TEMPLATE_', 'PROC_DEF_CODE_', 'PROC_ID_', 'PROC_STATUS_', 'VERSION_', 'DOC_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'EFFECTIVE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectMyAdminDoc.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'myAdminDocList',
					totalProperty : 'total'
				}
			}
		});

		var nextRunningNodeInfoStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'nextRunningNodeInfoStore',
			autoLoad : false,
			loading : false,
			root : {
				'NODE_NAME_' : '<spring:message code="next" /><spring:message code="NODE" />'
			},
			pageSize : -1,
			fields : [ 'NODE_CODE_', 'NODE_NAME_', 'subProcPath', 'expression', 'candidate', 'subProcDef' ]
		});

		var docPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'docPanel',
			store : docStore,
			title : '我管理的公文',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="DOC.DOC_CODE_" />',
				dataIndex : 'DOC_CODE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80
			}, {
				text : '<spring:message code="DOC.DOC_NAME_" />',
				dataIndex : 'DOC_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80
			}, {
				text : '<spring:message code="DOC.DOC_TYPE_NAME_" />',
				dataIndex : 'DOC_TYPE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 112
			}, {
				text : '<spring:message code="DOC.OWNER_NAME_" />',
				dataIndex : 'OWNER_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 96
			}, {
				text : '<spring:message code="DOC.OWNER_ORG_NAME_" />',
				dataIndex : 'OWNER_ORG_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 112
			}, {
				text : '<spring:message code="DOC.DOC_FILE_" />',
				dataIndex : 'DOC_FILE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null) ? '<a href=javascript:_loadDocFile(\'' + record.data.DOC_ID_ + '\')>' + value + '</a>' : '';
				}
			}, {
				text : '<spring:message code="DOC.USING_TEMPLATE_" />',
				dataIndex : 'USING_TEMPLATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 144,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? BOOLEAN_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="DOC.PROC_DEF_CODE_" />',
				dataIndex : 'PROC_DEF_CODE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 112
			}, {
				text : '<spring:message code="DOC.PROC_STATUS_" />',
				dataIndex : 'PROC_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? PROC_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="DOC.VERSION_" />',
				dataIndex : 'VERSION_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="DOC.DOC_STATUS_" />',
				dataIndex : 'DOC_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? DOC_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="DOC.CREATION_DATE_" />',
				dataIndex : 'CREATION_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="DOC.EFFECTIVE_DATE_" />',
				dataIndex : 'EFFECTIVE_DATE_',
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
					handler : _selectDoc
				}, {
					xtype : 'button',
					text : '<spring:message code="compile" /><spring:message code="new" /><spring:message code="DOC" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertDoc
				}, {
					id : 'update',
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateDoc
				}, {
					id : 'approval',
					xtype : 'button',
					text : '<spring:message code="submitForApproval" />',
					icon : 'image/icon/transferOut.png',
					handler : _submitForApproval
				}, {
					id : 'delete',
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteDoc
				}, {
					xtype : 'button',
					text : '<spring:message code="view" />',
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
								html : '<spring:message code="manage" /><spring:message code="DOC" /><br /><br /><spring:message code="help.manageDoc" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'docFormPanel',
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
					name : 'DOC_CODE_',
					fieldLabel : '<spring:message code="DOC.DOC_CODE_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'DOC_NAME_',
					fieldLabel : '<spring:message code="DOC.DOC_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'DOC_TYPE_NAME_',
					fieldLabel : '<spring:message code="DOC.DOC_TYPE_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'OWNER_NAME_',
					fieldLabel : '<spring:message code="DOC.OWNER_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'OWNER_ORG_NAME_',
					fieldLabel : '<spring:message code="DOC.OWNER_ORG_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'combo',
					name : 'USING_TEMPLATE_LIST',
					store : BOOLEAN_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="DOC.USING_TEMPLATE_" />'
				}, {
					xtype : 'textfield',
					name : 'PROC_DEF_CODE_',
					fieldLabel : '<spring:message code="DOC.PROC_DEF_CODE_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'PROC_ID_',
					fieldLabel : '<spring:message code="DOC.PROC_ID_" />',
					maxLength : 20
				}, {
					xtype : 'tagfield',
					name : 'PROC_STATUS_LIST',
					store : PROC_STATUS_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					fieldLabel : '<spring:message code="DOC.PROC_STATUS_" />'
				}, {
					xtype : 'combo',
					name : 'DOC_STATUS_LIST',
					store : DOC_STATUS_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="DOC.DOC_STATUS_" />'
				}, {
					xtype : 'datefield',
					name : 'FROM_CREATION_DATE_',
					format : 'Y-m-d H:i:s',
					submitFormat : 'Y-m-d H:i:s',
					fieldLabel : '<spring:message code="DOC.CREATION_DATE_" /> <spring:message code="from" />'
				}, {
					xtype : 'datefield',
					name : 'TO_CREATION_DATE_',
					format : 'Y-m-d H:i:s',
					submitFormat : 'Y-m-d H:i:s',
					fieldLabel : '<spring:message code="to" />'
				}, {
					xtype : 'datefield',
					name : 'FROM_EFFECTIVE_DATE_',
					format : 'Y-m-d H:i:s',
					submitFormat : 'Y-m-d H:i:s',
					fieldLabel : '<spring:message code="DOC.EFFECTIVE_DATE_" /> <spring:message code="from" />'
				}, {
					xtype : 'datefield',
					name : 'TO_EFFECTIVE_DATE_',
					format : 'Y-m-d H:i:s',
					submitFormat : 'Y-m-d H:i:s',
					fieldLabel : '<spring:message code="to" />'
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : docStore,
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
				'itemclick' : function(gridPanel, record, item, index, e, eOpts) {
					_updateButtonStatus();
				}
			}
		});

		var nextRunningNodeInfoWin = Ext.create('Ext.window.Window', {
			id : 'nextRunningNodeInfoWin',
			title : '<spring:message code="next" /><spring:message code="NODE" />',
			modal : true,
			autoShow : false,
			maximized : false,
			maximizable : true,
			closeAction : 'hide',
			width : 800,
			height : '80%',
			items : [ {
				xtype : 'treepanel',
				id : 'nextRunningNodeInfoPanel',
				store : nextRunningNodeInfoStore,
				rootVisible : true,//根节点是否可见
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
					flex : 1
				} ],
				viewConfig : {
					emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
				},
				listeners : {
					'checkchange' : function(node, checked, eOpts) {
						_toggleSubProcDefChoosable(node, checked);
					}
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
					text : '<spring:message code="submitForApproval" />',
					icon : 'image/icon/transferOut.png',
					handler : _submit
				}, {
					xtype : 'button',
					text : '<spring:message code="cancel" />',
					icon : 'image/icon/close.png',
					handler : function() {
						nextRunningNodeInfoWin.close();
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
								html : '<spring:message code="insert" /><spring:message code="ORG" /><br /><br /><spring:message code="help.insertOrg" />'
							});
						}
					}
				} ],
				dock : 'top',
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
				region : 'center',
				layout : 'fit',//充满
				items : [ docPanel ]
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
		var PROC_STATUS_CodeStore = Ext.data.StoreManager.lookup('PROC_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^PROC_STATUS$'));
		PROC_STATUS_CodeStore.add(codeStore.getRange());
		PROC_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var DOC_STATUS_CodeStore = Ext.data.StoreManager.lookup('DOC_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^DOC_STATUS$'));
		DOC_STATUS_CodeStore.add(codeStore.getRange());
		DOC_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		var form = Ext.getCmp('docFormPanel').getForm();//设置初始值，初始验证。
		form.findField('PROC_STATUS_LIST').setValue([ '0', '8' ]);

		_selectDoc();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectDoc() {//查询主表数据
		var docStore = Ext.data.StoreManager.lookup('docStore');
		var item;
		for (var i = 0; i < Ext.getCmp('docFormPanel').items.length; i++) {
			item = Ext.getCmp('docFormPanel').items.get(i);
			docStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		docStore.currentPage = 1;
		docStore.load();
	}

	function _preInsertDoc() {//新增
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="compile" /><spring:message code="new" /><spring:message code="DOC" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="compileDoc.do" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var doc = returnValue;
						Ext.data.StoreManager.lookup('docStore').add(doc);//前台新增数据

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdateDoc() {//修改
		var records = Ext.getCmp('docPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DOC" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="DOC" />',
			modal : true,
			autoShow : true,
			maximized : true,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="compileDoc.do?DOC_ID_=' + records[0].get('DOC_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var doc = returnValue;
						for ( var key in doc) {
							records[0].set(key, doc[key]);
						}

						_updateButtonStatus();

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _submitForApproval() {
		var records = Ext.getCmp('docPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DOC" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.Ajax.request({
			url : 'hasDocFile.do',
			async : false,
			params : {
				'DOC_ID_' : records[0].get('DOC_ID_')
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {//更新页面数据
						var hasDocFile = data.hasDocFile;
						if (!hasDocFile) {
							Ext.MessageBox.alert('<spring:message code="error" />', '该公文没有正文文件', Ext.MessageBox.ERROR);
							return;
						} else {
							Ext.Ajax.request({
								url : 'getStartRunningNodeDefList.do',
								async : false,
								params : {
									'procDefCode' : records[0].get('PROC_DEF_CODE_')
								},
								callback : function(options, success, response) {
									if (success) {
										var data = Ext.decode(response.responseText);
										if (data.success) {
											nextRunningNodeDefList = data.nextRunningNodeDefList;
											var nextRunningNodeInfoStore = Ext.data.StoreManager.lookup('nextRunningNodeInfoStore');//组装子代码数据，过滤注入。
											var node = nextRunningNodeInfoStore.getRoot();
											node.removeAll();
											emptyAssignee = false;

											_buildNextRunningNodeInfoPanel(node, nextRunningNodeDefList);

											Ext.getCmp('nextRunningNodeInfoPanel').expandAll();
											Ext.getCmp('nextRunningNodeInfoWin').show();

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
					} else {
						Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
					}
				} else {
					Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
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
						'expression' : nextRunningNodeDefList[i].candidateSubProcDefList[j].procDefCode,
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

	function _submit() {
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

		var records = Ext.getCmp('docPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DOC" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.Ajax.request({
			url : 'restartDocProc.do',
			async : false,
			params : {
				'DOC_ID_' : records[0].get('DOC_ID_'),
				'CANDIDATE_LIST' : JSON.stringify(candidateList)
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {//更新页面数据
						var doc = data.doc;
						for ( var key in doc) {
							records[0].set(key, doc[key]);
						}

						_updateButtonStatus();

						Ext.MessageBox.alert('<spring:message code="info" />', '上报成功，下一步审批人是 ' + data.nextAssigneeNameList, Ext.MessageBox.INFO);

						Ext.getCmp('nextRunningNodeInfoWin').close();
					} else {
						Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
					}
				} else {
					Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
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

	function _deleteDoc() {//删除
		var records = Ext.getCmp('docPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DOC" />', Ext.MessageBox.WARNING);
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
						url : 'deleteDoc.do',
						async : false,
						params : {
							'DOC_ID_' : records[0].get('DOC_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('docStore').remove(records[0]);//前台删除被删除数据

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

	function _viewDoc() {//查看
		var records = Ext.getCmp('docPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DOC" />', Ext.MessageBox.WARNING);
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
			html : '<iframe src="viewDoc.do?DOC_ID_=' + records[0].get('DOC_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _loadDocFile(DOC_ID_) {//下载
		location.href = 'loadDocFile.do?DOC_ID_=' + DOC_ID_;
	}

	function _updateButtonStatus() {
		var records = Ext.getCmp('docPanel').getSelectionModel().getSelection();
		if (records.length == 0) {
			return;
		}
		record = records[0];

		var updateButton = Ext.getCmp('update');
		var approvalButton = Ext.getCmp('approval');
		var deleteButton = Ext.getCmp('delete');

		var PROC_STATUS_ = record.get('PROC_STATUS_');
		var STAMP_STATUS_ = record.get('STAMP_STATUS_');

		updateButton.setDisabled(true);
		approvalButton.setDisabled(true);
		deleteButton.setDisabled(true);
		if (PROC_STATUS_ == '0' || PROC_STATUS_ == '8') {
			updateButton.setDisabled(false);
			approvalButton.setDisabled(false);
			deleteButton.setDisabled(false);
		}
		if (STAMP_STATUS_ == '1' || STAMP_STATUS_ == '2') {
			stampButton.setDisabled(false);
		}
	}
</script>
</head>
<body>
</body>
</html>