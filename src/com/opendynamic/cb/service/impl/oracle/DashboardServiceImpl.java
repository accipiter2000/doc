package com.opendynamic.cb.service.impl.oracle;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
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
import com.opendynamic.cb.service.DashboardService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class DashboardServiceImpl implements DashboardService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadDashboard(String DASHBOARD_ID_) {
        String sql = "select * from CBV_DASHBOARD where DASHBOARD_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, DASHBOARD_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectDashboard(String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, String POSI_EMP_ID_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDashboard(false, DASHBOARD_ID_, DASHBOARD_MODULE_ID_, POSI_EMP_ID_);// 根据查询条件组装查询SQL语句
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
    public int countDashboard(String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, String POSI_EMP_ID_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDashboard(true, DASHBOARD_ID_, DASHBOARD_MODULE_ID_, POSI_EMP_ID_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaDashboard(boolean count, String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, String POSI_EMP_ID_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_DASHBOARD where 1 = 1";
        }
        else {
            sql = "select * from CBV_DASHBOARD where 1 = 1";
        }

        if (StringUtils.isNotEmpty(DASHBOARD_ID_)) {
            sql += " and DASHBOARD_ID_ = :DASHBOARD_ID_";
            paramMap.put("DASHBOARD_ID_", DASHBOARD_ID_);
        }
        if (StringUtils.isNotEmpty(DASHBOARD_MODULE_ID_)) {
            sql += " and DASHBOARD_MODULE_ID_ = :DASHBOARD_MODULE_ID_";
            paramMap.put("DASHBOARD_MODULE_ID_", DASHBOARD_MODULE_ID_);
        }
        if (StringUtils.isNotEmpty(POSI_EMP_ID_)) {
            sql += " and POSI_EMP_ID_ = :POSI_EMP_ID_";
            paramMap.put("POSI_EMP_ID_", POSI_EMP_ID_);
        }
        else {
            sql += " and POSI_EMP_ID_ is null";
        }

        if (!count) {
            sql += " order by ORDER_";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectCommonDashboard(Integer page, Integer limit) {
        return selectDashboard(null, null, null, page, limit);
    }

    @Override
    public List<Map<String, Object>> selectMyDashboard(String POSI_EMP_ID_, Boolean alternative, Integer page, Integer limit) {
        List<Map<String, Object>> dashboardList = selectDashboard(null, null, POSI_EMP_ID_, page, limit);
        if (dashboardList.size() == 0 && (alternative == null || alternative == true)) {
            dashboardList = selectDashboard(null, null, null, page, limit);
        }

        return dashboardList;
    }

    @Override
    public List<Map<String, Object>> selectDashboardByIdList(List<String> DASHBOARD_ID_LIST) {
        if (DASHBOARD_ID_LIST == null || DASHBOARD_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(DASHBOARD_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_DASHBOARD where DASHBOARD_ID_ in (:DASHBOARD_ID_LIST)");
        paramMap.put("DASHBOARD_ID_LIST", DASHBOARD_ID_LIST);
        sql.append(" order by DECODE(DASHBOARD_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < DASHBOARD_ID_LIST.size(); i++) {
            sql.append(" '").append(DASHBOARD_ID_LIST.get(i)).append("', ").append(i);
            if (i < DASHBOARD_ID_LIST.size() - 1) {
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
    public int insertDashboard(String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, String POSI_EMP_ID_, String DASHBOARD_MODULE_NAME_, String URL_, String WIDTH_, String HEIGHT_, Integer ORDER_) {
        String sql = "insert into CB_DASHBOARD (DASHBOARD_ID_, DASHBOARD_MODULE_ID_, POSI_EMP_ID_, DASHBOARD_MODULE_NAME_, URL_, WIDTH_, HEIGHT_, ORDER_) values (?, ?, ?, ?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, DASHBOARD_ID_, DASHBOARD_MODULE_ID_, POSI_EMP_ID_, DASHBOARD_MODULE_NAME_, URL_, WIDTH_, HEIGHT_, ORDER_);
    }

    @Override
    public int insertDashboardByDashboardModule(String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, String POSI_EMP_ID_) {
        String sql;

        Integer ORDER_;
        if (StringUtils.isEmpty(POSI_EMP_ID_)) {
            sql = "select max(ORDER_) from CB_DASHBOARD where POSI_EMP_ID_ is null";
            ORDER_ = msJdbcTemplate.queryForObject(sql, Integer.class);
        }
        else {
            sql = "select max(ORDER_) from CB_DASHBOARD where POSI_EMP_ID_ = ?";
            ORDER_ = msJdbcTemplate.queryForObject(sql, new Object[] { POSI_EMP_ID_ }, Integer.class);
        }
        if (ORDER_ == null) {
            ORDER_ = 0;
        }
        ORDER_++;

        sql = "insert into CB_DASHBOARD (DASHBOARD_ID_, DASHBOARD_MODULE_ID_, POSI_EMP_ID_, DASHBOARD_MODULE_NAME_, URL_, WIDTH_, HEIGHT_, ORDER_) select ?, DASHBOARD_MODULE_ID_, ?, DASHBOARD_MODULE_NAME_, DEFAULT_URL_, DEFAULT_WIDTH_, DEFAULT_HEIGHT_, ? from CB_DASHBOARD_MODULE where DASHBOARD_MODULE_ID_ = ?";
        return msJdbcTemplate.update(sql, DASHBOARD_ID_, POSI_EMP_ID_, ORDER_, DASHBOARD_MODULE_ID_);
    }

    @Override
    public int updateDashboard(String DASHBOARD_ID_, String DASHBOARD_MODULE_NAME_, String URL_, String WIDTH_, String HEIGHT_, Integer ORDER_) {
        String sql = "update CB_DASHBOARD set DASHBOARD_MODULE_NAME_ = ?, URL_ = ?, WIDTH_ = ?, HEIGHT_ = ?, ORDER_ = ? where DASHBOARD_ID_ = ?";
        return msJdbcTemplate.update(sql, DASHBOARD_MODULE_NAME_, URL_, WIDTH_, HEIGHT_, ORDER_, DASHBOARD_ID_);
    }

    @Override
    public int updateDashboardOrder(final List<String> DASHBOARD_ID_LIST) {
        if (DASHBOARD_ID_LIST == null || DASHBOARD_ID_LIST.size() == 0) {
            return 0;
        }

        String sql = "update CB_DASHBOARD set ORDER_ = ? where DASHBOARD_ID_ = ?";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setInt(1, i);
                ps.setString(2, DASHBOARD_ID_LIST.get(i));
            }

            public int getBatchSize() {
                return DASHBOARD_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int deleteDashboard(String DASHBOARD_ID_) {
        String sql = "delete from CB_DASHBOARD where DASHBOARD_ID_ = ?";
        return msJdbcTemplate.update(sql, DASHBOARD_ID_);
    }

    @Override
    public int deleteDashboardByPosiEmpId(String POSI_EMP_ID_) {
        String sql = "delete from CB_DASHBOARD where POSI_EMP_ID_ = ?";
        return msJdbcTemplate.update(sql, POSI_EMP_ID_);
    }
}