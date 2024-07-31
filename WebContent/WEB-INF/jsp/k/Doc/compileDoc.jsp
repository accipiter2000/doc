<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="update" /><spring:message code="DOC" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	//获取url中的入参
	var DOC_ID_ = '';
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.DOC_ID_ != undefined) ? DOC_ID_ = parameters.DOC_ID_ : 0;
	}

	var doc;
	var emptyAssignee;

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		if (DOC_ID_ != null && DOC_ID_ != '') {
			Ext.Ajax.request({//加载被修改对象
				url : 'loadDoc.do',
				async : false,//同步加载
				params : {
					'DOC_ID_' : DOC_ID_
				},
				callback : function(options, success, response) {
					if (success) {
						var data = Ext.decode(response.responseText);
						if (data.success) {
							doc = data.doc;
						}
					}
				}
			});
		}

		var nextRunningNodeInfoStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'nextRunningNodeInfoStore',
			autoLoad : false,
			loading : false,
			root : {
				'NODE_NAME_' : '<spring:message code="next" /><spring:message code="NODE" />'
			},
			pageSize : -1,
			fields : [ 'NODE_CODE_', 'NODE_NAME_', 'subProcPath', 'expression', 'candidate', 'subProcDef' ]
		});

		var buttonPanel = Ext.create('Ext.Panel', {//按钮
			id : 'buttonPanel',
			layout : 'column',
			defaults : {
				labelAlign : 'right',
				margin : '2'
			},
			items : [ {
				id : 'approval',
				xtype : 'button',
				text : '<spring:message code="submitForApproval" />',
				icon : 'image/icon/transferOut.png',
				hidden : (DOC_ID_ == '' || (doc.PROC_STATUS_ != '0' && doc.PROC_STATUS_ != '8')) ? true : false,
				handler : _submitForApproval
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
							html : '<spring:message code="manage" /><spring:message code="ORGANIZATION" /><br /><br /><spring:message code="help.manageOrganization" />'
						});
					}
				}
			} ]
		});

		var tabPanel = Ext.create('Ext.tab.Panel', {//tab
			id : 'tabPanel',
			items : [ {
				itemId : 'docPanel',
				title : '<spring:message code="DOC" />',
				layout : 'fit',
				html : '<iframe id="docPanel" src="preUpdateDoc.do?DOC_ID_=' + DOC_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
			}, {
				itemId : 'docDataPanel',
				title : '<spring:message code="DOC_DATA" />',
				layout : 'fit',
				html : '<iframe id="docDataPanel" src="preUpdateDocData.do?DOC_ID_=' + DOC_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
			}, {
				itemId : 'docRiderPanel',
				title : '<spring:message code="RIDER" />',
				layout : 'fit',
				html : '<iframe id="docRiderPanel" src="manageDocRider.do?DOC_ID_=' + DOC_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
			} ]
		});

		var nextRunningNodeInfoWin = Ext.create('Ext.window.Window', {
			id : 'nextRunningNodeInfoWin',
			title : '<spring:message code="next" /><spring:message code="NODE" />',
			modal : true,
			autoShow : false,
			maximized : false,
			maximizable : true,
			closeAction : 'hide',
			width : 800,
			height : '80%',
			items : [ {
				xtype : 'treepanel',
				id : 'nextRunningNodeInfoPanel',
				store : nextRunningNodeInfoStore,
				rootVisible : true,//根节点是否可见
				hideHeaders : true,
				rowLines : false,//是否显示表格横线
				columnLines : false,//是否显示表格竖线
				border : false,
				animate : false,//取消动画，加快显示速度
				columns : [ {
					xtype : 'treecolumn',
					text : '<spring:message code="NODE_NAME_" />',
					dataIndex : 'NODE_NAME_',
					style : 'text-align: center; font-weight: bold;',
					flex : 1
				}, {
					text : '<spring:message code="ASSIGNEE_" />',
					dataIndex : 'expression',
					cellWrap : true,
					style : 'text-align: center; font-weight: bold;',
					flex : 1
				} ],
				viewConfig : {
					emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>'
				},
				listeners : {
					'checkchange' : function(node, checked, eOpts) {
						_toggleSubProcDefChoosable(node, checked);
					}
				}
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
					text : '<spring:message code="submitForApproval" />',
					icon : 'image/icon/transferOut.png',
					handler : _submit
				}, {
					xtype : 'button',
					text : '<spring:message code="cancel" />',
					icon : 'image/icon/close.png',
					handler : function() {
						nextRunningNodeInfoWin.close();
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
								html : '<spring:message code="insert" /><spring:message code="ORG" /><br /><br /><spring:message code="help.insertOrg" />'
							});
						}
					}
				} ],
				dock : 'top',
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
				items : [ tabPanel ]
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

		if (DOC_ID_ == null || DOC_ID_ == '') {
			Ext.getCmp('tabPanel').getComponent('docDataPanel').tab.hide();
			Ext.getCmp('tabPanel').getComponent('docRiderPanel').tab.hide();
		}

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _submitForApproval() {
		Ext.Ajax.request({
			url : 'getStartRunningNodeDefList.do',
			async : false,
			params : {
				'procDefCode' : doc.PROC_DEF_CODE_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						nextRunningNodeDefList = data.nextRunningNodeDefList;
						var nextRunningNodeInfoStore = Ext.data.StoreManager.lookup('nextRunningNodeInfoStore');//组装子代码数据，过滤注入。
						var node = nextRunningNodeInfoStore.getRoot();
						node.removeAll();
						emptyAssignee = false;

						_buildNextRunningNodeInfoPanel(node, nextRunningNodeDefList);

						Ext.getCmp('nextRunningNodeInfoPanel').expandAll();
						Ext.getCmp('nextRunningNodeInfoWin').show();

						//默认子流程定义未被选择时，其下的候选人设置为disable状态
						var nodes = Ext.data.StoreManager.lookup('nextRunningNodeInfoStore').getData();//组装子代码数据，过滤注入。
						var node;
						for (var i = 0; i < nodes.getCount(); i++) {
							node = nodes.getAt(i);
							if (node.get('candidate') && node.get('subProcDef') && !node.get('checked'))
								_toggleSubProcDefChoosable(node, false);
						}
					}
				}
			}
		});
	}

	//构建候选树形表现
	function _buildNextRunningNodeInfoPanel(node, nextRunningNodeDefList) {
		for (var i = 0; i < nextRunningNodeDefList.length; i++) {
			if (nextRunningNodeDefList[i].candidateAssigneeList != null) {//候选人，显示为checkbox列表，单行，
				if (nextRunningNodeDefList[i].candidateAssigneeList.length == 0 && nextRunningNodeDefList[i].autoCompleteEmptyAssignee != '1') {//未配置候选人，且节点的自动完成空办理人的属性不为1，设置空办理人为true
					emptyAssignee = true;
				}

				var candidateAssignee = '';
				for (var j = 0; j < nextRunningNodeDefList[i].candidateAssigneeList.length; j++) {
					if (nextRunningNodeDefList[i].candidateAssigneeList.length == 1) {
						candidateAssignee = candidateAssignee + '<input type="checkbox" data-subprocpath="' + nextRunningNodeDefList[i].subProcPath + '" data-nodecode="' + nextRunningNodeDefList[i].nodeCode + '" value = "' + nextRunningNodeDefList[i].candidateAssigneeList[j].id + '" checked>' + nextRunningNodeDefList[i].candidateAssigneeList[j].userName + '</input>';
					} else {
						candidateAssignee = candidateAssignee + '<input type="checkbox" data-subprocpath="' + nextRunningNodeDefList[i].subProcPath + '" data-nodecode="' + nextRunningNodeDefList[i].nodeCode + '" value = "' + nextRunningNodeDefList[i].candidateAssigneeList[j].id + '">' + nextRunningNodeDefList[i].candidateAssigneeList[j].userName + '</input>';
					}
				}

				node.appendChild({
					'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
					'NODE_NAME_' : nextRunningNodeDefList[i].nodeName,
					'expression' : candidateAssignee,
					'candidate' : true
				});
			}
			if (nextRunningNodeDefList[i].candidateSubProcDefList != null) {//候选子流程，显示为树形结构，每个候选子流程定义为一个带checkbox的节点。
				if (nextRunningNodeDefList[i].candidateSubProcDefList.length == 0) {//未配置候选子流程定义，设置空办理人为true
					emptyAssignee = true;
				}

				var nextNode = node.appendChild({//该候选子流程定义所在的节点
					'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
					'NODE_NAME_' : nextRunningNodeDefList[i].nodeName,
					'subProcDef' : true
				});

				for (var j = 0; j < nextRunningNodeDefList[i].candidateSubProcDefList.length; j++) {//候选子流程定义
					var subProcDefNode = nextNode.appendChild({
						'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
						'NODE_NAME_' : nextRunningNodeDefList[i].candidateSubProcDefList[j].procDefName,
						'subProcPath' : nextRunningNodeDefList[i].subProcPath,
						'expression' : nextRunningNodeDefList[i].candidateSubProcDefList[j].procDefCode,
						'subProcDef' : true,
						'candidate' : true,
						'checked' : nextRunningNodeDefList[i].candidateSubProcDefList.length == 1 ? true : false
					});

					_buildNextRunningNodeInfoPanel(subProcDefNode, nextRunningNodeDefList[i].candidateSubProcDefList[j].nextRunningNodeDefList);//级联处理嵌套的子流程定义
				}
			}
			if (nextRunningNodeDefList[i].assigneeList != null) {//办理人
				if (nextRunningNodeDefList[i].assigneeList.length == 0 && nextRunningNodeDefList[i].autoCompleteEmptyAssignee != '1') {//未配置办理人，且节点的自动完成空办理人的属性不为1，设置空办理人为true
					emptyAssignee = true;
				}

				var assignee = '';
				for (var j = 0; j < nextRunningNodeDefList[i].assigneeList.length; j++) {
					assignee += nextRunningNodeDefList[i].assigneeList[j].userName + ' ';
				}

				node.appendChild({
					'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
					'NODE_NAME_' : nextRunningNodeDefList[i].nodeName,
					'expression' : assignee
				});
			}
			if (nextRunningNodeDefList[i].assignSubProcDefList != null) {//办理子流程定义
				if (nextRunningNodeDefList[i].assignSubProcDefList.length == 0) {//未配置办理子流程定义，设置空办理人为true
					emptyAssignee = true;
				}

				var nextNode = node.appendChild({//该子流程定义所在的节点
					'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
					'NODE_NAME_' : nextRunningNodeDefList[i].nodeName,
					'subProcDef' : true
				});

				for (var j = 0; j < nextRunningNodeDefList[i].assignSubProcDefList.length; j++) {//子流程定义
					var subProcDefNode = nextNode.appendChild({
						'NODE_CODE_' : nextRunningNodeDefList[i].nodeCode,
						'NODE_NAME_' : nextRunningNodeDefList[i].assignSubProcDefList[j].procDefName,
						'subProcPath' : nextRunningNodeDefList[i].subProcPath,
						'expression' : nextRunningNodeDefList[i].assignSubProcDefList[j].procDefCode,
						'subProcDef' : true
					});

					_buildNextRunningNodeInfoPanel(subProcDefNode, nextRunningNodeDefList[i].assignSubProcDefList[j].nextRunningNodeDefList);//级联处理嵌套的子流程定义
				}
			}
		}
	}

	//切换子流程定义下的候选人disable状态。
	function _toggleSubProcDefChoosable(node, checked) {
		var checkboxes = Ext.getCmp('nextRunningNodeInfoPanel').getEl().select('input').elements;
		var subProcPath = node.data.subProcPath;
		if (subProcPath == null || subProcPath == '') {
			subProcPath = node.data.NODE_CODE_ + ':' + node.data.expression;
		} else {
			subProcPath = subProcPath + '.' + node.data.NODE_CODE_ + ':' + node.data.expression;
		}
		for (var i = 0; i < checkboxes.length; i++) {
			if (checkboxes[i].dataset.subprocpath == subProcPath) {
				if (checked) {
					checkboxes[i].disabled = false;
				} else {
					checkboxes[i].disabled = true;
				}
			}
		}
	}

	function _submit() {
		if (emptyAssignee) {
			Ext.MessageBox.alert('<spring:message code="error" />', '下一步审批未配置人员，请联系管理员', Ext.MessageBox.ERROR);
			return;
		}

		var candidateList = _buildCandidateList();//构建候选数据

		//有候选但一个都未选，错误提示。
		if (!candidateList) {
			Ext.MessageBox.alert('<spring:message code="error" />', '请选择下一步审批人或子流程！', Ext.MessageBox.ERROR);
			return;
		}

		Ext.Ajax.request({
			url : 'restartDocProc.do',
			async : false,
			params : {
				'DOC_ID_' : doc.DOC_ID_,
				'CANDIDATE_LIST' : JSON.stringify(candidateList)
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {//更新页面数据
						var doc = data.doc;
						parent.returnValue = data.doc;

						Ext.MessageBox.show({
							title : '<spring:message code="info" />',
							msg : '上报成功，下一步审批人是 ' + data.nextAssigneeNameList,
							buttons : Ext.MessageBox.OK,
							icon : Ext.MessageBox.INFO,
							fn : function(btn) {
								_close();
							}
						});
					} else {
						Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
					}
				} else {
					Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
				}
			}
		});
	}

	function _buildCandidateList() {
		var checkboxes = Ext.getCmp('nextRunningNodeInfoPanel').getEl().select('input').elements;
		var candidateList = new Array();

		//候选人，从checkbox input中获取。
		for (var i = 0; i < checkboxes.length; i++) {
			if (checkboxes[i].disabled) {
				continue;
			}

			var candidate = null;
			candidateList.forEach(function(item, index, arr) {
				if (item['subProcPath'] == checkboxes[i].dataset.subprocpath && item['nodeCode'] == checkboxes[i].dataset.nodecode) {
					candidate = item;
				}
			});
			if (candidate == null) {
				candidate = new Object();
				candidate['subProcPath'] = checkboxes[i].dataset.subprocpath;
				candidate['nodeCode'] = checkboxes[i].dataset.nodecode;
				candidateList.push(candidate);
			}

			if (checkboxes[i].checked && !checkboxes[i].disabled) {
				if (candidate['candidateExpression'] == null) {
					candidate['candidateExpression'] = checkboxes[i].value;
				} else {
					candidate['candidateExpression'] = candidate['candidateExpression'] + ',' + checkboxes[i].value;
				}
			}
		}

		//候选子流程，从datastore中获取。
		var nodes = Ext.data.StoreManager.lookup('nextRunningNodeInfoStore').getData();//组装子代码数据，过滤注入。
		var node;
		for (var i = 0; i < nodes.getCount(); i++) {
			node = nodes.getAt(i);
			if (node.get('checked') == null) {
				continue;
			}

			var candidate = null;
			candidateList.forEach(function(item, index, arr) {
				if (item['subProcPath'] == node.get('subProcPath') && item['nodeCode'] == node.get('NODE_CODE_')) {
					candidate = item;
				}
			});
			if (candidate == null) {
				candidate = new Object();
				candidate['subProcPath'] = node.get('subProcPath');
				candidate['nodeCode'] = node.get('NODE_CODE_');
				candidateList.push(candidate);
			}

			if (node.get('checked')) {
				if (candidate['candidateExpression'] == null) {
					candidate['candidateExpression'] = node.get('expression');
				} else {
					candidate['candidateExpression'] = candidate['candidateExpression'] + ',' + node.get('expression');
				}
			}
		}

		//有候选人但一个都未选，提示异常。
		for (var i = 0; i < candidateList.length; i++) {
			if (candidateList[i]['candidateExpression'] == null) {
				return false;
			}
		}

		return candidateList;
	}

	function _afterInsertDoc() {
		DOC_ID_ = doc.DOC_ID_;
		var tabPanel = Ext.getCmp('tabPanel');
		tabPanel.getComponent('docDataPanel').html = '<iframe src="preUpdateDocData.do?DOC_ID_=' + DOC_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>';
		tabPanel.getComponent('docRiderPanel').html = '<iframe src="manageDocRider.do?DOC_ID_=' + DOC_ID_ + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>';
		tabPanel.getComponent('docDataPanel').tab.show();
		tabPanel.getComponent('docRiderPanel').tab.show();
		tabPanel.setActiveTab('docDataPanel');

		Ext.getCmp('approval').setHidden(false);

		parent.returnValue = doc;
	}

	function _afterUpdateDoc() {
		parent.returnValue = doc;

		//刷新docDataPanel
		var docDataPanel = document.getElementById('docDataPanel');
		if (docDataPanel != null) {
			docDataPanel.contentWindow.location.reload();
		}
	}

	function _afterUpdateDocData() {
		if (parent.docDataUpdated != null) {
			parent.docDataUpdated = true;
		}

		//刷新docPanel
		var docPanel = document.getElementById('docPanel');
		if (docPanel != null) {
			docPanel.contentWindow.location.href = 'preUpdateDoc.do?DOC_ID_=' + DOC_ID_;
		}
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>