<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="CUSTOM_DOC_TYPE" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

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

		var customDocTypeStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'customDocTypeStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'CUSTOM_DOC_TYPE_ID_', 'EMP_ID_', 'DOC_TYPE_ID_', 'DOC_TYPE_NAME_', 'TEMPLATE_FILE_', 'TEMPLATE_FILE_NAME_', 'TEMPLATE_FILE_LENGTH_', 'HTML_', 'BOOKMARK_', 'INDEX_', 'USING_TEMPLATE_', 'PROC_DEF_CODE_', 'DESC_', 'ORDER_', 'DOC_TYPE_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectCustomDocType.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'customDocTypeList',
					totalProperty : 'total'
				}
			}
		});

		var docTypeStore = Ext.create('Ext.data.Store', {//树形数据
			storeId : 'docTypeStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'DOC_TYPE_ID_', 'DOC_TYPE_NAME_', 'TEMPLATE_FILE_', 'TEMPLATE_FILE_NAME_', 'TEMPLATE_FILE_LENGTH_', 'HTML_', 'BOOKMARK_', 'INDEX_', 'USING_TEMPLATE_', 'PROC_DEF_CODE_', 'DESC_', 'ORDER_', 'DOC_TYPE_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectDocType.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'DOC_TYPE_STATUS_' : '1'
				},
				reader : {
					type : 'json',
					root : 'docTypeList',
					totalProperty : 'total'
				}
			}
		});

		var customDocTypePanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'customDocTypePanel',
			store : customDocTypeStore,
			title : '<spring:message code="CUSTOM_DOC_TYPE" />',
			headerBorders : false,//是否显示表格竖线 
			columns : [ {
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return '<a href="javascript:_deleteCustomDocType(\'' + record.get('CUSTOM_DOC_TYPE_ID_') + '\');"><spring:message code="remove" /></a>';
				}
			}, {
				text : '<spring:message code="DOC_TYPE.DOC_TYPE_NAME_" />',
				dataIndex : 'DOC_TYPE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
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

		var docTypePanel = Ext.create('Ext.grid.Panel', {
			id : 'docTypePanel',
			store : docTypeStore,
			title : '<spring:message code="DOC_TYPE" />',
			headerBorders : false,//是否显示表格竖线
			columns : [ {
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return '<a href="javascript:_addCustomDocType(\'' + record.get('DOC_TYPE_ID_') + '\');"><spring:message code="collect" /></a>';
				}
			}, {
				text : '<spring:message code="DOC_TYPE.DOC_TYPE_NAME_" />',
				dataIndex : 'DOC_TYPE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DOC_TYPE.TEMPLATE_FILE_" />',
				dataIndex : 'TEMPLATE_FILE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null) ? '<a href=office://word$open$' + document.getElementById('base').href + 'loadDocTypeTemplateFile.do;jsessionid=' + sessionId + '?DOC_TYPE_ID_=' + record.data.DOC_TYPE_ID_ + '>' + value + '</a>' : '';
				}
			}, {
				text : '<spring:message code="DOC_TYPE.USING_TEMPLATE_" />',
				dataIndex : 'USING_TEMPLATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 128,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? BOOLEAN_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="DOC_TYPE.PROC_DEF_CODE_" />',
				dataIndex : 'PROC_DEF_CODE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DOC_TYPE.DESC_" />',
				dataIndex : 'DESC_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
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
					text : '<spring:message code="select" />',
					icon : 'image/icon/select.png',
					handler : _selectDocType
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
								html : '<spring:message code="choose" /><spring:message code="DOC_TYPE" /><br /><br /><spring:message code="help.chooseDocType" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'docTypeFormPanel',
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
					name : 'DOC_TYPE_NAME_',
					fieldLabel : '<spring:message code="DOC_TYPE.DOC_TYPE_NAME_" />',
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
					fieldLabel : '<spring:message code="DOC_TYPE.USING_TEMPLATE_" />'
				}, {
					xtype : 'textfield',
					name : 'PROC_DEF_CODE_',
					fieldLabel : '<spring:message code="DOC_TYPE.PROC_DEF_CODE_" />',
					maxLength : 20
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : docTypeStore,
				displayInfo : true,
				dock : 'bottom'
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
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
								if (dataIndex == 'DOC_TYPE_NAME_' || dataIndex == 'LICENSE_') {
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
				region : 'west',
				layout : 'fit',//充满
				width : 400,
				items : [ customDocTypePanel ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ docTypePanel ]
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

		_selectCustomDocType();//加载主表数据
		_selectDocType();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectCustomDocType() {//查询主表数据
		var customDocTypeStore = Ext.data.StoreManager.lookup('customDocTypeStore');
		customDocTypeStore.currentPage = 1;
		customDocTypeStore.load();
	}

	function _selectDocType() {//查询主表数据
		var docTypeStore = Ext.data.StoreManager.lookup('docTypeStore');
		var item;
		for (var i = 0; i < Ext.getCmp('docTypeFormPanel').items.length; i++) {
			item = Ext.getCmp('docTypeFormPanel').items.get(i);
			docTypeStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		docTypeStore.currentPage = 1;
		docTypeStore.load();
	}

	function _deleteCustomDocType(CUSTOM_DOC_TYPE_ID_) {//删除
		Ext.Ajax.request({
			url : 'deleteCustomDocType.do',
			async : false,
			params : {
				'CUSTOM_DOC_TYPE_ID_' : CUSTOM_DOC_TYPE_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {//更新页面数据
						var customDocTypeStore = Ext.data.StoreManager.lookup('customDocTypeStore');
						customDocTypeStore.remove(customDocTypeStore.findRecord('CUSTOM_DOC_TYPE_ID_', new RegExp('^' + CUSTOM_DOC_TYPE_ID_ + '$')));//前台删除被删除数据  

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

	function _addCustomDocType(DOC_TYPE_ID_) {
		Ext.Ajax.request({
			url : 'insertCustomDocType.do',
			async : false,
			params : {
				'DOC_TYPE_ID_' : DOC_TYPE_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {//更新页面数据
						var customDocType = data.customDocType;
						Ext.data.StoreManager.lookup('customDocTypeStore').add(customDocType);

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
</script>
</head>
<body>
</body>
</html>