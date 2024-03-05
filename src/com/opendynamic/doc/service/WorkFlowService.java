package com.opendynamic.doc.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opendynamic.ff.FfOperation;
import com.opendynamic.ff.vo.CandidateList;
import com.opendynamic.ff.vo.FfResult;
import com.opendynamic.ff.vo.ProcDef;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface WorkFlowService {
    public FfResult restartDocProc(String DOC_ID_, Map<String, Object> nodeVarMap, CandidateList candidateList, Map<String, Object> operator);

    public FfResult restartDocIsolateProc(String DOC_ID_, String isolateSubProcNodeId, Map<String, Object> nodeVarMap, CandidateList candidateList, Map<String, Object> operator);

    public FfResult completeDocTask(String TASK_ID_, String APPROVAL_MEMO_, Map<String, Object> nodeVarMap, CandidateList candidateList, Map<String, Object> operator);

    public FfResult forwardDocTask(String TASK_ID_, List<String> assigneeList, String ACTION_, String APPROVAL_MEMO_, Map<String, Object> nodeVarMap, Map<String, Object> operator);

    public FfResult rejectDocTask(String TASK_ID_, String APPROVAL_MEMO_, Map<String, Object> nodeVarMap, Map<String, Object> operator);

    public FfResult fakeRejectDocTask(String TASK_ID_, String APPROVAL_MEMO_, Map<String, Object> nodeVarMap, CandidateList candidateList, Map<String, Object> operator);

    public FfResult appendDocCandidate(String NODE_ID_, CandidateList candidateList, Map<String, Object> operator);

    public FfResult withdrawDocTask(String TASK_ID_, Map<String, Object> operator);

    public FfResult withdrawDocNode(String NODE_ID_, Map<String, Object> operator);

    /**
     * 测试流程定义.下个节点办理人取assignee中所有人，如果assignee为空，取candidate中所有人。子流程同理。
     * 
     * @param procDef
     * @return
     */
    @FfOperation
    public FfResult testProcDef(ProcDef procDef, String bizId, String bizType, String bizCode, String bizName, String bizDesc, String procStartUser, Map<String, Object> nodeVarMap, CandidateList candidateList);
}