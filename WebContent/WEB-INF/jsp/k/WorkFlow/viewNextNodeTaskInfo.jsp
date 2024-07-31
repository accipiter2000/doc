<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="view" /><spring:message code="DOC_TYPE" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var OPERATION_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.OPERATION_ID_ != undefined) ? OPERATION_ID_ = parameters.OPERATION_ID_ : 0;
	}

	var operation;
	var emptyAssignee;

	var NODE_ID_;
	var proc;

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'loadOperation.do',
			async : false,//同步加载
			params : {
				'OPERATION_ID_' : OPERATION_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						operation = data.operation;

						if (operation.OPERATION_ == 'startProcByProcDefCode') {
							Ext.Ajax.request({//加载被修改对象
								url : 'getProcByOperationId.do',
								async : false,//同步加载
								params : {
									'OPERATION_ID_' : operation.OPERATION_ID_
								},
								callback : function(options, success, response) {
									if (success) {
										var data = Ext.decode(response.responseText);
										if (data.success) {
											proc = data.proc;
										}
									}
								}
							});
						}
					}
				}
			}
		});

		var nextNodeTaskInfoStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'nextNodeTaskInfoStore',
			autoLoad : false,
			loading : false,
			root : {},//保证autoload有效
			pageSize : -1,
			fields : [ 'NODE_ID_', 'DISPLAY_VALUE_', 'candidate', 'deletable' ],
			proxy : {
				url : 'getNextNodeTaskInfo.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'OPERATION_ID_' : OPERATION_ID_
				},
				reader : {
					type : 'json',
					root : 'children',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, node, records, successful, eOpts) {
					setTimeout('_expandAllOperationDetail()', 200);//延迟展开树
				}
			}
		});

		var nextRunningNodeInfoStore = Ext.create('Ext.data.TreeStore', {//树形数据
			storeId : 'nextRunningNodeInfoStore',
			autoLoad : false,
			loading : false,
			root : {},
			pageSize : -1,
			fields : [ 'NODE_CODE_', 'NODE_NAME_', 'SUB_PROC_DEF_CODE_', 'subProcPath', 'expression', 'candidate', 'subProcDef' ]
		});

		var nextNodeTaskInfoPanel = Ext.create('Ext.tree.Panel', {//树形表格
			id : 'nextNodeTaskInfoPanel',
			store : nextNodeTaskInfoStore,
			rootVisible : false,//根节点是否可见
			hideHeaders : true,//是否隐藏表头
			rowLines : true,//是否显示表格横线
			headerBorders : false,//是否显示表格竖线
			animate : false,//取消动画，加快显示速度
			columns : [ {
				xtype : 'treecolumn',
				dataIndex : 'DISPLAY_VALUE_',
				style : 'text-align: center; font-weight: bold;',
				flex : 1
			}, {
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				width : 80,
				renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
					if (record.get('deletable') == true && record.get('TASK_ID_') != null) {
						return '<a href="javascript:_withdrawDocTask(\'' + record.get('TASK_ID_') + '\');"><spring:message code="withdraw" /></a>';
					}
					if (record.get('deletable') == true && record.get('TASK_ID_') == null) {
						return '<a href="javascript:_withdrawDocNode(\'' + record.get('NODE_ID_') + '\');"><spring:message code="withdraw" /></a>';
					}
					if (record.get('candidate') == true) {
						return '<a href="javascript:_preAppendCandidate(\'' + record.get('NODE_ID_') + '\');"><spring:message code="append" /></a>';
					}
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
								html : '<spring:message code="manage" /><spring:message code="OPERATION" /><br /><br /><spring:message code="help.manageOperation" />'
							});
						}
					}
				} ],
				dock : 'top',
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="noData" /></div>',
				enableTextSelection : true
			},
			listeners : {
				'render' : function(gridPanel, eOpts) {
					var view = gridPanel.getView();
					var toolTip = Ext.create('Ext.tip.ToolTip', {
						target : gridPanel.getEl(),
						delegate : view.getCellSelector(),//单元格触发
						listeners : {
							beforeshow : function(sender, eOpts) { // 动态切换提示内容
								var dataIndex = view.getHeaderByCell(sender.triggerElement).dataIndex;
								if (dataIndex == 'URL_') {
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

		var nextRunningNodeInfoWin = Ext.create('Ext.window.Window', {
			id : 'nextRunningNodeInfoWin',
			title : '<spring:message code="append" />',
			modal : true,
			autoShow : false,
			maximized : false,
			maximizable : true,
			closeAction : 'hide',
			width : '80%',
			height : '80%',
			scrollable : 'y',
			items : [ {
				xtype : 'treepanel',
				id : 'nextRunningNodeInfoPanel',
				store : nextRunningNodeInfoStore,
				rootVisible : false,//根节点是否可见
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
					text : '<spring:message code="confirm" />',
					icon : 'image/icon/insert.png',
					handler : _appendCandidate
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
				region : 'center',
				layout : 'fit',//充满
				items : [ nextNodeTaskInfoPanel ]
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

		Ext.data.StoreManager.lookup('nextNodeTaskInfoStore').load();

		var nextRunningNodeInfoStore = Ext.data.StoreManager.lookup('nextRunningNodeInfoStore');//组装子代码数据，过滤注入。
		var rootNode = nextRunningNodeInfoStore.getRoot();
		rootNode.appendChild({
			'NODE_NAME_' : '<spring:message code="next" /><spring:message code="NODE" />'
		});

		Ext.getBody().unmask();//取消页面遮盖
	}

	//绘制候选面板
	function _preAppendCandidate(NODE_ID_) {
		this.NODE_ID_ = NODE_ID_;

		var nextNodeTaskInfoStore = Ext.data.StoreManager.lookup('nextNodeTaskInfoStore');
		var node = nextNodeTaskInfoStore.findNode('NODE_ID_', new RegExp('^' + NODE_ID_ + '$'));
		var subProcPath = node.get('subProcPath');
		var NODE_CODE_ = node.get('NODE_CODE_');

		var url = 'getNextRunningNodeDefList.do';
		var params = {
			'TASK_ID_' : operation.TASK_ID_
		}
		if (operation.OPERATION_ == 'startProcByProcDefCode') {
			url = 'getStartRunningNodeDefList.do'
			params = {
				'procDefCode' : proc.procDefCode
			}
		}

		//获取所有候选
		Ext.Ajax.request({//加载被修改对象
			url : url,
			async : false,//同步加载
			params : params,
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						nextRunningNodeDefList = data.nextRunningNodeDefList;
						var nextRunningNodeInfoStore = Ext.data.StoreManager.lookup('nextRunningNodeInfoStore');//组装子代码数据，过滤注入。
						var node = nextRunningNodeInfoStore.getRoot().childNodes[0];
						node.removeAll();
						emptyAssignee = false;

						//过滤候选数据，去掉其它节点的和已选的。
						nextRunningNodeDefList = _getChildNextRunningNodeDefList(nextRunningNodeDefList, subProcPath, NODE_CODE_);
						nextRunningNodeDefList = _removeExistsCandidate(nextRunningNodeDefList, NODE_ID_);

						if (nextRunningNodeDefList.length == 0) {
							node.appendChild({
								'NODE_NAME_' : '<spring:message code="none" />'
							});
						} else {
							_buildNextRunningNodeInfoPanel(node, nextRunningNodeDefList);
						}

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

	//过滤候选数据，只保留该节点的候选数据
	function _getChildNextRunningNodeDefList(nextRunningNodeDefList, subProcPath, NODE_CODE_) {
		var childNextRunningNodeDefList;
		for (var i = 0; i < nextRunningNodeDefList.length; i++) {
			if (nextRunningNodeDefList[i].nodeCode == NODE_CODE_ && (((nextRunningNodeDefList[i].subProcPath == null || nextRunningNodeDefList[i].subProcPath == '') && (subProcPath == null || subProcPath == '') || nextRunningNodeDefList[i].subProcPath == subProcPath))) {
				childNextRunningNodeDefList = new Array();
				childNextRunningNodeDefList.push(nextRunningNodeDefList[i]);
				return childNextRunningNodeDefList;
			} else if (nextRunningNodeDefList[i].candidateSubProcDefList != null) {
				for (var j = 0; j < nextRunningNodeDefList[i].candidateSubProcDefList.length; j++) {//候选子流程定义
					childNextRunningNodeDefList = _getChildNextRunningNodeDefList(nextRunningNodeDefList[i].candidateSubProcDefList[j].nextRunningNodeDefList, subProcPath, NODE_CODE_);
					if (childNextRunningNodeDefList != null) {
						return childNextRunningNodeDefList;
					}
				}
			} else if (nextRunningNodeDefList[i].assignSubProcDefList != null) {
				for (var j = 0; j < nextRunningNodeDefList[i].assignSubProcDefList.length; j++) {//候选子流程定义
					childNextRunningNodeDefList = _getChildNextRunningNodeDefList(nextRunningNodeDefList[i].assignSubProcDefList[j].nextRunningNodeDefList, subProcPath, NODE_CODE_);
					if (childNextRunningNodeDefList != null) {
						return childNextRunningNodeDefList;
					}
				}
			}
		}
	}

	//过滤候选数据，只保留未使用的候选数据
	function _removeExistsCandidate(nextRunningNodeDefList, NODE_ID_) {
		for (var i = 0; i < nextRunningNodeDefList.length; i++) {
			if (nextRunningNodeDefList[i].candidateAssigneeList != null) {
				for (var j = nextRunningNodeDefList[i].candidateAssigneeList.length - 1; j >= 0; j--) {//候选子流程定义
					if (_contains(NODE_ID_, nextRunningNodeDefList[i].candidateAssigneeList[j].id, 'ASSIGNEE_')) {
						nextRunningNodeDefList[i].candidateAssigneeList.splice(j, 1);
					}
				}
			} else if (nextRunningNodeDefList[i].candidateSubProcDefList != null) {
				for (var j = nextRunningNodeDefList[i].candidateSubProcDefList.length - 1; j >= 0; j--) {//候选子流程定义
					if (_contains(NODE_ID_, nextRunningNodeDefList[i].candidateSubProcDefList[j].procDefCode, 'SUB_PROC_DEF_CODE_') && !_containsSubProc(nextRunningNodeDefList[i].candidateSubProcDefList[j].nextRunningNodeDefList)) {
						nextRunningNodeDefList[i].candidateSubProcDefList.splice(j, 1);
					}
				}
			}
		}

		return nextRunningNodeDefList;
	}

	//节点下是否已有指定的候选
	function _contains(NODE_ID_, CODE_, fieldName) {
		var nextNodeTaskInfoStore = Ext.data.StoreManager.lookup('nextNodeTaskInfoStore');
		var childNodes = nextNodeTaskInfoStore.findNode('NODE_ID_', new RegExp('^' + NODE_ID_ + '$')).childNodes;
		for (var i = 0; i < childNodes.length; i++) {
			if (childNodes[i].get(fieldName) == CODE_) {
				return true;
			}
		}

		return false;
	}

	//节点下是否有子流程
	function _containsSubProc(nextRunningNodeDefList) {
		if (nextRunningNodeDefList != null) {
			for (var i = 0; i < nextRunningNodeDefList.length; i++) {
				if (nextRunningNodeDefList[i].nodeType == 'SUB_PROC') {
					return true;
				}
			}
		}

		return false;
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
					candidateAssignee = candidateAssignee + '<input type="checkbox" data-subprocpath="' + nextRunningNodeDefList[i].subProcPath + '" data-nodecode="' + nextRunningNodeDefList[i].nodeCode + '" value = "' + nextRunningNodeDefList[i].candidateAssigneeList[j].id + '">' + nextRunningNodeDefList[i].candidateAssigneeList[j].userName + '</input>';
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
						'checked' : false
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

	//撤回任务
	function _withdrawDocTask(TASK_ID_) {
		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="withdraw" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'withdrawDocTask.do',
						async : false,
						params : {
							'TASK_ID_' : TASK_ID_
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									var nextNodeTaskInfoStore = Ext.data.StoreManager.lookup('nextNodeTaskInfoStore');
									nextNodeTaskInfoStore.findRecord('TASK_ID_', new RegExp('^' + TASK_ID_ + '$')).remove();

									Ext.MessageBox.alert('<spring:message code="info" />', '<spring:message code="withdraw" /><spring:message code="success" />', Ext.MessageBox.INFO);
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

	//撤回节点
	function _withdrawDocNode(NODE_ID_) {
		Ext.MessageBox.show({
			title : '<spring:message code="pleaseConfirm" />',
			msg : '<spring:message code="withdraw" />',
			buttons : Ext.MessageBox.YESNO,
			icon : Ext.MessageBox.QUESTION,
			fn : function(btn) {
				if (btn == 'yes') {
					Ext.Ajax.request({
						url : 'withdrawDocNode.do',
						async : false,
						params : {
							'NODE_ID_' : NODE_ID_
						},
						callback : function(options, success, response) {
							if (success) {
								var data = Ext.decode(response.responseText);
								if (data.success) {//更新页面数据
									Ext.data.StoreManager.lookup('nextNodeTaskInfoStore').load();

									Ext.MessageBox.alert('<spring:message code="info" />', '<spring:message code="withdraw" /><spring:message code="success" />', Ext.MessageBox.INFO);
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

	function _appendCandidate() {
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

		Ext.Ajax.request({//加载被修改对象
			url : 'appendDocCandidate.do',
			async : false,//同步加载
			params : {
				'NODE_ID_' : NODE_ID_,
				'CANDIDATE_LIST' : JSON.stringify(candidateList)
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						parent.returnValue = true;

						var msg = '<spring:message code="success" />!';
						msg = msg + ' 已追加审批人： ' + data.nextAssigneeNameList;
						Ext.MessageBox.show({
							title : '<spring:message code="info" />',
							msg : msg,
							buttons : Ext.MessageBox.OK,
							icon : Ext.MessageBox.INFO,
							fn : function(btn) {
								Ext.getCmp('nextRunningNodeInfoWin').close();

								Ext.data.StoreManager.lookup('nextNodeTaskInfoStore').load();
							}
						});
					}
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

	function _expandAllOperationDetail() {
		Ext.getCmp('nextNodeTaskInfoPanel').expandAll();
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>