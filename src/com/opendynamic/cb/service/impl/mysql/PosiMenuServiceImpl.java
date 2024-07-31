package com.opendynamic.cb.service.impl.mysql;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
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
import com.opendynamic.OdUtils;
import com.opendynamic.cb.service.PosiMenuService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class PosiMenuServiceImpl implements PosiMenuService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadPosiMenu(String POSI_MENU_ID_) {
        String sql = "select * from CBV_POSI_MENU where POSI_MENU_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, POSI_MENU_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectPosiMenu(String POSI_MENU_ID_, String POSI_ID_, String POSI_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaPosiMenu(false, POSI_MENU_ID_, POSI_ID_, POSI_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countPosiMenu(String POSI_MENU_ID_, String POSI_ID_, String POSI_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaPosiMenu(true, POSI_MENU_ID_, POSI_ID_, POSI_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaPosiMenu(boolean count, String POSI_MENU_ID_, String POSI_ID_, String POSI_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<>();

        if (count) {
            sql = "select count(*) from CBV_POSI_MENU where 1 = 1";
        }
        else {
            sql = "select * from CBV_POSI_MENU where 1 = 1";
        }

        if (POSI_MENU_ID_ != null) {
            sql += " and POSI_MENU_ID_ = :POSI_MENU_ID_";
            paramMap.put("POSI_MENU_ID_", POSI_MENU_ID_);
        }
        if (POSI_ID_ != null) {
            sql += " and POSI_ID_ = :POSI_ID_";
            paramMap.put("POSI_ID_", POSI_ID_);
        }
        if (POSI_NAME_ != null) {
            sql += " and POSI_NAME_ like concat('%',:POSI_NAME_,'%')";
            paramMap.put("POSI_NAME_", POSI_NAME_);
        }
        if (MENU_ID_ != null) {
            sql += " and MENU_ID_ = :MENU_ID_";
            paramMap.put("MENU_ID_", MENU_ID_);
        }
        if (PARENT_MENU_ID_ != null) {
            sql += " and PARENT_MENU_ID_ = :PARENT_MENU_ID_";
            paramMap.put("PARENT_MENU_ID_", PARENT_MENU_ID_);
        }
        if (MENU_NAME_ != null) {
            sql += " and MENU_NAME_ like concat('%',:MENU_NAME_,'%')";
            paramMap.put("MENU_NAME_", MENU_NAME_);
        }
        if (MENU_TYPE_LIST != null && !MENU_TYPE_LIST.isEmpty()) {
            sql += " and MENU_TYPE_ in (:MENU_TYPE_LIST)";
            paramMap.put("MENU_TYPE_LIST", MENU_TYPE_LIST);
        }
        if (MENU_STATUS_LIST != null && !MENU_STATUS_LIST.isEmpty()) {
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
    public List<Map<String, Object>> selectPosiMenuByIdList(List<String> POSI_MENU_ID_LIST) {
        if (POSI_MENU_ID_LIST == null || POSI_MENU_ID_LIST.isEmpty()) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(POSI_MENU_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<>();

        sql.append("select * from CBV_POSI_MENU where POSI_MENU_ID_ in (:POSI_MENU_ID_LIST)");
        paramMap.put("POSI_MENU_ID_LIST", POSI_MENU_ID_LIST);
        sql.append(" order by FIELD(POSI_MENU_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < POSI_MENU_ID_LIST.size(); i++) {
            sql.append(" '").append(POSI_MENU_ID_LIST.get(i)).append("'");
            if (i < POSI_MENU_ID_LIST.size() - 1) {
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
    public int insertPosiMenu(String POSI_MENU_ID_, String POSI_ID_, String POSI_NAME_, String MENU_ID_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "insert into CB_POSI_MENU (POSI_MENU_ID_, POSI_ID_, POSI_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (?, ?, ?, ?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, POSI_MENU_ID_, POSI_ID_, POSI_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);
    }

    @Override
    public int insertPosiMenu(final List<String> POSI_ID_LIST, final List<String> POSI_NAME_LIST, final List<String> MENU_ID_LIST, final Date CREATION_DATE_, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        if (POSI_ID_LIST == null || POSI_ID_LIST.isEmpty() || MENU_ID_LIST == null || MENU_ID_LIST.isEmpty()) {
            return 0;
        }

        String sql = "insert into CB_POSI_MENU (POSI_MENU_ID_, POSI_ID_, POSI_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (?, ?, ?, ?, ?, ?, ?, ?)";
        for (int i = 0; i < POSI_ID_LIST.size(); i++) {
            final String POSI_ID_ = POSI_ID_LIST.get(i);
            final String POSI_NAME_ = POSI_NAME_LIST.get(i);

            BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
                public void setValues(PreparedStatement ps, int j) throws SQLException {
                    ps.setString(1, OdUtils.getUuid());
                    ps.setString(2, POSI_ID_);
                    ps.setString(3, POSI_NAME_);
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

        return POSI_ID_LIST.size() * MENU_ID_LIST.size();
    }

    @Override
    public int updatePosiMenu(String POSI_MENU_ID_, String POSI_ID_, String POSI_NAME_, String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update CB_POSI_MENU set POSI_ID_ = ?, POSI_NAME_ = ?, MENU_ID_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where POSI_MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, POSI_ID_, POSI_NAME_, MENU_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, POSI_MENU_ID_);
    }

    @Override
    public int updatePosiMenuByMenuIdList(final String POSI_ID_, final String POSI_NAME_, final List<String> MENU_ID_LIST, final Date CREATION_DATE_, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        deletePosiMenuByPosiId(POSI_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);

        if (MENU_ID_LIST == null || MENU_ID_LIST.isEmpty()) {
            return 0;
        }

        String sql = "insert into CB_POSI_MENU (POSI_MENU_ID_, POSI_ID_, POSI_NAME_, MENU_ID_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (?, ?, ?, ?, ?, ?, ?, ?)";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setString(1, OdUtils.getUuid());
                ps.setString(2, POSI_ID_);
                ps.setString(3, POSI_NAME_);
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
    public int deletePosiMenu(String POSI_MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from CB_POSI_MENU where POSI_MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, POSI_MENU_ID_);
    }

    @Override
    public int deletePosiMenuByPosiId(String POSI_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from CB_POSI_MENU where POSI_ID_ = ?";
        return msJdbcTemplate.update(sql, POSI_ID_);
    }

    @Override
    public int deletePosiMenuByMenuId(String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from CB_POSI_MENU where MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, MENU_ID_);
    }
}