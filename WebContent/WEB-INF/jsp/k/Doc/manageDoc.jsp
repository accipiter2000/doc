<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="DOC" /></title>
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

		var PROC_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'PROC_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var BOOLEAN_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'BOOLEAN_CodeStore',
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
			fields : [ 'DOC_ID_', 'DOC_TYPE_NAME_', 'DOC_CODE_', 'DOC_NAME_', 'MEMO_', 'TEMPLATE_FILE_', 'TEMPLATE_FILE_NAME_', 'TEMPLATE_FILE_LENGTH_', 'DOC_FILE_', 'DOC_FILE_NAME_', 'DOC_FILE_LENGTH_', 'TEMPLATE_BOOKMARK_', 'TEMPLATE_INDEX_', 'TEMPLATE_HTML_', 'USING_TEMPLATE_PLACEHOLDERS_', 'DRAFTER_ID_', 'DRAFTER_NAME_', 'DRAFTER_COM_ID_', 'DRAFTER_COM_NAME_', 'PROC_DEF_CODE_', 'PROC_ID_', 'PROC_STATUS_', 'DOC_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'VERSION_' ],
			proxy : {
				url : 'selectDoc.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'docList',
					totalProperty : 'total'
				}
			}
		});

		var docPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'docPanel',
			store : docStore,
			title : '<spring:message code="DOC" />',
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
				flex : 1
			}, {
				text : '<spring:message code="DOC.DOC_NAME_" />',
				dataIndex : 'DOC_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
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
				text : '<spring:message code="DOC.DOC_STATUS_" />',
				dataIndex : 'DOC_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? DOC_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="DOC.DRAFTER_NAME_" />',
				dataIndex : 'DRAFTER_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80
			}, {
				text : '<spring:message code="DOC.CREATION_DATE_" />',
				dataIndex : 'CREATION_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 100
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
					id : 'disable',
					xtype : 'button',
					text : '<spring:message code="disable" />',
					icon : 'image/icon/disable.png',
					handler : _disableDoc
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
					maxLength : 50
				}, {
					xtype : 'textfield',
					name : 'DOC_TYPE_NAME_',
					fieldLabel : '<spring:message code="DOC.DOC_TYPE_NAME_" />',
					maxLength : 100
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
					xtype : 'combo',
					name : 'PROC_STATUS_LIST',
					store : PROC_STATUS_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
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
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : docStore,
				displayInfo : true,
				inputItemWidth : 48,
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
								if (dataIndex == 'DOC_NAME_' || dataIndex == 'SPONSOR_NAME_' || dataIndex == 'DOCOR_NAME_') {
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
		var PROC_STATUS_CodeStore = Ext.data.StoreManager.lookup('PROC_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^PROC_STATUS$'));
		PROC_STATUS_CodeStore.add(codeStore.getRange());
		PROC_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var BOOLEAN_CodeStore = Ext.data.StoreManager.lookup('BOOLEAN_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^BOOLEAN$'));
		BOOLEAN_CodeStore.add(codeStore.getRange());
		BOOLEAN_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var DOC_STATUS_CodeStore = Ext.data.StoreManager.lookup('DOC_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^DOC_STATUS$'));
		DOC_STATUS_CodeStore.add(codeStore.getRange());
		DOC_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

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

	function _disableDoc() {
		var records = Ext.getCmp('docPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DOC" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '废弃原因：<input id="reason" type="text" size="20" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'disableDoc.do',
						async : false,
						params : {
							'DOC_ID_' : records[0].get('DOC_ID_'),
							'DISABLE_REASON_' : document.getElementById('reason').value
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var doc = data.doc;
									for ( var key in doc) {
										records[0].set(key, doc[key]);
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
			width : 1200,
			height : '80%',
			html : '<iframe src="viewDoc.do?DOC_ID_=' + records[0].get('DOC_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _updateButtonStatus() {
		var records = Ext.getCmp('docPanel').getSelectionModel().getSelection();
		if (records.length == 0) {
			return;
		}
		record = records[0];

		var disableButton = Ext.getCmp('disable');

		var PROC_STATUS_ = record.get('PROC_STATUS_');

		disableButton.setDisabled(true);
		if (PROC_STATUS_ == '9') {
			disableButton.setDisabled(false);
		}
	}
</script>
</head>
<body>
</body>
</html>