package com.opendynamic.cb.service.impl.mysql;

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
import com.opendynamic.cb.service.DutyMenuService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class DutyMenuServiceImpl implements DutyMenuService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadDutyMenu(String DUTY_MENU_ID_) {
        String sql = "select * from CBV_DUTY_MENU where DUTY_MENU_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, DUTY_MENU_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectDutyMenu(String DUTY_MENU_ID_, String DUTY_ID_, String DUTY_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDutyMenu(false, DUTY_MENU_ID_, DUTY_ID_, DUTY_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countDutyMenu(String DUTY_MENU_ID_, String DUTY_ID_, String DUTY_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDutyMenu(true, DUTY_MENU_ID_, DUTY_ID_, DUTY_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaDutyMenu(boolean count, String DUTY_MENU_ID_, String DUTY_ID_, String DUTY_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_DUTY_MENU where 1 = 1";
        }
        else {
            sql = "select * from CBV_DUTY_MENU where 1 = 1";
        }

        if (StringUtils.isNotEmpty(DUTY_MENU_ID_)) {
            sql += " and DUTY_MENU_ID_ = :DUTY_MENU_ID_";
            paramMap.put("DUTY_MENU_ID_", DUTY_MENU_ID_);
        }
        if (StringUtils.isNotEmpty(DUTY_ID_)) {
            sql += " and DUTY_ID_ = :DUTY_ID_";
            paramMap.put("DUTY_ID_", DUTY_ID_);
        }
        if (StringUtils.isNotEmpty(DUTY_NAME_)) {
            sql += " and DUTY_NAME_like concat('%',:DUTY_NAME_,'%')";
            paramMap.put("DUTY_NAME_", DUTY_NAME_);
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
            sql += " and MENU_NAME_like concat('%',:MENU_NAME_,'%')";
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
    public List<Map<String, Object>> selectDutyMenuByIdList(List<String> DUTY_MENU_ID_LIST) {
        if (DUTY_MENU_ID_LIST == null || DUTY_MENU_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(DUTY_MENU_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_DUTY_MENU where DUTY_MENU_ID_ in (:DUTY_MENU_ID_LIST)");
        paramMap.put("DUTY_MENU_ID_LIST", DUTY_MENU_ID_LIST);
        sql.append(" order by FIELD(DUTY_MENU_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < DUTY_MENU_ID_LIST.size(); i++) {
            sql.append(" '").append(DUTY_MENU_ID_LIST.get(i)).append("'");
            if (i < DUTY_MENU_ID_LIST.size() - 1) {
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
    public int insertDutyMenu(String DUTY_MENU_ID_, String DUTY_ID_, String DUTY_NAME_, String MENU_ID_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "insert into CB_DUTY_MENU (DUTY_MENU_ID_, DUTY_ID_, DUTY_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''))";
        return msJdbcTemplate.update(sql, DUTY_MENU_ID_, DUTY_ID_, DUTY_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);
    }

    @Override
    public int insertDutyMenu(final List<String> DUTY_ID_LIST, final List<String> DUTY_NAME_LIST, final List<String> MENU_ID_LIST, final Date CREATION_DATE_, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        if (DUTY_ID_LIST == null || DUTY_ID_LIST.size() == 0 || MENU_ID_LIST == null || MENU_ID_LIST.size() == 0) {
            return 0;
        }

        String sql = "insert into CB_DUTY_MENU (DUTY_MENU_ID_, DUTY_ID_, DUTY_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''))";
        for (int i = 0; i < DUTY_ID_LIST.size(); i++) {
            final String DUTY_ID_ = DUTY_ID_LIST.get(i);
            final String DUTY_NAME_ = DUTY_NAME_LIST.get(i);

            BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
                public void setValues(PreparedStatement ps, int j) throws SQLException {
                    ps.setString(1, OdUtils.getUuid());
                    ps.setString(2, DUTY_ID_);
                    ps.setString(3, DUTY_NAME_);
                    ps.setString(4, MENU_ID_LIST.get(j));
                    ps.setTimestamp(5, CREATION_DATE_ == null ? null : new Timestamp(CREATION_DATE_.getTime()));
                    ps.setTimestamp(6, UPDATE_DATE_ == null ? null : new Timestamp(UPDATE_DATE_.getTime()));
                    ps.setString(7, OPERATOR_ID_);
                    ps.setString(8, OPERATOR_NAME_);
                }

                public int getBatchSize() {
                    return MENU_ID_LIST.size();
                }
            };
            msJdbcTemplate.batchUpdate(sql, batch);
        }

        return DUTY_ID_LIST.size() * MENU_ID_LIST.size();
    }

    @Override
    public int updateDutyMenu(String DUTY_MENU_ID_, String DUTY_ID_, String DUTY_NAME_, String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update CB_DUTY_MENU set DUTY_ID_ = NULLIF(?, ''), DUTY_NAME_ = NULLIF(?, ''), MENU_ID_ = NULLIF(?, ''), UPDATE_DATE_ = NULLIF(?, ''), OPERATOR_ID_ = NULLIF(?, ''), OPERATOR_NAME_ = NULLIF(?, '') where DUTY_MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, DUTY_ID_, DUTY_NAME_, MENU_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, DUTY_MENU_ID_);
    }

    @Override
    public int updateDutyMenuByMenuIdList(final String DUTY_ID_, final String DUTY_NAME_, final List<String> MENU_ID_LIST, final Date CREATION_DATE_, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        deleteDutyMenuByDutyId(DUTY_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);

        if (MENU_ID_LIST == null || MENU_ID_LIST.size() == 0) {
            return 0;
        }

        String sql = "insert into CB_DUTY_MENU (DUTY_MENU_ID_, DUTY_ID_, DUTY_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''))";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setString(1, OdUtils.getUuid());
                ps.setString(2, DUTY_ID_);
                ps.setString(3, DUTY_NAME_);
                ps.setString(4, MENU_ID_LIST.get(i));
                ps.setTimestamp(5, CREATION_DATE_ == null ? null : new Timestamp(CREATION_DATE_.getTime()));
                ps.setTimestamp(6, UPDATE_DATE_ == null ? null : new Timestamp(UPDATE_DATE_.getTime()));
                ps.setString(7, OPERATOR_ID_);
                ps.setString(8, OPERATOR_NAME_);
            }

            public int getBatchSize() {
                return MENU_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int deleteDutyMenu(String DUTY_MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from CB_DUTY_MENU where DUTY_MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, DUTY_MENU_ID_);
    }

    @Override
    public int deleteDutyMenuByDutyId(String DUTY_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from CB_DUTY_MENU where DUTY_ID_ = ?";
        return msJdbcTemplate.update(sql, DUTY_ID_);
    }

    @Override
    public int deleteDutyMenuByMenuId(String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from CB_DUTY_MENU where MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, MENU_ID_);
    }
}