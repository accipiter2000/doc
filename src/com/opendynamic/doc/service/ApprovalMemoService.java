package com.opendynamic.doc.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface ApprovalMemoService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadApprovalMemo(String APPROVAL_MEMO_ID_);

    /**
     * 按编码查询,返回单个对象。
     */
    public Map<String, Object> loadLastApprovalMemoByTaskId(String TASK_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String NODE_ID_, String NODE_TYPE_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String COM_ID_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_DUE_DATE_, Date TO_DUE_DATE_, Integer APPROVAL_MEMO_TYPE_, Date FROM_APPROVAL_DATE_, Date TO_APPROVAL_DATE_, List<String> APPROVAL_MEMO_STATUS_LIST, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String NODE_ID_, String NODE_TYPE_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String COM_ID_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_DUE_DATE_, Date TO_DUE_DATE_, Integer APPROVAL_MEMO_TYPE_, Date FROM_APPROVAL_DATE_, Date TO_APPROVAL_DATE_, List<String> APPROVAL_MEMO_STATUS_LIST);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectApprovalMemoByIdList(List<String> APPROVAL_MEMO_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String PREVIOUS_TASK_ID_, String NODE_ID_, String NODE_TYPE_, String NODE_NAME_, String PARENT_NODE_ID_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String ORG_NAME_, String COM_ID_, String COM_NAME_, Date CREATION_DATE_, Date DUE_DATE_, String APPROVAL_MEMO_TYPE_, String APPROVAL_MEMO_, Date APPROVAL_DATE_, String APPROVAL_MEMO_STATUS_, String BIZ_NAME_, String FORWARD_URL_, String OPERATION_ID_);

    /**
     * 新增对象。
     */
    public int insertApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String PREVIOUS_TASK_ID_, String NODE_ID_, String NODE_TYPE_, String NODE_NAME_, String PARENT_NODE_ID_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String ORG_NAME_, String COM_ID_, String COM_NAME_, Date CREATION_DATE_, Date DUE_DATE_, String APPROVAL_MEMO_TYPE_, String APPROVAL_MEMO_, Date APPROVAL_DATE_, String APPROVAL_MEMO_SOURCE_, String APPROVAL_MEMO_STATUS_, String BIZ_NAME_, String FORWARD_URL_, String OPERATION_ID_);

    /**
     * 修改对象。
     */
    public int updateApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String PREVIOUS_TASK_ID_, String NODE_ID_, String NODE_TYPE_, String NODE_NAME_, String PARENT_NODE_ID_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String ORG_NAME_, String COM_ID_, String COM_NAME_, Date DUE_DATE_, String APPROVAL_MEMO_TYPE_, String APPROVAL_MEMO_, Date APPROVAL_DATE_);

    public int updateApprovalMemoApprovalMemo(String APPROVAL_MEMO_ID_, String APPROVAL_MEMO_);

    public int completeApprovalMemo(String TASK_ID_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String APPROVAL_MEMO_, Date APPROVAL_DATE_);

    public int rejectApprovalMemo(String TASK_ID_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String APPROVAL_MEMO_, Date APPROVAL_DATE_);

    public int fakeRejectApprovalMemo(String TASK_ID_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String APPROVAL_MEMO_, Date APPROVAL_DATE_);

    public int saveApprovalMemo(String TASK_ID_, String APPROVAL_MEMO_);

    public int updateNodeApprovalMemoStatus(String NODE_ID_, String APPROVAL_MEMO_STATUS_);

    public int replaceApprovalMemoProcId(String ORI_PROC_ID_, String PROC_ID_);

    /**
     * 拖动排序。
     */
    public int updateApprovalMemoOrder(List<String> APPROVAL_MEMO_ID_LIST, List<Integer> ORDER_LIST, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteApprovalMemo(String APPROVAL_MEMO_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteApprovalMemoByProcId(String PROC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int deleteLastApprovalMemoByTaskId(String TASK_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int deleteLastApprovalMemoByNodeId(String NODE_ID_, String NODE_TYPE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int terminateLastApprovalMemoByTaskId(String TASK_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);
    
    public int activateLastApprovalMemoByTaskId(String TASK_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int deleteApprovalMemoByOperationId(String OPERATION_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);
}