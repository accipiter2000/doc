<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="TAG" /></title>
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

		var orgnSetStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'orgnSetStore',
			autoLoad : true,//true为自动加载
			loading : true,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'PARENT_ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'ALLOW_SYNC_', 'MEMO_', 'ORDER_', 'ORGN_SET_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectOmOrgnSet.do',
				type : 'ajax',
				async : true,//false为同步
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'orgnSetList',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, records, successful, eOpts) {
					_init();//自动加载时必须调用
				}
			}
		});

		var tagStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'tagStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'TAG_ID_', 'OBJ_ID_', 'OBJ_TYPE_', 'TAG_' ],
			proxy : {
				url : 'selectOmTag.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'tagList',
					totalProperty : 'total'
				}
			}
		});

		var tagPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'tagPanel',
			store : tagStore,
			title : '<spring:message code="TAG" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="TAG.OBJ_ID_" />',
				dataIndex : 'OBJ_ID_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="TAG.OBJ_TYPE_" />',
				dataIndex : 'OBJ_TYPE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="TAG.TAG_" />',
				dataIndex : 'TAG_',
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
					handler : _selectTag
				}, {
					xtype : 'button',
					text : '<spring:message code="insert" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertTag
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateTag
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteTag
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
								html : '<spring:message code="manage" /><spring:message code="TAG" /><br /><br /><spring:message code="help.manageTag" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'tagFormPanel',
				xtype : 'form',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 360,
					margin : '4'
				},
				items : [ {
					id : 'ORGN_SET_ID_',
					xtype : 'combo',
					name : 'ORGN_SET_ID_',
					store : orgnSetStore,
					queryMode : 'local',
					valueField : 'ORGN_SET_ID_',
					displayField : 'ORGN_SET_NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="ORGN_SET.ORGN_SET_NAME_" />',
					listeners : {
						'select' : function(combo, records, eOpts) {
							_selectDuty();
						}
					}
				}, {
					xtype : 'textfield',
					name : 'OBJ_ID_',
					fieldLabel : '<spring:message code="TAG.OBJ_ID_" />',
					maxLength : 40
				}, {
					xtype : 'textfield',
					name : 'OBJ_TYPE_',
					fieldLabel : '<spring:message code="TAG.OBJ_TYPE_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'TAG_',
					fieldLabel : '<spring:message code="TAG.TAG_" />',
					maxLength : 20
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : tagStore,
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
			padding : '1 1 1 1',
			defaults : {
				border : false,
				frame : true
			},
			items : [ {
				region : 'center',
				layout : 'fit',//充满
				items : [ tagPanel ]
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

		var orgnSetStore = Ext.data.StoreManager.lookup('orgnSetStore');//设置组织架构套缺省值
		Ext.getCmp('ORGN_SET_ID_').setValue(orgnSetStore.getAt(0));

		_selectTag();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectTag() {//查询主表数据
		var tagStore = Ext.data.StoreManager.lookup('tagStore');
		var item;
		for (var i = 0; i < Ext.getCmp('tagFormPanel').items.length; i++) {
			item = Ext.getCmp('tagFormPanel').items.get(i);
			tagStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		tagStore.currentPage = 1;
		tagStore.load();
	}

	function _preInsertTag() {//新增
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="TAG" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertOmTag.do?ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var tag = returnValue;
						Ext.data.StoreManager.lookup('tagStore').add(tag);//前台新增数据

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdateTag() {//修改
		var records = Ext.getCmp('tagPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="TAG" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="TAG" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preUpdateOmTag.do?ORGN_SET_ID_=' + records[0].get('ORGN_SET_ID_') + '&TAG_ID_=' + records[0].get('TAG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var tag = returnValue;
						for ( var key in tag) {
							records[0].set(key, tag[key]);
						}

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _deleteTag() {//删除
		var records = Ext.getCmp('tagPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="TAG" />', Ext.MessageBox.WARNING);
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
						url : 'deleteOmTag.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
							'TAG_ID_' : records[0].get('TAG_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('tagStore').remove(records[0]);//前台删除被删除数据

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
</script>
</head>
<body>
</body>
</html>