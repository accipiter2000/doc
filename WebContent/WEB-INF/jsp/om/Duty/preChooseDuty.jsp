<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="choose" /><spring:message code="DUTY" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var multipul = 'F';//是否为多选
	var ORGN_SET_ID_ = null;//组织架构套
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.multipul != undefined) ? multipul = parameters.multipul : 0;
		(parameters.ORGN_SET_ID_ != undefined) ? ORGN_SET_ID_ = parameters.ORGN_SET_ID_ : 0;
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

		var CATEGORY_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'CATEGORY_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var DUTY_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'DUTY_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var dutyStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'dutyStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'DUTY_ID_', 'DUTY_CODE_', 'DUTY_NAME_', 'DUTY_CATEGORY_', 'MEMO_', 'DUTY_TAG_', 'DUTY_EXT_ATTR_1_', 'DUTY_EXT_ATTR_2_', 'DUTY_EXT_ATTR_3_', 'DUTY_EXT_ATTR_4_', 'DUTY_EXT_ATTR_5_', 'DUTY_EXT_ATTR_6_', 'DUTY_EXT_ATTR_7_', 'DUTY_EXT_ATTR_8_', 'ORDER_', 'DUTY_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectOmDuty.do',
				type : 'ajax',
				async : true,//false为同步
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'dutyList',
					totalProperty : 'total'
				}
			}
		});

		var buttonPanel = Ext.create('Ext.Panel', {//按钮
			id : 'buttonPanel',
			layout : 'column',
			defaults : {
				labelAlign : 'right',
				margin : '2'
			},
			items : [ {
				xtype : 'button',
				text : '<spring:message code="choose" />',
				icon : 'image/icon/choose.png',
				handler : _chooseDuty
			}, {
				xtype : 'button',
				text : '<spring:message code="select" />',
				icon : 'image/icon/select.png',
				handler : _selectDuty
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
							html : '<spring:message code="choose" /><spring:message code="DUTY" /><br /><br /><spring:message code="help.chooseDuty" />'
						});
					}
				}
			} ]
		});

		var dutyFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'dutyFormPanel',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 360,
				margin : '4'
			},
			items : [ {
				xtype : 'textfield',
				id : 'DUTY_CODE_',
				name : 'DUTY_CODE_',
				fieldLabel : '<spring:message code="DUTY.DUTY_CODE_" />'
			}, {
				xtype : 'textfield',
				id : 'DUTY_NAME_',
				name : 'DUTY_NAME_',
				fieldLabel : '<spring:message code="DUTY.DUTY_NAME_" />'
			} ]
		});

		var dutyPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'dutyPanel',
			store : dutyStore,
			title : '<spring:message code="DUTY" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : (multipul == 'T') ? 'SIMPLE' : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="DUTY.DUTY_NAME_" />',
				dataIndex : 'DUTY_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DUTY.DUTY_CODE_" />',
				dataIndex : 'DUTY_CODE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DUTY.DUTY_CATEGORY_" />',
				dataIndex : 'DUTY_CATEGORY_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 52,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? CATEGORY_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="DUTY.MEMO_" />',
				dataIndex : 'MEMO_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DUTY.DUTY_TAG_" />',
				dataIndex : 'DUTY_TAG_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DUTY.DUTY_STATUS_" />',
				dataIndex : 'DUTY_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? DUTY_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			} ],
			dockedItems : [ {
				xtype : 'pagingtoolbar',
				store : dutyStore,
				displayInfo : true,
				dock : 'bottom'
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
			},
			listeners : {
				'itemdblclick' : function(view, record, item, index, e, eOpts) {
					_chooseDuty();
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
				region : 'north',
				items : [ buttonPanel, dutyFormPanel ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ dutyPanel ]
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
		var CATEGORY_CodeStore = Ext.data.StoreManager.lookup('CATEGORY_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^CATEGORY$'));
		CATEGORY_CodeStore.add(codeStore.getRange());
		CATEGORY_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var DUTY_STATUS_CodeStore = Ext.data.StoreManager.lookup('DUTY_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		DUTY_STATUS_CodeStore.add(codeStore.getRange());
		DUTY_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		_selectDuty();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectDuty() {//查询主表数据
		var dutyStore = Ext.data.StoreManager.lookup('dutyStore');
		dutyStore.proxy.extraParams = {
			'ORGN_SET_ID_' : ORGN_SET_ID_,
			'DUTY_CODE_' : Ext.getCmp('DUTY_CODE_').getSubmitValue(),
			'DUTY_NAME_' : Ext.getCmp('DUTY_NAME_').getSubmitValue()
		};
		dutyStore.currentPage = 1;
		dutyStore.load();
	}

	function _chooseDuty() {//选择
		var records = Ext.getCmp('dutyPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DUTY" />', Ext.MessageBox.WARNING);
			return;
		}

		if (multipul == 'T') {
			var dutyList = new Array();
			for (var i = 0; i < records.length; i++) {
				dutyList.push(records[i].data);
			}
			parent.returnValue = dutyList;
		} else {
			parent.returnValue = records[0].data;
		}

		_close();
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>