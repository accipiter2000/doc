package com.opendynamic.cb.service.impl.oracle;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
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
import com.opendynamic.OdUtils;
import com.opendynamic.cb.service.PosiEmpMenuService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class PosiEmpMenuServiceImpl implements PosiEmpMenuService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadPosiEmpMenu(String POSI_EMP_MENU_ID_) {
        String sql = "select * from CBV_POSI_EMP_MENU where POSI_EMP_MENU_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, POSI_EMP_MENU_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectPosiEmpMenu(String POSI_EMP_MENU_ID_, String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaPosiEmpMenu(false, POSI_EMP_MENU_ID_, POSI_EMP_ID_, POSI_NAME_, EMP_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);// 根据查询条件组装查询SQL语句
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
    public int countPosiEmpMenu(String POSI_EMP_MENU_ID_, String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaPosiEmpMenu(true, POSI_EMP_MENU_ID_, POSI_EMP_ID_, POSI_NAME_, EMP_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaPosiEmpMenu(boolean count, String POSI_EMP_MENU_ID_, String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_POSI_EMP_MENU where 1 = 1";
        }
        else {
            sql = "select * from CBV_POSI_EMP_MENU where 1 = 1";
        }

        if (StringUtils.isNotEmpty(POSI_EMP_MENU_ID_)) {
            sql += " and POSI_EMP_MENU_ID_ = :POSI_EMP_MENU_ID_";
            paramMap.put("POSI_EMP_MENU_ID_", POSI_EMP_MENU_ID_);
        }
        if (StringUtils.isNotEmpty(POSI_EMP_ID_)) {
            sql += " and POSI_EMP_ID_ = :POSI_EMP_ID_";
            paramMap.put("POSI_EMP_ID_", POSI_EMP_ID_);
        }
        if (StringUtils.isNotEmpty(POSI_NAME_)) {
            sql += " and POSI_NAME_ like '%' || :POSI_NAME_ || '%'";
            paramMap.put("POSI_NAME_", POSI_NAME_);
        }
        if (StringUtils.isNotEmpty(EMP_NAME_)) {
            sql += " and EMP_NAME_ like '%' || :EMP_NAME_ || '%'";
            paramMap.put("EMP_NAME_", EMP_NAME_);
        }
        if (StringUtils.isNotEmpty(MENU_ID_)) {
            sql += " and MENU_ID_ = :MENU_ID_";
            paramMap.put("MENU_ID_", MENU_ID_);
        }
        if (StringUtils.isNotEmpty(PARENT_MENU_ID_)) {
            sql += " and PARENT_MENU_ID_ = :PARENT_MENU_ID_";
            paramMap.put("PARENT_MENU_ID_", PARENT_MENU_ID_);
        }
        if (StringUtils.isNotEmpty(MENU_NAME_)) {
            sql += " and MENU_NAME_ like '%' || :MENU_NAME_ || '%'";
            paramMap.put("MENU_NAME_", MENU_NAME_);
        }
        if (MENU_TYPE_LIST != null && MENU_TYPE_LIST.size() > 0) {
            sql += " and MENU_TYPE_ in (:MENU_TYPE_LIST)";
            paramMap.put("MENU_TYPE_LIST", MENU_TYPE_LIST);
        }
        if (MENU_STATUS_LIST != null && MENU_STATUS_LIST.size() > 0) {
            sql += " and MENU_STATUS_ in (:MENU_STATUS_LIST)";
            paramMap.put("MENU_STATUS_LIST", MENU_STATUS_LIST);
        }

        if (rootOnly != null && rootOnly) {
            sql += " and (PARENT_MENU_ID_ is null or PARENT_MENU_ID_ = '')";
        }

        if (!count) {
            sql += " order by ORDER_";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectPosiEmpMenuByIdList(List<String> POSI_EMP_MENU_ID_LIST) {
        if (POSI_EMP_MENU_ID_LIST == null || POSI_EMP_MENU_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(POSI_EMP_MENU_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_POSI_EMP_MENU where POSI_EMP_MENU_ID_ in (:POSI_EMP_MENU_ID_LIST)");
        paramMap.put("POSI_EMP_MENU_ID_LIST", POSI_EMP_MENU_ID_LIST);
        sql.append(" order by DECODE(POSI_EMP_MENU_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < POSI_EMP_MENU_ID_LIST.size(); i++) {
            sql.append(" '").append(POSI_EMP_MENU_ID_LIST.get(i)).append("', ").append(i);
            if (i < POSI_EMP_MENU_ID_LIST.size() - 1) {
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
    public int insertPosiEmpMenu(String POSI_EMP_MENU_ID_, String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, String MENU_ID_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "insert into CB_POSI_EMP_MENU (POSI_EMP_MENU_ID_, POSI_EMP_ID_, POSI_NAME_, EMP_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, POSI_EMP_MENU_ID_, POSI_EMP_ID_, POSI_NAME_, EMP_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);
    }

    @Override
    public int insertPosiEmpMenu(final List<String> POSI_EMP_ID_LIST, final List<String> POSI_NAME_LIST, final List<String> EMP_NAME_LIST, final List<String> MENU_ID_LIST, final Date CREATION_DATE_, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        if (POSI_EMP_ID_LIST == null || POSI_EMP_ID_LIST.size() == 0 || MENU_ID_LIST == null || MENU_ID_LIST.size() == 0) {
            return 0;
        }

        String sql = "insert into CB_POSI_EMP_MENU (POSI_EMP_MENU_ID_, POSI_EMP_ID_, POSI_NAME_, EMP_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        for (int i = 0; i < POSI_EMP_ID_LIST.size(); i++) {
            final String POSI_EMP_ID_ = POSI_EMP_ID_LIST.get(i);
            final String POSI_NAME_ = POSI_NAME_LIST.get(i);
            final String EMP_NAME_ = EMP_NAME_LIST.get(i);

            BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
                public void setValues(PreparedStatement ps, int j) throws SQLException {
                    ps.setString(1, OdUtils.getUuid());
                    ps.setString(2, POSI_EMP_ID_);
                    ps.setString(3, POSI_NAME_);
                    ps.setString(4, EMP_NAME_);
                    ps.setString(5, MENU_ID_LIST.get(j));
                    ps.setTimestamp(6, CREATION_DATE_ == null ? null : new Timestamp(CREATION_DATE_.getTime()));
                    ps.setTimestamp(7, UPDATE_DATE_ == null ? null : new Timestamp(UPDATE_DATE_.getTime()));
                    ps.setString(8, OPERATOR_ID_);
                    ps.setString(9, OPERATOR_NAME_);
                }

                public int getBatchSize() {
                    return MENU_ID_LIST.size();
                }
            };
            msJdbcTemplate.batchUpdate(sql, batch);
        }

        return POSI_EMP_ID_LIST.size() * MENU_ID_LIST.size();
    }

    @Override
    public int updatePosiEmpMenu(String POSI_EMP_MENU_ID_, String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update CB_POSI_EMP_MENU set POSI_EMP_ID_ = ?, POSI_NAME_ = ?, EMP_NAME_ = ?, MENU_ID_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where POSI_EMP_MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, POSI_EMP_ID_, POSI_NAME_, EMP_NAME_, MENU_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, POSI_EMP_MENU_ID_);
    }

    @Override
    public int updatePosiEmpMenuByMenuIdList(final String POSI_EMP_ID_, final String POSI_NAME_, final String EMP_NAME_, final List<String> MENU_ID_LIST, final Date CREATION_DATE_, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        deletePosiEmpMenuByPosiEmpId(POSI_EMP_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);

        if (MENU_ID_LIST == null || MENU_ID_LIST.size() == 0) {
            return 0;
        }

        String sql = "insert into CB_POSI_EMP_MENU (POSI_EMP_MENU_ID_, POSI_EMP_ID_, POSI_NAME_, EMP_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        BatchPreparedStatementSetter batch;
        batch = new BatchPreparedStatementSetter() {// 加菜单
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setString(1, OdUtils.getUuid());
                ps.setString(2, POSI_EMP_ID_);
                ps.setString(3, POSI_NAME_);
                ps.setString(4, EMP_NAME_);
                ps.setString(5, MENU_ID_LIST.get(i));
                ps.setTimestamp(6, CREATION_DATE_ == null ? null : new Timestamp(CREATION_DATE_.getTime()));
                ps.setTimestamp(7, UPDATE_DATE_ == null ? null : new Timestamp(UPDATE_DATE_.getTime()));
                ps.setString(8, OPERATOR_ID_);
                ps.setString(9, OPERATOR_NAME_);
            }

            public int getBatchSize() {
                return MENU_ID_LIST.size();
            }
        };
        msJdbcTemplate.batchUpdate(sql, batch);

        return MENU_ID_LIST.size();
    }

    @Override
    public int deletePosiEmpMenu(String POSI_EMP_MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from CB_POSI_EMP_MENU where POSI_EMP_MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, POSI_EMP_MENU_ID_);
    }

    @Override
    public int deletePosiEmpMenuByPosiEmpId(String POSI_EMP_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from CB_POSI_EMP_MENU where POSI_EMP_ID_ = ?";
        return msJdbcTemplate.update(sql, POSI_EMP_ID_);
    }

    @Override
    public int deletePosiEmpMenuByMenuId(String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from CB_POSI_EMP_MENU where MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, MENU_ID_);
    }
}