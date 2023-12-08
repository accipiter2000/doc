<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="MIRROR_SERVER" /></title>
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
	var MIRROR_SERVER_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.MIRROR_SERVER_ID_ != undefined) ? MIRROR_SERVER_ID_ = parameters.MIRROR_SERVER_ID_ : 0;
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

		var OPERATION_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'OPERATION_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var orgnSetStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'orgnSetStore',
			autoLoad : true,
			loading : true,
			root : {},//保证autoload有效
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'PARENT_ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'ALLOW_SYNC_', 'MEMO_', 'ORDER_', 'ORGN_SET_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'PARENT_ORGN_SET_CODE_', 'PARENT_ORGN_SET_NAME_' ],
			proxy : {
				url : 'selectOmOrgnSet.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'children',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, node, records, successful, eOpts) {
					_init();//自动加载时必须调用

					setTimeout('_expandAllOrgnSet()', 200);//延迟展开树
				}
			}
		});

		var mirrorServerOrgnSetStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'mirrorServerOrgnSetStore',
			autoLoad : true,
			loading : true,
			root : {},//保证autoload有效
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'PARENT_ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'ALLOW_SYNC_', 'MEMO_', 'ORDER_', 'ORGN_SET_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'PARENT_ORGN_SET_CODE_', 'PARENT_ORGN_SET_NAME_' ],
			proxy : {
				url : 'selectOmMirrorServerOrgnSet.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'MIRROR_SERVER_ID_' : MIRROR_SERVER_ID_
				},
				reader : {
					type : 'json',
					root : 'children',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, node, records, successful, eOpts) {
					_init();//自动加载时必须调用

					setTimeout('_expandAllMirrorServerOrgnSet()', 200);//延迟展开树
				}
			}
		});

		var orgStore = Ext.create('Ext.data.Store', {
			storeId : 'orgStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'ORG_ID_', 'ORGN_SET_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'CATEGORY_', 'MEMO_', 'ORG_TAG_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'EXT_ATTR_7_', 'EXT_ATTR_8_', 'ORDER_', 'ORG_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_' ]
		});

		var dutyStore = Ext.create('Ext.data.Store', {
			storeId : 'dutyStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'DUTY_ID_', 'ORGN_SET_ID_', 'DUTY_CODE_', 'DUTY_NAME_', 'CATEGORY_', 'MEMO_', 'DUTY_TAG_', 'ORDER_', 'DUTY_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_' ]
		});

		var posiStore = Ext.create('Ext.data.Store', {
			storeId : 'posiStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'POSI_ID_', 'ORGN_SET_ID_', 'ORG_ID_', 'DUTY_ID_', 'POSI_CODE_', 'POSI_NAME_', 'ORG_LEADER_TYPE_', 'CATEGORY_', 'MEMO_', 'POSI_TAG_', 'ORDER_', 'POSI_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'ORG_CODE_', 'ORG_NAME_', 'DUTY_CODE_', 'DUTY_NAME_' ]
		});

		var empStore = Ext.create('Ext.data.Store', {
			storeId : 'empStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'EMP_ID_', 'ORGN_SET_ID_', 'ORG_ID_', 'EMP_CODE_', 'EMP_NAME_', 'PASSWORD_RESET_REQ_', 'PARTY_', 'EMP_LEVEL_', 'GENDER_', 'BIRTH_DATE_', 'TEL_', 'EMAIL_', 'IN_DATE_', 'OUT_DATE_', 'CATEGORY_', 'MEMO_', 'EMP_TAG_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'EXT_ATTR_7_', 'EXT_ATTR_8_', 'ORDER_', 'EMP_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'ORG_CODE_', 'ORG_NAME_' ]
		});

		var posiEmpStore = Ext.create('Ext.data.Store', {
			storeId : 'posiEmpStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'POSI_EMP_ID_', 'ORGN_SET_ID_', 'POSI_ID_', 'EMP_ID_', 'MAIN_', 'POSI_EMP_TAG_', 'POSI_EMP_STATUS_', 'CREATION_DATE_', 'POSI_EMP_TAG_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'POSI_CODE_', 'POSI_NAME_', 'EMP_CODE_', 'EMP_NAME_', 'PASSWORD_RESET_REQ_', 'PARTY_', 'EMP_LEVEL_', 'GENDER_', 'BIRTH_DATE_', 'TEL_', 'EMAIL_', 'IN_DATE_', 'OUT_DATE_', 'CATEGORY_', 'MEMO_', 'EMP_TAG_', 'ORDER_', 'EMP_STATUS_' ]
		});

		var empRelationStore = Ext.create('Ext.data.Store', {
			storeId : 'empRelationStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'EMP_RELATION_ID_', 'ORGN_SET_ID_', 'UPPER_EMP_ID_', 'LOWER_EMP_ID_', 'EMP_RELATION_', 'EMP_RELATION_TAG_', 'EMP_RELATION_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'UPPER_EMP_CODE_', 'UPPER_EMP_NAME_', 'LOWER_EMP_CODE_', 'LOWER_EMP_NAME_' ]
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
				text : '<spring:message code="push" /><spring:message code="copy" />',
				icon : 'image/icon/transferIn.png',
				handler : _pushCopyMirrorServerOrgnSet
			}, {
				xtype : 'button',
				text : '<spring:message code="compare" />',
				icon : 'image/icon/associate.png',
				handler : _pushCompareMirrorServerOrgnSet
			}, {
				xtype : 'button',
				text : '<spring:message code="push" /><spring:message code="update" />',
				icon : 'image/icon/update.png',
				handler : _pushUpdateMirrorServerOrgnSet
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
							html : '<spring:message code="manage" /><spring:message code="ORGN_SET" /><br /><br /><spring:message code="help.manageOrgnSet" />'
						});
					}
				}
			} ],
		});

		var orgnSetPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'orgnSetPanel',
			store : orgnSetStore,
			title : '<spring:message code="ORGN_SET" />',
			rootVisible : false,//根节点是否可见
			hideHeaders : true,//是否隐藏表头
			rowLines : true,//是否显示表格横线
			headerBorders : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				xtype : 'treecolumn',
				text : '<spring:message code="ORGN_SET.ORGN_SET_CODE_" />',
				dataIndex : 'ORGN_SET_CODE_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			}
		});

		var mirrorServerOrgnSetPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'mirrorServerOrgnSetPanel',
			store : mirrorServerOrgnSetStore,
			title : '<spring:message code="MIRROR_SERVER" /><spring:message code="ORGN_SET" />',
			rootVisible : false,//根节点是否可见
			hideHeaders : true,//是否隐藏表头
			rowLines : true,//是否显示表格横线
			headerBorders : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				xtype : 'treecolumn',
				text : '<spring:message code="ORGN_SET.ORGN_SET_CODE_" />',
				dataIndex : 'ORGN_SET_CODE_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			}
		});

		var leftPanel = Ext.create('Ext.Panel', {
			id : 'leftPanel',
			layout : 'border',
			defaults : {
				border : false
			},
			items : [ {
				region : 'north',
				layout : 'fit',
				height : '80%',
				items : [ orgnSetPanel ]
			}, {
				region : 'center',
				layout : 'fit',
				items : [ mirrorServerOrgnSetPanel ]
			} ]
		});

		var orgnChangePanel = Ext.create('Ext.tab.Panel', {//tab
			id : 'orgnChangePanel',
			items : [ {
				id : 'orgTab',
				title : '<spring:message code="ORG" />',
				layout : 'fit',
				items : [ {
					id : 'orgPanel',
					xtype : 'gridpanel',
					store : orgStore,
					headerBorders : false,//是否显示表格竖线
					selModel : {
						selType : 'checkboxmodel',
						mode : 'SIMPLE'
					},
					columns : [ {
						text : '<spring:message code="operation" />',
						dataIndex : 'OPERATION_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 1,
						renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
							return (value != null && value != '') ? OPERATION_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
						}
					}, {
						text : '<spring:message code="ORG.ORG_NAME_" />',
						dataIndex : 'ORG_NAME_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="ORG.ORG_CODE_" />',
						dataIndex : 'ORG_CODE_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="DUTY.CATEGORY_" />',
						dataIndex : 'CATEGORY_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2,
						renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
							return (value != null && value != '') ? CATEGORY_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
						}
					} ]
				} ]
			}, {
				id : 'dutyTab',
				title : '<spring:message code="DUTY" />',
				layout : 'fit',
				items : [ {
					id : 'dutyPanel',
					xtype : 'gridpanel',
					store : dutyStore,
					headerBorders : false,//是否显示表格竖线
					selModel : {
						selType : 'checkboxmodel',
						mode : 'SIMPLE'
					},
					columns : [ {
						text : '<spring:message code="operation" />',
						dataIndex : 'OPERATION_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 1,
						renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
							return (value != null && value != '') ? OPERATION_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
						}
					}, {
						text : '<spring:message code="DUTY.DUTY_NAME_" />',
						dataIndex : 'DUTY_NAME_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="DUTY.DUTY_CODE_" />',
						dataIndex : 'DUTY_CODE_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="DUTY.CATEGORY_" />',
						dataIndex : 'CATEGORY_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2,
						renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
							return (value != null && value != '') ? CATEGORY_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
						}
					} ]
				} ]
			}, {
				id : 'posiTab',
				title : '<spring:message code="POSI" />',
				layout : 'fit',
				items : [ {
					id : 'posiPanel',
					xtype : 'gridpanel',
					store : posiStore,
					headerBorders : false,//是否显示表格竖线
					selModel : {
						selType : 'checkboxmodel',
						mode : 'SIMPLE'
					},
					columns : [ {
						text : '<spring:message code="operation" />',
						dataIndex : 'OPERATION_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 1,
						renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
							return (value != null && value != '') ? OPERATION_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
						}
					}, {
						text : '<spring:message code="POSI.POSI_NAME_" />',
						dataIndex : 'POSI_NAME_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="POSI.POSI_CODE_" />',
						dataIndex : 'POSI_CODE_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="POSI.CATEGORY_" />',
						dataIndex : 'CATEGORY_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2,
						renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
							return (value != null && value != '') ? CATEGORY_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
						}
					} ]
				} ]
			}, {
				id : 'empTab',
				title : '<spring:message code="EMP" />',
				layout : 'fit',
				items : [ {
					id : 'empPanel',
					xtype : 'gridpanel',
					store : empStore,
					headerBorders : false,//是否显示表格竖线
					selModel : {
						selType : 'checkboxmodel',
						mode : 'SIMPLE'
					},
					columns : [ {
						text : '<spring:message code="operation" />',
						dataIndex : 'OPERATION_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 1,
						renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
							return (value != null && value != '') ? OPERATION_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
						}
					}, {
						text : '<spring:message code="EMP.EMP_NAME_" />',
						dataIndex : 'EMP_NAME_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="EMP.EMP_CODE_" />',
						dataIndex : 'EMP_CODE_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="EMP.CATEGORY_" />',
						dataIndex : 'CATEGORY_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2,
						renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
							return (value != null && value != '') ? CATEGORY_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
						}
					} ]
				} ]
			}, {
				id : 'posiEmpTab',
				title : '<spring:message code="POSI_EMP" />',
				layout : 'fit',
				items : [ {
					id : 'posiEmpPanel',
					xtype : 'gridpanel',
					store : posiEmpStore,
					headerBorders : false,//是否显示表格竖线
					selModel : {
						selType : 'checkboxmodel',
						mode : 'SIMPLE'
					},
					columns : [ {
						text : '<spring:message code="operation" />',
						dataIndex : 'OPERATION_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 1,
						renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
							return (value != null && value != '') ? OPERATION_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
						}
					}, {
						text : '<spring:message code="POSI_EMP.POSI_EMP_ID_" />',
						dataIndex : 'POSI_EMP_ID_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="POSI_EMP.POSI_ID_" />',
						dataIndex : 'POSI_ID_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="POSI_EMP.EMP_ID_" />',
						dataIndex : 'EMP_ID_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					} ]
				} ]
			}, {
				id : 'empRelationTab',
				title : '<spring:message code="EMP_RELATION" />',
				layout : 'fit',
				items : [ {
					id : 'empRelationPanel',
					xtype : 'gridpanel',
					store : empRelationStore,
					headerBorders : false,//是否显示表格竖线
					selModel : {
						selType : 'checkboxmodel',
						mode : 'SIMPLE'
					},
					columns : [ {
						text : '<spring:message code="operation" />',
						dataIndex : 'OPERATION_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 1,
						renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
							return (value != null && value != '') ? OPERATION_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
						}
					}, {
						text : '<spring:message code="EMP_RELATION.EMP_RELATION_ID_" />',
						dataIndex : 'EMP_RELATION_ID_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="EMP_RELATION.UPPER_EMP_ID_" />',
						dataIndex : 'UPPER_EMP_ID_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="EMP_RELATION.LOWER_EMP_ID_" />',
						dataIndex : 'LOWER_EMP_ID_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					} ]
				} ]
			} ]
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
				items : [ buttonPanel ]
			}, {
				region : 'west',
				layout : 'fit',//充满
				width : 200,
				items : [ leftPanel ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ orgnChangePanel ]
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
		codeStore.clearFilter();
		var OPERATION_CodeStore = Ext.data.StoreManager.lookup('OPERATION_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^OPERATION$'));
		OPERATION_CodeStore.add(codeStore.getRange());
		codeStore.clearFilter();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _pushCopyMirrorServerOrgnSet() {//修改
		var records = Ext.getCmp('orgnSetPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORGN_SET" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="push" /><spring:message code="copy" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'pushCopyOmMirrorServerOrgnSet.do',
						async : false,
						params : {
							'MIRROR_SERVER_ID_' : MIRROR_SERVER_ID_,
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('mirrorServerOrgnSetStore').load();

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

	function _pushCompareMirrorServerOrgnSet() {//比较
		var records = Ext.getCmp('orgnSetPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORGN_SET" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.Ajax.request({
			url : 'pushCompareOmMirrorServerOrgnSet.do',
			async : false,
			params : {
				'MIRROR_SERVER_ID_' : MIRROR_SERVER_ID_,
				'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_')
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {//更新页面数据
						var orgnChange = data.orgnChange;

						for (var i = 0; i < orgnChange.insertOrgList.length; i++) {
							orgnChange.insertOrgList[i].OPERATION_ = 'INSERT';
						}
						for (var i = 0; i < orgnChange.updateOrgList.length; i++) {
							orgnChange.updateOrgList[i].OPERATION_ = 'UPDATE';
						}
						for (var i = 0; i < orgnChange.deleteOrgList.length; i++) {
							orgnChange.deleteOrgList[i].OPERATION_ = 'DELETE';
						}
						for (var i = 0; i < orgnChange.insertDutyList.length; i++) {
							orgnChange.insertDutyList[i].OPERATION_ = 'INSERT';
						}
						for (var i = 0; i < orgnChange.updateDutyList.length; i++) {
							orgnChange.updateDutyList[i].OPERATION_ = 'UPDATE';
						}
						for (var i = 0; i < orgnChange.deleteDutyList.length; i++) {
							orgnChange.deleteDutyList[i].OPERATION_ = 'DELETE';
						}
						for (var i = 0; i < orgnChange.insertPosiList.length; i++) {
							orgnChange.insertPosiList[i].OPERATION_ = 'INSERT';
						}
						for (var i = 0; i < orgnChange.updatePosiList.length; i++) {
							orgnChange.updatePosiList[i].OPERATION_ = 'UPDATE';
						}
						for (var i = 0; i < orgnChange.deletePosiList.length; i++) {
							orgnChange.deletePosiList[i].OPERATION_ = 'DELETE';
						}
						for (var i = 0; i < orgnChange.insertEmpList.length; i++) {
							orgnChange.insertEmpList[i].OPERATION_ = 'INSERT';
						}
						for (var i = 0; i < orgnChange.updateEmpList.length; i++) {
							orgnChange.updateEmpList[i].OPERATION_ = 'UPDATE';
						}
						for (var i = 0; i < orgnChange.deleteEmpList.length; i++) {
							orgnChange.deleteEmpList[i].OPERATION_ = 'DELETE';
						}
						for (var i = 0; i < orgnChange.insertPosiEmpList.length; i++) {
							orgnChange.insertPosiEmpList[i].OPERATION_ = 'INSERT';
						}
						for (var i = 0; i < orgnChange.updatePosiEmpList.length; i++) {
							orgnChange.updatePosiEmpList[i].OPERATION_ = 'UPDATE';
						}
						for (var i = 0; i < orgnChange.deletePosiEmpList.length; i++) {
							orgnChange.deletePosiEmpList[i].OPERATION_ = 'DELETE';
						}
						for (var i = 0; i < orgnChange.insertEmpRelationList.length; i++) {
							orgnChange.insertEmpRelationList[i].OPERATION_ = 'INSERT';
						}
						for (var i = 0; i < orgnChange.updateEmpRelationList.length; i++) {
							orgnChange.updateEmpRelationList[i].OPERATION_ = 'UPDATE';
						}
						for (var i = 0; i < orgnChange.deleteEmpRelationList.length; i++) {
							orgnChange.deleteEmpRelationList[i].OPERATION_ = 'DELETE';
						}

						var orgStore = Ext.data.StoreManager.lookup('orgStore');//组装子代码数据，过滤注入。
						orgStore.setData(orgnChange.insertOrgList);
						orgStore.add(orgnChange.updateOrgList);
						orgStore.add(orgnChange.deleteOrgList);
						var dutyStore = Ext.data.StoreManager.lookup('dutyStore');//组装子代码数据，过滤注入。
						dutyStore.setData(orgnChange.insertDutyList);
						dutyStore.add(orgnChange.updateDutyList);
						dutyStore.add(orgnChange.deleteDutyList);
						var posiStore = Ext.data.StoreManager.lookup('posiStore');//组装子代码数据，过滤注入。
						posiStore.setData(orgnChange.insertPosiList);
						posiStore.add(orgnChange.updatePosiList);
						posiStore.add(orgnChange.deletePosiList);
						var empStore = Ext.data.StoreManager.lookup('empStore');//组装子代码数据，过滤注入。
						empStore.setData(orgnChange.insertEmpList);
						empStore.add(orgnChange.updateEmpList);
						empStore.add(orgnChange.deleteEmpList);
						var posiEmpStore = Ext.data.StoreManager.lookup('posiEmpStore');//组装子代码数据，过滤注入。
						posiEmpStore.setData(orgnChange.insertPosiEmpList);
						posiEmpStore.add(orgnChange.updatePosiEmpList);
						posiEmpStore.add(orgnChange.deletePosiEmpList);
						var empRelationStore = Ext.data.StoreManager.lookup('empRelationStore');//组装子代码数据，过滤注入。
						empRelationStore.setData(orgnChange.insertEmpRelationList);
						empRelationStore.add(orgnChange.updateEmpRelationList);
						empRelationStore.add(orgnChange.deleteEmpRelationList);

						Ext.getCmp('orgTab').setTitle('<spring:message code="ORG" />(' + orgStore.getCount() + ')');
						Ext.getCmp('dutyTab').setTitle('<spring:message code="DUTY" />(' + dutyStore.getCount() + ')');
						Ext.getCmp('posiTab').setTitle('<spring:message code="POSI" />(' + posiStore.getCount() + ')');
						Ext.getCmp('empTab').setTitle('<spring:message code="EMP" />(' + empStore.getCount() + ')');
						Ext.getCmp('posiEmpTab').setTitle('<spring:message code="POSI_EMP" />(' + posiEmpStore.getCount() + ')');
						Ext.getCmp('empRelationTab').setTitle('<spring:message code="EMP_RELATION" />(' + empRelationStore.getCount() + ')');

						Ext.getCmp('orgPanel').getSelectionModel().selectAll();
						Ext.getCmp('dutyPanel').getSelectionModel().selectAll();
						Ext.getCmp('posiPanel').getSelectionModel().selectAll();
						Ext.getCmp('empPanel').getSelectionModel().selectAll();
						Ext.getCmp('posiEmpPanel').getSelectionModel().selectAll();
						Ext.getCmp('empRelationPanel').getSelectionModel().selectAll();
					} else {
						Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
					}
				} else {
					Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
				}
			}
		});
	}

	function _pushUpdateMirrorServerOrgnSet() {
		var orgList = Ext.getCmp('orgPanel').getSelectionModel().getSelection();
		var INSERT_ORG_ID_LIST = new Array();
		var UPDATE_ORG_ID_LIST = new Array();
		var DELETE_ORG_ID_LIST = new Array();
		for (var i = 0; i < orgList.length; i++) {
			if (orgList[i].get('OPERATION_') == 'INSERT') {
				INSERT_ORG_ID_LIST.push(orgList[i].get('ORG_ID_'));
			} else if (orgList[i].get('OPERATION_') == 'UPDATE') {
				UPDATE_ORG_ID_LIST.push(orgList[i].get('ORG_ID_'));
			} else if (orgList[i].get('OPERATION_') == 'DELETE') {
				DELETE_ORG_ID_LIST.push(orgList[i].get('ORG_ID_'));
			}
		}
		var dutyList = Ext.getCmp('dutyPanel').getSelectionModel().getSelection();
		var INSERT_DUTY_ID_LIST = new Array();
		var UPDATE_DUTY_ID_LIST = new Array();
		var DELETE_DUTY_ID_LIST = new Array();
		for (var i = 0; i < dutyList.length; i++) {
			if (dutyList[i].get('OPERATION_') == 'INSERT') {
				INSERT_DUTY_ID_LIST.push(dutyList[i].get('DUTY_ID_'));
			} else if (dutyList[i].get('OPERATION_') == 'UPDATE') {
				UPDATE_DUTY_ID_LIST.push(dutyList[i].get('DUTY_ID_'));
			} else if (dutyList[i].get('OPERATION_') == 'DELETE') {
				DELETE_DUTY_ID_LIST.push(dutyList[i].get('DUTY_ID_'));
			}
		}
		var posiList = Ext.getCmp('posiPanel').getSelectionModel().getSelection();
		var INSERT_POSI_ID_LIST = new Array();
		var UPDATE_POSI_ID_LIST = new Array();
		var DELETE_POSI_ID_LIST = new Array();
		for (var i = 0; i < posiList.length; i++) {
			if (posiList[i].get('OPERATION_') == 'INSERT') {
				INSERT_POSI_ID_LIST.push(posiList[i].get('POSI_ID_'));
			} else if (posiList[i].get('OPERATION_') == 'UPDATE') {
				UPDATE_POSI_ID_LIST.push(posiList[i].get('POSI_ID_'));
			} else if (posiList[i].get('OPERATION_') == 'DELETE') {
				DELETE_POSI_ID_LIST.push(posiList[i].get('POSI_ID_'));
			}
		}
		var empList = Ext.getCmp('empPanel').getSelectionModel().getSelection();
		var INSERT_EMP_ID_LIST = new Array();
		var UPDATE_EMP_ID_LIST = new Array();
		var DELETE_EMP_ID_LIST = new Array();
		for (var i = 0; i < empList.length; i++) {
			if (empList[i].get('OPERATION_') == 'INSERT') {
				INSERT_EMP_ID_LIST.push(empList[i].get('EMP_ID_'));
			} else if (empList[i].get('OPERATION_') == 'UPDATE') {
				UPDATE_EMP_ID_LIST.push(empList[i].get('EMP_ID_'));
			} else if (empList[i].get('OPERATION_') == 'DELETE') {
				DELETE_EMP_ID_LIST.push(empList[i].get('EMP_ID_'));
			}
		}
		var posiEmpList = Ext.getCmp('posiEmpPanel').getSelectionModel().getSelection();
		var INSERT_POSI_EMP_ID_LIST = new Array();
		var UPDATE_POSI_EMP_ID_LIST = new Array();
		var DELETE_POSI_EMP_ID_LIST = new Array();
		for (var i = 0; i < posiEmpList.length; i++) {
			if (posiEmpList[i].get('OPERATION_') == 'INSERT') {
				INSERT_POSI_EMP_ID_LIST.push(posiEmpList[i].get('POSI_EMP_ID_'));
			} else if (posiEmpList[i].get('OPERATION_') == 'UPDATE') {
				UPDATE_POSI_EMP_ID_LIST.push(posiEmpList[i].get('POSI_EMP_ID_'));
			} else if (posiEmpList[i].get('OPERATION_') == 'DELETE') {
				DELETE_POSI_EMP_ID_LIST.push(posiEmpList[i].get('POSI_EMP_ID_'));
			}
		}
		var empRelationList = Ext.getCmp('empRelationPanel').getSelectionModel().getSelection();
		var INSERT_EMP_RELATION_ID_LIST = new Array();
		var UPDATE_EMP_RELATION_ID_LIST = new Array();
		var DELETE_EMP_RELATION_ID_LIST = new Array();
		for (var i = 0; i < empRelationList.length; i++) {
			if (empRelationList[i].get('OPERATION_') == 'INSERT') {
				INSERT_EMP_RELATION_ID_LIST.push(empRelationList[i].get('EMP_RELATION_ID_'));
			} else if (empRelationList[i].get('OPERATION_') == 'UPDATE') {
				UPDATE_EMP_RELATION_ID_LIST.push(empRelationList[i].get('EMP_RELATION_ID_'));
			} else if (empRelationList[i].get('OPERATION_') == 'DELETE') {
				DELETE_EMP_RELATION_ID_LIST.push(empRelationList[i].get('EMP_RELATION_ID_'));
			}
		}

		Ext.Ajax.request({
			url : 'pushUpdateOmMirrorServerOrgnSet.do',
			async : false,
			params : {
				'MIRROR_SERVER_ID_' : MIRROR_SERVER_ID_,
				'INSERT_ORG_ID_LIST' : INSERT_ORG_ID_LIST,
				'UPDATE_ORG_ID_LIST' : UPDATE_ORG_ID_LIST,
				'DELETE_ORG_ID_LIST' : DELETE_ORG_ID_LIST,
				'INSERT_DUTY_ID_LIST' : INSERT_DUTY_ID_LIST,
				'UPDATE_DUTY_ID_LIST' : UPDATE_DUTY_ID_LIST,
				'DELETE_DUTY_ID_LIST' : DELETE_DUTY_ID_LIST,
				'INSERT_POSI_ID_LIST' : INSERT_POSI_ID_LIST,
				'UPDATE_POSI_ID_LIST' : UPDATE_POSI_ID_LIST,
				'DELETE_POSI_ID_LIST' : DELETE_POSI_ID_LIST,
				'INSERT_EMP_ID_LIST' : INSERT_EMP_ID_LIST,
				'UPDATE_EMP_ID_LIST' : UPDATE_EMP_ID_LIST,
				'DELETE_EMP_ID_LIST' : DELETE_EMP_ID_LIST,
				'INSERT_POSI_EMP_ID_LIST' : INSERT_POSI_EMP_ID_LIST,
				'UPDATE_POSI_EMP_ID_LIST' : UPDATE_POSI_EMP_ID_LIST,
				'DELETE_POSI_EMP_ID_LIST' : DELETE_POSI_EMP_ID_LIST,
				'INSERT_EMP_RELATION_ID_LIST' : INSERT_EMP_RELATION_ID_LIST,
				'UPDATE_EMP_RELATION_ID_LIST' : UPDATE_EMP_RELATION_ID_LIST,
				'DELETE_EMP_RELATION_ID_LIST' : DELETE_EMP_RELATION_ID_LIST,
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

	}

	function _expandAllOrgnSet() {
		Ext.getCmp('orgnSetPanel').expandAll();
	}

	function _expandAllMirrorServerOrgnSet() {
		Ext.getCmp('mirrorServerOrgnSetPanel').expandAll();
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>