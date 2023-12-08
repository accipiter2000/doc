<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="ORGANIZATION" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
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

		var ORG_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'ORG_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var CATEGORY_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'CATEGORY_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var ORG_LEADER_TYPE_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'ORG_LEADER_TYPE_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var POSI_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'POSI_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var PARTY_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'PARTY_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var EMP_LEVEL_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'EMP_LEVEL_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var GENDER_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'GENDER_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

		var EMP_STATUS_CodeStore = Ext.create('Ext.data.Store', {//子代码表，数据在_init方法里从codeStore中过滤注入。
			storeId : 'EMP_STATUS_CodeStore',
			autoLoad : false,
			fields : [ 'CODE_ID_', 'PARENT_CODE_ID_', 'CATEGORY_', 'CODE_', 'NAME_', 'EXT_ATTR_1_', 'EXT_ATTR_2_', 'EXT_ATTR_3_', 'EXT_ATTR_4_', 'EXT_ATTR_5_', 'EXT_ATTR_6_', 'ORDER_' ]
		});

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

		var orgStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'orgStore',
			autoLoad : false,
			loading : false,
			root : {},//保证autoload有效
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'MEMO_', 'ORG_TAG_', 'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_', 'ORG_EXT_ATTR_8_', 'ORDER_', 'ORG_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_' ],
			proxy : {
				url : 'selectOmOrg.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'orgList',
					totalProperty : 'total'
				}
			}
		});

		var posiStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'posiStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'POSI_ID_', 'POSI_CODE_', 'POSI_NAME_', 'ORG_LEADER_TYPE_', 'POSI_CATEGORY_', 'MEMO_', 'POSI_TAG_', 'POSI_EXT_ATTR_1_', 'POSI_EXT_ATTR_2_', 'POSI_EXT_ATTR_3_', 'POSI_EXT_ATTR_4_', 'POSI_EXT_ATTR_5_', 'POSI_EXT_ATTR_6_', 'POSI_EXT_ATTR_7_', 'POSI_EXT_ATTR_8_', 'ORDER_', 'POSI_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'DUTY_ID_', 'DUTY_CODE_', 'DUTY_NAME_', 'DUTY_CATEGORY_', 'DUTY_TAG_', 'DUTY_EXT_ATTR_1_', 'DUTY_EXT_ATTR_2_', 'DUTY_EXT_ATTR_3_', 'DUTY_EXT_ATTR_4_', 'DUTY_EXT_ATTR_5_', 'DUTY_EXT_ATTR_6_', 'DUTY_EXT_ATTR_7_', 'DUTY_EXT_ATTR_8_', 'DUTY_STATUS_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'ORG_TAG_',
					'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_', 'ORG_EXT_ATTR_8_', 'ORG_STATUS_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_' ],
			proxy : {
				url : 'selectOmPosi.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'posiList',
					totalProperty : 'total'
				}
			}
		});

		var empStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'empStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'EMP_ID_', 'EMP_CODE_', 'EMP_NAME_', 'PASSWORD_RESET_REQ_', 'PARTY_', 'EMP_LEVEL_', 'GENDER_', 'BIRTH_DATE_', 'TEL_', 'EMAIL_', 'IN_DATE_', 'OUT_DATE_', 'EMP_CATEGORY_', 'MEMO_', 'EMP_TAG_', 'EMP_EXT_ATTR_1_', 'EMP_EXT_ATTR_2_', 'EMP_EXT_ATTR_3_', 'EMP_EXT_ATTR_4_', 'EMP_EXT_ATTR_5_', 'EMP_EXT_ATTR_6_', 'EMP_EXT_ATTR_7_', 'EMP_EXT_ATTR_8_', 'ORDER_', 'EMP_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'ORG_TAG_', 'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_', 'ORG_EXT_ATTR_8_', ],
			proxy : {
				url : 'selectOmEmp.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'empList',
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
						_switchToOrgnSet();
					}
				}
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
							html : '<spring:message code="manage" /><spring:message code="ORGANIZATION" /><br /><br /><spring:message code="help.manageOrganization" />'
						});
					}
				}
			} ]
		});

		var orgPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'orgPanel',
			store : orgStore,
			title : '<spring:message code="ORG" />',
			rootVisible : false,//根节点是否可见
			hideHeaders : false,//是否隐藏表头
			rowLines : true,//是否显示表格横线
			headerBorders : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				xtype : 'treecolumn',
				text : '<spring:message code="ORG.ORG_NAME_" />',
				dataIndex : 'ORG_NAME_',
				style : 'text-align: center; font-weight: bold;',
				flex : 2
			}, {
				text : '<spring:message code="ORG.ORG_CODE_" />',
				dataIndex : 'ORG_CODE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="ORG.ORG_STATUS_" />',
				dataIndex : 'ORG_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? ORG_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
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
					text : '<spring:message code="insert" /><spring:message code="child" /><spring:message code="ORG" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertChildOrg
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateOrg
				}, {
					xtype : 'button',
					text : '<spring:message code="move" />',
					icon : 'image/icon/move.png',
					handler : _moveOrg
				}, {
					xtype : 'button',
					text : '<spring:message code="disable" />',
					icon : 'image/icon/disable.png',
					handler : _disableOrg
				}, {
					xtype : 'button',
					text : '<spring:message code="enable" />',
					icon : 'image/icon/enable.png',
					handler : _enableOrg
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteOrg
				}, {
					xtype : 'button',
					text : '<spring:message code="view" />',
					icon : 'image/icon/view.png',
					handler : _viewOrg
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
								html : '<spring:message code="manage" /><spring:message code="ORG" /><br /><br /><spring:message code="help.manageOrg" />'
							});
						}
					}
				} ],
				dock : 'top',
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
			},
			listeners : {
				'beforeitemexpand' : function(node, eOpts) {
					orgStore.proxy.extraParams.ORGN_SET_ID_ = Ext.getCmp('ORGN_SET_ID_').getSubmitValue();
					orgStore.proxy.extraParams.PARENT_ORG_ID_ = node.get('ORG_ID_');
				},
				'itemclick' : function(view, record, item, index, e, eOpts) {
					_selectPosi();
					_selectEmp();
				},
				'render' : function(gridPanel, eOpts) {
					var view = gridPanel.getView();
					var toolTip = Ext.create('Ext.tip.ToolTip', {
						target : gridPanel.getEl(),
						delegate : view.getCellSelector(),//单元格触发
						listeners : {
							beforeshow : function(sender, eOpts) { // 动态切换提示内容
								var dataIndex = view.getHeaderByCell(sender.triggerElement).dataIndex;
								if (dataIndex == 'ORG_NAME_') {
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

		var posiPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'posiPanel',
			store : posiStore,
			title : '<spring:message code="POSI" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="POSI.POSI_NAME_" />',
				dataIndex : 'POSI_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="POSI.POSI_CODE_" />',
				dataIndex : 'POSI_CODE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DUTY.DUTY_NAME_" />',
				dataIndex : 'DUTY_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="POSI.ORG_LEADER_TYPE_" />',
				dataIndex : 'ORG_LEADER_TYPE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? ORG_LEADER_TYPE_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="POSI.POSI_CATEGORY_" />',
				dataIndex : 'POSI_CATEGORY_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 52,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? CATEGORY_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="POSI.POSI_TAG_" />',
				dataIndex : 'POSI_TAG_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="POSI.ORDER_" />',
				dataIndex : 'ORDER_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 48
			}, {
				text : '<spring:message code="POSI.POSI_STATUS_" />',
				dataIndex : 'POSI_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? POSI_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
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
					text : '<spring:message code="insert" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertPosi
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdatePosi
				}, {
					xtype : 'button',
					text : '<spring:message code="move" />',
					icon : 'image/icon/transferOut.png',
					handler : _movePosi
				}, {
					xtype : 'button',
					text : '<spring:message code="disable" />',
					icon : 'image/icon/disable.png',
					handler : _disablePosi
				}, {
					xtype : 'button',
					text : '<spring:message code="enable" />',
					icon : 'image/icon/enable.png',
					handler : _enablePosi
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deletePosi
				}, {
					xtype : 'button',
					text : '<spring:message code="view" />',
					icon : 'image/icon/view.png',
					handler : _viewPosi
				}, {
					xtype : 'button',
					text : '<spring:message code="manage" /><spring:message code="POSI_EMP" />',
					icon : 'image/icon/manage.png',
					handler : _managePosiEmp
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
								html : '<spring:message code="manage" /><spring:message code="POSI" /><br /><br /><spring:message code="help.managePosi" />'
							});
						}
					}
				} ],
				dock : 'top',
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			}
		});

		var empPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'empPanel',
			store : empStore,
			title : '<spring:message code="EMP" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SINGLE'
			},
			columns : [ {
				text : '<spring:message code="EMP.EMP_NAME_" />',
				dataIndex : 'EMP_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="EMP.EMP_CODE_" />',
				dataIndex : 'EMP_CODE_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="EMP.PARTY_" />',
				dataIndex : 'PARTY_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? PARTY_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="EMP.EMP_LEVEL_" />',
				dataIndex : 'EMP_LEVEL_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 52,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? EMP_LEVEL_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="EMP.GENDER_" />',
				dataIndex : 'GENDER_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 52,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? GENDER_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="EMP.TEL_" />',
				dataIndex : 'TEL_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 100,
			}, {
				text : '<spring:message code="EMP.EMAIL_" />',
				dataIndex : 'EMAIL_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="EMP.EMP_CATEGORY_" />',
				dataIndex : 'EMP_CATEGORY_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 52,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? CATEGORY_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
				}
			}, {
				text : '<spring:message code="EMP.EMP_TAG_" />',
				dataIndex : 'EMP_TAG_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="EMP.ORDER_" />',
				dataIndex : 'ORDER_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 48
			}, {
				text : '<spring:message code="EMP.EMP_STATUS_" />',
				dataIndex : 'EMP_STATUS_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 104,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					return (value != null && value != '') ? EMP_STATUS_CodeStore.findRecord('CODE_', new RegExp('^' + value + '$')).get('NAME_') : value;
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
					text : '<spring:message code="insert" />',
					icon : 'image/icon/insert.png',
					handler : _preInsertEmp
				}, {
					xtype : 'button',
					text : '<spring:message code="update" />',
					icon : 'image/icon/update.png',
					handler : _preUpdateEmp
				}, {
					xtype : 'button',
					text : '<spring:message code="reset" /><spring:message code="EMP.PASSWORD_" />',
					icon : 'image/icon/update.png',
					handler : _resetEmpPassword
				}, {
					xtype : 'button',
					text : '<spring:message code="transferOut" />',
					icon : 'image/icon/transferOut.png',
					handler : _transferOutEmp
				}, {
					xtype : 'button',
					text : '<spring:message code="transferIn" />',
					icon : 'image/icon/transferIn.png',
					handler : _transferInEmp
				}, {
					xtype : 'button',
					text : '<spring:message code="disable" />',
					icon : 'image/icon/disable.png',
					handler : _disableEmp
				}, {
					xtype : 'button',
					text : '<spring:message code="enable" />',
					icon : 'image/icon/enable.png',
					handler : _enableEmp
				}, {
					xtype : 'button',
					text : '<spring:message code="delete" />',
					icon : 'image/icon/delete.png',
					handler : _deleteEmp
				}, {
					xtype : 'button',
					text : '<spring:message code="view" />',
					icon : 'image/icon/view.png',
					handler : _viewEmp
				}, {
					xtype : 'button',
					text : '<spring:message code="manage" /><spring:message code="EMP_POSI" />',
					icon : 'image/icon/manage.png',
					handler : _manageEmpPosi
				}, {
					xtype : 'button',
					text : '<spring:message code="manage" /><spring:message code="EMP_RELATION" />',
					icon : 'image/icon/manage.png',
					handler : _manageEmpRelation
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
								html : '<spring:message code="manage" /><spring:message code="EMP" /><br /><br /><spring:message code="help.manageEmp" />'
							});
						}
					}
				} ],
				dock : 'top',
			}, {
				xtype : 'pagingtoolbar',//分页
				store : empStore,
				displayInfo : true,
				dock : 'bottom'
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			}
		});

		var rightPanel = Ext.create('Ext.Panel', {
			id : 'rightPanel',
			layout : 'border',
			defaults : {
				border : false
			},
			items : [ {
				region : 'north',
				layout : 'fit',
				height : '40%',
				items : [ posiPanel ]
			}, {
				region : 'center',
				layout : 'fit',
				items : [ empPanel ]
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
				width : 720,
				split : true,
				collapsible : true,
				header : false,
				items : [ orgPanel ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ rightPanel ]
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
		var ORG_STATUS_CodeStore = Ext.data.StoreManager.lookup('ORG_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		ORG_STATUS_CodeStore.add(codeStore.getRange());
		ORG_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var CATEGORY_CodeStore = Ext.data.StoreManager.lookup('CATEGORY_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^CATEGORY$'));
		CATEGORY_CodeStore.add(codeStore.getRange());
		codeStore.clearFilter();
		var ORG_LEADER_TYPE_CodeStore = Ext.data.StoreManager.lookup('ORG_LEADER_TYPE_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^ORG_LEADER_TYPE$'));
		ORG_LEADER_TYPE_CodeStore.add(codeStore.getRange());
		ORG_LEADER_TYPE_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var POSI_STATUS_CodeStore = Ext.data.StoreManager.lookup('POSI_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		POSI_STATUS_CodeStore.add(codeStore.getRange());
		POSI_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var PARTY_CodeStore = Ext.data.StoreManager.lookup('PARTY_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^PARTY$'));
		PARTY_CodeStore.add(codeStore.getRange());
		PARTY_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var EMP_LEVEL_CodeStore = Ext.data.StoreManager.lookup('EMP_LEVEL_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^EMP_LEVEL$'));
		EMP_LEVEL_CodeStore.add(codeStore.getRange());
		EMP_LEVEL_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var GENDER_CodeStore = Ext.data.StoreManager.lookup('GENDER_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^GENDER$'));
		GENDER_CodeStore.add(codeStore.getRange());
		GENDER_CodeStore.insert(0, {});
		codeStore.clearFilter();
		var EMP_STATUS_CodeStore = Ext.data.StoreManager.lookup('EMP_STATUS_CodeStore');
		codeStore.filter('CATEGORY_', new RegExp('^STATUS$'));
		EMP_STATUS_CodeStore.add(codeStore.getRange());
		EMP_STATUS_CodeStore.insert(0, {});
		codeStore.clearFilter();

		var orgnSetStore = Ext.data.StoreManager.lookup('orgnSetStore');//设置组织架构套缺省值
		Ext.getCmp('ORGN_SET_ID_').setValue(orgnSetStore.getAt(0));

		_switchToOrgnSet();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _switchToOrgnSet() {
		Ext.Ajax.request({//加载机构根节点
			url : 'selectOmOrg.do',
			async : false,//同步加载
			params : {
				'ORGN_SET_ID_' : Ext.getCmp('ORGN_SET_ID_').getSubmitValue(),
				'ORG_ID_' : Ext.util.Cookies.get('COM_ID_')
			},
			callback : function(options, success, response) {
				if (success) {
					Ext.data.StoreManager.lookup('posiStore').removeAll();
					Ext.data.StoreManager.lookup('empStore').removeAll();
					var rootNode = Ext.data.StoreManager.lookup('orgStore').getRootNode();
					rootNode.removeAll();
					var data = Ext.decode(response.responseText);
					if (data.success && data.orgList.length > 0) {
						rootNode.appendChild(data.orgList, false, false, true);
						rootNode.getChildAt(0).expand();
						rootNode.expand();

						var orgPanel = Ext.getCmp('orgPanel');
						orgPanel.getSelectionModel().select(rootNode.getChildAt(0));//选中新增记录
						orgPanel.fireEvent('itemclick', orgPanel, rootNode.getChildAt(0));
					}
				}
			}
		});
	}

	function _preInsertChildOrg() {//新增
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="parent" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="child" /><spring:message code="ORG" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertOmOrg.do?ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&PARENT_ORG_ID_=' + records[0].get('ORG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var org = returnValue;

						if (records[0].data.loaded) {//如果上级节点已经加载，则直接在前台添加该新增的节点。
							org.loaded = true;
							org.expandable = false;
							records[0].appendChild(org);
						}
						if (!records[0].data.expanded) {//展开上级节点。如果上级节点未加载，则从服务器实时加载，其中包括新增的节点。
							records[0].expand();
						}

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdateOrg() {//修改
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="ORG" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preUpdateOmOrg.do?ORGN_SET_ID_=' + records[0].get('ORGN_SET_ID_') + '&ORG_ID_=' + records[0].get('ORG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var org = returnValue;
						for ( var key in org) {
							records[0].set(key, org[key]);
						}

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _moveOrg() {//移动
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="parent" /><spring:message code="ORG" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmOrg.do?rootVisible=T&multipul=F&ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var parentOrg = returnValue;
						Ext.MessageBox.show({
							title : '<spring:message code="pleaseConfirm" />',
							msg : '<spring:message code="move" />',
							buttons : Ext.MessageBox.YESNO,
							icon : Ext.MessageBox.QUESTION,
							fn : function(btn) {
								if (btn == 'yes') {
									Ext.Ajax.request({
										url : 'moveOmOrg.do',
										async : false,
										params : {
											'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
											'ORG_ID_' : records[0].get('ORG_ID_'),
											'PARENT_ORG_ID_' : parentOrg.ORG_ID_
										},
										callback : function(options, success, response) {
											if (success) {
												var data = Ext.decode(response.responseText);
												if (data.success) {//更新页面数据
													var org = data.org;
													for ( var key in org) {
														records[0].set(key, org[key]);
													}

													var rootNode = Ext.data.StoreManager.lookup('orgStore').getRootNode();
													var parentNode = rootNode;
													if (parentOrg.ORG_ID_ != null && parentOrg.ORG_ID_ != '') {
														parentNode = rootNode.findChild('ORG_ID_', parentOrg.ORG_ID_, true);
													}

													if (parentNode.data.loaded) {
														parentNode.appendChild(records[0]);
													} else {
														records[0].remove();
													}
													if (!parentNode.data.expanded) {
														parentNode.expand();
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
				}
			}
		});
	}

	function _disableOrg() {//废弃
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
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
						url : 'disableOmOrg.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
							'ORG_ID_' : records[0].get('ORG_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var org = data.org;
									for ( var key in org) {
										records[0].set(key, org[key]);
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

	function _enableOrg() {//恢复
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
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
						url : 'enableOmOrg.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
							'ORG_ID_' : records[0].get('ORG_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var org = data.org;
									for ( var key in org) {
										records[0].set(key, org[key]);
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

	function _deleteOrg() {//删除
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
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
						url : 'deleteOmOrg.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
							'ORG_ID_' : records[0].get('ORG_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									records[0].remove();

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

	function _viewOrg() {
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="ORG" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewOmOrg.do?ORGN_SET_ID_=' + records[0].get('ORGN_SET_ID_') + '&ORG_ID_=' + records[0].get('ORG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _selectPosi() {
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();
		var posiStore = Ext.data.StoreManager.lookup('posiStore');
		posiStore.proxy.extraParams.ORGN_SET_ID_ = Ext.getCmp('ORGN_SET_ID_').getSubmitValue();
		posiStore.proxy.extraParams.ORG_ID_ = records[0].get('ORG_ID_');
		posiStore.currentPage = 1;
		posiStore.load();
	}

	function _preInsertPosi() {//新增
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="POSI" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertOmPosi.do?ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&ORG_ID_=' + records[0].get('ORG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var posi = returnValue;
						Ext.data.StoreManager.lookup('posiStore').add(posi);//前台新增数据

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdatePosi() {//修改
		var records = Ext.getCmp('posiPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="POSI" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="POSI" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preUpdateOmPosi.do?ORGN_SET_ID_=' + records[0].get('ORGN_SET_ID_') + '&POSI_ID_=' + records[0].get('POSI_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var posi = returnValue;
						for ( var key in posi) {
							records[0].set(key, posi[key]);
						}

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _movePosi() {//移动
		var records = Ext.getCmp('posiPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="POSI" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="ORG" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmOrg.do?rootVisible=F&multipul=F&ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&ORG_ID_=' + records[0].get('ORG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null && returnValue.ORG_ID_ != records[0].get('ORG_ID_')) {
						var org = returnValue;
						Ext.MessageBox.show({
							title : '<spring:message code="pleaseConfirm" />',
							msg : '<spring:message code="move" />',
							buttons : Ext.MessageBox.YESNO,
							icon : Ext.MessageBox.QUESTION,
							fn : function(btn) {
								if (btn == 'yes') {
									Ext.Ajax.request({
										url : 'moveOmPosi.do',
										async : false,
										params : {
											'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
											'POSI_ID_' : records[0].get('POSI_ID_'),
											'ORG_ID_' : org.ORG_ID_
										},
										callback : function(options, success, response) {
											if (success) {
												var data = Ext.decode(response.responseText);
												if (data.success) {
													Ext.data.StoreManager.lookup('posiStore').remove(records[0]);
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
				}
			}
		});
	}

	function _disablePosi() {//废弃
		var records = Ext.getCmp('posiPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="POSI" />', Ext.MessageBox.WARNING);
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
						url : 'disableOmPosi.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
							'POSI_ID_' : records[0].get('POSI_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var posi = data.posi;
									for ( var key in posi) {
										records[0].set(key, posi[key]);
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

	function _enablePosi() {//恢复
		var records = Ext.getCmp('posiPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="POSI" />', Ext.MessageBox.WARNING);
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
						url : 'enableOmPosi.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
							'POSI_ID_' : records[0].get('POSI_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var posi = data.posi;
									for ( var key in posi) {
										records[0].set(key, posi[key]);
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

	function _deletePosi() {//删除
		var records = Ext.getCmp('posiPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="POSI" />', Ext.MessageBox.WARNING);
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
						url : 'deleteOmPosi.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
							'POSI_ID_' : records[0].get('POSI_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('posiStore').remove(records[0]);//前台删除被删除数据

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

	function _viewPosi() {//查看
		var records = Ext.getCmp('posiPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="POSI" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="POSI" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewOmPosi.do?ORGN_SET_ID_=' + records[0].get('ORGN_SET_ID_') + '&POSI_ID_=' + records[0].get('POSI_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _managePosiEmp() {//管理岗位人员
		var records = Ext.getCmp('posiPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="POSI" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="manage" /><spring:message code="POSI_EMP" /> - ' + records[0].get('POSI_NAME_'),
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 1024,
			height : '80%',
			html : '<iframe src="manageOmPosiEmp.do?ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&ORG_ID_=' + Ext.getCmp('orgPanel').getSelectionModel().getSelection()[0].get('ORG_ID_') + '&POSI_ID_=' + records[0].get('POSI_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _selectEmp() {
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();
		var empStore = Ext.data.StoreManager.lookup('empStore');
		empStore.proxy.extraParams.ORGN_SET_ID_ = Ext.getCmp('ORGN_SET_ID_').getSubmitValue();
		empStore.proxy.extraParams.ORG_ID_ = records[0].get('ORG_ID_');
		empStore.currentPage = 1;
		empStore.load();
	}

	function _preInsertEmp() {//新增
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="insert" /><spring:message code="EMP" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preInsertOmEmp.do?ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&ORG_ID_=' + records[0].get('ORG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var emp = returnValue;
						Ext.data.StoreManager.lookup('empStore').add(emp);//前台新增数据

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _preUpdateEmp() {//修改
		var records = Ext.getCmp('empPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="update" /><spring:message code="EMP" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preUpdateOmEmp.do?ORGN_SET_ID_=' + records[0].get('ORGN_SET_ID_') + '&EMP_ID_=' + records[0].get('EMP_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {//更新页面数据
						var emp = returnValue;
						for ( var key in emp) {
							records[0].set(key, emp[key]);
						}

						Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
					}
				}
			}
		});
	}

	function _resetEmpPassword() {
		var records = Ext.getCmp('empPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP" />', Ext.MessageBox.WARNING);
			return;
		}

		Ext.MessageBox.prompt('<spring:message code="pleaseConfirm" />', '<spring:message code="EMP.TEMP_PASSWORD_" />', function(btn, text, opt) {
			if (btn == 'ok') {
				Ext.Ajax.request({
					url : 'resetOmEmpPassword.do',
					async : false,
					params : {
						'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
						'EMP_ID_' : records[0].get('EMP_ID_'),
						'PASSWORD_' : hex_md5(text)
					},
					callback : function(options, success, response) {
						if (success) {
							var data = Ext.decode(response.responseText);
							if (data.success) {//更新页面数据
								var emp = data.emp;
								for ( var key in emp) {
									records[0].set(key, emp[key]);
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
		});
	}

	function _transferOutEmp() {//转出人员
		var records = Ext.getCmp('empPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="ORG" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmOrg.do?rootVisible=F&multipul=F&ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&ORG_ID_=' + records[0].get('ORG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null && returnValue.ORG_ID_ != records[0].get('ORG_ID_')) {
						var org = returnValue;
						Ext.MessageBox.show({
							title : '<spring:message code="pleaseConfirm" />',
							msg : '<spring:message code="transferOut" />',
							buttons : Ext.MessageBox.YESNO,
							icon : Ext.MessageBox.QUESTION,
							fn : function(btn) {
								if (btn == 'yes') {
									Ext.Ajax.request({
										url : 'moveOmEmp.do',
										async : false,
										params : {
											'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
											'EMP_ID_' : records[0].get('EMP_ID_'),
											'ORG_ID_' : org.ORG_ID_
										},
										callback : function(options, success, response) {
											if (success) {
												var data = Ext.decode(response.responseText);
												if (data.success) {
													returnValue = null;
													win = Ext.create('Ext.window.Window', {
														title : '<spring:message code="update" /><spring:message code="EMP" /><spring:message code="POSI" /> - ' + records[0].get('EMP_NAME_'),
														modal : true,
														autoShow : true,
														maximized : false,
														maximizable : true,
														width : 800,
														height : '80%',
														html : '<iframe src="manageOmEmpPosi.do?ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&ORG_ID_=' + org.ORG_ID_ + '&EMP_ID_=' + records[0].get('EMP_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
													});

													Ext.data.StoreManager.lookup('empStore').remove(records[0]);
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
				}
			}
		});
	}

	function _transferInEmp() {//转入人员
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="EMP" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseOmEmp.do?rootVisible=F&multipul=F&ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&ORG_ID_=' + records[0].get('ORG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null && returnValue.ORG_ID_ != records[0].get('ORG_ID_')) {
						var emp = returnValue;
						Ext.MessageBox.show({
							title : '<spring:message code="pleaseConfirm" />',
							msg : '<spring:message code="transferIn" />',
							buttons : Ext.MessageBox.YESNO,
							icon : Ext.MessageBox.QUESTION,
							fn : function(btn) {
								if (btn == 'yes') {
									Ext.Ajax.request({
										url : 'moveOmEmp.do',
										async : false,
										params : {
											'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
											'EMP_ID_' : emp.EMP_ID_,
											'ORG_ID_' : records[0].get('ORG_ID_')
										},
										callback : function(options, success, response) {
											if (success) {
												var data = Ext.decode(response.responseText);
												if (data.success) {
													returnValue = null;
													win = Ext.create('Ext.window.Window', {
														title : '<spring:message code="update" /><spring:message code="EMP" /><spring:message code="POSI" />  - ' + records[0].get('EMP_NAME_'),
														modal : true,
														autoShow : true,
														maximized : false,
														maximizable : true,
														width : 800,
														height : '80%',
														html : '<iframe src="manageOmEmpPosi.do?ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&ORG_ID_=' + records[0].get('ORG_ID_') + '&EMP_ID_=' + emp.EMP_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
													});

													Ext.data.StoreManager.lookup('empStore').add(data.emp);
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
				}
			}
		});
	}

	function _disableEmp() {//废弃
		var records = Ext.getCmp('empPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP" />', Ext.MessageBox.WARNING);
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
						url : 'disableOmEmp.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
							'EMP_ID_' : records[0].get('EMP_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var emp = data.emp;
									for ( var key in emp) {
										records[0].set(key, emp[key]);
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

	function _enableEmp() {//恢复
		var records = Ext.getCmp('empPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP" />', Ext.MessageBox.WARNING);
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
						url : 'enableOmEmp.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
							'EMP_ID_' : records[0].get('EMP_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var emp = data.emp;
									for ( var key in emp) {
										records[0].set(key, emp[key]);
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

	function _deleteEmp() {//删除
		var records = Ext.getCmp('empPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP" />', Ext.MessageBox.WARNING);
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
						url : 'deleteOmEmp.do',
						async : false,
						params : {
							'ORGN_SET_ID_' : records[0].get('ORGN_SET_ID_'),
							'EMP_ID_' : records[0].get('EMP_ID_')
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('empStore').remove(records[0]);//前台删除被删除数据

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

	function _viewEmp() {//查看
		var records = Ext.getCmp('empPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="view" /><spring:message code="EMP" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="viewOmEmp.do?ORGN_SET_ID_=' + records[0].get('ORGN_SET_ID_') + '&EMP_ID_=' + records[0].get('EMP_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
		});
	}

	function _manageEmpPosi() {
		var records = Ext.getCmp('empPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="manage" /><spring:message code="EMP_POSI" /> - ' + records[0].get('EMP_NAME_'),
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 1024,
			height : '80%',
			html : '<iframe src="manageOmEmpPosi.do?ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&ORG_ID_=' + Ext.getCmp('orgPanel').getSelectionModel().getSelection()[0].get('ORG_ID_') + '&EMP_ID_=' + records[0].get('EMP_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
				}
			}
		});
	}

	function _manageEmpRelation() {
		var records = Ext.getCmp('empPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP" />', Ext.MessageBox.WARNING);
			return;
		}

		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="manage" /><spring:message code="EMP_RELATION" /> - ' + records[0].get('EMP_NAME_'),
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="manageOmEmpRelation.do?ORGN_SET_ID_=' + Ext.getCmp('ORGN_SET_ID_').getSubmitValue() + '&EMP_ID_=' + records[0].get('EMP_ID_') + '&ORG_ID_=' + Ext.getCmp('orgPanel').getSelectionModel().getSelection()[0].get('ORG_ID_') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
				}
			}
		});
	}
</script>
</head>
<body>
</body>
</html>