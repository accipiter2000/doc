package com.opendynamic.doc.service.impl.mysql;

import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opendynamic.OdConfig;
import com.opendynamic.OdUtils;
import com.opendynamic.doc.service.ApprovalMemoService;
import com.opendynamic.doc.service.DocService;
import com.opendynamic.doc.service.WorkFlowService;
import com.opendynamic.ff.FfOperation;
import com.opendynamic.ff.service.FfService;
import com.opendynamic.ff.vo.CandidateList;
import com.opendynamic.ff.vo.FfResult;
import com.opendynamic.ff.vo.Node;
import com.opendynamic.ff.vo.Proc;
import com.opendynamic.ff.vo.ProcDef;
import com.opendynamic.ff.vo.RunningNodeDef;
import com.opendynamic.ff.vo.Task;
import com.opendynamic.om.service.OmService;
import com.opendynamic.om.vo.Org;
import com.opendynamic.om.vo.PosiEmp;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class WorkFlowServiceImpl implements WorkFlowService {
    @Autowired
    private DocService docService;
    @Autowired
    private ApprovalMemoService approvalMemoService;
    @Autowired
    private FfService ffService;
    @Autowired
    private OmService omService;

    @Override
    public FfResult restartDocProc(String DOC_ID_, Map<String, Object> nodeVarMap, CandidateList candidateList, Map<String, Object> operator) {
        Map<String, Object> doc = docService.loadDoc(DOC_ID_);

        if (!doc.get("PROC_STATUS_").equals("0") && !doc.get("PROC_STATUS_").equals("8")) {
            throw new RuntimeException("errors.alreadySubmit");
        }

        String procDefCode = (String) doc.get("PROC_DEF_CODE_");
        String bizType = (String) doc.get("DOC_TYPE_NAME_");
        String bizCode = (String) doc.get("DOC_CODE_");
        String bizName = (String) doc.get("DOC_NAME_");
        String bizDesc = (String) doc.get("MEMO_");

        if (nodeVarMap == null) {
            nodeVarMap = new HashMap<>();
        }
        nodeVarMap.put("drafter", operator);

        FfResult ffResult = ffService.startProcByProcDefCode(procDefCode, DOC_ID_, bizType, bizCode, bizName, bizDesc, (String) operator.get("POSI_EMP_ID_"), nodeVarMap, candidateList);
        Proc proc = ffResult.getCreateProcList().get(0);

        approvalMemoService.insertApprovalMemo(OdUtils.getUuid(), null, null, null, null, "起草", proc.getProcId(), proc.getProcId(), DOC_ID_, (String) operator.get("POSI_EMP_ID_"), (String) operator.get("EMP_CODE_"), (String) operator.get("EMP_NAME_"), (String) operator.get("POSI_EMP_ID_"), (String) operator.get("EMP_CODE_"), (String) operator.get("EMP_NAME_"), (String) operator.get("ORG_ID_"), (String) operator.get("ORG_NAME_"), (String) operator.get("COM_ID_"), (String) operator.get("COM_NAME_"), new Date(), null, "1", "上报审批", new Date(), "1", null, null, ffResult.getOperationId());

        handleApproveMemo(ffResult);

        docService.updateProcId(DOC_ID_, proc.getProcId());
        docService.updateProcStatus(DOC_ID_, proc.getProcStatus());
        docService.updateDocHis(DOC_ID_);

        // 重新上报，合并以前的审批意见
        if (doc.get("PROC_ID_") != null) {
            approvalMemoService.replaceApprovalMemoProcId((String) doc.get("PROC_ID_"), proc.getProcId());
        }

        return ffResult;
    }

    public FfResult restartDocIsolateProc(String DOC_ID_, String isolateSubProcNodeId, Map<String, Object> nodeVarMap, CandidateList candidateList, Map<String, Object> operator) {
        Map<String, Object> doc = docService.loadDoc(DOC_ID_);

        if (!doc.get("PROC_STATUS_").equals("0") && !doc.get("PROC_STATUS_").equals("8")) {
            throw new RuntimeException("errors.alreadySubmit");
        }

        String bizType = (String) doc.get("DOC_TYPE_NAME_");
        String bizCode = (String) doc.get("DOC_CODE_");
        String bizName = (String) doc.get("DOC_NAME_");
        String bizDesc = (String) doc.get("MEMO_");

        if (nodeVarMap == null) {
            nodeVarMap = new HashMap<>();
        }
        nodeVarMap.put("drafter", operator);

        FfResult ffResult = ffService.startIsolateSubProc(isolateSubProcNodeId, DOC_ID_, bizType, bizCode, bizName, bizDesc, (String) operator.get("POSI_EMP_ID_"), nodeVarMap, candidateList);
        Proc proc = ffResult.getCreateProcList().get(0);

        approvalMemoService.insertApprovalMemo(OdUtils.getUuid(), null, null, null, null, "起草", proc.getProcId(), proc.getProcId(), DOC_ID_, (String) operator.get("POSI_EMP_ID_"), (String) operator.get("EMP_CODE_"), (String) operator.get("EMP_NAME_"), (String) operator.get("POSI_EMP_ID_"), (String) operator.get("EMP_CODE_"), (String) operator.get("EMP_NAME_"), (String) operator.get("ORG_ID_"), (String) operator.get("ORG_NAME_"), (String) operator.get("COM_ID_"), (String) operator.get("COM_NAME_"), new Date(), null, "1", "上报审批", new Date(), "1", null, null, ffResult.getOperationId());

        handleApproveMemo(ffResult);

        docService.updateProcId(DOC_ID_, proc.getProcId());
        docService.updateProcStatus(DOC_ID_, proc.getProcStatus());
        docService.updateDocHis(DOC_ID_);

        // 重新上报，合并以前的审批意见
        if (doc.get("PROC_ID_") != null) {
            approvalMemoService.replaceApprovalMemoProcId((String) doc.get("PROC_ID_"), proc.getProcId());
        }

        return ffResult;
    }

    @SuppressWarnings("unchecked")
    @Override
    public FfResult completeDocTask(String TASK_ID_, String APPROVAL_MEMO_, Map<String, Object> nodeVarMap, CandidateList candidateList, Map<String, Object> operator) {
        String POSI_EMP_ID_ = (String) operator.get("POSI_EMP_ID_");
        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        List<String> posiEmpIdList = OdUtils.collect(posiEmpList, "POSI_EMP_ID_", String.class);
        Task task = ffService.loadTask(TASK_ID_);
        for (String posiEmpId : posiEmpIdList) {
            if (posiEmpId.equals(task.getAssignee())) {
                POSI_EMP_ID_ = posiEmpId;
                break;
            }
        }

        FfResult ffResult = ffService.completeTask(TASK_ID_, nodeVarMap, candidateList, POSI_EMP_ID_);
        List<Task> completeTaskList = ffResult.getCompleteTaskList();
        for (Task completeTask : completeTaskList) {
            if (completeTask.getTaskId().equals(TASK_ID_)) {
                approvalMemoService.completeApprovalMemo(TASK_ID_, POSI_EMP_ID_, (String) operator.get("EMP_CODE_"), (String) operator.get("EMP_NAME_"), APPROVAL_MEMO_, new Date());
            }
        }

        handleApproveMemo(ffResult);

        return ffResult;
    }

    private void handleApproveMemo(FfResult ffResult) {
        for (Node createNode : ffResult.getCreateNodeList()) {
            if ((createNode.getNodeType().equals(FfService.NODE_TYPE_STAGE) || createNode.getNodeType().equals(FfService.NODE_TYPE_SUB_PROC) || createNode.getNodeType().equals(FfService.NODE_TYPE_BRANCH) || createNode.getNodeType().equals(FfService.NODE_TYPE_GATEWAY)) && StringUtils.isNotEmpty(createNode.getParentNodeId())) {
                approvalMemoService.insertApprovalMemo(OdUtils.getUuid(), null, null, createNode.getNodeId(), createNode.getNodeType(), createNode.getNodeName(), createNode.getParentNodeId(), createNode.getProcId(), createNode.getBizId(), null, null, null, null, null, null, null, null, null, null, new Date(), null, null, null, null, "0", null, null, ffResult.getOperationId());
            }
        }

        for (Node completeNode : ffResult.getCompleteNodeList()) {
            // 自动完成的空节点
            if (FfService.USER_FF_SYSTEM.equals(completeNode.getNodeEndUser())) {
                approvalMemoService.insertApprovalMemo(OdUtils.getUuid(), null, null, completeNode.getNodeId(), completeNode.getNodeType(), completeNode.getNodeName(), completeNode.getParentNodeId(), completeNode.getProcId(), completeNode.getBizId(), null, null, null, completeNode.getNodeEndUser(), null, completeNode.getNodeEndUserName(), null, null, null, null, new Date(), null, null, "岗位没有分配人员，系统自动跳过", new Date(), "1", null, null, ffResult.getOperationId());
            }
        }

        List<Task> createTaskList = ffResult.getCreateTaskList();
        for (Task forwardingProcessingCompletedTask : ffResult.getForwardingProcessingCompletedTaskList()) {
            if (forwardingProcessingCompletedTask.getNodeStatus().equals(FfService.NODE_STATUS_ACTIVE)) {
                createTaskList.add(forwardingProcessingCompletedTask);
            }
        }
        for (Task createTask : createTaskList) {
            String assignee = createTask.getAssignee();
            PosiEmp posiEmp = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setPosiEmpId(assignee).queryForObject();
            Org com = null;
            List<Org> parentOrgList = omService.createParentOrgQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setOrgId(posiEmp.getOrgId()).setOrgTypeList(Arrays.asList("1", "2", "3", "4", "5", "99")).setRecursive(true).setIncludeSelf(true).queryForObjectList();
            if (parentOrgList.size() > 0) {
                com = parentOrgList.get(0);
            }

            approvalMemoService.insertApprovalMemo(OdUtils.getUuid(), createTask.getTaskId(), createTask.getPreviousTaskId(), createTask.getNodeId(), createTask.getNodeType(), createTask.getNodeName(), createTask.getParentNodeId(), createTask.getProcId(), createTask.getBizId(), createTask.getAssignee(), posiEmp.getEmpCode(), createTask.getAssigneeName(), null, null, null, posiEmp.getOrgId(), posiEmp.getOrgName(), com.getOrgId(), com.getOrgName(), new Date(), createTask.getDueDate(), "3", null, null, "0", createTask.getBizName(), createTask.getAction(), ffResult.getOperationId());
        }

        for (Task activateTask : ffResult.getActivateTaskList()) {
            String assignee = activateTask.getAssignee();
            PosiEmp posiEmp = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setPosiEmpId(assignee).queryForObject();
            Org com = null;
            List<Org> parentOrgList = omService.createParentOrgQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setOrgId(posiEmp.getOrgId()).setOrgTypeList(Arrays.asList("1", "2", "3", "4", "5", "99")).queryForObjectList();
            if (parentOrgList.size() > 0) {
                com = parentOrgList.get(0);
            }

            approvalMemoService.insertApprovalMemo(OdUtils.getUuid(), activateTask.getTaskId(), activateTask.getPreviousTaskId(), activateTask.getNodeId(), activateTask.getNodeType(), activateTask.getNodeName(), activateTask.getParentNodeId(), activateTask.getProcId(), activateTask.getBizId(), activateTask.getAssignee(), posiEmp.getEmpCode(), activateTask.getAssigneeName(), null, null, null, posiEmp.getOrgId(), posiEmp.getOrgName(), com.getOrgId(), com.getOrgName(), new Date(), activateTask.getDueDate(), "3", null, null, "0", activateTask.getBizName(), activateTask.getAction(), ffResult.getOperationId());
        }

        for (Task terminateTask : ffResult.getTerminateTaskList()) {
            approvalMemoService.terminateLastApprovalMemoByTaskId(terminateTask.getTaskId(), new Date(), null, null);
        }

        for (Task deleteTask : ffResult.getDeleteTaskList()) {
            approvalMemoService.deleteLastApprovalMemoByTaskId(deleteTask.getTaskId(), new Date(), null, null);
        }

        // 处理自动完成的任务
        for (Task completeTask : ffResult.getCompleteTaskList()) {
            if (FfService.USER_FF_SYSTEM.equals(completeTask.getTaskEndUser())) {
                approvalMemoService.completeApprovalMemo(completeTask.getTaskId(), completeTask.getTaskEndUser(), null, completeTask.getTaskEndUserName(), "相同办理人，系统自动完成", new Date());
            }
        }

        for (Node completeNode : ffResult.getCompleteNodeList()) {
            approvalMemoService.updateNodeApprovalMemoStatus(completeNode.getNodeId(), "1");
        }

        for (Proc completeProc : ffResult.getCompleteProcList()) {
            docService.updateProcStatus(completeProc.getBizId(), "9");
            docService.updateDocStatus(completeProc.getBizId(), "9");
        }

        for (Node deleteNode : ffResult.getDeleteNodeList()) {
            if (!deleteNode.getNodeType().equals(FfService.NODE_TYPE_TASK)) {
                approvalMemoService.deleteLastApprovalMemoByNodeId(deleteNode.getNodeId(), deleteNode.getNodeType(), new Date(), null, null);
            }
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public FfResult forwardDocTask(String TASK_ID_, List<String> assigneeList, String ACTION_, String APPROVAL_MEMO_, Map<String, Object> nodeVarMap, Map<String, Object> operator) {
        String POSI_EMP_ID_ = (String) operator.get("POSI_EMP_ID_");
        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        List<String> posiEmpIdList = OdUtils.collect(posiEmpList, "POSI_EMP_ID_", String.class);
        Task task = ffService.loadTask(TASK_ID_);
        for (String posiEmpId : posiEmpIdList) {
            if (posiEmpId.equals(task.getAssignee())) {
                POSI_EMP_ID_ = posiEmpId;
                break;
            }
        }

        FfResult ffResult = ffService.forwardTask(TASK_ID_, assigneeList, ACTION_, null, FfService.BOOLEAN_FALSE, FfService.BOOLEAN_TRUE, 5, POSI_EMP_ID_);
        approvalMemoService.completeApprovalMemo(TASK_ID_, POSI_EMP_ID_, (String) operator.get("EMP_CODE_"), (String) operator.get("EMP_NAME_"), APPROVAL_MEMO_, new Date());

        List<Task> createTaskList = ffResult.getCreateTaskList();
        for (Task createTask : createTaskList) {
            String assignee = createTask.getAssignee();
            PosiEmp posiEmp = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setPosiEmpId(assignee).queryForObject();
            Org com = null;
            List<Org> parentOrgList = omService.createParentOrgQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setOrgId(posiEmp.getOrgId()).setOrgTypeList(Arrays.asList("1", "2", "3", "4", "5", "99")).queryForObjectList();
            if (parentOrgList.size() > 0) {
                com = parentOrgList.get(0);
            }

            approvalMemoService.insertApprovalMemo(OdUtils.getUuid(), createTask.getTaskId(), createTask.getPreviousTaskId(), createTask.getNodeId(), createTask.getNodeType(), "内部流转", createTask.getParentNodeId(), createTask.getProcId(), createTask.getBizId(), createTask.getAssignee(), posiEmp.getEmpCode(), createTask.getAssigneeName(), null, null, null, posiEmp.getOrgId(), posiEmp.getOrgName(), com.getOrgId(), com.getOrgName(), new Date(), createTask.getDueDate(), "3", null, null, "0", createTask.getBizName(), createTask.getAction(), ffResult.getOperationId());
        }

        return ffResult;
    }

    @SuppressWarnings("unchecked")
    @Override
    public FfResult rejectDocTask(String TASK_ID_, String APPROVAL_MEMO_, Map<String, Object> nodeVarMap, Map<String, Object> operator) {
        Task task = ffService.loadTask(TASK_ID_);
        String POSI_EMP_ID_ = null;
        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        List<String> posiEmpIdList = OdUtils.collect(posiEmpList, "POSI_EMP_ID_", String.class);
        for (String posiEmpId : posiEmpIdList) {
            if (posiEmpId.equals(task.getAssignee())) {
                POSI_EMP_ID_ = posiEmpId;
                break;
            }
        }
        if (POSI_EMP_ID_ == null) {
            throw new RuntimeException("errors.notAssignee");
        }

        FfResult ffResult = ffService.terminateProc(task.getProcId(), task.getTaskId(), (String) operator.get("POSI_EMP_ID_"));

        approvalMemoService.rejectApprovalMemo(TASK_ID_, (String) operator.get("POSI_EMP_ID_"), (String) operator.get("EMP_CODE_"), (String) operator.get("EMP_NAME_"), APPROVAL_MEMO_, new Date());
        for (Task _task : ffResult.getTerminateTaskList()) {
            if (!_task.getTaskId().equals(TASK_ID_)) {
                approvalMemoService.deleteLastApprovalMemoByTaskId(_task.getTaskId(), new Date(), (String) operator.get("POSI_EMP_ID_"), (String) operator.get("EMP_CODE_"));
            }
        }

        docService.updateProcStatus(task.getBizId(), "8");
        docService.updateDocVersion(task.getBizId());

        return ffResult;
    }

    @SuppressWarnings("unchecked")
    @Override
    public FfResult fakeRejectDocTask(String TASK_ID_, String APPROVAL_MEMO_, Map<String, Object> nodeVarMap, CandidateList candidateList, Map<String, Object> operator) {
        String POSI_EMP_ID_ = (String) operator.get("POSI_EMP_ID_");
        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        List<String> posiEmpIdList = OdUtils.collect(posiEmpList, "POSI_EMP_ID_", String.class);
        Task task = ffService.loadTask(TASK_ID_);
        for (String posiEmpId : posiEmpIdList) {
            if (posiEmpId.equals(task.getAssignee())) {
                POSI_EMP_ID_ = posiEmpId;
                break;
            }
        }

        FfResult ffResult = ffService.completeTask(TASK_ID_, nodeVarMap, candidateList, POSI_EMP_ID_);
        List<Task> completeTaskList = ffResult.getCompleteTaskList();
        for (Task completeTask : completeTaskList) {
            if (completeTask.getTaskId().equals(TASK_ID_)) {
                approvalMemoService.fakeRejectApprovalMemo(TASK_ID_, POSI_EMP_ID_, (String) operator.get("EMP_CODE_"), (String) operator.get("EMP_NAME_"), APPROVAL_MEMO_, new Date());
            }
        }

        handleApproveMemo(ffResult);

        return ffResult;
    }

    @Override
    public FfResult appendDocCandidate(String NODE_ID_, CandidateList candidateList, Map<String, Object> operator) {
        FfResult ffResult = ffService.appendCandidate(NODE_ID_, candidateList, (String) operator.get("POSI_EMP_ID_"));

        handleApproveMemo(ffResult);

        return ffResult;
    }

    @Override
    public FfResult withdrawDocTask(String TASK_ID_, Map<String, Object> operator) {
        Task task = ffService.createTaskQuery().setTaskId(TASK_ID_).queryForObject();
        if (!task.getTaskStatus().equals(FfService.TASK_STATUS_ACTIVE)) {
            throw new RuntimeException("errors.taskNotActive");
        }

        FfResult ffResult = ffService.deleteTask(TASK_ID_, (String) operator.get("POSI_EMP_ID_"));

        handleApproveMemo(ffResult);

        return ffResult;
    }

    @Override
    public FfResult withdrawDocNode(String NODE_ID_, Map<String, Object> operator) {
        Node node = ffService.createNodeQuery().setNodeId(NODE_ID_).queryForObject();
        if (!node.getNodeStatus().equals(FfService.NODE_STATUS_ACTIVE)) {
            throw new RuntimeException("errors.nodeNotActive");
        }

        FfResult ffResult = ffService.deleteNode(NODE_ID_, (String) operator.get("POSI_EMP_ID_"));

        handleApproveMemo(ffResult);

        return ffResult;
    }

    @SuppressWarnings("unused")
    @Override
    @FfOperation(operator = "${procStartUser}")
    public FfResult testProcDef(ProcDef procDef, String bizId, String bizType, String bizCode, String bizName, String bizDesc, String procStartUser, Map<String, Object> nodeVarMap, CandidateList candidateList) {
        FfResult ffResult = new FfResult();

        ffResult = ffService.startProc(procDef, bizId, bizType, bizCode, bizName, bizDesc, procStartUser, nodeVarMap, candidateList);
        ffResult.addAll(testCompleteTask(ffResult.getCreateTaskList(), candidateList));

        List<Task> completeTaskList = ffResult.getCompleteTaskList();
        for (Task completeTask : completeTaskList) {
            System.out.println(completeTask.getNodeName() + ":" + completeTask.getAssigneeName());
        }

        if (true) {
            throw new RuntimeException("rollback");
        }

        return ffResult;
    }

    private FfResult testCompleteTask(List<Task> createTaskList, CandidateList candidateList) {
        FfResult ffResult = new FfResult();

        Map<String, Object> nodeVarMap = new HashMap<>();
        for (Task task : createTaskList) {
            task = ffService.loadTask(task.getTaskId());
            if (!task.getTaskStatus().equals(FfService.TASK_STATUS_ACTIVE)) {
                continue;
            }
            List<RunningNodeDef> nextRunningNodeDefList = ffService.getNextRunningNodeDefList(task.getTaskId(), null);
            for (RunningNodeDef nextRunningNodeDef : nextRunningNodeDefList) {
                if ("${assignee}".equals(nextRunningNodeDef.getAssignee()) || "${assignSubProcDef}".equals(nextRunningNodeDef.getAssignSubProcDef())) {
                    if (nextRunningNodeDef.getCandidateAssigneeList() != null) {
                        nodeVarMap.put("assignee", nextRunningNodeDef.getCandidateAssigneeList());
                    }
                    if (nextRunningNodeDef.getCandidateSubProcDefList() != null) {
                        nodeVarMap.put("assignSubProcDef", nextRunningNodeDef.getCandidateSubProcDefList());
                    }
                }
            }

            FfResult _ffResult = ffService.completeTask(task.getTaskId(), nodeVarMap, candidateList, "SYSADMIN");
            ffResult.addAll(_ffResult);
            ffResult.addAll(testCompleteTask(_ffResult.getCreateTaskList(), candidateList));
        }

        return ffResult;
    }
}