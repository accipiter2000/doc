<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="menu" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');

		var empMenuStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'empMenuStore',
			autoLoad : true,
			loading : true,
			root : {},//保证autoload有效
			pageSize : -1,
			fields : [ 'POSI_MENU_ID_', 'POSI_EMP_MENU_ID_', 'POSI_EMP_ID_', 'POSI_ID_', 'POSI_NAME_', 'EMP_NAME_', 'MENU_ID_', 'ORDER_', 'POSI_MENU_STATUS_', 'POSI_EMP_MENU_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'PARENT_MENU_ID_', 'MENU_NAME_', 'MENU_TYPE_', 'URL_', 'ICON_' ],
			proxy : {
				url : 'selectEmpMenu.do',
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
				load : function(store, node, records, successful, eOpts) {
					_init();
				}
			}
		});

		var menuPanel = Ext.create('Ext.Panel', {
			id : 'menuPanel',
			layout : 'accordion'
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
			padding : '1 0 1 0',
			defaults : {
				border : false,
				frame : true
			},
			items : [ {
				region : 'center',
				layout : 'fit',//充满
				items : [ menuPanel ]
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

		var rootNode = Ext.data.StoreManager.lookup('empMenuStore').getRootNode();
		var menuPanel = Ext.getCmp('menuPanel');
		menuPanel.suspendLayout = true;

		for (var i = rootNode.childNodes.length - 1; i >= 0; i--) {
			var childEmpMenuStore = Ext.create('Ext.data.Store', {
				fields : [ 'POSI_EMP_MENU_ID_', 'POSI_EMP_ID_', 'POSI_NAME_', 'EMP_NAME_', 'MENU_ID_', 'ORDER_', 'POSI_EMP_MENU_STATUS_', 'CREATION_DATE_', 'UPDATE_DATE_', 'OPERATOR_ID_', 'OPERATOR_NAME_', 'PARENT_MENU_ID_', 'MENU_NAME_', 'MENU_TYPE_', 'URL_', 'ICON_' ],
			});

			var childNode = rootNode.childNodes[i];
			childEmpMenuStore.add(childNode.childNodes);
			var panel = new Ext.create('Ext.grid.Panel', {
				store : childEmpMenuStore,
				title : childNode.get('MENU_NAME_'),
				headerBorders : false,//是否显示表格竖线
				titleAlign : 'center',
				hideHeaders : true,
				rowLines : false,
				columnLines : false,
				columns : [ {
					text : '<spring:message code="MENU.MENU_NAME_" />',
					dataIndex : 'MENU_NAME_',
					style : 'text-align: center; font-weight: bold;',
					flex : 1,
					renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
						return '<span class="' + record.get('ICON_') + '"></span>' + value;
					}
				} ],
				viewConfig : {
					stripeRows : false
				},
				listeners : {
					'itemclick' : function(view, record, item, index, e, eOpts) {
						if (record.get('MENU_TYPE_') == '11') {
							Ext.Ajax.request({
								url : record.get('URL_'),
								async : false,
								params : {},
								callback : function(options, success, response) {
									if (success) {
										var data = Ext.decode(response.responseText);
										if (data.success) {
											var operator = data.operator;

											Ext.util.Cookies.set('EMP_ID_', operator.EMP_ID_);
											Ext.util.Cookies.set('EMP_CODE_', operator.EMP_CODE_);
											Ext.util.Cookies.set('EMP_NAME_', operator.EMP_NAME_);
											Ext.util.Cookies.set('ORG_ID_', operator.ORG_ID_);
											Ext.util.Cookies.set('ORG_CODE_', operator.ORG_CODE_);
											Ext.util.Cookies.set('ORG_NAME_', operator.ORG_NAME_);
											Ext.util.Cookies.set('COM_ID_', operator.COM_ID_);
											Ext.util.Cookies.set('COM_CODE_', operator.COM_CODE_);
											Ext.util.Cookies.set('COM_NAME_', operator.COM_NAME_);
											Ext.util.Cookies.set('DUTY_ID_', operator.DUTY_ID_);
											Ext.util.Cookies.set('DUTY_CODE_', operator.DUTY_CODE_);
											Ext.util.Cookies.set('DUTY_NAME_', operator.DUTY_NAME_);
											Ext.util.Cookies.set('POSI_ID_', operator.POSI_ID_);
											Ext.util.Cookies.set('POSI_CODE_', operator.POSI_CODE_);
											Ext.util.Cookies.set('POSI_NAME_', operator.POSI_NAME_);
											Ext.util.Cookies.set('POSI_EMP_ID_', operator.POSI_EMP_ID_);

											top.banner.document.getElementById('EMP_NAME_').innerHTML = operator.EMP_NAME_;
											top.banner.document.getElementById('POSI_NAME_').innerHTML = operator.POSI_NAME_;
											top.banner.document.getElementById('ORG_NAME_').innerHTML = operator.ORG_NAME_;
											top.banner.document.getElementById('COM_NAME_').innerHTML = operator.COM_NAME_;

											Toast.alert('<spring:message code="info" />', operator.EMP_NAME_, 1000);
										} else {
											Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
										}
									} else {
										Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
									}
								}
							});
						} else {
							top.content.location.href = record.get('URL_');
						}
					}
				}
			})
			menuPanel.insert(0, panel);
		}

		menuPanel.suspendLayout = false;
		menuPanel.updateLayout();

		Ext.getBody().unmask();
	}
</script>
</head>
<body>
</body>
</html>