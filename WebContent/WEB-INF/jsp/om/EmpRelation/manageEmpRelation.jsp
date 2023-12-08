<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="EMP_RELATION" /></title>
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
	var ORGN_SET_ID_ = null;
	var EMP_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.ORGN_SET_ID_ != undefined) ? ORGN_SET_ID_ = parameters.ORGN_SET_ID_ : 0;
		(parameters.EMP_ID_ != undefined) ? EMP_ID_ = parameters.EMP_ID_ : 0;
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

		var EMP_RELATION_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'EMP_RELATION_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var EMP_RELATION_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'EMP_RELATION_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var upperEmpRelationStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'upperEmpRelationStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'EMP_RELATION_ID_', 'EMP_RELATION_', 'EMP_RELATION_CATEGORY_', 'MEMO_', 'EMP_RELATION_TAG_', 'EMP_RELATION_EXT_ATTR_1_', 'EMP_RELATION_EXT_ATTR_2_', 'EMP_RELATION_EXT_ATTR_3_', 'EMP_RELATION_EXT_ATTR_4_', 'EMP_RELATION_EXT_ATTR_5_', 'EMP_RELATION_EXT_ATTR_6_', 'EMP_RELATION_EXT_ATTR_7_', 'EMP_RELATION_EXT_ATTR_8_', 'ORDER_', 'EMP_RELATION_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'UPPER_EMP_ID_', 'UPPER_EMP_CODE_', 'UPPER_EMP_NAME_', 'UPPER_PASSWORD_RESET_REQ_', 'UPPER_PARTY_', 'UPPER_EMP_LEVEL_', 'UPPER_GENDER_', 'UPPER_BIRTH_DATE_', 'UPPER_TEL_', 'UPPER_EMAIL_', 'UPPER_IN_DATE_', 'UPPER_OUT_DATE_', 'UPPER_EMP_CATEGORY_', 'UPPER_EMP_TAG_', 'UPPER_EMP_EXT_ATTR_1_',
					'UPPER_EMP_EXT_ATTR_2_', 'UPPER_EMP_EXT_ATTR_3_', 'UPPER_EMP_EXT_ATTR_4_', 'UPPER_EMP_EXT_ATTR_5_', 'UPPER_EMP_EXT_ATTR_6_', 'UPPER_EMP_EXT_ATTR_7_', 'UPPER_EMP_EXT_ATTR_8_', 'UPPER_EMP_STATUS_', 'UPPER_ORG_ID_', 'UPPER_PARENT_ORG_ID_', 'UPPER_ORG_CODE_', 'UPPER_ORG_NAME_', 'UPPER_ORG_ABBR_NAME_', 'UPPER_ORG_TYPE_', 'UPPER_ORG_CATEGORY_', 'UPPER_ORG_TAG_', 'UPPER_ORG_EXT_ATTR_1_', 'UPPER_ORG_EXT_ATTR_2_', 'UPPER_ORG_EXT_ATTR_3_', 'UPPER_ORG_EXT_ATTR_4_', 'UPPER_ORG_EXT_ATTR_5_', 'UPPER_ORG_EXT_ATTR_6_', 'UPPER_ORG_EXT_ATTR_7_', 'UPPER_ORG_EXT_ATTR_8_', 'UPPER_ORG_STATUS_', 'UPPER_PARENT_ORG_CODE_', 'UPPER_PARENT_ORG_NAME_', 'LOWER_EMP_ID_', 'LOWER_EMP_CODE_', 'LOWER_EMP_NAME_', 'LOWER_PASSWORD_RESET_REQ_', 'LOWER_PARTY_', 'LOWER_EMP_LEVEL_', 'LOWER_GENDER_',
					'LOWER_BIRTH_DATE_', 'LOWER_TEL_', 'LOWER_EMAIL_', 'LOWER_IN_DATE_', 'LOWER_OUT_DATE_', 'LOWER_EMP_CATEGORY_', 'LOWER_EMP_TAG_', 'LOWER_EMP_EXT_ATTR_1_', 'LOWER_EMP_EXT_ATTR_2_', 'LOWER_EMP_EXT_ATTR_3_', 'LOWER_EMP_EXT_ATTR_4_', 'LOWER_EMP_EXT_ATTR_5_', 'LOWER_EMP_EXT_ATTR_6_', 'LOWER_EMP_EXT_ATTR_7_', 'LOWER_EMP_EXT_ATTR_8_', 'LOWER_EMP_STATUS_', 'LOWER_ORG_ID_', 'LOWER_PARENT_ORG_ID_', 'LOWER_ORG_CODE_', 'LOWER_ORG_NAME_', 'LOWER_ORG_ABBR_NAME_', 'LOWER_ORG_TYPE_', 'LOWER_ORG_CATEGORY_', 'LOWER_ORG_TAG_', 'LOWER_ORG_EXT_ATTR_1_', 'LOWER_ORG_EXT_ATTR_2_', 'LOWER_ORG_EXT_ATTR_3_', 'LOWER_ORG_EXT_ATTR_4_', 'LOWER_ORG_EXT_ATTR_5_', 'LOWER_ORG_EXT_ATTR_6_', 'LOWER_ORG_EXT_ATTR_7_', 'LOWER_ORG_EXT_ATTR_8_', 'LOWER_ORG_STATUS_', 'LOWER_PARENT_ORG_CODE_',
					'LOWER_PARENT_ORG_NAME_' ],
			proxy : {
				url : 'selectOmEmpRelation.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'empRelationList',
					totalProperty : 'total'
				}
			}
		});

		var lowerEmpRelationStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'lowerEmpRelationStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'EMP_RELATION_ID_', 'EMP_RELATION_', 'EMP_RELATION_CATEGORY_', 'MEMO_', 'EMP_RELATION_TAG_', 'EMP_RELATION_EXT_ATTR_1_', 'EMP_RELATION_EXT_ATTR_2_', 'EMP_RELATION_EXT_ATTR_3_', 'EMP_RELATION_EXT_ATTR_4_', 'EMP_RELATION_EXT_ATTR_5_', 'EMP_RELATION_EXT_ATTR_6_', 'EMP_RELATION_EXT_ATTR_7_', 'EMP_RELATION_EXT_ATTR_8_', 'ORDER_', 'EMP_RELATION_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'UPPER_EMP_ID_', 'UPPER_EMP_CODE_', 'UPPER_EMP_NAME_', 'UPPER_PASSWORD_RESET_REQ_', 'UPPER_PARTY_', 'UPPER_EMP_LEVEL_', 'UPPER_GENDER_', 'UPPER_BIRTH_DATE_', 'UPPER_TEL_', 'UPPER_EMAIL_', 'UPPER_IN_DATE_', 'UPPER_OUT_DATE_', 'UPPER_EMP_CATEGORY_', 'UPPER_EMP_TAG_', 'UPPER_EMP_EXT_ATTR_1_',
					'UPPER_EMP_EXT_ATTR_2_', 'UPPER_EMP_EXT_ATTR_3_', 'UPPER_EMP_EXT_ATTR_4_', 'UPPER_EMP_EXT_ATTR_5_', 'UPPER_EMP_EXT_ATTR_6_', 'UPPER_EMP_EXT_ATTR_7_', 'UPPER_EMP_EXT_ATTR_8_', 'UPPER_EMP_STATUS_', 'UPPER_ORG_ID_', 'UPPER_PARENT_ORG_ID_', 'UPPER_ORG_CODE_', 'UPPER_ORG_NAME_', 'UPPER_ORG_ABBR_NAME_', 'UPPER_ORG_TYPE_', 'UPPER_ORG_CATEGORY_', 'UPPER_ORG_TAG_', 'UPPER_ORG_EXT_ATTR_1_', 'UPPER_ORG_EXT_ATTR_2_', 'UPPER_ORG_EXT_ATTR_3_', 'UPPER_ORG_EXT_ATTR_4_', 'UPPER_ORG_EXT_ATTR_5_', 'UPPER_ORG_EXT_ATTR_6_', 'UPPER_ORG_EXT_ATTR_7_', 'UPPER_ORG_EXT_ATTR_8_', 'UPPER_ORG_STATUS_', 'UPPER_PARENT_ORG_CODE_', 'UPPER_PARENT_ORG_NAME_', 'LOWER_EMP_ID_', 'LOWER_EMP_CODE_', 'LOWER_EMP_NAME_', 'LOWER_PASSWORD_RESET_REQ_', 'LOWER_PARTY_', 'LOWER_EMP_LEVEL_', 'LOWER_GENDER_',
					'LOWER_BIRTH_DATE_', 'LOWER_TEL_', 'LOWER_EMAIL_', 'LOWER_IN_DATE_', 'LOWER_OUT_DATE_', 'LOWER_EMP_CATEGORY_', 'LOWER_EMP_TAG_', 'LOWER_EMP_EXT_ATTR_1_', 'LOWER_EMP_EXT_ATTR_2_', 'LOWER_EMP_EXT_ATTR_3_', 'LOWER_EMP_EXT_ATTR_4_', 'LOWER_EMP_EXT_ATTR_5_', 'LOWER_EMP_EXT_ATTR_6_', 'LOWER_EMP_EXT_ATTR_7_', 'LOWER_EMP_EXT_ATTR_8_', 'LOWER_EMP_STATUS_', 'LOWER_ORG_ID_', 'LOWER_PARENT_ORG_ID_', 'LOWER_ORG_CODE_', 'LOWER_ORG_NAME_', 'LOWER_ORG_ABBR_NAME_', 'LOWER_ORG_TYPE_', 'LOWER_ORG_CATEGORY_', 'LOWER_ORG_TAG_', 'LOWER_ORG_EXT_ATTR_1_', 'LOWER_ORG_EXT_ATTR_2_', 'LOWER_ORG_EXT_ATTR_3_', 'LOWER_ORG_EXT_ATTR_4_', 'LOWER_ORG_EXT_ATTR_5_', 'LOWER_ORG_EXT_ATTR_6_', 'LOWER_ORG_EXT_ATTR_7_', 'LOWER_ORG_EXT_ATTR_8_', 'LOWER_ORG_STATUS_', 'LOWER_PARENT_ORG_CODE_',
					'LOWER_PARENT_ORG_NAME_' ],
			proxy : {
				url : 'selectOmEmpRelation.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'empRelationList',
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
							html : '<spring:message code="manage" /><spring:message code="EMP_RELATION" /><br /><br /><spring:message code="help.manageEmpRelation" />'
						});
					}
				}
			} ]
		});

		var upperEmpRelationPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'upperEmpRelationPanel',
			store : upperEmpRelationStore,
			title : '<spring:message code="upper" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			plugins : [ Ext.create('Ext.grid.plugin.RowEditing', {
				clicksToEdit : 2,
				autoCancel : false,
				errorSummary : false,
				saveBtnText : '<spring:message code="save" />',
				cancelBtnText : '<spring:message code="cancel" />',
				errorsText : '<spring:message code="prompt" />',
				dirtyText : '<div style="font: italic bold 20px Microsoft YaHei; color: red;"><spring:message code="errors.saveRequired" /></div>',
				listeners : {
					beforeedit : function(editor, context, eOpts) {
						if (editor.editing && upperEmpRelationStore.last().data.EMP_RELATION_ID_ == null) {
							upperEmpRelationStore.remove(upperEmpRelationStore.last());//删除未保存新增记录
						}

						Ext.getCmp('upperEmpRelationButtonPanel').disable();
					},
					edit : function(editor, context, eOpts) {
						var record = context.record;
						if (context.record.data.EMP_RELATION_ID_ == null) {
							Ext.Ajax.request({
								url : 'insertOmEmpRelation.do',
								async : false,
								params : {
									'ORGN_SET_ID_' : ORGN_SET_ID_,
									'UPPER_EMP_ID_' : record.get('UPPER_EMP_ID_'),
									'LOWER_EMP_ID_' : EMP_ID_,
									'EMP_RELATION_' : record.get('EMP_RELATION_'),
									'EMP_RELATION_TAG_' : record.get('EMP_RELATION_TAG_')
								},
								callback : function(options, success, response) {
									if (success) {
										var data = Ext.decode(response.responseText);
										if (data.success) {
											var empRelation = data.empRelation;
											for ( var key in empRelation) {
												record.set(key, empRelation[key]);
											}
											record.commit();

											Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
										} else {
											Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
											upperEmpRelationPanel.editingPlugin.startEdit(upperEmpRelationStore.data.length - 1, 0);
										}
									} else {
										Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
									}
								}
							});
						} else {
							Ext.Ajax.request({
								url : 'updateOmEmpRelation.do',
								async : false,
								params : {
									'ORGN_SET_ID_' : ORGN_SET_ID_,
									'EMP_RELATION_ID_' : record.get('EMP_RELATION_ID_'),
									'EMP_RELATION_' : record.get('EMP_RELATION_'),
									'EMP_RELATION_TAG_' : record.get('EMP_RELATION_TAG_')
								},
								callback : function(options, success, response) {
									if (success) {
										var data = Ext.decode(response.responseText);
										if (data.success) {
											empRelation = data.empRelation;
											for ( var key in empRelation) {
												record.set(key, empRelation[key]);
											}
											record.commit();

											Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
										} else {
											Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
											upperEmpRelationPanel.editingPlugin.startEdit(record, 0);
										}
									} else {
										Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
									}
								}
							});
						}

						Ext.getCmp('upperEmpRelationButtonPanel').enable();
					},
					canceledit : function(editor, context, eOpts) {
						if (context.record.data.EMP_RELATION_ID_ == null) {
							upperEmpRelationStore.remove(context.record);
						}

						Ext.getCmp('upperEmpRelationButtonPanel').enable();
					}
				}
			}) ],
			columns : [ {
				text : '<spring:message code="EMP.EMP_NAME_" />',
				dataIndex : 'UPPER_EMP_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1,
				editor : {
					id : 'UPPER_EMP_NAME_',
					xtype : 'displayfield',
					maxLength : 20,
					allowBlank : false
				}
			}, {
				text : '<spring:message code="EMP_RELATION.EMP_RELATION_" />',
				dataIndex : 'EMP_RELATION_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? EMP_RELATION_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				},
				editor : {
					xtype : 'combo',
					store : EMP_RELATION_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					forceSelection : true,
					allowBlank : false
				}
			}, {
				text : '<spring:message code="EMP_RELATION.EMP_RELATION_TAG_" />',
				dataIndex : 'EMP_RELATION_TAG_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1,
				editor : {
					xtype : 'textfield',
					maxLength : 40
				}
			}, {
				text : '<spring:message code="EMP_RELATION.EMP_RELATION_STATUS_" />',
				dataIndex : 'EMP_RELATION_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 120,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? EMP_RELATION_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="EMP_RELATION.OPERATOR_NAME_" />',
				dataIndex : 'OPERATOR_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 100
			} ],
			dockedItems : [ {
				id : 'upperEmpRelationButtonPanel',
				xtype : 'panel',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					margin : '2'
				},
				items : [ {
					xtype : 'button',
					text : '<spring:message code="insert" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertUpperEmpRelation
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateUpperEmpRelation
				}, {
					xtype : 'button',
					text : '<spring:message code="disable" />',
					icon : 'image/icon/disable.png',
					handler : _disableUpperEmpRelation
				}, {
					xtype : 'button',
					text : '<spring:message code="enable" />',
					icon : 'image/icon/enable.png',
					handler : _enableUpperEmpRelation
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteUpperEmpRelation
				} ],
				dock : 'top',
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			}
		});

		var lowerEmpRelationPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'lowerEmpRelationPanel',
			store : lowerEmpRelationStore,
			title : '<spring:message code="lower" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			plugins : [ Ext.create('Ext.grid.plugin.RowEditing', {
				clicksToEdit : 2,
				autoCancel : false,
				errorSummary : false,
				saveBtnText : '<spring:message code="save" />',
				cancelBtnText : '<spring:message code="cancel" />',
				errorsText : '<spring:message code="prompt" />',
				dirtyText : '<div style="font: italic bold 20px Microsoft YaHei; color: red;"><spring:message code="errors.saveRequired" /></div>',
				listeners : {
					beforeedit : function(editor, context, eOpts) {
						if (editor.editing && lowerEmpRelationStore.last().data.EMP_RELATION_ID_ == null) {
							lowerEmpRelationStore.remove(lowerEmpRelationStore.last());//删除未保存新增记录
						}

						Ext.getCmp('lowerEmpRelationButtonPanel').disable();
					},
					edit : function(editor, context, eOpts) {
						var record = context.record;
						if (context.record.data.EMP_RELATION_ID_ == null) {
							Ext.Ajax.request({
								url : 'insertOmEmpRelation.do',
								async : false,
								params : {
									'ORGN_SET_ID_' : ORGN_SET_ID_,
									'UPPER_EMP_ID_' : EMP_ID_,
									'LOWER_EMP_ID_' : record.get('LOWER_EMP_ID_'),
									'EMP_RELATION_' : record.get('EMP_RELATION_'),
									'EMP_RELATION_TAG_' : record.get('EMP_RELATION_TAG_')
								},
								callback : function(options, success, response) {
									if (success) {
										var data = Ext.decode(response.responseText);
										if (data.success) {
											var empRelation = data.empRelation;
											for ( var key in empRelation) {
												record.set(key, empRelation[key]);
											}
											record.commit();

											Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
										} else {
											Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
											lowerEmpRelationPanel.editingPlugin.startEdit(lowerEmpRelationStore.data.length - 1, 0);
										}
									} else {
										Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
									}
								}
							});
						} else {
							Ext.Ajax.request({
								url : 'updateOmEmpRelation.do',
								async : false,
								params : {
									'ORGN_SET_ID_' : ORGN_SET_ID_,
									'EMP_RELATION_ID_' : record.get('EMP_RELATION_ID_'),
									'EMP_RELATION_' : record.get('EMP_RELATION_'),
									'EMP_RELATION_TAG_' : record.get('EMP_RELATION_TAG_')
								},
								callback : function(options, success, response) {
									if (success) {
										var data = Ext.decode(response.responseText);
										if (data.success) {
											empRelation = data.empRelation;
											for ( var key in empRelation) {
												record.set(key, empRelation[key]);
											}
											record.commit();

											Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
										} else {
											Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
											lowerEmpRelationPanel.editingPlugin.startEdit(record, 0);
										}
									} else {
										Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
									}
								}
							});
						}

						Ext.getCmp('lowerEmpRelationButtonPanel').enable();
					},
					canceledit : function(editor, context, eOpts) {
						if (context.record.data.EMP_RELATION_ID_ == null) {
							lowerEmpRelationStore.remove(context.record);
						}

						Ext.getCmp('lowerEmpRelationButtonPanel').enable();
					}
				}
			}) ],
			columns : [ {
				text : '<spring:message code="EMP.EMP_NAME_" />',
				dataIndex : 'LOWER_EMP_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1,
				editor : {
					id : 'LOWER_EMP_NAME_',
					xtype : 'displayfield',
					maxLength : 20,
					allowBlank : false
				}
			}, {
				text : '<spring:message code="EMP_RELATION.EMP_RELATION_" />',
				dataIndex : 'EMP_RELATION_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 150,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? EMP_RELATION_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				},
				editor : {
					xtype : 'combo',
					store : EMP_RELATION_CodeStore,
					queryMode : 'local',
					valueField : 'CODE_',
					displayField : 'NAME_',
					forceSelection : true,
					allowBlank : false
				}
			}, {
				text : '<spring:message code="EMP_RELATION.EMP_RELATION_TAG_" />',
				dataIndex : 'EMP_RELATION_TAG_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1,
				editor : {
					xtype : 'textfield',
					maxLength : 40
				}
			}, {
				text : '<spring:message code="EMP_RELATION.EMP_RELATION_STATUS_" />',
				dataIndex : 'EMP_RELATION_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 120,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? EMP_RELATION_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="EMP_RELATION.OPERATOR_NAME_" />',
				dataIndex : 'OPERATOR_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 100
			} ],
			dockedItems : [ {
				id : 'lowerEmpRelationButtonPanel',
				xtype : 'panel',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					margin : '2'
				},
				items : [ {
					xtype : 'button',
					text : '<spring:message code="insert" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertLowerEmpRelation
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateLowerEmpRelation
				}, {
					xtype : 'button',
					text : '<spring:message code="disable" />',
					icon : 'image/icon/disable.png',
					handler : _disableLowerEmpRelation
				}, {
					xtype : 'button',
					text : '<spring:message code="enable" />',
					icon : 'image/icon/enable.png',
					handler : _enableLowerEmpRelation
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteLowerEmpRelation
				} ],
				dock : 'top',
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			}
		});

		var bottomPanel = Ext.create('Ext.Panel', {
			id : 'bottomPanel',
			layout : 'border',
			defaults : {
				border : false
			},
			items : [ {
				region : 'north',
				layout : 'fit',
				height : '50%',
				items : [ upperEmpRelationPanel ]
			}, {
				region : 'center',
				layout : 'fit',
				items : [ lowerEmpRelationPanel ]
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
				items : [ bottomPanel ]
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
		var EMP_RELATION_CodeStore = Ext.data.StoreManager.lookup('EMP_RELATION_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^EMP_RELATION$'));
		EMP_RELATION_CodeStore.add(codeStore.getRange());
		codeStore.clearFilter();
		var EMP_RELATION_STATUS_CodeStore = Ext.data.StoreManager.lookup('EMP_RELATION_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		EMP_RELATION_STATUS_CodeStore.add(codeStore.getRange());
		EMP_RELATION_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		_selectUpperEmpRelation();//加载主表数据
		_selectLowerEmpRelation();//加载主表数据

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _selectUpperEmpRelation() {
		var upperEmpRelationStore = Ext.data.StoreManager.lookup('upperEmpRelationStore');
		upperEmpRelationStore.proxy.extraParams.ORGN_SET_ID_ = ORGN_SET_ID_;
		upperEmpRelationStore.proxy.extraParams.LOWER_EMP_ID_ = EMP_ID_;
		upperEmpRelationStore.currentPage = 1;
		upperEmpRelationStore.load();
	}

	function _selectLowerEmpRelation() {
		var lowerEmpRelationStore = Ext.data.StoreManager.lookup('lowerEmpRelationStore');
		lowerEmpRelationStore.proxy.extraParams.ORGN_SET_ID_ = ORGN_SET_ID_;
		lowerEmpRelationStore.proxy.extraParams.UPPER_EMP_ID_ = EMP_ID_;
		lowerEmpRelationStore.currentPage = 1;
		lowerEmpRelationStore.load();
	}

	function _preInsertUpperEmpRelation() {//新增
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="upper" /><spring:message code="EMP" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmEmp.do?rootVisible=T&multipul=F&ORGN_SET_ID_=' + ORGN_SET_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var emp = returnValue;

						var upperEmpRelationStore = Ext.data.StoreManager.lookup('upperEmpRelationStore');
						upperEmpRelationStore.add({
							'EMP_RELATION_' : '1.1'
						});
						Ext.getCmp('upperEmpRelationPanel').editingPlugin.startEdit(upperEmpRelationStore.data.length - 1, 0);

						Ext.getCmp('upperEmpRelationPanel').editingPlugin.context.record.set('UPPER_EMP_ID_', emp.EMP_ID_);
						Ext.getCmp('UPPER_EMP_NAME_').setValue(emp.EMP_NAME_);
					}
				}
			}
		});
	}

	function _preUpdateUpperEmpRelation() {//修改
		var records = Ext.getCmp('upperEmpRelationPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP_RELATION" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.getCmp('upperEmpRelationPanel').editingPlugin.startEdit(records[0], 0);
	}

	function _disableUpperEmpRelation() {//废弃
		var records = Ext.getCmp('upperEmpRelationPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP_RELATION" />', Ext.MessageBox.WARNING);
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
						url : 'disableOmEmpRelation.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : ORGN_SET_ID_,
							'EMP_RELATION_ID_' : records[0].get('EMP_RELATION_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var empRelation = data.empRelation;
									for ( var key in empRelation) {
										records[0].set(key, empRelation[key]);
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

	function _enableUpperEmpRelation() {//恢复
		var records = Ext.getCmp('upperEmpRelationPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP_RELATION" />', Ext.MessageBox.WARNING);
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
						url : 'enableOmEmpRelation.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : ORGN_SET_ID_,
							'EMP_RELATION_ID_' : records[0].get('EMP_RELATION_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var empRelation = data.empRelation;
									for ( var key in empRelation) {
										records[0].set(key, empRelation[key]);
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

	function _deleteUpperEmpRelation() {//删除
		var records = Ext.getCmp('upperEmpRelationPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP_RELATION" />', Ext.MessageBox.WARNING);
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
						url : 'deleteOmEmpRelation.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : ORGN_SET_ID_,
							'EMP_RELATION_ID_' : records[0].get('EMP_RELATION_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('upperEmpRelationStore').remove(records[0]);//前台删除被删除数据

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

	function _preInsertLowerEmpRelation() {//新增
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="lower" /><spring:message code="EMP" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmEmp.do?rootVisible=T&multipul=F&ORGN_SET_ID_=' + ORGN_SET_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var emp = returnValue;

						var lowerEmpRelationStore = Ext.data.StoreManager.lookup('lowerEmpRelationStore');
						lowerEmpRelationStore.add({
							'EMP_RELATION_' : '1.1'
						});
						Ext.getCmp('lowerEmpRelationPanel').editingPlugin.startEdit(lowerEmpRelationStore.data.length - 1, 0);

						Ext.getCmp('lowerEmpRelationPanel').editingPlugin.context.record.set('LOWER_EMP_ID_', emp.EMP_ID_);
						Ext.getCmp('LOWER_EMP_NAME_').setValue(emp.EMP_NAME_);
					}
				}
			}
		});
	}

	function _preUpdateLowerEmpRelation() {//修改
		var records = Ext.getCmp('lowerEmpRelationPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP_RELATION" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.getCmp('lowerEmpRelationPanel').editingPlugin.startEdit(records[0], 0);
	}

	function _disableLowerEmpRelation() {//废弃
		var records = Ext.getCmp('lowerEmpRelationPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP_RELATION" />', Ext.MessageBox.WARNING);
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
						url : 'disableOmEmpRelation.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : ORGN_SET_ID_,
							'EMP_RELATION_ID_' : records[0].get('EMP_RELATION_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var empRelation = data.empRelation;
									for ( var key in empRelation) {
										records[0].set(key, empRelation[key]);
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

	function _enableLowerEmpRelation() {//恢复
		var records = Ext.getCmp('lowerEmpRelationPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP_RELATION" />', Ext.MessageBox.WARNING);
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
						url : 'enableOmEmpRelation.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : ORGN_SET_ID_,
							'EMP_RELATION_ID_' : records[0].get('EMP_RELATION_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var empRelation = data.empRelation;
									for ( var key in empRelation) {
										records[0].set(key, empRelation[key]);
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

	function _deleteLowerEmpRelation() {//删除
		var records = Ext.getCmp('lowerEmpRelationPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP_RELATION" />', Ext.MessageBox.WARNING);
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
						url : 'deleteOmEmpRelation.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : ORGN_SET_ID_,
							'EMP_RELATION_ID_' : records[0].get('EMP_RELATION_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('lowerEmpRelationStore').remove(records[0]);//前台删除被删除数据

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

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>