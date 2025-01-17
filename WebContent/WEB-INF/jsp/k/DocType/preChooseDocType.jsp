<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="choose" /><spring:message code="DOC_TYPE" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var rootVisible = 'F';//根节点是否可见
	var multipul = 'F';//是否为多选
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.rootVisible != undefined) ? rootVisible = parameters.rootVisible : 0;
		(parameters.multipul != undefined) ? multipul = parameters.multipul : 0;
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

		var BOOLEAN_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'BOOLEAN_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var DOC_TYPE_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'DOC_TYPE_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var docTypeStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'docTypeStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'DOC_TYPE_ID_', 'DOC_TYPE_NAME_', 'TEMPLATE_FILE_', 'TEMPLATE_FILE_NAME_', 'TEMPLATE_FILE_LENGTH_', 'TEMPLATE_BOOKMARK_', 'TEMPLATE_INDEX_', 'TEMPLATE_HTML_', 'USING_TEMPLATE_PLACEHOLDERS_', 'PROC_DEF_CODE_', 'DESC_', 'ORDER_', 'DOC_TYPE_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ],
			proxy : {
				url : 'selectDocType.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'docTypeList',
					totalProperty : 'total'
				}
			}
		});

		var docTypePanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'docTypePanel',
			store : docTypeStore,
			title : '<spring:message code="DOC_TYPE" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : (multipul == 'T') ? 'SIMPLE' : 'SINGLE'
			},
			columns : [ {
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
				flex : 1
			}, {
				text : '<spring:message code="DOC_TYPE.USING_TEMPLATE_PLACEHOLDERS_" />',
				dataIndex : 'USING_TEMPLATE_PLACEHOLDERS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 112,
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
			}, {
				text : '<spring:message code="DOC_TYPE.ORDER_" />',
				dataIndex : 'ORDER_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 48
			}, {
				text : '<spring:message code="DOC_TYPE.DOC_TYPE_STATUS_" />',
				dataIndex : 'DOC_TYPE_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 112,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? DOC_TYPE_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
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
					handler : _selectDocType
				}, {
					xtype : 'button',
					text : '<spring:message code="choose" />',
					icon : 'image/icon/choose.png',
					handler : _chooseDocType
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
								html : '<spring:message code="manage" /><spring:message code="DOC_TYPE" /><br /><br /><spring:message code="help.manageDocType" />'
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
					name : 'USING_TEMPLATE_PLACEHOLDERS_LIST',
					store : BOOLEAN_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="DOC_TYPE.USING_TEMPLATE_PLACEHOLDERS_" />'
				}, {
					xtype : 'textfield',
					name : 'PROC_DEF_CODE_',
					fieldLabel : '<spring:message code="DOC_TYPE.PROC_DEF_CODE_" />',
					maxLength : 20
				}, {
					xtype : 'hidden',
					name : 'DOC_TYPE_STATUS_LIST',
					store : DOC_TYPE_STATUS_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					emptyText : '<spring:message code="all" />',
					forceSelection : true,
					fieldLabel : '<spring:message code="DOC_TYPE.DOC_TYPE_STATUS_" />',
					value : '1'
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : docTypeStore,
				displayInfo : true,
				inputItemWidth : 48,
				dock : 'bottom'
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			},
			listeners : {
				'itemdblclick' : function(panel, record, item, index, e, eOpts) {
					_chooseDocType();
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
		var DOC_TYPE_STATUS_CodeStore = Ext.data.StoreManager.lookup('DOC_TYPE_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		DOC_TYPE_STATUS_CodeStore.add(codeStore.getRange());
		DOC_TYPE_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		var form = Ext.getCmp('docTypeFormPanel').getForm();//设置初始值，初始验证。
		//form.findField('DOC_TYPE_STATUS_LIST').setValue('1');
		_selectDocType();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
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

	function _chooseDocType() {//选择
		var records = Ext.getCmp('docTypePanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="DOC_TYPE" />', Ext.MessageBox.WARNING);
			return;
		}

		if (multipul == 'T') {
			var docTypeList = new Array();
			for (var i = 0; i < records.length; i++) {
				docTypeList.push(records[i].data);
			}
			parent.returnValue = docTypeList;
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