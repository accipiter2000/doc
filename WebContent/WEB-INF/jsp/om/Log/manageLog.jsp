<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="LOG" /></title>
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

		var codeStore = Ext.create('Ext.data.Store', {//代码表
			storeId : 'codeStore',
			autoLoad : true,//true为自动加载
			loading : true,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ],
			proxy : {
				url : 'selectOmCode.do',
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

		var logStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'logStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'LOG_ID_', 'CATEGORY_', 'IP_', 'USER_AGENT_', 'URL_', 'ACTION_', 'PARAMETER_MAP_', 'BUSINESS_KEY_', 'ERROR_', 'MESSAGE_', 'ORG_ID_', 'ORG_NAME_', 'POSI_ID_', 'POSI_NAME_', 'EMP_ID_', 'EMP_NAME_', 'CREATION_DATE_' ],
			proxy : {
				url : 'selectOmLog.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'logList',
					totalProperty : 'total'
				}
			}
		});

		var logPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'logPanel',
			store : logStore,
			title : '<spring:message code="LOG" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="LOG.LOG_ID_" />',
				dataIndex : 'LOG_ID_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 260
			}, {
				text : '<spring:message code="LOG.CATEGORY_" />',
				dataIndex : 'CATEGORY_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 78,
			}, {
				text : '<spring:message code="LOG.IP_" />',
				dataIndex : 'IP_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="LOG.USER_AGENT_" />',
				dataIndex : 'USER_AGENT_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			}, {
				text : '<spring:message code="LOG.ACTION_" />',
				dataIndex : 'ACTION_',
				style : 'text-align: center; font-weight: bold;',
				flex : 2
			}, {
				text : '<spring:message code="LOG.BUSINESS_KEY_" />',
				dataIndex : 'BUSINESS_KEY_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 2
			}, {
				text : '<spring:message code="LOG.ERROR_" />',
				dataIndex : 'ERROR_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 52,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? BOOLEAN_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="LOG.ORG_NAME_" />',
				dataIndex : 'ORG_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="LOG.POSI_NAME_" />',
				dataIndex : 'POSI_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="LOG.EMP_NAME_" />',
				dataIndex : 'EMP_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="LOG.CREATION_DATE_" />',
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
					handler : _selectLog
				}, {
					xtype : 'button',
					text : '<spring:message code="view" />',
					icon : 'image/icon/view.png',
					handler : _viewLog
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
								html : '<spring:message code="manage" /><spring:message code="LOG" /><br /><br /><spring:message code="help.manageLog" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'logFormPanel',
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
					name : 'LOG_ID_',
					fieldLabel : '<spring:message code="LOG.LOG_ID_" />',
					maxLength : 40
				}, {
					xtype : 'textfield',
					name : 'CATEGORY_',
					fieldLabel : '<spring:message code="LOG.CATEGORY_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'IP_',
					fieldLabel : '<spring:message code="LOG.IP_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'ACTION_',
					fieldLabel : '<spring:message code="LOG.ACTION_" />',
					maxLength : 200
				}, {
					xtype : 'textfield',
					name : 'BUSINESS_KEY_',
					fieldLabel : '<spring:message code="LOG.BUSINESS_KEY_" />',
					maxLength : 40
				}, {
					xtype : 'combo',
					name : 'ERROR_LIST',
					store : BOOLEAN_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="LOG.ERROR_" />'
				}, {
					xtype : 'textfield',
					name : 'ORG_ID_',
					fieldLabel : '<spring:message code="LOG.ORG_ID_" />',
					maxLength : 40
				}, {
					xtype : 'textfield',
					name : 'ORG_NAME_',
					fieldLabel : '<spring:message code="LOG.ORG_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'POSI_ID_',
					fieldLabel : '<spring:message code="LOG.POSI_ID_" />',
					maxLength : 40
				}, {
					xtype : 'textfield',
					name : 'POSI_NAME_',
					fieldLabel : '<spring:message code="LOG.POSI_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'textfield',
					name : 'EMP_ID_',
					fieldLabel : '<spring:message code="LOG.EMP_ID_" />',
					maxLength : 40
				}, {
					xtype : 'textfield',
					name : 'EMP_NAME_',
					fieldLabel : '<spring:message code="LOG.EMP_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'datefield',
					name : 'FROM_CREATION_DATE_',
					format : 'Y-m-d H:i:s',
					submitFormat : 'Y-m-d H:i:s',
					fieldLabel : '<spring:message code="LOG.CREATION_DATE_" /> <spring:message code="from" />'
				}, {
					xtype : 'datefield',
					name : 'TO_CREATION_DATE_',
					format : 'Y-m-d H:i:s',
					submitFormat : 'Y-m-d H:i:s',
					fieldLabel : '<spring:message code="to" />'
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : logStore,
				displayInfo : true,
				dock : 'bottom'
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			},
			listeners : {
				'itemdblclick' : function(view, record, item, index, e, eOpts) {
					_viewLog();
				},
				'render' : function(gridPanel, eOpts) {
					var view = gridPanel.getView();
					var toolTip = Ext.create('Ext.tip.ToolTip', {
						target : gridPanel.getEl(),
						delegate : view.getCellSelector(),//单元格触发
						listeners : {
							beforeshow : function(sender, eOpts) { // 动态切换提示内容
								var dataIndex = view.getHeaderByCell(sender.triggerElement).dataIndex;
								if (dataIndex == 'USER_AGENT_' || dataIndex == 'ACTION_') {
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
				items : [ logPanel ]
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

		_selectLog();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectLog() {//查询主表数据
		var logStore = Ext.data.StoreManager.lookup('logStore');
		var item;
		for (var i = 0; i < Ext.getCmp('logFormPanel').items.length; i++) {
			item = Ext.getCmp('logFormPanel').items.get(i);
			logStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		logStore.currentPage = 1;
		logStore.load();
	}

	function _viewLog() {//查看
		var records = Ext.getCmp('logPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="LOG" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="LOG" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewOmLog.do?LOG_ID_=' + records[0].get('LOG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}
</script>
</head>
<body>
</body>
</html>