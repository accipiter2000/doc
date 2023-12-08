<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="RIDER" /></title>
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
	var OBJ_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.OBJ_ID_ != undefined) ? OBJ_ID_ = parameters.OBJ_ID_ : 0;
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

		var RIDER_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'RIDER_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var riderStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'riderStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'RIDER_ID_', 'OBJ_ID_', 'RIDER_FILE_', 'RIDER_FILE_NAME_', 'RIDER_FILE_LENGTH_', 'MEMO_', 'RIDER_TAG_', 'ORDER_', 'RIDER_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectRider.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'OBJ_ID_' : OBJ_ID_
				},
				reader : {
					type : 'json',
					root : 'riderList',
					totalProperty : 'total'
				}
			}
		});

		var riderPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'riderPanel',
			store : riderStore,
			title : '<spring:message code="RIDER" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="RIDER.RIDER_FILE_" />',
				dataIndex : 'RIDER_FILE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null) ? '<a href=javascript:_loadRiderFile(\'' + record.data.RIDER_ID_ + '\')>' + value + '</a>' : '';
				}
			}, {
				text : '<spring:message code="RIDER.RIDER_FILE_LENGTH_" />',
				dataIndex : 'RIDER_FILE_LENGTH_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 156
			}, {
				text : '<spring:message code="RIDER.MEMO_" />',
				dataIndex : 'MEMO_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="RIDER.RIDER_TAG_" />',
				dataIndex : 'RIDER_TAG_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="RIDER.ORDER_" />',
				dataIndex : 'ORDER_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 48
			}, {
				text : '<spring:message code="RIDER.RIDER_STATUS_" />',
				dataIndex : 'RIDER_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? RIDER_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="RIDER.CREATION_DATE_" />',
				dataIndex : 'CREATION_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="RIDER.UPDATE_DATE_" />',
				dataIndex : 'UPDATE_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="RIDER.OPERATOR_NAME_" />',
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
					text : '<spring:message code="disable" />',
					icon : 'image/icon/disable.png',
					handler : _disableRider
				}, {
					xtype : 'button',
					text : '<spring:message code="enable" />',
					icon : 'image/icon/enable.png',
					handler : _enableRider
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteRider
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
								html : '<spring:message code="manage" /><spring:message code="RIDER" /><br /><br /><spring:message code="help.manageRider" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'riderFormPanel',
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
					name : 'RIDER_ID_',
					fieldLabel : '<spring:message code="RIDER.RIDER_ID_" />',
					maxLength : 40
				}, {
					xtype : 'hiddenfield',
					name : 'OBJ_ID_',
					fieldLabel : '<spring:message code="RIDER.OBJ_ID_" />',
					maxLength : 40,
					value : OBJ_ID_
				}, {
					xtype : 'filefield',
					name : 'RIDER_FILE_',
					fieldLabel : '<spring:message code="RIDER.RIDER_FILE_" />',
					buttonText : '<spring:message code="pleaseChoose" />',
					width : '92%'
				}, {
					xtype : 'textfield',
					name : 'MEMO_',
					fieldLabel : '<spring:message code="RIDER.MEMO_" />',
					maxLength : 100
				}, {
					xtype : 'textfield',
					name : 'RIDER_TAG_',
					fieldLabel : '<spring:message code="RIDER.RIDER_TAG_" />',
					maxLength : 40
				}, {
					xtype : 'numberfield',
					name : 'ORDER_',
					fieldLabel : '<spring:message code="RIDER.ORDER_" />',
					allowDecimals : false
				}, {
					xtype : 'button',
					text : '<spring:message code="insert" />',
					icon : 'image/icon/insert.png',
					width : 80,
					handler : _insertRider
				}, {
					id : 'update',
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					width : 80,
					handler : _updateRider
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : riderStore,
				displayInfo : true,
				dock : 'bottom'
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			},
			listeners : {
				'itemclick' : function(view, record, item, index, e, eOpts) {
					var form = Ext.getCmp('riderFormPanel').getForm();
					var rider = record.getData()
					for ( var key in rider) {
						(form.findField(key) != null) ? form.findField(key).setValue(rider[key]) : 0;
					}
					form.findField('RIDER_FILE_').setEmptyText(rider.RIDER_FILE_NAME_);//显示原上传文件名
				},
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
				items : [ riderPanel ]
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
		var RIDER_STATUS_CodeStore = Ext.data.StoreManager.lookup('RIDER_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		RIDER_STATUS_CodeStore.add(codeStore.getRange());
		RIDER_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		_selectRider();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectRider() {//查询主表数据
		var riderStore = Ext.data.StoreManager.lookup('riderStore');
		riderStore.currentPage = 1;
		riderStore.load();
	}

	function _insertRider() {//新增 
		if (Ext.getCmp('riderFormPanel').getForm().findField('RIDER_FILE_').getSubmitValue() == "") {
			Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.pleaseChooseFile" />', Ext.MessageBox.ERROR);
			return;
		}

		Ext.getCmp('riderFormPanel').getForm().submit({//提交表单
			url : 'insertRider.do',
			submitEmptyText : false,
			waitMsg : '<spring:message code="processing" />',
			success : function(form, action) {
				var rider = action.result.rider;
				var riderStore = Ext.data.StoreManager.lookup('riderStore');//前台新增数据
				riderStore.add(rider);

				Ext.getCmp('riderPanel').getSelectionModel().select(riderStore.last());//选中新增记录
				Ext.getCmp('riderPanel').fireEvent('itemclick', Ext.getCmp('riderPanel'), riderStore.last());

				Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
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

	function _updateRider() {//修改
		var records = Ext.getCmp('riderPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="RIDER" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.getCmp('riderFormPanel').getForm().submit({//提交表单
			url : 'updateRider.do',
			submitEmptyText : false,
			waitMsg : '<spring:message code="processing" />',
			success : function(form, action) {
				var rider = action.result.rider;
				for ( var key in rider) {
					records[0].set(key, rider[key]);
				}

				Ext.getCmp('riderPanel').fireEvent('itemclick', Ext.getCmp('riderPanel'), records[0]);

				Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
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

	function _disableRider() {//废弃
		var records = Ext.getCmp('riderPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="RIDER" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="disable" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'disableRider.do',
						async : false,
						params : {
							'RIDER_ID_' : records[0].get('RIDER_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var rider = data.rider;
									for ( var key in rider) {
										records[0].set(key, rider[key]);
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

	function _enableRider() {//恢复
		var records = Ext.getCmp('riderPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="RIDER" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="enable" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'enableRider.do',
						async : false,
						params : {
							'RIDER_ID_' : records[0].get('RIDER_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var rider = data.rider;
									for ( var key in rider) {
										records[0].set(key, rider[key]);
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

	function _deleteRider() {//删除
		var records = Ext.getCmp('riderPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="RIDER" />', Ext.MessageBox.WARNING);
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
						url : 'deleteRider.do',
						async : false,
						params : {
							'RIDER_ID_' : records[0].get('RIDER_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('riderStore').remove(records[0]);//前台删除被删除数据

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

	function _loadRiderFile(RIDER_ID_) {//下载
		location.href = 'loadRiderFile.do?RIDER_ID_=' + RIDER_ID_;
	}

	function _close() {
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>