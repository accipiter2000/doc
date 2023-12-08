<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="choose" /><spring:message code="EMP" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
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

		var posiStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'posiStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'POSI_ID_', 'POSI_CODE_', 'POSI_NAME_', 'ORG_LEADER_TYPE_', 'POSI_CATEGORY_', 'MEMO_', 'POSI_TAG_', 'POSI_EXT_ATTR_1_', 'POSI_EXT_ATTR_2_', 'POSI_EXT_ATTR_3_', 'POSI_EXT_ATTR_4_', 'POSI_EXT_ATTR_5_', 'POSI_EXT_ATTR_6_', 'POSI_EXT_ATTR_7_', 'POSI_EXT_ATTR_8_', 'ORDER_', 'POSI_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'DUTY_ID_', 'DUTY_CODE_', 'DUTY_NAME_', 'DUTY_CATEGORY_', 'DUTY_TAG_', 'DUTY_EXT_ATTR_1_', 'DUTY_EXT_ATTR_2_', 'DUTY_EXT_ATTR_3_', 'DUTY_EXT_ATTR_4_', 'DUTY_EXT_ATTR_5_', 'DUTY_EXT_ATTR_6_', 'DUTY_EXT_ATTR_7_', 'DUTY_EXT_ATTR_8_', 'DUTY_STATUS_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'ORG_TAG_', 'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_', 'ORG_EXT_ATTR_8_', 'ORG_STATUS_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_' ],
			proxy : {
				url : 'selectOmPosi.do',
				type : 'ajax',
				async : true,//false为同步
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'ORGN_SET_ID_' : ORGN_SET_ID_
				},
				reader : {
					type : 'json',
					root : 'posiList',
					totalProperty : 'total'
				}
			}
		});

		var posiEmpStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'posiEmpStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'ORGN_SET_ID_', 'ORGN_SET_CODE_', 'ORGN_SET_NAME_', 'POSI_EMP_ID_', 'MAIN_', 'POSI_EMP_CATEGORY_', 'MEMO_', 'POSI_EMP_TAG_', 'POSI_EMP_EXT_ATTR_1_', 'POSI_EMP_EXT_ATTR_2_', 'POSI_EMP_EXT_ATTR_3_', 'POSI_EMP_EXT_ATTR_4_', 'POSI_EMP_EXT_ATTR_5_', 'POSI_EMP_EXT_ATTR_6_', 'POSI_EMP_EXT_ATTR_7_', 'POSI_EMP_EXT_ATTR_8_', 'ORDER_', 'POSI_EMP_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'EMP_ID_', 'EMP_CODE_', 'EMP_NAME_', 'PASSWORD_RESET_REQ_', 'PARTY_', 'EMP_LEVEL_', 'GENDER_', 'BIRTH_DATE_', 'TEL_', 'EMAIL_', 'IN_DATE_', 'OUT_DATE_', 'EMP_CATEGORY_', 'EMP_TAG_', 'EMP_EXT_ATTR_1_', 'EMP_EXT_ATTR_2_', 'EMP_EXT_ATTR_3_', 'EMP_EXT_ATTR_4_', 'EMP_EXT_ATTR_5_', 'EMP_EXT_ATTR_6_', 'EMP_EXT_ATTR_7_', 'EMP_EXT_ATTR_8_', 'EMP_STATUS_', 'POSI_ID_', 'POSI_CODE_', 'POSI_NAME_', 'ORG_LEADER_TYPE_', 'POSI_CATEGORY_', 'POSI_TAG_', 'POSI_EXT_ATTR_1_', 'POSI_EXT_ATTR_2_', 'POSI_EXT_ATTR_3_', 'POSI_EXT_ATTR_4_', 'POSI_EXT_ATTR_5_', 'POSI_EXT_ATTR_6_', 'POSI_EXT_ATTR_7_', 'POSI_EXT_ATTR_8_', 'POSI_STATUS_', 'DUTY_ID_', 'DUTY_CODE_', 'DUTY_NAME_', 'DUTY_CATEGORY_', 'DUTY_TAG_', 'DUTY_EXT_ATTR_1_', 'DUTY_EXT_ATTR_2_', 'DUTY_EXT_ATTR_3_', 'DUTY_EXT_ATTR_4_', 'DUTY_EXT_ATTR_5_', 'DUTY_EXT_ATTR_6_', 'DUTY_EXT_ATTR_7_', 'DUTY_EXT_ATTR_8_', 'DUTY_STATUS_', 'ORG_ID_', 'PARENT_ORG_ID_', 'ORG_CODE_', 'ORG_NAME_', 'ORG_ABBR_NAME_', 'ORG_TYPE_', 'ORG_CATEGORY_', 'ORG_TAG_', 'ORG_EXT_ATTR_1_', 'ORG_EXT_ATTR_2_', 'ORG_EXT_ATTR_3_', 'ORG_EXT_ATTR_4_', 'ORG_EXT_ATTR_5_', 'ORG_EXT_ATTR_6_', 'ORG_EXT_ATTR_7_', 'ORG_EXT_ATTR_8_', 'ORG_STATUS_', 'PARENT_ORG_CODE_', 'PARENT_ORG_NAME_' ],
			proxy : {
				url : 'selectOmPosiEmp.do',
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
					root : 'posiEmpList',
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
				handler : _choosePosiEmp
			}, {
				xtype : 'button',
				text : '<spring:message code="select" />',
				icon : 'image/icon/select.png',
				handler : _selectPosiEmp
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
							html : '<spring:message code="choose" /><spring:message code="POSI_EMP" /><br /><br /><spring:message code="help.choosePosiEmp" />'
						});
					}
				}
			} ]
		});

		var posiEmpFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'posiEmpFormPanel',
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
				id : 'EMP_CODE_',
				name : 'EMP_CODE_',
				fieldLabel : '<spring:message code="EMP.EMP_CODE_" />'
			}, {
				xtype : 'textfield',
				id : 'EMP_NAME_',
				name : 'EMP_NAME_',
				fieldLabel : '<spring:message code="EMP.EMP_NAME_" />'
			} ]
		});

		var orgPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'orgPanel',
			store : orgStore,
			title : '<spring:message code="ORG" />',
			rootVisible : false,//根节点是否可见
			hideHeaders : true,//是否隐藏表头
			rowLines : false,//是否显示表格横线
			columnLines : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度
			columns : [ {
				xtype : 'treecolumn',
				text : '<spring:message code="ORG.ORG_NAME_" />',
				dataIndex : 'ORG_NAME_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
			},
			listeners : {
				'beforeitemexpand' : function(node, eOpts) {
					orgStore.proxy.extraParams.PARENT_ORG_ID_ = node.get('ORG_ID_');
				},
				'itemclick' : function(view, record, item, index, e, eOpts) {
					_selectPosiByOrgId();
					_selectPosiEmpByOrgId();
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
				text : '<spring:message code="ORG.ORG_NAME_" />',
				dataIndex : 'ORG_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			} ],
			dockedItems : [ {
				xtype : 'pagingtoolbar',
				store : posiStore,
				displayInfo : true,
				dock : 'bottom'
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
			},
			listeners : {
				'itemclick' : function(view, record, item, index, e, eOpts) {
					_selectPosiEmpByPosiId();
				}
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
				height : '40%',
				items : [ orgPanel ]
			}, {
				region : 'center',
				layout : 'fit',
				items : [ posiPanel ]
			} ]
		});

		var posiEmpPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'posiEmpPanel',
			store : posiEmpStore,
			title : '<spring:message code="POSI_EMP" />',
			headerBorders : false,//是否显示表格竖线
			selModel : {
				selType : 'checkboxmodel',
				mode : 'SIMPLE'
			},
			columns : [ {
				text : '<spring:message code="EMP.EMP_NAME_" />',
				dataIndex : 'EMP_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="ORG.ORG_NAME_" />',
				dataIndex : 'ORG_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="POSI_EMP.OPERATOR_NAME_" />',
				dataIndex : 'OPERATOR_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 100
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
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
				items : [ buttonPanel, posiEmpFormPanel ]
			}, {
				region : 'west',
				layout : 'fit',
				width : 300,
				items : [ leftPanel ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ posiEmpPanel ]
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

						var orgPanel = Ext.getCmp('orgPanel');
						orgPanel.getSelectionModel().select(rootNode.getChildAt(0));//选中新增记录
						orgPanel.fireEvent('itemclick', orgPanel, rootNode.getChildAt(0));
					}
				}
			}
		});
	}

	function _selectPosiEmp() {//查询主表数据
		var posiEmpStore = Ext.data.StoreManager.lookup('posiEmpStore');
		posiEmpStore.proxy.extraParams = {
			'ORGN_SET_ID_' : ORGN_SET_ID_,
			'EMP_CODE_' : Ext.getCmp('EMP_CODE_').getSubmitValue(),
			'EMP_NAME_' : Ext.getCmp('EMP_NAME_').getSubmitValue()
		};
		posiEmpStore.currentPage = 1;
		posiEmpStore.load();
	}

	function _selectPosiByOrgId() {
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();
		var posiStore = Ext.data.StoreManager.lookup('posiStore');
		posiStore.proxy.extraParams = {
			'ORGN_SET_ID_' : ORGN_SET_ID_,
			'ORG_ID_' : records[0].get('ORG_ID_')
		};
		posiStore.currentPage = 1;
		posiStore.load();
	}

	function _selectPosiEmpByPosiId() {//查询主表数据
		var records = Ext.getCmp('posiPanel').getSelectionModel().getSelection();
		var posiEmpStore = Ext.data.StoreManager.lookup('posiEmpStore');
		posiEmpStore.proxy.extraParams = {
			'ORGN_SET_ID_' : ORGN_SET_ID_,
			'POSI_ID_' : records[0].get('POSI_ID_')
		};
		posiEmpStore.currentPage = 1;
		posiEmpStore.load();
	}

	function _selectPosiEmpByOrgId() {//查询主表数据
		var records = Ext.getCmp('orgPanel').getSelectionModel().getSelection();
		var posiEmpStore = Ext.data.StoreManager.lookup('posiEmpStore');
		posiEmpStore.proxy.extraParams = {
			'ORGN_SET_ID_' : ORGN_SET_ID_,
			'ORG_ID_' : records[0].get('ORG_ID_')
		};
		posiEmpStore.currentPage = 1;
		posiEmpStore.load();
	}

	function _choosePosiEmp() {//选择
		var records = Ext.getCmp('posiEmpPanel').getSelectionModel().getSelection();

		if (records.length == 0) {
			Ext.MessageBox.alert('<spring:message code="warning" />', '<spring:message code="pleaseChoose" /><spring:message code="EMP" />', Ext.MessageBox.WARNING);
			return;
		}

		if (multipul == 'T') {
			var posiEmpList = new Array();
			for (var i = 0; i < records.length; i++) {
				posiEmpList.push(records[i].data);
			}
			parent.returnValue = posiEmpList;
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