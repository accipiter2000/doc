package com.opendynamic.cb.service.impl.mysql;

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
import com.opendynamic.cb.service.MenuService;
import com.opendynamic.cb.service.PosiEmpMenuService;
import com.opendynamic.cb.service.PosiMenuService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class MenuServiceImpl implements MenuService {
    @Autowired
    private PosiMenuService posiMenuService;
    @Autowired
    private PosiEmpMenuService posiEmpMenuService;
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadMenu(String MENU_ID_) {
        String sql = "select * from CBV_MENU where MENU_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, MENU_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectMenu(String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaMenu(false, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countMenu(String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaMenu(true, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaMenu(boolean count, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_MENU where 1 = 1";
        }
        else {
            sql = "select * from CBV_MENU where 1 = 1";
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
    public List<Map<String, Object>> selectParentMenu(String MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean recursive, Boolean includeSelf) {
        if (StringUtils.isEmpty(MENU_ID_)) {
            throw new RuntimeException("errors.idRequired");
        }

        String sql = "select * from CBV_MENU where 1 = 1";
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("MENU_ID_", MENU_ID_);

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

        if (includeSelf == null || includeSelf.equals(false)) {
            sql += " and MENU_ID_ != :MENU_ID_";
        }
        if (recursive == null || recursive.equals(false)) {
            sql += " and (MENU_ID_ = (select PARENT_MENU_ID_ from CB_MENU where MENU_ID_ = :MENU_ID_) or MENU_ID_ = :MENU_ID_)";
        }
        else {
            sql += " and MENU_ID_ in (with recursive CTE as (select MENU_ID_, PARENT_MENU_ID_ from CB_MENU where MENU_ID_ = :MENU_ID_ union all select CB_MENU.MENU_ID_, CB_MENU.PARENT_MENU_ID_ from CB_MENU inner join CTE on CTE.PARENT_MENU_ID_ = CB_MENU.MENU_ID_) select MENU_ID_ from CTE)";
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectChildMenu(String MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean recursive, Boolean includeSelf) {
        if (StringUtils.isEmpty(MENU_ID_)) {
            throw new RuntimeException("errors.idRequired");
        }

        String sql = "select * from CBV_MENU where 1 = 1";
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("MENU_ID_", MENU_ID_);

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

        if (includeSelf == null || includeSelf.equals(false)) {
            sql += " and MENU_ID_ != :MENU_ID_";
        }
        if (recursive == null || recursive.equals(false)) {
            sql += " and (PARENT_MENU_ID_ = :MENU_ID_ or MENU_ID_ = :MENU_ID_)";
        }
        else {
            sql += " and MENU_ID_ in (with recursive CTE as (select MENU_ID_, PARENT_MENU_ID_ from CB_MENU where MENU_ID_ = :MENU_ID_ union all select CB_MENU.MENU_ID_, CB_MENU.PARENT_MENU_ID_ from CB_MENU inner join CTE on CTE.MENU_ID_ = CB_MENU.PARENT_MENU_ID_) select MENU_ID_ from CTE)";
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectMenuByIdList(List<String> MENU_ID_LIST) {
        if (MENU_ID_LIST == null || MENU_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(MENU_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_MENU where MENU_ID_ in (:MENU_ID_LIST)");
        paramMap.put("MENU_ID_LIST", MENU_ID_LIST);
        sql.append(" order by FIELD(MENU_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < MENU_ID_LIST.size(); i++) {
            sql.append(" '").append(MENU_ID_LIST.get(i)).append("'");
            if (i < MENU_ID_LIST.size() - 1) {
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
    public int insertMenu(String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, String MENU_TYPE_, String URL_, String ICON_, Integer ORDER_, String MENU_STATUS_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "insert into CB_MENU (MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_, URL_, ICON_, ORDER_, MENU_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''))";
        return msJdbcTemplate.update(sql, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_, URL_, ICON_, ORDER_, MENU_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);
    }

    @Override
    public int updateMenu(String MENU_ID_, String MENU_NAME_, String MENU_TYPE_, String URL_, String ICON_, Integer ORDER_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update CB_MENU set MENU_NAME_ = NULLIF(?, ''), MENU_TYPE_ = NULLIF(?, ''), URL_ = NULLIF(?, ''), ICON_ = NULLIF(?, ''),  ORDER_ = NULLIF(?, ''), UPDATE_DATE_ = NULLIF(?, ''), OPERATOR_ID_ = NULLIF(?, ''), OPERATOR_NAME_ = NULLIF(?, '') where MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, MENU_NAME_, MENU_TYPE_, URL_, ICON_, ORDER_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, MENU_ID_);
    }

    @Override
    public int updateMenuOrder(final List<String> MENU_ID_LIST, final List<Integer> ORDER_LIST, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        if (MENU_ID_LIST == null || MENU_ID_LIST.size() == 0) {
            return 0;
        }
        if (MENU_ID_LIST.size() != ORDER_LIST.size()) {
            return 0;
        }

        String sql = "update CB_MENU set ORDER_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where MENU_ID_ = ?";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setInt(1, ORDER_LIST.get(i));
                ps.setTimestamp(2, UPDATE_DATE_ == null ? null : new java.sql.Timestamp(UPDATE_DATE_.getTime()));
                ps.setString(3, OPERATOR_ID_);
                ps.setString(4, OPERATOR_NAME_);
                ps.setString(5, MENU_ID_LIST.get(i));
            }

            public int getBatchSize() {
                return MENU_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int moveMenu(String MENU_ID_, String PARENT_MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update CB_MENU set PARENT_MENU_ID_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where MENU_ID_ = ? and not exists (with recursive CTE as (select MENU_ID_ from CB_MENU where MENU_ID_ = ? union all select CB_MENU.MENU_ID_ from CB_MENU inner join CTE on CTE.MENU_ID_ = CB_MENU.PARENT_MENU_ID_) select 1 from CTE where MENU_ID_= ?)";
        return msJdbcTemplate.update(sql, PARENT_MENU_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, MENU_ID_, MENU_ID_, PARENT_MENU_ID_);
    }

    @Override
    public int disableMenu(String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update CB_MENU set MENU_STATUS_ = '0', UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, MENU_ID_);
    }

    @Override
    public int enableMenu(String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update CB_MENU set MENU_STATUS_ = '1', UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, MENU_ID_);
    }

    @Override
    public int deleteMenu(String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        posiEmpMenuService.deletePosiEmpMenuByMenuId(MENU_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);
        posiMenuService.deletePosiMenuByMenuId(MENU_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);

        String sql = "delete from CB_MENU where MENU_ID_ = ?";
        return msJdbcTemplate.update(sql, MENU_ID_);
    }
}