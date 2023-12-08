package com.opendynamic.k.service.impl.oracle;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opendynamic.OdSqlCriteria;
import com.opendynamic.k.service.CustomApprovalMemoService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class CustomApprovalMemoServiceImpl implements CustomApprovalMemoService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_) {
        String sql = "select * from KV_CUSTOM_APPROVAL_MEMO where CUSTOM_APPROVAL_MEMO_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, CUSTOM_APPROVAL_MEMO_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, String EMP_ID_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaCustomApprovalMemo(false, CUSTOM_APPROVAL_MEMO_ID_, EMP_ID_);// 根据查询条件组装查询SQL语句
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
    public int countCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, String EMP_ID_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaCustomApprovalMemo(true, CUSTOM_APPROVAL_MEMO_ID_, EMP_ID_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaCustomApprovalMemo(boolean count, String CUSTOM_APPROVAL_MEMO_ID_, String EMP_ID_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from KV_CUSTOM_APPROVAL_MEMO where 1 = 1";
        }
        else {
            sql = "select * from KV_CUSTOM_APPROVAL_MEMO where 1 = 1";
        }

        if (StringUtils.isNotEmpty(CUSTOM_APPROVAL_MEMO_ID_)) {
            sql += " and CUSTOM_APPROVAL_MEMO_ID_ = :CUSTOM_APPROVAL_MEMO_ID_";
            paramMap.put("CUSTOM_APPROVAL_MEMO_ID_", CUSTOM_APPROVAL_MEMO_ID_);
        }
        if (StringUtils.isNotEmpty(EMP_ID_)) {
            sql += " and EMP_ID_ = :EMP_ID_";
            paramMap.put("EMP_ID_", EMP_ID_);
        }

        if (!count) {
            sql += " order by ORDER_";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectCustomApprovalMemoByIdList(List<String> CUSTOM_APPROVAL_MEMO_ID_LIST) {
        if (CUSTOM_APPROVAL_MEMO_ID_LIST == null || CUSTOM_APPROVAL_MEMO_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(CUSTOM_APPROVAL_MEMO_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from KV_CUSTOM_APPROVAL_MEMO where CUSTOM_APPROVAL_MEMO_ID_ in (:CUSTOM_APPROVAL_MEMO_ID_LIST)");
        paramMap.put("CUSTOM_APPROVAL_MEMO_ID_LIST", CUSTOM_APPROVAL_MEMO_ID_LIST);
        sql.append(" order by DECODE(CUSTOM_APPROVAL_MEMO_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < CUSTOM_APPROVAL_MEMO_ID_LIST.size(); i++) {
            sql.append(" '").append(CUSTOM_APPROVAL_MEMO_ID_LIST.get(i)).append("', ").append(i);
            if (i < CUSTOM_APPROVAL_MEMO_ID_LIST.size() - 1) {
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
    public int insertCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, String EMP_ID_, String APPROVAL_MEMO_, String DEFAULT_, Integer ORDER_) {
        String sql = "insert into K_CUSTOM_APPROVAL_MEMO (CUSTOM_APPROVAL_MEMO_ID_, EMP_ID_, APPROVAL_MEMO_, DEFAULT_, ORDER_) values (?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, CUSTOM_APPROVAL_MEMO_ID_, EMP_ID_, APPROVAL_MEMO_, DEFAULT_, ORDER_);
    }

    @Override
    public int updateCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, String EMP_ID_, String APPROVAL_MEMO_, String DEFAULT_, Integer ORDER_) {
        String sql = "update K_CUSTOM_APPROVAL_MEMO set EMP_ID_ = ?, APPROVAL_MEMO_ = ?, DEFAULT_ = ?, ORDER_ = ? where CUSTOM_APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, EMP_ID_, APPROVAL_MEMO_, DEFAULT_, ORDER_, CUSTOM_APPROVAL_MEMO_ID_);
    }

    @Override
    public int updateCustomApprovalMemoOrder(final List<String> CUSTOM_APPROVAL_MEMO_ID_LIST, final List<Integer> ORDER_LIST, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        if (CUSTOM_APPROVAL_MEMO_ID_LIST == null || CUSTOM_APPROVAL_MEMO_ID_LIST.size() == 0) {
            return 0;
        }
        if (CUSTOM_APPROVAL_MEMO_ID_LIST.size() != ORDER_LIST.size()) {
            return 0;
        }

        String sql = "update K_CUSTOM_APPROVAL_MEMO set ORDER_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where CUSTOM_APPROVAL_MEMO_ID_ = ?";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setInt(1, ORDER_LIST.get(i));
                ps.setTimestamp(2, UPDATE_DATE_ == null ? null : new java.sql.Timestamp(UPDATE_DATE_.getTime()));
                ps.setString(3, OPERATOR_ID_);
                ps.setString(4, OPERATOR_NAME_);
                ps.setString(5, CUSTOM_APPROVAL_MEMO_ID_LIST.get(i));
            }

            public int getBatchSize() {
                return CUSTOM_APPROVAL_MEMO_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int deleteCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from K_CUSTOM_APPROVAL_MEMO where CUSTOM_APPROVAL_MEMO_ID_ = ?";
        return msJdbcTemplate.update(sql, CUSTOM_APPROVAL_MEMO_ID_);
    }
}