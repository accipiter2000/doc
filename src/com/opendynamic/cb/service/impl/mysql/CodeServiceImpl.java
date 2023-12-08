package com.opendynamic.cb.service.impl.mysql;

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
import com.opendynamic.cb.service.CodeService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class CodeServiceImpl implements CodeService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadCode(String CODE_ID_) {
        String sql = "select * from CBV_CODE where CODE_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, CODE_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectCode(String CODE_ID_, String PARENT_CODE_ID_, List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean rootOnly, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaCode(false, CODE_ID_, PARENT_CODE_ID_, CATEGORY_LIST, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, rootOnly);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countCode(String CODE_ID_, String PARENT_CODE_ID_, List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean rootOnly) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaCode(true, CODE_ID_, PARENT_CODE_ID_, CATEGORY_LIST, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, rootOnly);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaCode(boolean count, String CODE_ID_, String PARENT_CODE_ID_, List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean rootOnly) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_CODE where 1 = 1";
        }
        else {
            sql = "select * from CBV_CODE where 1 = 1";
        }

        if (StringUtils.isNotEmpty(CODE_ID_)) {
            sql += " and CODE_ID_ = :CODE_ID_";
            paramMap.put("CODE_ID_", CODE_ID_);
        }
        if (StringUtils.isNotEmpty(PARENT_CODE_ID_)) {
            sql += " and PARENT_CODE_ID_ = :PARENT_CODE_ID_";
            paramMap.put("PARENT_CODE_ID_", PARENT_CODE_ID_);
        }
        if (CATEGORY_LIST != null && CATEGORY_LIST.size() > 0) {
            sql += " and CATEGORY_ in (:CATEGORY_LIST)";
            paramMap.put("CATEGORY_LIST", CATEGORY_LIST);
        }
        if (StringUtils.isNotEmpty(CODE_)) {
            sql += " and CODE_ = :CODE_";
            paramMap.put("CODE_", CODE_);
        }
        if (StringUtils.isNotEmpty(NAME_)) {
            sql += " and NAME_like concat('%',:NAME_,'%')";
            paramMap.put("NAME_", NAME_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_1_)) {
            sql += " and EXT_ATTR_1_ = :EXT_ATTR_1_";
            paramMap.put("EXT_ATTR_1_", EXT_ATTR_1_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_2_)) {
            sql += " and EXT_ATTR_2_ = :EXT_ATTR_2_";
            paramMap.put("EXT_ATTR_2_", EXT_ATTR_2_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_3_)) {
            sql += " and EXT_ATTR_3_ = :EXT_ATTR_3_";
            paramMap.put("EXT_ATTR_3_", EXT_ATTR_3_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_4_)) {
            sql += " and EXT_ATTR_4_ = :EXT_ATTR_4_";
            paramMap.put("EXT_ATTR_4_", EXT_ATTR_4_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_5_)) {
            sql += " and EXT_ATTR_5_ = :EXT_ATTR_5_";
            paramMap.put("EXT_ATTR_5_", EXT_ATTR_5_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_6_)) {
            sql += " and EXT_ATTR_6_ = :EXT_ATTR_6_";
            paramMap.put("EXT_ATTR_6_", EXT_ATTR_6_);
        }

        if (rootOnly != null && rootOnly) {
            sql += " and (PARENT_CODE_ID_ is null or PARENT_CODE_ID_ = '')";
        }

        if (!count) {
            sql += " order by CATEGORY_, ORDER_";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectParentCode(String CODE_ID_, List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean recursive, Boolean includeSelf) {
        if (StringUtils.isEmpty(CODE_ID_)) {
            throw new RuntimeException("errors.idRequired");
        }

        String sql = "select * from CBV_CODE where 1 = 1";
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("CODE_ID_", CODE_ID_);

        if (CATEGORY_LIST != null && CATEGORY_LIST.size() > 0) {
            sql += " and CATEGORY_ in (:CATEGORY_LIST)";
            paramMap.put("CATEGORY_LIST", CATEGORY_LIST);
        }
        if (StringUtils.isNotEmpty(CODE_)) {
            sql += " and CODE_ = :CODE_";
            paramMap.put("CODE_", CODE_);
        }
        if (StringUtils.isNotEmpty(NAME_)) {
            sql += " and NAME_like concat('%',:NAME_,'%')";
            paramMap.put("NAME_", NAME_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_1_)) {
            sql += " and EXT_ATTR_1_ = :EXT_ATTR_1_";
            paramMap.put("EXT_ATTR_1_", EXT_ATTR_1_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_2_)) {
            sql += " and EXT_ATTR_2_ = :EXT_ATTR_2_";
            paramMap.put("EXT_ATTR_2_", EXT_ATTR_2_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_3_)) {
            sql += " and EXT_ATTR_3_ = :EXT_ATTR_3_";
            paramMap.put("EXT_ATTR_3_", EXT_ATTR_3_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_4_)) {
            sql += " and EXT_ATTR_4_ = :EXT_ATTR_4_";
            paramMap.put("EXT_ATTR_4_", EXT_ATTR_4_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_5_)) {
            sql += " and EXT_ATTR_5_ = :EXT_ATTR_5_";
            paramMap.put("EXT_ATTR_5_", EXT_ATTR_5_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_6_)) {
            sql += " and EXT_ATTR_6_ = :EXT_ATTR_6_";
            paramMap.put("EXT_ATTR_6_", EXT_ATTR_6_);
        }

        if (includeSelf == null || includeSelf.equals(false)) {
            sql += " and CODE_ID_ != :CODE_ID_";
        }
        if (recursive == null || recursive.equals(false)) {
            sql += " and (CODE_ID_ = (select PARENT_CODE_ID_ from CB_CODE where CODE_ID_ = :CODE_ID_) or CODE_ID_ = :CODE_ID_)";
        }
        else {
            sql += " and CODE_ID_ in (with recursive CTE as (select CODE_ID_, PARENT_CODE_ID_ from CB_CODE where CODE_ID_ = :CODE_ID_ union all select CB_CODE.CODE_ID_, CB_CODE.PARENT_CODE_ID_ from CB_CODE inner join CTE on CTE.PARENT_CODE_ID_ = CB_CODE.CODE_ID_) select CODE_ID_ from CTE)";
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectChildCode(String CODE_ID_, List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean recursive, Boolean includeSelf) {
        if (StringUtils.isEmpty(CODE_ID_)) {
            throw new RuntimeException("errors.idRequired");
        }

        String sql = "select * from CBV_CODE where 1 = 1";
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("CODE_ID_", CODE_ID_);

        if (CATEGORY_LIST != null && CATEGORY_LIST.size() > 0) {
            sql += " and CATEGORY_ in (:CATEGORY_LIST)";
            paramMap.put("CATEGORY_LIST", CATEGORY_LIST);
        }
        if (StringUtils.isNotEmpty(CODE_)) {
            sql += " and CODE_ = :CODE_";
            paramMap.put("CODE_", CODE_);
        }
        if (StringUtils.isNotEmpty(NAME_)) {
            sql += " and NAME_like concat('%',:NAME_,'%')";
            paramMap.put("NAME_", NAME_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_1_)) {
            sql += " and EXT_ATTR_1_ = :EXT_ATTR_1_";
            paramMap.put("EXT_ATTR_1_", EXT_ATTR_1_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_2_)) {
            sql += " and EXT_ATTR_2_ = :EXT_ATTR_2_";
            paramMap.put("EXT_ATTR_2_", EXT_ATTR_2_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_3_)) {
            sql += " and EXT_ATTR_3_ = :EXT_ATTR_3_";
            paramMap.put("EXT_ATTR_3_", EXT_ATTR_3_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_4_)) {
            sql += " and EXT_ATTR_4_ = :EXT_ATTR_4_";
            paramMap.put("EXT_ATTR_4_", EXT_ATTR_4_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_5_)) {
            sql += " and EXT_ATTR_5_ = :EXT_ATTR_5_";
            paramMap.put("EXT_ATTR_5_", EXT_ATTR_5_);
        }
        if (StringUtils.isNotEmpty(EXT_ATTR_6_)) {
            sql += " and EXT_ATTR_6_ = :EXT_ATTR_6_";
            paramMap.put("EXT_ATTR_6_", EXT_ATTR_6_);
        }

        if (includeSelf == null || includeSelf.equals(false)) {
            sql += " and CODE_ID_ != :CODE_ID_";
        }
        if (recursive == null || recursive.equals(false)) {
            sql += " and (PARENT_CODE_ID_ = :CODE_ID_ or CODE_ID_ = :CODE_ID_)";
        }
        else {
            sql += " and CODE_ID_ in (with recursive CTE as (select CODE_ID_, PARENT_CODE_ID_ from CB_CODE where CODE_ID_ = :CODE_ID_ union all select CB_CODE.CODE_ID_, CB_CODE.PARENT_CODE_ID_ from CB_CODE inner join CTE on CTE.CODE_ID_ = CB_CODE.PARENT_CODE_ID_) select CODE_ID_ from CTE)";
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectCodeCategory() {
        String sql = "select distinct(CATEGORY_) from CB_CODE order by CATEGORY_";
        return msJdbcTemplate.queryForList(sql);
    }

    @Override
    public List<Map<String, Object>> selectCodeByIdList(List<String> CODE_ID_LIST) {
        if (CODE_ID_LIST == null || CODE_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(CODE_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_CODE where CODE_ID_ in (:CODE_ID_LIST)");
        paramMap.put("CODE_ID_LIST", CODE_ID_LIST);
        sql.append(" order by FIELD(CODE_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < CODE_ID_LIST.size(); i++) {
            sql.append(" '").append(CODE_ID_LIST.get(i)).append("'");
            if (i < CODE_ID_LIST.size() - 1) {
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
    public int insertCode(String CODE_ID_, String PARENT_CODE_ID_, String CATEGORY_, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Integer ORDER_) {
        String sql = "insert into CB_CODE (CODE_ID_, PARENT_CODE_ID_, CATEGORY_, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_) values (NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''))";
        return msJdbcTemplate.update(sql, CODE_ID_, PARENT_CODE_ID_, CATEGORY_, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_);
    }

    @Override
    public int updateCode(String CODE_ID_, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Integer ORDER_) {
        String sql = "update CB_CODE set CODE_ = NULLIF(?, ''), NAME_ = NULLIF(?, ''), EXT_ATTR_1_ = NULLIF(?, ''), EXT_ATTR_2_ = NULLIF(?, ''), EXT_ATTR_3_ = NULLIF(?, ''), EXT_ATTR_4_ = NULLIF(?, ''), EXT_ATTR_5_ = NULLIF(?, ''), EXT_ATTR_6_ = NULLIF(?, ''), ORDER_ = NULLIF(?, '') where CODE_ID_ = ?";
        return msJdbcTemplate.update(sql, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_, CODE_ID_);
    }

    @Override
    public int updateCodeOrder(final List<String> CODE_ID_LIST, final List<Integer> ORDER_LIST) {
        if (CODE_ID_LIST == null || CODE_ID_LIST.size() == 0) {
            return 0;
        }
        if (CODE_ID_LIST.size() != ORDER_LIST.size()) {
            return 0;
        }

        String sql = "update CB_CODE set ORDER_ = ? where CODE_ID_ = ?";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setInt(1, ORDER_LIST.get(i));
                ps.setString(2, CODE_ID_LIST.get(i));
            }

            public int getBatchSize() {
                return CODE_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int moveCode(String CODE_ID_, String PARENT_CODE_ID_) {
        String sql = "update CB_CODE set PARENT_CODE_ID_ = ? where CODE_ID_ = ? and not exists (with recursive CTE as (select CODE_ID_ from CB_CODE where CODE_ID_ = ? union all select CB_CODE.CODE_ID_ from CB_CODE inner join CTE on CTE.CODE_ID_ = CB_CODE.PARENT_CODE_ID_) select 1 from CTE where CODE_ID_= ?)";
        return msJdbcTemplate.update(sql, PARENT_CODE_ID_, CODE_ID_, CODE_ID_, PARENT_CODE_ID_);
    }

    @Override
    public int deleteCode(String CODE_ID_) {
        String sql = "delete from CB_CODE where CODE_ID_ = ?";
        return msJdbcTemplate.update(sql, CODE_ID_);
    }
}