<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="MIRROR_SERVER" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
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

		var orgStore = Ext.create('Ext.data.Store', {
			storeId : 'orgStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'MEMO_', 'ORG_TAG_', 'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_', 'ORG_EXT_ATTR_8_', 'ORDER_', 'ORG_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_' ]
		});

		var dutyStore = Ext.create('Ext.data.Store', {
			storeId : 'dutyStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'DUTY_ID_', 'DUTY_CODE_', 'DUTY_NAME_', 'DUTY_CATEGORY_', 'MEMO_', 'DUTY_TAG_', 'DUTY_EXT_ATTR_1_', 'DUTY_EXT_ATTR_2_', 'DUTY_EXT_ATTR_3_', 'DUTY_EXT_ATTR_4_', 'DUTY_EXT_ATTR_5_', 'DUTY_EXT_ATTR_6_', 'DUTY_EXT_ATTR_7_', 'DUTY_EXT_ATTR_8_', 'ORDER_', 'DUTY_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_' ]
		});

		var posiStore = Ext.create('Ext.data.Store', {
			storeId : 'posiStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'POSI_ID_', 'POSI_CODE_', 'POSI_NAME_', 'ORG_LEADER_TYPE_', 'POSI_CATEGORY_', 'MEMO_', 'POSI_TAG_', 'POSI_EXT_ATTR_1_', 'POSI_EXT_ATTR_2_', 'POSI_EXT_ATTR_3_', 'POSI_EXT_ATTR_4_', 'POSI_EXT_ATTR_5_', 'POSI_EXT_ATTR_6_', 'POSI_EXT_ATTR_7_', 'POSI_EXT_ATTR_8_', 'ORDER_', 'POSI_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'ORG_TAG_', 'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_', 'ORG_EXT_ATTR_8_', 'ORG_STATUS_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_', 'DUTY_ID_', 'DUTY_CODE_',
					'DUTY_NAME_', 'DUTY_CATEGORY_', 'DUTY_TAG_', 'DUTY_EXT_ATTR_1_', 'DUTY_EXT_ATTR_2_', 'DUTY_EXT_ATTR_3_', 'DUTY_EXT_ATTR_4_', 'DUTY_EXT_ATTR_5_', 'DUTY_EXT_ATTR_6_', 'DUTY_EXT_ATTR_7_', 'DUTY_EXT_ATTR_8_', 'DUTY_STATUS_' ]
		});

		var empStore = Ext.create('Ext.data.Store', {
			storeId : 'empStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'EMP_ID_', 'EMP_CODE_', 'EMP_NAME_', 'PASSWORD_RESET_REQ_', 'PARTY_', 'EMP_LEVEL_', 'GENDER_', 'BIRTH_DATE_', 'TEL_', 'EMAIL_', 'IN_DATE_', 'OUT_DATE_', 'EMP_CATEGORY_', 'MEMO_', 'EMP_TAG_', 'EMP_EXT_ATTR_1_', 'EMP_EXT_ATTR_2_', 'EMP_EXT_ATTR_3_', 'EMP_EXT_ATTR_4_', 'EMP_EXT_ATTR_5_', 'EMP_EXT_ATTR_6_', 'EMP_EXT_ATTR_7_', 'EMP_EXT_ATTR_8_', 'ORDER_', 'EMP_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'ORG_TAG_', 'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_', 'ORG_EXT_ATTR_8_',
					'ORG_STATUS_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_' ]
		});

		var posiEmpStore = Ext.create('Ext.data.Store', {
			storeId : 'posiEmpStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'POSI_EMP_ID_', 'MAIN_', 'POSI_EMP_CATEGORY_', 'MEMO_', 'POSI_EMP_TAG_', 'POSI_EMP_EXT_ATTR_1_', 'POSI_EMP_EXT_ATTR_2_', 'POSI_EMP_EXT_ATTR_3_', 'POSI_EMP_EXT_ATTR_4_', 'POSI_EMP_EXT_ATTR_5_', 'POSI_EMP_EXT_ATTR_6_', 'POSI_EMP_EXT_ATTR_7_', 'POSI_EMP_EXT_ATTR_8_', 'ORDER_', 'POSI_EMP_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'EMP_ID_', 'EMP_CODE_', 'EMP_NAME_', 'PASSWORD_RESET_REQ_', 'PARTY_', 'EMP_LEVEL_', 'GENDER_', 'BIRTH_DATE_', 'TEL_', 'EMAIL_', 'IN_DATE_', 'OUT_DATE_', 'EMP_CATEGORY_', 'EMP_TAG_', 'EMP_EXT_ATTR_1_', 'EMP_EXT_ATTR_2_', 'EMP_EXT_ATTR_3_', 'EMP_EXT_ATTR_4_', 'EMP_EXT_ATTR_5_', 'EMP_EXT_ATTR_6_', 'EMP_EXT_ATTR_7_', 'EMP_EXT_ATTR_8_',
					'EMP_STATUS_', 'POSI_ID_', 'POSI_CODE_', 'POSI_NAME_', 'ORG_LEADER_TYPE_', 'POSI_CATEGORY_', 'POSI_TAG_', 'POSI_EXT_ATTR_1_', 'POSI_EXT_ATTR_2_', 'POSI_EXT_ATTR_3_', 'POSI_EXT_ATTR_4_', 'POSI_EXT_ATTR_5_', 'POSI_EXT_ATTR_6_', 'POSI_EXT_ATTR_7_', 'POSI_EXT_ATTR_8_', 'POSI_STATUS_', 'DUTY_ID_', 'DUTY_CODE_', 'DUTY_NAME_', 'DUTY_CATEGORY_', 'DUTY_TAG_', 'DUTY_EXT_ATTR_1_', 'DUTY_EXT_ATTR_2_', 'DUTY_EXT_ATTR_3_', 'DUTY_EXT_ATTR_4_', 'DUTY_EXT_ATTR_5_', 'DUTY_EXT_ATTR_6_', 'DUTY_EXT_ATTR_7_', 'DUTY_EXT_ATTR_8_', 'DUTY_STATUS_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'ORG_TAG_', 'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_',
					'ORG_EXT_ATTR_8_', 'ORG_STATUS_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_' ]
		});

		var empRelationStore = Ext.create('Ext.data.Store', {
			storeId : 'empRelationStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'OPERATION_', 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'EMP_RELATION_ID_', 'EMP_RELATION_', 'EMP_RELATION_CATEGORY_', 'MEMO_', 'EMP_RELATION_TAG_', 'EMP_RELATION_EXT_ATTR_1_', 'EMP_RELATION_EXT_ATTR_2_', 'EMP_RELATION_EXT_ATTR_3_', 'EMP_RELATION_EXT_ATTR_4_', 'EMP_RELATION_EXT_ATTR_5_', 'EMP_RELATION_EXT_ATTR_6_', 'EMP_RELATION_EXT_ATTR_7_', 'EMP_RELATION_EXT_ATTR_8_', 'ORDER_', 'EMP_RELATION_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'UPPER_EMP_ID_', 'UPPER_EMP_CODE_', 'UPPER_EMP_NAME_', 'UPPER_PASSWORD_RESET_REQ_', 'UPPER_PARTY_', 'UPPER_EMP_LEVEL_', 'UPPER_GENDER_', 'UPPER_BIRTH_DATE_', 'UPPER_TEL_', 'UPPER_EMAIL_', 'UPPER_IN_DATE_', 'UPPER_OUT_DATE_', 'UPPER_EMP_CATEGORY_', 'UPPER_MEMO_', 'UPPER_EMP_TAG_',
					'UPPER_EMP_EXT_ATTR_1_', 'UPPER_EMP_EXT_ATTR_2_', 'UPPER_EMP_EXT_ATTR_3_', 'UPPER_EMP_EXT_ATTR_4_', 'UPPER_EMP_EXT_ATTR_5_', 'UPPER_EMP_EXT_ATTR_6_', 'UPPER_EMP_EXT_ATTR_7_', 'UPPER_EMP_EXT_ATTR_8_', 'UPPER_ORDER_', 'UPPER_EMP_STATUS_', 'UPPER_CREATION_DATE_', 'UPPER_UPDATE_DATE_', 'UPPER_OPERATOR_ID_', 'UPPER_OPERATOR_NAME_', 'UPPER_ORG_ID_', 'UPPER_PARENT_ORG_ID_', 'UPPER_ORG_CODE_', 'UPPER_ORG_NAME_', 'UPPER_ORG_ABBR_NAME_', 'UPPER_ORG_TYPE_', 'UPPER_ORG_CATEGORY_', 'UPPER_ORG_TAG_', 'UPPER_ORG_EXT_ATTR_1_', 'UPPER_ORG_EXT_ATTR_2_', 'UPPER_ORG_EXT_ATTR_3_', 'UPPER_ORG_EXT_ATTR_4_', 'UPPER_ORG_EXT_ATTR_5_', 'UPPER_ORG_EXT_ATTR_6_', 'UPPER_ORG_EXT_ATTR_7_', 'UPPER_ORG_EXT_ATTR_8_', 'UPPER_ORG_STATUS_', 'UPPER_PARENT_ORG_CODE_', 'UPPER_PARENT_ORG_NAME_',
					'LOWER_EMP_ID_', 'LOWER_EMP_CODE_', 'LOWER_EMP_NAME_', 'LOWER_PASSWORD_RESET_REQ_', 'LOWER_PARTY_', 'LOWER_EMP_LEVEL_', 'LOWER_GENDER_', 'LOWER_BIRTH_DATE_', 'LOWER_TEL_', 'LOWER_EMAIL_', 'LOWER_IN_DATE_', 'LOWER_OUT_DATE_', 'LOWER_EMP_CATEGORY_', 'LOWER_MEMO_', 'LOWER_EMP_TAG_', 'LOWER_EMP_EXT_ATTR_1_', 'LOWER_EMP_EXT_ATTR_2_', 'LOWER_EMP_EXT_ATTR_3_', 'LOWER_EMP_EXT_ATTR_4_', 'LOWER_EMP_EXT_ATTR_5_', 'LOWER_EMP_EXT_ATTR_6_', 'LOWER_EMP_EXT_ATTR_7_', 'LOWER_EMP_EXT_ATTR_8_', 'LOWER_ORDER_', 'LOWER_EMP_STATUS_', 'LOWER_CREATION_DATE_', 'LOWER_UPDATE_DATE_', 'LOWER_OPERATOR_ID_', 'LOWER_OPERATOR_NAME_', 'LOWER_ORG_ID_', 'LOWER_PARENT_ORG_ID_', 'LOWER_ORG_CODE_', 'LOWER_ORG_NAME_', 'LOWER_ORG_ABBR_NAME_', 'LOWER_ORG_TYPE_', 'LOWER_ORG_CATEGORY_', 'LOWER_ORG_TAG_',
					'LOWER_ORG_EXT_ATTR_1_', 'LOWER_ORG_EXT_ATTR_2_', 'LOWER_ORG_EXT_ATTR_3_', 'LOWER_ORG_EXT_ATTR_4_', 'LOWER_ORG_EXT_ATTR_5_', 'LOWER_ORG_EXT_ATTR_6_', 'LOWER_ORG_EXT_ATTR_7_', 'LOWER_ORG_EXT_ATTR_8_', 'LOWER_ORG_STATUS_', 'LOWER_PARENT_ORG_CODE_', 'LOWER_PARENT_ORG_NAME_' ]
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
				text : '<spring:message code="pull" /><spring:message code="copy" />',
				icon : 'image/icon/transferIn.png',
				handler : _pullCopyMainServerOrgnSet
			}, {
				xtype : 'button',
				text : '<spring:message code="compare" />',
				icon : 'image/icon/associate.png',
				handler : _pullCompareMainServerOrgnSet
			}, {
				xtype : 'button',
				text : '<spring:message code="pull" /><spring:message code="replace" />',
				icon : 'image/icon/refresh.png',
				handler : _pullReplaceMainServerOrgnSet
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
						text : '<spring:message code="ORG.ORG_CATEGORY_" />',
						dataIndex : 'ORG_CATEGORY_',
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
						text : '<spring:message code="DUTY.DUTY_CATEGORY_" />',
						dataIndex : 'DUTY_CATEGORY_',
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
						text : '<spring:message code="POSI.POSI_CATEGORY_" />',
						dataIndex : 'POSI_CATEGORY_',
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
						text : '<spring:message code="EMP.EMP_CATEGORY_" />',
						dataIndex : 'EMP_CATEGORY_',
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
						text : '<spring:message code="POSI.POSI_NAME_" />',
						dataIndex : 'POSI_NAME_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="EMP.EMP_NAME_" />',
						dataIndex : 'EMP_NAME_',
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
						text : '<spring:message code="EMP_RELATION.UPPER_EMP_NAME_" />',
						dataIndex : 'UPPER_EMP_NAME_',
						style : 'text-align: center; font-weight: bold;',
						align : 'center',
						flex : 2
					}, {
						text : '<spring:message code="EMP_RELATION.LOWER_EMP_NAME_" />',
						dataIndex : 'LOWER_EMP_NAME_',
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

	function _pullCopyMainServerOrgnSet() {//修改
		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="pull" /><spring:message code="copy" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'pullCopyOmMainServerOrgnSet.do',
						async : false,
						params : {},
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
			}
		});
	}

	function _pullCompareMainServerOrgnSet() {//比较
		Ext.Ajax.request({
			url : 'pullCompareOmMainServerOrgnSet.do',
			async : false,
			params : {},
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

	function _pullReplaceMainServerOrgnSet() {
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
			url : 'pullReplaceOmMainServerOrgnSet.do',
			async : false,
			params : {
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

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>