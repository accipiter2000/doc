package com.opendynamic.cb.service.impl.mysql;

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
import com.opendynamic.cb.service.CustomThemeService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class CustomThemeServiceImpl implements CustomThemeService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadCustomTheme(String CUSTOM_THEME_ID_) {
        String sql = "select * from CBV_CUSTOM_THEME where CUSTOM_THEME_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, CUSTOM_THEME_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public Map<String, Object> loadCustomThemeByOperatorId(String OPERATOR_ID_) {
        String sql = "select * from CBV_CUSTOM_THEME where OPERATOR_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, OPERATOR_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectCustomTheme(String CUSTOM_THEME_ID_, String OPERATOR_ID_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaCustomTheme(false, CUSTOM_THEME_ID_, OPERATOR_ID_);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countCustomTheme(String CUSTOM_THEME_ID_, String OPERATOR_ID_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaCustomTheme(true, CUSTOM_THEME_ID_, OPERATOR_ID_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaCustomTheme(boolean count, String CUSTOM_THEME_ID_, String OPERATOR_ID_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_CUSTOM_THEME where 1 = 1";
        }
        else {
            sql = "select * from CBV_CUSTOM_THEME where 1 = 1";
        }

        if (StringUtils.isNotEmpty(CUSTOM_THEME_ID_)) {
            sql += " and CUSTOM_THEME_ID_ = :CUSTOM_THEME_ID_";
            paramMap.put("CUSTOM_THEME_ID_", CUSTOM_THEME_ID_);
        }
        if (StringUtils.isNotEmpty(OPERATOR_ID_)) {
            sql += " and OPERATOR_ID_ = :OPERATOR_ID_";
            paramMap.put("OPERATOR_ID_", OPERATOR_ID_);
        }

        if (!count) {
            sql += " order by ORDER_";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectCustomThemeByIdList(List<String> CUSTOM_THEME_ID_LIST) {
        if (CUSTOM_THEME_ID_LIST == null || CUSTOM_THEME_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(CUSTOM_THEME_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_CUSTOM_THEME where CUSTOM_THEME_ID_ in (:CUSTOM_THEME_ID_LIST)");
        paramMap.put("CUSTOM_THEME_ID_LIST", CUSTOM_THEME_ID_LIST);
        sql.append(" order by FIELD(CUSTOM_THEME_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < CUSTOM_THEME_ID_LIST.size(); i++) {
            sql.append(" '").append(CUSTOM_THEME_ID_LIST.get(i)).append("'");
            if (i < CUSTOM_THEME_ID_LIST.size() - 1) {
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
    public int insertCustomTheme(String CUSTOM_THEME_ID_, String OPERATOR_ID_, String CSS_HREF_) {
        String sql = "insert into CB_CUSTOM_THEME (CUSTOM_THEME_ID_, OPERATOR_ID_, CSS_HREF_) values (?, ?, ?)";
        return msJdbcTemplate.update(sql, CUSTOM_THEME_ID_, OPERATOR_ID_, CSS_HREF_);
    }

    @Override
    public int updateCustomTheme(String CUSTOM_THEME_ID_, String CSS_HREF_) {
        String sql = "update CB_CUSTOM_THEME set CSS_HREF_ = ? where CUSTOM_THEME_ID_ = ?";
        return msJdbcTemplate.update(sql, CSS_HREF_, CUSTOM_THEME_ID_);
    }

    @Override
    public int deleteCustomTheme(String CUSTOM_THEME_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from CB_CUSTOM_THEME where CUSTOM_THEME_ID_ = ?";
        return msJdbcTemplate.update(sql, CUSTOM_THEME_ID_);
    }
}