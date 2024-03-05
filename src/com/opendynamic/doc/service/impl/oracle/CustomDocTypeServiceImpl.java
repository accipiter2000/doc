package com.opendynamic.doc.service.impl.oracle;

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
import com.opendynamic.doc.service.CustomDocTypeService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class CustomDocTypeServiceImpl implements CustomDocTypeService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadCustomDocType(String CUSTOM_DOC_TYPE_ID_) {
        String sql = "select * from KV_CUSTOM_DOC_TYPE where CUSTOM_DOC_TYPE_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, CUSTOM_DOC_TYPE_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectCustomDocType(String CUSTOM_DOC_TYPE_ID_, String EMP_ID_, String DOC_TYPE_ID_, List<String> DOC_TYPE_STATUS_LIST, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaCustomDocType(false, CUSTOM_DOC_TYPE_ID_, EMP_ID_, DOC_TYPE_ID_, DOC_TYPE_STATUS_LIST);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            int start = (page - 1) * limit + 1;
            int end = page * limit;
            sql = "select * from (select FULLTABLE.*, ROWNUM RN from (" + sql + ") FULLTABLE where ROWNUM <= " + end + ") where RN >= " + start;
        }

        NamedParameterJdbcTemplate namedParameterJdbcDocType = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcDocType.queryForList(sql, paramMap);
    }

    @Override
    public int countCustomDocType(String CUSTOM_DOC_TYPE_ID_, String EMP_ID_, String DOC_TYPE_ID_, List<String> DOC_TYPE_STATUS_LIST) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaCustomDocType(true, CUSTOM_DOC_TYPE_ID_, EMP_ID_, DOC_TYPE_ID_, DOC_TYPE_STATUS_LIST);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcDocType = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcDocType.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaCustomDocType(boolean count, String CUSTOM_DOC_TYPE_ID_, String EMP_ID_, String DOC_TYPE_ID_, List<String> DOC_TYPE_STATUS_LIST) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from KV_CUSTOM_DOC_TYPE where 1 = 1";
        }
        else {
            sql = "select * from KV_CUSTOM_DOC_TYPE where 1 = 1";
        }

        if (StringUtils.isNotEmpty(CUSTOM_DOC_TYPE_ID_)) {
            sql += " and CUSTOM_DOC_TYPE_ID_ = :CUSTOM_DOC_TYPE_ID_";
            paramMap.put("CUSTOM_DOC_TYPE_ID_", CUSTOM_DOC_TYPE_ID_);
        }
        if (StringUtils.isNotEmpty(EMP_ID_)) {
            sql += " and EMP_ID_ = :EMP_ID_";
            paramMap.put("EMP_ID_", EMP_ID_);
        }
        if (StringUtils.isNotEmpty(DOC_TYPE_ID_)) {
            sql += " and DOC_TYPE_ID_ = :DOC_TYPE_ID_";
            paramMap.put("DOC_TYPE_ID_", DOC_TYPE_ID_);
        }
        if (DOC_TYPE_STATUS_LIST != null && DOC_TYPE_STATUS_LIST.size() > 0) {
            sql += " and DOC_TYPE_STATUS_ in (:DOC_TYPE_STATUS_LIST)";
            paramMap.put("DOC_TYPE_STATUS_LIST", DOC_TYPE_STATUS_LIST);
        }

        if (!count) {
            sql += " order by DOC_TYPE_ID_";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectCustomDocTypeByIdList(List<String> CUSTOM_DOC_TYPE_ID_LIST) {
        if (CUSTOM_DOC_TYPE_ID_LIST == null || CUSTOM_DOC_TYPE_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(CUSTOM_DOC_TYPE_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from KV_CUSTOM_DOC_TYPE where CUSTOM_DOC_TYPE_ID_ in (:CUSTOM_DOC_TYPE_ID_LIST)");
        paramMap.put("CUSTOM_DOC_TYPE_ID_LIST", CUSTOM_DOC_TYPE_ID_LIST);
        sql.append(" order by DECODE(CUSTOM_DOC_TYPE_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < CUSTOM_DOC_TYPE_ID_LIST.size(); i++) {
            sql.append(" '").append(CUSTOM_DOC_TYPE_ID_LIST.get(i)).append("', ").append(i);
            if (i < CUSTOM_DOC_TYPE_ID_LIST.size() - 1) {
                sql.append(",");
            }
            else {
                sql.append(")");
            }
        }

        NamedParameterJdbcTemplate namedParameterJdbcDocType = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcDocType.queryForList(sql.toString(), paramMap);
    }

    @Override
    public int insertCustomDocType(String CUSTOM_DOC_TYPE_ID_, String EMP_ID_, String DOC_TYPE_ID_) {
        String sql = "insert into K_CUSTOM_DOC_TYPE (CUSTOM_DOC_TYPE_ID_, EMP_ID_, DOC_TYPE_ID_) values (?, ?, ?)";
        return msJdbcTemplate.update(sql, CUSTOM_DOC_TYPE_ID_, EMP_ID_, DOC_TYPE_ID_);
    }

    @Override
    public int updateCustomDocType(String CUSTOM_DOC_TYPE_ID_, String DOC_TYPE_ID_) {
        String sql = "update K_CUSTOM_DOC_TYPE set DOC_TYPE_ID_ = ? where CUSTOM_DOC_TYPE_ID_ = ?";
        return msJdbcTemplate.update(sql, DOC_TYPE_ID_, CUSTOM_DOC_TYPE_ID_);
    }

    @Override
    public int updateCustomDocTypeOrder(final List<String> CUSTOM_DOC_TYPE_ID_LIST, final List<Integer> ORDER_LIST, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        if (CUSTOM_DOC_TYPE_ID_LIST == null || CUSTOM_DOC_TYPE_ID_LIST.size() == 0) {
            return 0;
        }
        if (CUSTOM_DOC_TYPE_ID_LIST.size() != ORDER_LIST.size()) {
            return 0;
        }

        String sql = "update K_CUSTOM_DOC_TYPE set ORDER_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where CUSTOM_DOC_TYPE_ID_ = ?";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setInt(1, ORDER_LIST.get(i));
                ps.setTimestamp(2, UPDATE_DATE_ == null ? null : new java.sql.Timestamp(UPDATE_DATE_.getTime()));
                ps.setString(3, OPERATOR_ID_);
                ps.setString(4, OPERATOR_NAME_);
                ps.setString(5, CUSTOM_DOC_TYPE_ID_LIST.get(i));
            }

            public int getBatchSize() {
                return CUSTOM_DOC_TYPE_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int deleteCustomDocType(String CUSTOM_DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from K_CUSTOM_DOC_TYPE where CUSTOM_DOC_TYPE_ID_ = ?";
        return msJdbcTemplate.update(sql, CUSTOM_DOC_TYPE_ID_);
    }

    @Override
    public int deleteCustomDocTypeByDocTypeId(String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from K_CUSTOM_DOC_TYPE where DOC_TYPE_ID_ = ?";
        return msJdbcTemplate.update(sql, DOC_TYPE_ID_);
    }
}