<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="NOTICE" /></title>
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

		var NOTICE_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'NOTICE_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var noticeStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'noticeStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'NOTICE_ID_', 'POSI_EMP_ID_', 'EMP_ID_', 'EMP_CODE_', 'EMP_NAME_', 'CONTENT_', 'SOURCE_', 'IDENTITY_', 'REDIRECT_URL_', 'BIZ_URL_', 'EXP_DATE_', 'NOTICE_STATUS_', 'CREATION_DATE_' ],
			proxy : {
				url : 'selectMyNotice.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'noticeList',
					totalProperty : 'total'
				}
			}
		});

		var noticePanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'noticePanel',
			store : noticeStore,
			headerBorders : false,//是否显示表格竖线
			columns : [ {
				text : '<spring:message code="NOTICE.CONTENT_" />',
				dataIndex : 'CONTENT_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					if (record.get('REDIRECT_URL_') != null) {
						return '<a href="javascript:_redirectNotice(\'' + record.get('REDIRECT_URL_') + '\');">' + value + '</a>';
					} else {
						return value;
					}
				}
			}, {
				text : '<spring:message code="NOTICE.SOURCE_" />',
				dataIndex : 'SOURCE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80
			}, {
				text : '<spring:message code="NOTICE.CREATION_DATE_" />',
				dataIndex : 'CREATION_DATE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150
			}, {
				text : '<spring:message code="NOTICE.NOTICE_STATUS_" />',
				dataIndex : 'NOTICE_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? NOTICE_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 160,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return '<a href="javascript:_updateNoticeStatus(\'' + record.get('NOTICE_ID_') + '\',\'1\');">已读</a>&nbsp;&nbsp;<a href="javascript:_updateNoticeStatus(\'' + record.get('NOTICE_ID_') + '\',\'9\');">已处理</a>&nbsp;&nbsp;<a href="javascript:_updateNoticeStatus(\'' + record.get('NOTICE_ID_') + '\',\'0\');">未读</a>&nbsp;<a href="javascript:_deleteNotice(\'' + record.get('NOTICE_ID_') + '\');">删除</a>';
				}
			} ],
			dockedItems : [ {
				xtype : 'panel',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					margin : '2'
				},
				items : [ {
					id : 'unread',
					xtype : 'checkboxfield',
					boxLabel : '未读',
					checked : true,
					handler : _selectNotice
				}, {
					id : 'read',
					xtype : 'checkboxfield',
					boxLabel : '已读',
					handler : _selectNotice
				}, {
					id : 'handled',
					xtype : 'checkboxfield',
					boxLabel : '已处理',
					handler : _selectNotice
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
								html : '<spring:message code="manage" /><spring:message code="TASK" /><br /><br /><spring:message code="help.manageTask" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : noticeStore,
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
				items : [ noticePanel ]
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
		var NOTICE_STATUS_CodeStore = Ext.data.StoreManager.lookup('NOTICE_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^NOTICE_STATUS$'));
		NOTICE_STATUS_CodeStore.add(codeStore.getRange());
		NOTICE_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		_selectNotice();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectNotice() {//查询主表数据
		var noticeStore = Ext.data.StoreManager.lookup('noticeStore');
		var noticeStatusList = new Array();
		if (Ext.getCmp('unread').checked) {
			noticeStatusList.push('0');
		}
		if (Ext.getCmp('read').checked) {
			noticeStatusList.push('1');
		}
		if (Ext.getCmp('handled').checked) {
			noticeStatusList.push('9');
		}
		noticeStore.proxy.extraParams['NOTICE_STATUS_LIST'] = noticeStatusList;
		noticeStore.currentPage = 1;
		noticeStore.load();
	}

	function _updateNoticeStatus(NOTICE_ID_, NOTICE_STATUS_) {
		Ext.Ajax.request({
			url : 'updateNoticeStatus.do',
			async : false,
			params : {
				'NOTICE_ID_' : NOTICE_ID_,
				'NOTICE_STATUS_' : NOTICE_STATUS_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {//更新页面数据
						var notice = data.notice;
						var noticeStore = Ext.data.StoreManager.lookup('noticeStore');//组装子代码数据，过滤注入。
						var record = noticeStore.findRecord('NOTICE_ID_', new RegExp('^' + NOTICE_ID_ + '$'));
						for ( var key in notice) {
							record.set(key, notice[key]);
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

	function _deleteNotice(NOTICE_ID_) {//删除 
		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="delete" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'deleteNotice.do',
						async : false,
						params : {
							'NOTICE_ID_' : NOTICE_ID_
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var noticeStore = Ext.data.StoreManager.lookup('noticeStore');
									noticeStore.remove(noticeStore.findRecord('NOTICE_ID_', new RegExp('^' + NOTICE_ID_ + '$')));//前台删除被删除数据  

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

	function _redirectNotice(REDIRECT_URL_) {
		Ext.Ajax.request({
			url : REDIRECT_URL_,
			async : false,
			params : {},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {//更新页面数据
						var BIZ_URL_ = data.BIZ_URL_;

						parent.location.href = BIZ_URL_;
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