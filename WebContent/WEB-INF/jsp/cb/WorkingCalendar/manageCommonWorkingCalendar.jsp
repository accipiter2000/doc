<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="view" /><spring:message code="WORKING_CALENDAR" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<link rel="stylesheet" type="text/css" href="css/simple-calendar.css" />
<style>
html, body {
	height: 100%;
	margin: 0;
	overflow: hidden;
}
</style>
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script type="text/javascript" src="js/simple-calendar.js"></script>
<script>
	var yearList = new Array();
	var simpleCalendar;

	Ext.onReady(function() {
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

		var workingCalendarStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'workingCalendarStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'WORKING_CALENDAR_ID_', 'EMP_ID_', 'DATE_', 'WORKING_DAY_', 'MARK_' ],
			proxy : {
				url : 'selectCommonWorkingCalendar.do',
				type : 'ajax',
				async : false,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'workingCalendarList',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, records, successful, eOpts) {
					var workingCalendar;
					for (var i = 0; i < store.getCount(); i++) {
						workingCalendar = store.getAt(i);
						simpleCalendar.addWorkingDay(Ext.Date.parse(workingCalendar.get('DATE_'), 'Y-m-d H:i:s'), workingCalendar.get('WORKING_DAY_'));
						if (workingCalendar.get('MARK_') != null) {
							simpleCalendar.addMark(Ext.Date.parse(workingCalendar.get('DATE_'), 'Y-m-d H:i:s'), workingCalendar.get('MARK_'));
						}
					}
				}
			}
		});

		var workingCalendarFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'workingCalendarFormPanel',
			layout : 'column',
			width : '100%',
			height : '100%',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 30,
				width : 360,
				margin : '4'
			},
			items : [ {
				xtype : 'displayfield',
				name : 'DISPLAY_DATE_',
				fieldLabel : '<spring:message code="WORKING_CALENDAR.DATE_" />',
				width : '92%'
			}, {
				xtype : 'datefield',
				hidden : true,
				name : 'DATE_',
				format : 'Y-m-d H:i:s',
				submitFormat : 'Y-m-d H:i:s',
				fieldLabel : '<spring:message code="WORKING_CALENDAR.DATE_" />',
				width : '92%',
				allowBlank : false
			}, {
				xtype : 'combo',
				name : 'WORKING_DAY_',
				store : BOOLEAN_CodeStore,
				queryMode : 'local',
				valueField : 'CODE_',
				displayField : 'NAME_',
				emptyText : '<spring:message code="all" />',
				forceSelection : true,
				fieldLabel : '<spring:message code="WORKING_CALENDAR.WORKING_DAY_" />',
				width : '92%',
				allowBlank : false
			}, {
				xtype : 'textareafield',
				name : 'MARK_',
				fieldLabel : '<spring:message code="WORKING_CALENDAR.MARK_" />',
				width : '92%',
				height : document.documentElement.clientHeight - 160,
				allowBlank : true
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
					handler : _updateWorkingCalendar
				}, {
					xtype : 'button',
					text : '初始化年份',
					icon : 'image/icon/update.png',
					handler : _initWorkingCalendar
				}, {
					id : 'YEAR_',
					xtype : 'numberfield',
					name : 'YEAR_',
					allowDecimals : false,
					allowBlank : false
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
								html : '<spring:message code="insert" /><spring:message code="WORKING_CALENDAR" /><br /><br /><spring:message code="help.insertWorkingCalendar" />'
							});
						}
					}
				} ],
				dock : 'top',
			} ],
			renderTo : 'workingCalendarFormDiv'
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
		codeStore.clearFilter();

		var workingCalendarDiv = document.getElementById('workingCalendarDiv');
		var options = {
			width : workingCalendarDiv.clientWidth - 2 + 'px',
			height : workingCalendarDiv.clientHeight - 1 + 'px',
			onSelect : function(date) {
				var form = Ext.getCmp('workingCalendarFormPanel').getForm();
				form.findField('DISPLAY_DATE_').setValue(Ext.Date.format(date, 'Y-m-d'));
				form.findField('DATE_').setValue(date);
				form.findField('WORKING_DAY_').setValue(simpleCalendar.getWorkingDay(date));
				form.findField('MARK_').setValue(simpleCalendar.getMark(date));
			},
			beforeUpdate : function(year, month) {
				if (!yearList.includes(year)) {
					yearList.push(year);
					_selectWorkingCalendar(year);
				}
			}
		};
		simpleCalendar = new SimpleCalendar('#workingCalendarDiv', options);

		var today = new Date();
		var form = Ext.getCmp('workingCalendarFormPanel').getForm();//设置初始值，初始验证。
		form.findField('YEAR_').setValue(today.getFullYear());
		form.isValid();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectWorkingCalendar(year) {
		var workingCalendarStore = Ext.data.StoreManager.lookup('workingCalendarStore');
		workingCalendarStore.proxy.extraParams = {
			'FROM_DATE_' : year + '-01-01 00:00:00',
			'TO_DATE_' : year + '-12-31 00:00:00',
		};
		workingCalendarStore.currentPage = 1;
		workingCalendarStore.load();
	}

	function _updateWorkingCalendar() {
		Ext.getCmp('workingCalendarFormPanel').getForm().submit({//提交表单
			url : 'updateCommonWorkingCalendar.do',
			submitEmptyText : false,
			waitMsg : '<spring:message code="processing" />',
			success : function(form, action) {
				var data = action.result;
				var workingCalendar = data.workingCalendar;

				simpleCalendar.addWorkingDay(Ext.Date.parse(workingCalendar.DATE_, 'Y-m-d H:i:s'), workingCalendar.WORKING_DAY_);
				if (workingCalendar.MARK_ != null) {
					simpleCalendar.addMark(Ext.Date.parse(workingCalendar.DATE_, 'Y-m-d H:i:s'), workingCalendar.MARK_);
				} else {
					simpleCalendar.removeMark(Ext.Date.parse(workingCalendar.DATE_, 'Y-m-d H:i:s'));
				}

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

	function _initWorkingCalendar() {
		var YEAR_ = Ext.getCmp('YEAR_').getValue();
		Ext.Ajax.request({//加载被修改对象
			url : 'initWorkingCalendar.do',
			async : false,//同步加载
			params : {
				'YEAR_' : YEAR_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						_selectWorkingCalendar(YEAR_);

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}
</script>
</head>
<body>
	<div id="workingCalendarDiv" style="float: left; width: 60%; height: 100%;"></div>
	<div id="workingCalendarFormDiv" style="float: left; width: 40%; height: 100%;"></div>
</body>
</html>