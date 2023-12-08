package com.opendynamic.cb.service.impl.oracle;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opendynamic.OdSqlCriteria;
import com.opendynamic.cb.service.LogService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class LogServiceImpl implements LogService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadLog(String LOG_ID_) {
        String sql = "select * from CBV_LOG where LOG_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, LOG_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectLog(String LOG_ID_, String CATEGORY_, String IP_, String ACTION_, String BUSINESS_KEY_, List<String> ERROR_LIST, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaLog(false, LOG_ID_, CATEGORY_, IP_, ACTION_, BUSINESS_KEY_, ERROR_LIST, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, FROM_CREATION_DATE_, TO_CREATION_DATE_);// 根据查询条件组装查询SQL语句
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
    public int countLog(String LOG_ID_, String CATEGORY_, String IP_, String ACTION_, String BUSINESS_KEY_, List<String> ERROR_LIST, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaLog(true, LOG_ID_, CATEGORY_, IP_, ACTION_, BUSINESS_KEY_, ERROR_LIST, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, FROM_CREATION_DATE_, TO_CREATION_DATE_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaLog(boolean count, String LOG_ID_, String CATEGORY_, String IP_, String ACTION_, String BUSINESS_KEY_, List<String> ERROR_LIST, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_LOG where 1 = 1";
        }
        else {
            sql = "select * from CBV_LOG where 1 = 1";
        }

        if (StringUtils.isNotEmpty(LOG_ID_)) {
            sql += " and LOG_ID_ = :LOG_ID_";
            paramMap.put("LOG_ID_", LOG_ID_);
        }
        if (StringUtils.isNotEmpty(CATEGORY_)) {
            sql += " and CATEGORY_ = :CATEGORY_";
            paramMap.put("CATEGORY_", CATEGORY_);
        }
        if (StringUtils.isNotEmpty(IP_)) {
            sql += " and IP_ = :IP_";
            paramMap.put("IP_", IP_);
        }
        if (StringUtils.isNotEmpty(ACTION_)) {
            sql += " and ACTION_ = :ACTION_";
            paramMap.put("ACTION_", ACTION_);
        }
        if (StringUtils.isNotEmpty(BUSINESS_KEY_)) {
            sql += " and BUSINESS_KEY_ = :BUSINESS_KEY_";
            paramMap.put("BUSINESS_KEY_", BUSINESS_KEY_);
        }
        if (ERROR_LIST != null && ERROR_LIST.size() > 0) {
            sql += " and ERROR_ in (:ERROR_LIST)";
            paramMap.put("ERROR_LIST", ERROR_LIST);
        }
        if (StringUtils.isNotEmpty(ORG_ID_)) {
            sql += " and ORG_ID_ = :ORG_ID_";
            paramMap.put("ORG_ID_", ORG_ID_);
        }
        if (StringUtils.isNotEmpty(ORG_NAME_)) {
            sql += " and ORG_NAME_ like '%' || :ORG_NAME_ || '%'";
            paramMap.put("ORG_NAME_", ORG_NAME_);
        }
        if (StringUtils.isNotEmpty(POSI_ID_)) {
            sql += " and POSI_ID_ = :POSI_ID_";
            paramMap.put("POSI_ID_", POSI_ID_);
        }
        if (StringUtils.isNotEmpty(POSI_NAME_)) {
            sql += " and POSI_NAME_ like '%' || :POSI_NAME_ || '%'";
            paramMap.put("POSI_NAME_", POSI_NAME_);
        }
        if (StringUtils.isNotEmpty(EMP_ID_)) {
            sql += " and EMP_ID_ = :EMP_ID_";
            paramMap.put("EMP_ID_", EMP_ID_);
        }
        if (StringUtils.isNotEmpty(EMP_NAME_)) {
            sql += " and EMP_NAME_ like '%' || :EMP_NAME_ || '%'";
            paramMap.put("EMP_NAME_", EMP_NAME_);
        }
        if (FROM_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ >= :FROM_CREATION_DATE_";
            paramMap.put("FROM_CREATION_DATE_", FROM_CREATION_DATE_);
        }
        if (TO_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ <= :TO_CREATION_DATE_";
            paramMap.put("TO_CREATION_DATE_", TO_CREATION_DATE_);
        }

        if (!count) {
            sql += " order by CREATION_DATE_ desc";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectLogByIdList(List<String> LOG_ID_LIST) {
        if (LOG_ID_LIST == null || LOG_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(LOG_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_LOG where LOG_ID_ in (:LOG_ID_LIST)");
        paramMap.put("LOG_ID_LIST", LOG_ID_LIST);
        sql.append(" order by DECODE(LOG_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < LOG_ID_LIST.size(); i++) {
            sql.append(" '").append(LOG_ID_LIST.get(i)).append("', ").append(i);
            if (i < LOG_ID_LIST.size() - 1) {
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
    public int insertLog(String LOG_ID_, String CATEGORY_, String IP_, String USER_AGENT_, String URL_, String ACTION_, String PARAMETER_MAP_, String BUSINESS_KEY_, String ERROR_, String MESSAGE_, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_, Date CREATION_DATE_) {
        String sql = "insert into CB_LOG (LOG_ID_, CATEGORY_, IP_, USER_AGENT_, URL_, ACTION_, PARAMETER_MAP_, BUSINESS_KEY_, ERROR_, MESSAGE_, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, CREATION_DATE_) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, LOG_ID_, CATEGORY_, IP_, USER_AGENT_, URL_, ACTION_, PARAMETER_MAP_, BUSINESS_KEY_, ERROR_, MESSAGE_, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, CREATION_DATE_);
    }

    @Override
    public int updateLog(String LOG_ID_, String CATEGORY_, String IP_, String USER_AGENT_, String URL_, String ACTION_, String PARAMETER_MAP_, String BUSINESS_KEY_, String ERROR_, String MESSAGE_, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_) {
        String sql = "update CB_LOG set CATEGORY_ = ?, IP_ = ?, USER_AGENT_ = ?, URL_ = ?, ACTION_ = ?, PARAMETER_MAP_ = ?, BUSINESS_KEY_ = ?, ERROR_ = ?, MESSAGE_ = ?, ORG_ID_ = ?, ORG_NAME_ = ?, POSI_ID_ = ?, POSI_NAME_ = ?, EMP_ID_ = ?, EMP_NAME_ = ? where LOG_ID_ = ?";
        return msJdbcTemplate.update(sql, CATEGORY_, IP_, USER_AGENT_, URL_, ACTION_, PARAMETER_MAP_, BUSINESS_KEY_, ERROR_, MESSAGE_, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, LOG_ID_);
    }

    @Override
    public int deleteLog(String LOG_ID_) {
        String sql = "delete from CB_LOG where LOG_ID_ = ?";
        return msJdbcTemplate.update(sql, LOG_ID_);
    }
}