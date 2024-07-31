<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="DOC_RIDER" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	//获取url中的入参
	var DOC_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.DOC_ID_ != undefined) ? DOC_ID_ = parameters.DOC_ID_ : 0;
	}

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		var docRiderStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'docRiderStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'DOC_RIDER_ID_', 'DOC_ID_', 'DOC_RIDER_FILE_', 'DOC_RIDER_FILE_NAME_', 'DOC_RIDER_FILE_LENGTH_', 'MD5_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectDocRider.do',
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
					root : 'docRiderList',
					totalProperty : 'total'
				}
			}
		});

		var docRiderPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'docRiderPanel',
			store : docRiderStore,
			title : '<spring:message code="DOC_RIDER" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="DOC_RIDER.DOC_RIDER_FILE_" />',
				dataIndex : 'DOC_RIDER_FILE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null) ? '<a href=javascript:_loadDocRiderFile(\'' + record.data.DOC_RIDER_ID_ + '\')>' + value + '</a>' : '';
				}
			}, {
				text : '<spring:message code="DOC_RIDER.DOC_RIDER_FILE_LENGTH_" />',
				dataIndex : 'DOC_RIDER_FILE_LENGTH_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 144
			}, {
				text : '<spring:message code="DOC_RIDER.CREATION_DATE_" />',
				dataIndex : 'CREATION_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="DOC_RIDER.UPDATE_DATE_" />',
				dataIndex : 'UPDATE_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="DOC_RIDER.OPERATOR_NAME_" />',
				dataIndex : 'OPERATOR_NAME_',
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
					handler : _selectDocRider
				}, {
					xtype : 'button',
					text : '<spring:message code="insert" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertDocRider
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateDocRider
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteDocRider
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
								html : '<spring:message code="manage" /><spring:message code="DOC_RIDER" /><br /><br /><spring:message code="help.manageDocRider" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : docRiderStore,
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
				items : [ docRiderPanel ]
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

		_selectDocRider();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectDocRider() {//查询主表数据
		var docRiderStore = Ext.data.StoreManager.lookup('docRiderStore');
		docRiderStore.currentPage = 1;
		docRiderStore.load();
	}

	function _preInsertDocRider() {//新增
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="DOC_RIDER" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertDocRider.do?DOC_ID_=' + DOC_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var docRider = returnValue;
						Ext.data.StoreManager.lookup('docRiderStore').add(docRider);//前台新增数据

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdateDocRider() {//修改
		var records = Ext.getCmp('docRiderPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DOC_RIDER" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="DOC_RIDER" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preUpdateDocRider.do?DOC_RIDER_ID_=' + records[0].get('DOC_RIDER_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var docRider = returnValue;
						for ( var key in docRider) {
							records[0].set(key, docRider[key]);
						}

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _deleteDocRider() {//删除
		var records = Ext.getCmp('docRiderPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DOC_RIDER" />', Ext.MessageBox.WARNING);
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
						url : 'deleteDocRider.do',
						async : false,
						params : {
							'DOC_RIDER_ID_' : records[0].get('DOC_RIDER_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('docRiderStore').remove(records[0]);//前台删除被删除数据

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

	function _loadDocRiderFile(DOC_RIDER_ID_) {//下载
		location.href = 'loadDocRiderFile.do?DOC_RIDER_ID_=' + DOC_RIDER_ID_;
	}
</script>
</head>
<body>
</body>
</html>