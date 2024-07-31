package com.opendynamic.doc.service.impl.mysql;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opendynamic.OdSqlCriteria;
import com.opendynamic.doc.service.ApprovalMemoService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class ApprovalMemoServiceImpl implements ApprovalMemoService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadApprovalMemo(String APPROVAL_MEMO_ID_) {
        String sql = "select * from KV_APPROVAL_MEMO where APPROVAL_MEMO_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, APPROVAL_MEMO_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public Map<String, Object> loadLastApprovalMemoByTaskId(String TASK_ID_) {
        String sql = "select * from KV_APPROVAL_MEMO where TASK_ID_ = ? order by CREATION_DATE_ desc";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, TASK_ID_);
        if (result.size() >= 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String NODE_ID_, String NODE_TYPE_, String PROC_ID_, List<String> PROC_ID_LIST, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String COM_ID_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_DUE_DATE_, Date TO_DUE_DATE_, Integer APPROVAL_MEMO_TYPE_, Date FROM_APPROVAL_DATE_, Date TO_APPROVAL_DATE_, List<String> APPROVAL_MEMO_STATUS_LIST, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaApprovalMemo(false, APPROVAL_MEMO_ID_, TASK_ID_, NODE_ID_, NODE_TYPE_, PROC_ID_, PROC_ID_LIST, BIZ_ID_, ASSIGNEE_, ASSIGNEE_CODE_, ASSIGNEE_NAME_, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, ORG_ID_, COM_ID_, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_DUE_DATE_, TO_DUE_DATE_, APPROVAL_MEMO_TYPE_, FROM_APPROVAL_DATE_, TO_APPROVAL_DATE_, APPROVAL_MEMO_STATUS_LIST);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            int start = (page - 1) * limit + 1;
            int end = page * limit;
            sql = "select * from (select FULLTABLE.*, ROWNUM RN from (" + sql + ") FULLTABLE where ROWNUM <= " + end + ") where RN >= " + start;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String NODE_ID_, String NODE_TYPE_, String PROC_ID_, List<String> PROC_ID_LIST, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String COM_ID_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_DUE_DATE_, Date TO_DUE_DATE_, Integer APPROVAL_MEMO_TYPE_, Date FROM_APPROVAL_DATE_, Date TO_APPROVAL_DATE_, List<String> APPROVAL_MEMO_STATUS_LIST) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaApprovalMemo(true, APPROVAL_MEMO_ID_, TASK_ID_, NODE_ID_, NODE_TYPE_, PROC_ID_, PROC_ID_LIST, BIZ_ID_, ASSIGNEE_, ASSIGNEE_CODE_, ASSIGNEE_NAME_, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, ORG_ID_, COM_ID_, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_DUE_DATE_, TO_DUE_DATE_, APPROVAL_MEMO_TYPE_, FROM_APPROVAL_DATE_, TO_APPROVAL_DATE_, APPROVAL_MEMO_STATUS_LIST);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaApprovalMemo(boolean count, String APPROVAL_MEMO_ID_, String TASK_ID_, String NODE_ID_, String NODE_TYPE_, String PROC_ID_, List<String> PROC_ID_LIST, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String COM_ID_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_DUE_DATE_, Date TO_DUE_DATE_, Integer APPROVAL_MEMO_TYPE_, Date FROM_APPROVAL_DATE_, Date TO_APPROVAL_DATE_, List<String> APPROVAL_MEMO_STATUS_LIST) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<>();

        if (count) {
            sql = "select count(*) from KV_APPROVAL_MEMO where 1 = 1";
        }
        else {
            sql = "select * from KV_APPROVAL_MEMO where 1 = 1";
        }

        if (APPROVAL_MEMO_ID_ != null) {
            sql += " and APPROVAL_MEMO_ID_ = :APPROVAL_MEMO_ID_";
            paramMap.put("APPROVAL_MEMO_ID_", APPROVAL_MEMO_ID_);
        }
        if (TASK_ID_ != null) {
            sql += " and TASK_ID_ = :TASK_ID_";
            paramMap.put("TASK_ID_", TASK_ID_);
        }
        if (NODE_ID_ != null) {
            sql += " and NODE_ID_ = :NODE_ID_";
            paramMap.put("NODE_ID_", NODE_ID_);
        }
        if (NODE_TYPE_ != null) {
            sql += " and NODE_TYPE_ = :NODE_TYPE_";
            paramMap.put("NODE_TYPE_", NODE_TYPE_);
        }
        if (PROC_ID_ != null) {
            sql += " and PROC_ID_ = :PROC_ID_";
            paramMap.put("PROC_ID_", PROC_ID_);
        }
        if (PROC_ID_LIST != null && !PROC_ID_LIST.isEmpty()) {
            sql += " and PROC_ID_ in (:PROC_ID_LIST)";
            paramMap.put("PROC_ID_LIST", PROC_ID_LIST);
        }
        if (BIZ_ID_ != null) {
            sql += " and BIZ_ID_ = :BIZ_ID_";
            paramMap.put("BIZ_ID_", BIZ_ID_);
        }
        if (ASSIGNEE_ != null) {
            sql += " and ASSIGNEE_ = :ASSIGNEE_";
            paramMap.put("ASSIGNEE_", ASSIGNEE_);
        }
        if (ASSIGNEE_CODE_ != null) {
            sql += " and ASSIGNEE_CODE_ = :ASSIGNEE_CODE_";
            paramMap.put("ASSIGNEE_CODE_", ASSIGNEE_CODE_);
        }
        if (ASSIGNEE_NAME_ != null) {
            sql += " and ASSIGNEE_NAME_ like concat('%',:ASSIGNEE_NAME_,'%')";
            paramMap.put("ASSIGNEE_NAME_", ASSIGNEE_NAME_);
        }
        if (EXECUTOR_ != null) {
            sql += " and EXECUTOR_ = :EXECUTOR_";
            paramMap.put("EXECUTOR_", EXECUTOR_);
        }
        if (EXECUTOR_CODE_ != null) {
            sql += " and EXECUTOR_CODE_ = :EXECUTOR_CODE_";
            paramMap.put("EXECUTOR_CODE_", EXECUTOR_CODE_);
        }
        if (EXECUTOR_NAME_ != null) {
            sql += " and EXECUTOR_NAME_ like concat('%',:EXECUTOR_NAME_,'%')";
            paramMap.put("EXECUTOR_NAME_", EXECUTOR_NAME_);
        }
        if (ORG_ID_ != null) {
            sql += " and ORG_ID_ = :ORG_ID_";
            paramMap.put("ORG_ID_", ORG_ID_);
        }
        if (COM_ID_ != null) {
            sql += " and COM_ID_ = :COM_ID_";
            paramMap.put("COM_ID_", COM_ID_);
        }
        if (FROM_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ >= :FROM_CREATION_DATE_";
            paramMap.put("FROM_CREATION_DATE_", FROM_CREATION_DATE_);
        }
        if (TO_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ <= :TO_CREATION_DATE_";
            paramMap.put("TO_CREATION_DATE_", TO_CREATION_DATE_);
        }
        if (FROM_DUE_DATE_ != null) {
            sql += " and DUE_DATE_ >= :FROM_DUE_DATE_";
            paramMap.put("FROM_DUE_DATE_", FROM_DUE_DATE_);
        }
        if (TO_DUE_DATE_ != null) {
            sql += " and DUE_DATE_ <= :TO_DUE_DATE_";
            paramMap.put("TO_DUE_DATE_", TO_DUE_DATE_);
        }
        if (APPROVAL_MEMO_TYPE_ != null) {
            sql += " and APPROVAL_MEMO_TYPE_ = :APPROVAL_MEMO_TYPE_";
            paramMap.put("APPROVAL_MEMO_TYPE_", APPROVAL_MEMO_TYPE_);
        }
        if (FROM_APPROVAL_DATE_ != null) {
            sql += " and APPROVAL_DATE_ >= :FROM_APPROVAL_DATE_";
            paramMap.put("FROM_APPROVAL_DATE_", FROM_APPROVAL_DATE_);
        }
        if (TO_APPROVAL_DATE_ != null) {
            sql += " and APPROVAL_DATE_ <= :TO_APPROVAL_DATE_";
            paramMap.put("TO_APPROVAL_DATE_", TO_APPROVAL_DATE_);
        }
        if (APPROVAL_MEMO_STATUS_LIST != null && !APPROVAL_MEMO_STATUS_LIST.isEmpty()) {
            sql += " and APPROVAL_MEMO_STATUS_ in (:APPROVAL_MEMO_STATUS_LIST)";
            paramMap.put("APPROVAL_MEMO_STATUS_LIST", APPROVAL_MEMO_STATUS_LIST);
        }

        if (!count) {
            sql += " order by CREATION_DATE_, - APPROVAL_DATE_ desc";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectApprovalMemoByIdList(List<String> APPROVAL_MEMO_ID_LIST) {
        if (APPROVAL_MEMO_ID_LIST == null || APPROVAL_MEMO_ID_LIST.isEmpty()) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(APPROVAL_MEMO_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<>();

        sql.append("select * from KV_APPROVAL_MEMO where APPROVAL_MEMO_ID_ in (:APPROVAL_MEMO_ID_LIST)");
        paramMap.put("APPROVAL_MEMO_ID_LIST", APPROVAL_MEMO_ID_LIST);
        sql.append(" order by DECODE(APPROVAL_MEMO_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < APPROVAL_MEMO_ID_LIST.size(); i++) {
            sql.append(" '").append(APPROVAL_MEMO_ID_LIST.get(i)).append("', ").append(i);
            if (i < APPROVAL_MEMO_ID_LIST.size() - 1) {
                sql.append(",");
            }
            else {
                sql.append(")");
            }
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql.toString(), paramMap);
    }

    @Override
    public int insertApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String PREVIOUS_TASK_ID_, String NODE_ID_, String NODE_TYPE_, String NODE_NAME_, String PARENT_NODE_ID_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String ORG_NAME_, String COM_ID_, String COM_NAME_, Date CREATION_DATE_, Date DUE_DATE_, String APPROVAL_MEMO_TYPE_, String APPROVAL_MEMO_, Date APPROVAL_DATE_, String APPROVAL_MEMO_STATUS_, String BIZ_NAME_, String FORWARD_URL_, String OPERATION_ID_) {
        String sql = "insert into K_APPROVAL_MEMO (APPROVAL_MEMO_ID_, TASK_ID_, PREVIOUS_TASK_ID_, NODE_ID_, NODE_TYPE_, NODE_NAME_, PARENT_NODE_ID_, PROC_ID_, BIZ_ID_, ASSIGNEE_, ASSIGNEE_CODE_, ASSIGNEE_NAME_, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, ORG_ID_, ORG_NAME_, COM_ID_, COM_NAME_, CREATION_DATE_, DUE_DATE_, APPROVAL_MEMO_TYPE_, APPROVAL_MEMO_, APPROVAL_DATE_, APPROVAL_MEMO_STATUS_, OPERATION_ID_) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, APPROVAL_MEMO_ID_, TASK_ID_, PREVIOUS_TASK_ID_, NODE_ID_, NODE_TYPE_, NODE_NAME_, PARENT_NODE_ID_, PROC_ID_, BIZ_ID_, ASSIGNEE_, ASSIGNEE_CODE_, ASSIGNEE_NAME_, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, ORG_ID_, ORG_NAME_, COM_ID_, COM_NAME_, CREATION_DATE_, DUE_DATE_, APPROVAL_MEMO_TYPE_, APPROVAL_MEMO_, APPROVAL_DATE_, APPROVAL_MEMO_STATUS_, OPERATION_ID_);
    }

    @Override
    public int updateApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String PREVIOUS_TASK_ID_, String NODE_ID_, String NODE_TYPE_, String NODE_NAME_, String PARENT_NODE_ID_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String ORG_NAME_, String COM_ID_, String COM_NAME_, Date DUE_DATE_, String APPROVAL_MEMO_TYPE_, String APPROVAL_MEMO_, Date APPROVAL_DATE_) {
        String sql = "update K_APPROVAL_MEMO set TASK_ID_ = ?, PREVIOUS_TASK_ID_ = ?, NODE_ID_ = ?, NODE_TYPE_ = ?, NODE_NAME_ = ?, PARENT_NODE_ID_ = ?, PROC_ID_ = ?, BIZ_ID_ = ?, ASSIGNEE_ = ?, ASSIGNEE_CODE_ = ?, ASSIGNEE_NAME_ = ?, EXECUTOR_ = ?, EXECUTOR_CODE_ = ?, EXECUTOR_NAME_ = ?, ORG_ID_ = ?, ORG_NAME_ = ?, COM_ID_ = ?, COM_NAME_ = ?, DUE_DATE_ = ?, APPROVAL_MEMO_TYPE_ = ?, APPROVAL_MEMO_ = ?, APPROVAL_DATE_ = ? where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, TASK_ID_, PREVIOUS_TASK_ID_, NODE_ID_, NODE_TYPE_, NODE_NAME_, PARENT_NODE_ID_, PROC_ID_, BIZ_ID_, ASSIGNEE_, ASSIGNEE_CODE_, ASSIGNEE_NAME_, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, ORG_ID_, ORG_NAME_, COM_ID_, COM_NAME_, DUE_DATE_, APPROVAL_MEMO_TYPE_, APPROVAL_MEMO_, APPROVAL_DATE_, APPROVAL_MEMO_ID_);
    }

    @Override
    public int updateApprovalMemoApprovalMemo(String APPROVAL_MEMO_ID_, String APPROVAL_MEMO_) {
        String sql = "update K_APPROVAL_MEMO set APPROVAL_MEMO_ = ? where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, APPROVAL_MEMO_, APPROVAL_MEMO_ID_);
    }

    @Override
    public int completeApprovalMemo(String TASK_ID_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String APPROVAL_MEMO_, Date APPROVAL_DATE_) {
        Map<String, Object> approvalMemo = loadLastApprovalMemoByTaskId(TASK_ID_);
        if (approvalMemo == null) {
            throw new RuntimeException("没有找到待审批记录");
        }

        String sql = "update K_APPROVAL_MEMO set EXECUTOR_ = ?, EXECUTOR_CODE_ = ?, EXECUTOR_NAME_ = ?, APPROVAL_MEMO_ = ?, APPROVAL_DATE_ = ?, APPROVAL_MEMO_STATUS_ = '1' where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, APPROVAL_MEMO_, APPROVAL_DATE_, approvalMemo.get("APPROVAL_MEMO_ID_"));
    }

    @Override
    public int fakeRejectApprovalMemo(String TASK_ID_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String APPROVAL_MEMO_, Date APPROVAL_DATE_) {
        Map<String, Object> approvalMemo = loadLastApprovalMemoByTaskId(TASK_ID_);
        if (approvalMemo == null) {
            throw new RuntimeException("没有找到待审批记录");
        }

        String sql = "update K_APPROVAL_MEMO set EXECUTOR_ = ?, EXECUTOR_CODE_ = ?, EXECUTOR_NAME_ = ?, APPROVAL_MEMO_ = ?, APPROVAL_DATE_ = ?, APPROVAL_MEMO_STATUS_ = '7' where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, APPROVAL_MEMO_, APPROVAL_DATE_, approvalMemo.get("APPROVAL_MEMO_ID_"));
    }

    @Override
    public int rejectApprovalMemo(String TASK_ID_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String APPROVAL_MEMO_, Date APPROVAL_DATE_) {
        Map<String, Object> approvalMemo = loadLastApprovalMemoByTaskId(TASK_ID_);
        if (approvalMemo == null) {
            throw new RuntimeException("没有找到待审批记录");
        }

        String sql = "update K_APPROVAL_MEMO set EXECUTOR_ = ?, EXECUTOR_CODE_ = ?, EXECUTOR_NAME_ = ?, APPROVAL_MEMO_ = ?, APPROVAL_DATE_ = ?, APPROVAL_MEMO_STATUS_ = '8' where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, APPROVAL_MEMO_, APPROVAL_DATE_, approvalMemo.get("APPROVAL_MEMO_ID_"));
    }

    @Override
    public int saveApprovalMemo(String TASK_ID_, String APPROVAL_MEMO_) {
        Map<String, Object> approvalMemo = loadLastApprovalMemoByTaskId(TASK_ID_);
        if (approvalMemo == null) {
            throw new RuntimeException("没有找到待审批记录");
        }

        String sql = "update K_APPROVAL_MEMO set APPROVAL_MEMO_ = ? where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, APPROVAL_MEMO_, approvalMemo.get("APPROVAL_MEMO_ID_"));
    }

    @Override
    public int updateNodeApprovalMemoStatus(String NODE_ID_, String APPROVAL_MEMO_STATUS_) {
        String sql = "update K_APPROVAL_MEMO set APPROVAL_MEMO_STATUS_ = ? where NODE_ID_ = ? and NODE_TYPE_ in ('STAGE','SUB_PROC','BRANCH','GATEWAY')";
        return msJdbcTemplate.update(sql, APPROVAL_MEMO_STATUS_, NODE_ID_);
    }

    @Override
    public int replaceApprovalMemoProcId(String ORI_PROC_ID_, String PROC_ID_) {
        String sql = "update K_APPROVAL_MEMO set PROC_ID_ = ? where PROC_ID_ = ?";
        msJdbcTemplate.update(sql, PROC_ID_, ORI_PROC_ID_);
        sql = "update K_APPROVAL_MEMO set PARENT_NODE_ID_ = ? where PARENT_NODE_ID_ = ?";
        return msJdbcTemplate.update(sql, PROC_ID_, ORI_PROC_ID_);
    }

    @Override
    public int updateApprovalMemoOrder(final List<String> APPROVAL_MEMO_ID_LIST, final List<Integer> ORDER_LIST, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        if (APPROVAL_MEMO_ID_LIST == null || APPROVAL_MEMO_ID_LIST.isEmpty()) {
            return 0;
        }
        if (APPROVAL_MEMO_ID_LIST.size() != ORDER_LIST.size()) {
            return 0;
        }

        String sql = "update K_APPROVAL_MEMO set ORDER_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where APPROVAL_MEMO_ID_ = ?";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setInt(1, ORDER_LIST.get(i));
                ps.setTimestamp(2, UPDATE_DATE_ == null ? null : new java.sql.Timestamp(UPDATE_DATE_.getTime()));
                ps.setString(3, OPERATOR_ID_);
                ps.setString(4, OPERATOR_NAME_);
                ps.setString(5, APPROVAL_MEMO_ID_LIST.get(i));
            }

            public int getBatchSize() {
                return APPROVAL_MEMO_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int disableApprovalMemo(String APPROVAL_MEMO_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_APPROVAL_MEMO set APPROVAL_MEMO_STATUS_ = '0', UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, APPROVAL_MEMO_ID_);
    }

    @Override
    public int enableApprovalMemo(String APPROVAL_MEMO_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_APPROVAL_MEMO set APPROVAL_MEMO_STATUS_ = '1', UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, APPROVAL_MEMO_ID_);
    }

    @Override
    public int deleteApprovalMemo(String APPROVAL_MEMO_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from K_APPROVAL_MEMO where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, APPROVAL_MEMO_ID_);
    }

    @Override
    public int deleteApprovalMemoByProcId(String PROC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from K_APPROVAL_MEMO where PROC_ID_ = ?";
        return msJdbcTemplate.update(sql, PROC_ID_);
    }

    @Override
    public int deleteLastApprovalMemoByTaskId(String TASK_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        List<Map<String, Object>> approvalMemoList = selectApprovalMemo(null, TASK_ID_, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, -1);

        if (!approvalMemoList.isEmpty()) {
            String sql = "delete from K_APPROVAL_MEMO where APPROVAL_MEMO_ID_ = ?";
            return msJdbcTemplate.update(sql, approvalMemoList.get(approvalMemoList.size() - 1).get("APPROVAL_MEMO_ID_"));
        }

        return 0;
    }

    @Override
    public int deleteLastApprovalMemoByNodeId(String NODE_ID_, String NODE_TYPE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        List<Map<String, Object>> approvalMemoList = selectApprovalMemo(null, null, NODE_ID_, NODE_TYPE_, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, -1);

        if (!approvalMemoList.isEmpty()) {
            String sql = "delete from K_APPROVAL_MEMO where APPROVAL_MEMO_ID_ = ?";
            return msJdbcTemplate.update(sql, approvalMemoList.get(approvalMemoList.size() - 1).get("APPROVAL_MEMO_ID_"));
        }

        return 0;
    }

    @Override
    public int terminateLastApprovalMemoByTaskId(String TASK_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        List<Map<String, Object>> approvalMemoList = selectApprovalMemo(null, TASK_ID_, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, -1);

        String sql = "update K_APPROVAL_MEMO set APPROVAL_MEMO_STATUS_ = '-1' where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, approvalMemoList.get(approvalMemoList.size() - 1).get("APPROVAL_MEMO_ID_"));
    }

    @Override
    public int activateLastApprovalMemoByTaskId(String TASK_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        List<Map<String, Object>> approvalMemoList = selectApprovalMemo(null, TASK_ID_, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, -1);

        String sql = "update K_APPROVAL_MEMO set APPROVAL_MEMO_STATUS_ = '0' where APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, approvalMemoList.get(approvalMemoList.size() - 1).get("APPROVAL_MEMO_ID_"));
    }

    @Override
    public int deleteApprovalMemoByOperationId(String OPERATION_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from K_APPROVAL_MEMO where OPERATION_ID_ = ?";
        return msJdbcTemplate.update(sql, OPERATION_ID_);
    }
}