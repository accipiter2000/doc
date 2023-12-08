<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="DASHBOARD" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<style type="text/css">
.dashboardDiv {
	float: left;
}

.dashboardBorderDiv {
	width: calc(100% - 6px);
	height: calc(100% - 6px);
	box-shadow: 0px 0px 3px 1px rgba(0, 100, 0, 0.6);
	margin: 3px;
	cursor: move;
}

.dashboardHeaderDiv {
	width: 100%;
	height: 30px;
	line-height: 30px;
	position: relative;
	text-align: center;
	font-size: 16px;
	border-bottom: 1px solid #CCCCCC;
}

.dashboardCenterDiv {
	width: 100%;
	height: calc(100% - 31px);
}
</style>
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="js/Sortable.min.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	var scale;
	var $viewDashboardPanel;

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

		var DASHBOARD_MODULE_TYPE_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'DASHBOARD_MODULE_TYPE_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var dashboardModuleStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'dashboardModuleStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'DASHBOARD_MODULE_ID_', 'DASHBOARD_MODULE_NAME_', 'DASHBOARD_MODULE_TYPE_', 'DEFAULT_URL_', 'DEFAULT_WIDTH_', 'DEFAULT_HEIGHT_', 'DASHBOARD_MODULE_TAG_', 'ORDER_', 'DASHBOARD_MODULE_STATUS_' ],
			proxy : {
				url : 'selectDashboardModule.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'DASHBOARD_MODULE_STATUS_LIST' : '1'
				},
				reader : {
					type : 'json',
					root : 'dashboardModuleList',
					totalProperty : 'total'
				}
			}
		});

		var dashboardStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'dashboardStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'DASHBOARD_ID_', 'DASHBOARD_MODULE_ID_', 'POSI_EMP_ID_', 'DASHBOARD_MODULE_NAME_', 'URL_', 'WIDTH_', 'HEIGHT_', 'ORDER_' ],
			proxy : {
				url : 'selectMyDashboard.do',
				type : 'ajax',
				async : false,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'alternative' : false
				},
				reader : {
					type : 'json',
					root : 'dashboardList',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, records, successful, eOpts) {
					_updateDashboardLayout();//自动加载时必须调用
				}
			}
		});

		var dashboardModulePanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'dashboardModulePanel',
			store : dashboardModuleStore,
			title : '<spring:message code="DASHBOARD_MODULE" />',
			headerBorders : false,//是否显示表格竖线
			columns : [ {
				text : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_NAME_" />',
				dataIndex : 'DASHBOARD_MODULE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_TYPE_" />',
				dataIndex : 'DASHBOARD_MODULE_TYPE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 128,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? DASHBOARD_MODULE_TYPE_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 48,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return '<a href="javascript:_insertDashboard(\'' + record.get('DASHBOARD_MODULE_ID_') + '\');"><spring:message code="add" /></a>';
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
					xtype : 'button',
					text : '<spring:message code="select" />',
					icon : 'image/icon/select.png',
					handler : _selectDashboardModule
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
								html : '<spring:message code="manage" /><spring:message code="DASHBOARD_MODULE" /><br /><br /><spring:message code="help.manageDashboardModule" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				id : 'dashboardModuleFormPanel',
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
					name : 'DASHBOARD_MODULE_NAME_',
					fieldLabel : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_NAME_" />',
					maxLength : 20
				}, {
					xtype : 'combo',
					name : 'DASHBOARD_MODULE_TYPE_LIST',
					store : DASHBOARD_MODULE_TYPE_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_TYPE_" />'
				}, {
					xtype : 'textfield',
					name : 'DASHBOARD_MODULE_TAG_',
					fieldLabel : '<spring:message code="DASHBOARD_MODULE.DASHBOARD_MODULE_TAG_" />',
					maxLength : 20
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : dashboardModuleStore,
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
								if (dataIndex == 'DASHBOARD_MODULE_NAME_') {
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

		var viewDashboardPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'viewDashboardPanel',
			layout : 'column',
			autoScroll : true
		});

		var dashboardFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'dashboardFormPanel',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 360,
				margin : '4'
			},
			items : [ {
				xtype : 'hiddenfield',
				name : 'DASHBOARD_ID_'
			}, {
				xtype : 'textfield',
				name : 'DASHBOARD_MODULE_NAME_',
				fieldLabel : '<spring:message code="DASHBOARD.DASHBOARD_MODULE_NAME_" />',
				width : 300,
				maxLength : 20,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'URL_',
				fieldLabel : '<spring:message code="DASHBOARD.URL_" />',
				width : 400,
				maxLength : 300,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'WIDTH_',
				fieldLabel : '<spring:message code="DASHBOARD.WIDTH_" />',
				width : 200,
				maxLength : 20,
				allowBlank : false
			}, {
				xtype : 'textfield',
				name : 'HEIGHT_',
				fieldLabel : '<spring:message code="DASHBOARD.HEIGHT_" />',
				width : 200,
				maxLength : 20,
				allowBlank : false
			}, {
				xtype : 'hiddenfield',
				name : 'ORDER_',
				fieldLabel : '<spring:message code="DASHBOARD.ORDER_" />'
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
					text : '<spring:message code="save" />',
					icon : 'image/icon/save.png',
					handler : _updateDashboard
				} ],
				dock : 'top',
			} ]
		});

		Ext.create('Ext.container.Viewport', {//整体布局
			layout : {
				type : 'border',//border布局
				regionWeights : {//四个角的归属
					west : 1,
					north : -1,
					south : -1,
					east : 1
				}
			},
			padding : '1 1 1 1',
			defaults : {
				border : false,
				frame : true
			},
			items : [ {
				region : 'west',
				width : 400,
				layout : 'fit',
				items : [ dashboardModulePanel ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ viewDashboardPanel ]
			}, {
				region : 'south',
				height : 100,
				layout : 'fit',//充满
				items : [ dashboardFormPanel ]
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
		var DASHBOARD_MODULE_TYPE_CodeStore = Ext.data.StoreManager.lookup('DASHBOARD_MODULE_TYPE_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^DASHBOARD_MODULE_TYPE$'));
		DASHBOARD_MODULE_TYPE_CodeStore.add(codeStore.getRange());
		DASHBOARD_MODULE_TYPE_CodeStore.insert(0, {});
		codeStore.clearFilter();

		scale = $('#' + Ext.getCmp('viewDashboardPanel').getLayout().getRenderTarget().id).width() / $('body').width();
		$viewDashboardPanel = $('#' + Ext.getCmp('viewDashboardPanel').getLayout().getRenderTarget().id);

		_selectDashboardModule();
		_selectDashboard();

		//拖动排序
		Sortable.create($viewDashboardPanel[0], {
			animation : 300,
			onEnd : function(e) {//拖动结束，排序
				var $dashboard = $viewDashboardPanel.children();
				var DASHBOARD_ID_LIST = [];
				for (var i = 0; i < $dashboard.length; i++) {
					DASHBOARD_ID_LIST.push($dashboard.eq(i).attr('id'));
				}
				Ext.Ajax.request({
					url : 'updateDashboardOrder.do',
					async : false,
					params : {
						'DASHBOARD_ID_LIST' : DASHBOARD_ID_LIST
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
			},
		});

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectDashboardModule() {//查询主表数据
		var dashboardModuleStore = Ext.data.StoreManager.lookup('dashboardModuleStore');
		var item;
		for (var i = 0; i < Ext.getCmp('dashboardModuleFormPanel').items.length; i++) {
			item = Ext.getCmp('dashboardModuleFormPanel').items.get(i);
			dashboardModuleStore.proxy.extraParams[item.getName()] = item.getSubmitValue();
		}
		dashboardModuleStore.currentPage = 1;
		dashboardModuleStore.load();
	}

	function _selectDashboard() {//查询主表数据
		var dashboardStore = Ext.data.StoreManager.lookup('dashboardStore');
		dashboardStore.currentPage = 1;
		dashboardStore.load();
	}

	function _updateDashboardLayout() {//查询主表数据
		$viewDashboardPanel.empty();

		var dashboardStore = Ext.data.StoreManager.lookup('dashboardStore');//组装子代码数据，过滤注入。
		var id;
		var name;
		var url;
		var width;
		var height;
		for (var i = 0; i < dashboardStore.getCount(); i++) {
			id = dashboardStore.getAt(i).get('DASHBOARD_ID_');
			name = dashboardStore.getAt(i).get('DASHBOARD_MODULE_NAME_');
			url = dashboardStore.getAt(i).get('URL_');
			width = dashboardStore.getAt(i).get('WIDTH_');
			height = dashboardStore.getAt(i).get('HEIGHT_');
			if (width.indexOf('%') == -1) {//判断是否为百分比类型宽度
				width = width * scale;
				width += 'px';
			}
			height += 'px';

			//创建dashboardDiv，控制大小和布局
			var $dashboardDiv = $('<div id="' + id + '" class="dashboardDiv" style="width: ' + (width) + '; height: ' + height + ';" ></div>');
			$viewDashboardPanel.append($dashboardDiv);

			//创建dashboardBorderDiv，控制dashboard外观展示
			var $dashboardBorderDiv = $('<div class="dashboardBorderDiv"></div>');
			$dashboardDiv.append($dashboardBorderDiv);

			//创建dashboardHeaderDiv，控制题头和折叠
			var $dashboardHeaderDiv = $('<div class="dashboardHeaderDiv"></div>');
			$dashboardHeaderDiv.text(name);
			$dashboardHeaderDiv.append($('<img style="position: absolute; top: 8px; right: 30px; cursor: pointer;" src="image/icon/manage.png" onclick="_preUpdateDashboard(\'' + id + '\')" />'));
			$dashboardHeaderDiv.append($('<img style="position: absolute; top: 8px; right: 8px; cursor: pointer;" src="image/icon/close.png" onclick="_deleteDashboard(\'' + id + '\')" />'));
			$dashboardBorderDiv.append($dashboardHeaderDiv);

			//创建 dashboardCenterDiv，控制展示iframe
			var $dashboardCenterDiv = $('<div class="dashboardCenterDiv"></div>');
			$dashboardCenterDiv.append($('<iframe src="' + url + '" style="width: 100%; height: 100%; border: 0px;"></iframe>'));
			$dashboardBorderDiv.append($dashboardCenterDiv);
		}
	}

	function _insertDashboard(DASHBOARD_MODULE_ID_) { //新增仪表盘
		Ext.Ajax.request({//加载被修改对象
			url : 'insertMyDashboardByDashboardModule.do',
			async : false,//同步加载
			params : {
				'DASHBOARD_MODULE_ID_' : DASHBOARD_MODULE_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						_selectDashboard();

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdateDashboard(DASHBOARD_ID_) {
		var dashboardStore = Ext.data.StoreManager.lookup('dashboardStore');//组装子代码数据，过滤注入。

		var dashboard = dashboardStore.findRecord('DASHBOARD_ID_', new RegExp('^' + DASHBOARD_ID_ + '$')).getData();
		var form = Ext.getCmp('dashboardFormPanel').getForm();//设置初始值，初始验证。
		for ( var key in dashboard) {
			(form.findField(key) != null) ? form.findField(key).setValue(dashboard[key]) : 0;
		}
		form.isValid();
	}

	function _updateDashboard() {
		Ext.getCmp('dashboardFormPanel').getForm().submit({//提交表单
			url : 'updateDashboard.do',
			submitEmptyText : false,
			waitMsg : '<spring:message code="processing" />',
			success : function(form, action) {
				_selectDashboard();

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

	function _deleteDashboard(DASHBOARD_ID_) { //新增仪表盘
		Ext.Ajax.request({//加载被修改对象
			url : 'deleteDashboard.do',
			async : false,//同步加载
			params : {
				'DASHBOARD_ID_' : DASHBOARD_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						_selectDashboard();

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}
</script>
</head>
<body>
</body>
</html>