<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="choose" /><spring:message code="ORG" /></title>
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
	var ORGN_SET_ID_ = null;//组织架构套
	var ORG_ID_ = null;//根机构ID
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.rootVisible != undefined) ? rootVisible = parameters.rootVisible : 0;
		(parameters.multipul != undefined) ? multipul = parameters.multipul : 0;
		(parameters.ORGN_SET_ID_ != undefined) ? ORGN_SET_ID_ = parameters.ORGN_SET_ID_ : 0;
		(parameters.ORG_ID_ != undefined) ? ORG_ID_ = parameters.ORG_ID_ : 0;
	}

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

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
				extraParams : {
					'ORGN_SET_ID_' : ORGN_SET_ID_
				},
				reader : {
					type : 'json',
					root : 'orgList',
					totalProperty : 'total'
				}
			}
		});

		var orgPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'orgPanel',
			store : orgStore,
			title : '<spring:message code="ORG" />',
			rootVisible : rootVisible == 'T',//根节点是否可见
			hideHeaders : true,//是否隐藏表头
			rowLines : false,//是否显示表格横线
			columnLines : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度
			selModel : {
				selType : 'checkboxmodel',
				mode : (multipul == 'T') ? 'SIMPLE' : 'SINGLE'
			},
			columns : [ {
				xtype : 'treecolumn',
				text : '<spring:message code="ORG.ORG_NAME_" />',
				dataIndex : 'ORG_NAME_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
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
					text : '<spring:message code="choose" />',
					icon : 'image/icon/choose.png',
					handler : _chooseOrg
				}, {
					xtype : 'button',
					text : '<spring:message code="switchTo" /><spring:message code="parent" /><spring:message code="ORG" />',
					icon : 'image/icon/parent.png',
					handler : _switchToParentOrg
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
								html : '<spring:message code="choose" /><spring:message code="ORG" /><br /><br /><spring:message code="help.chooseOrg" />'
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
					orgStore.proxy.extraParams.PARENT_ORG_ID_ = node.get('ORG_ID_');
				},
				'itemdblclick' : function(view, record, item, index, e, eOpts) {
					_chooseOrg();
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
				items : [ orgPanel ]
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

		_switchToOrg();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _switchToOrg() {
		if (ORGN_SET_ID_ == null) {
			Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.loadDataFailed" />', Ext.MessageBox.ERROR);
			return;
		}

		var orgRootOnly = false;
		if (ORG_ID_ == null) {
			orgRootOnly = true;
		}
		Ext.Ajax.request({//加载机构根节点
			url : 'selectOmOrg.do',
			async : false,//同步加载
			params : {
				'ORGN_SET_ID_' : ORGN_SET_ID_,
				'ORG_ID_' : ORG_ID_,
				'orgRootOnly' : orgRootOnly
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success && data.orgList.length > 0) {
						var rootNode = Ext.data.StoreManager.lookup('orgStore').getRootNode();
						rootNode.removeAll();
						rootNode.appendChild(data.orgList, false, false, true);
						rootNode.expandChildren();
						rootNode.expand();
					}
				}
			}
		});
	}

	function _chooseOrg() {//选择
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="ORG" />', Ext.MessageBox.WARNING);
			return;
		}

		if (multipul == 'T') {
			var orgList = new Array();
			for (var i = 0; i < records.length; i++) {
				orgList.push(records[i].data);
			}
			parent.returnValue = orgList;
		} else {
			parent.returnValue = records[0].data;
		}

		_close();
	}

	function _switchToParentOrg() {//上级机构
		if (ORG_ID_ == null) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="noMoreParent" />', Ext.MessageBox.WARNING);
			return;
		}

		var orgStore = Ext.data.StoreManager.lookup('orgStore');
		var org = orgStore.getRootNode().getChildAt(0);
		ORG_ID_ = org.get('PARENT_ORG_ID_');

		_switchToOrg();
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>