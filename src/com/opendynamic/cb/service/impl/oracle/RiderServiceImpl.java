package com.opendynamic.cb.service.impl.oracle;

import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.support.SqlLobValue;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opendynamic.OdSqlCriteria;
import com.opendynamic.cb.service.RiderService;
import com.opendynamic.cb.service.TagService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class RiderServiceImpl implements RiderService {
    @Autowired
    private TagService tagService;
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadRider(String RIDER_ID_) {
        String sql = "select * from CBV_RIDER where RIDER_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, RIDER_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public InputStream loadRiderFile(String RIDER_ID_) {
        String sql = "select RIDER_FILE_ from CB_RIDER where RIDER_ID_ = ?";
        return msJdbcTemplate.queryForObject(sql, new Object[] { RIDER_ID_ }, new RowMapper<InputStream>() {
            public InputStream mapRow(ResultSet rs, int rowNum) throws SQLException {
                return rs.getBinaryStream(1);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectRider(String RIDER_ID_, String OBJ_ID_, String RIDER_FILE_NAME_, String RIDER_TAG_, List<String> RIDER_STATUS_LIST, Boolean tagUnion, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaRider(false, RIDER_ID_, OBJ_ID_, RIDER_FILE_NAME_, RIDER_TAG_, RIDER_STATUS_LIST, tagUnion);// 根据查询条件组装查询SQL语句
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
    public int countRider(String RIDER_ID_, String OBJ_ID_, String RIDER_FILE_NAME_, String RIDER_TAG_, List<String> RIDER_STATUS_LIST, Boolean tagUnion) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaRider(true, RIDER_ID_, OBJ_ID_, RIDER_FILE_NAME_, RIDER_TAG_, RIDER_STATUS_LIST, tagUnion);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaRider(boolean count, String RIDER_ID_, String OBJ_ID_, String RIDER_FILE_NAME_, String RIDER_TAG_, List<String> RIDER_STATUS_LIST, Boolean tagUnion) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_RIDER where 1 = 1";
        }
        else {
            sql = "select * from CBV_RIDER where 1 = 1";
        }

        if (StringUtils.isNotEmpty(RIDER_ID_)) {
            sql += " and RIDER_ID_ = :RIDER_ID_";
            paramMap.put("RIDER_ID_", RIDER_ID_);
        }
        if (StringUtils.isNotEmpty(OBJ_ID_)) {
            sql += " and OBJ_ID_ = :OBJ_ID_";
            paramMap.put("OBJ_ID_", OBJ_ID_);
        }
        if (StringUtils.isNotEmpty(RIDER_FILE_NAME_)) {
            sql += " and RIDER_FILE_NAME_ like '%' || :RIDER_FILE_NAME_ || '%'";
            paramMap.put("RIDER_FILE_NAME_", RIDER_FILE_NAME_);
        }
        if (StringUtils.isNotEmpty(RIDER_TAG_)) {
            List<String> tagList = tagService.splitTag(RIDER_TAG_);
            if (tagList.size() > 0) {
                if (tagUnion != null && tagUnion.equals(false)) {
                    sql += " and RIDER_ID_ in (select RIDER_ID_ from (select OBJ_ID_ as RIDER_ID_ from CB_TAG where OBJ_TYPE_ = 'RIDER' and TAG_ in (:RIDER_TAG_LIST)) T group by RIDER_ID_ having count(*) >= 1)";
                    paramMap.put("RIDER_TAG_LIST", tagList);
                }
                else {
                    sql += " and RIDER_ID_ in (select RIDER_ID_ from (select OBJ_ID_ as RIDER_ID_ from CB_TAG where OBJ_TYPE_ = 'RIDER' and TAG_ in (:RIDER_TAG_LIST)) T group by RIDER_ID_ having count(*) >= :tagCount)";
                    paramMap.put("RIDER_TAG_LIST", tagList);
                    paramMap.put("tagCount", tagList.size());
                }
            }
        }
        if (RIDER_STATUS_LIST != null && RIDER_STATUS_LIST.size() > 0) {
            sql += " and RIDER_STATUS_ in (:RIDER_STATUS_LIST)";
            paramMap.put("RIDER_STATUS_LIST", RIDER_STATUS_LIST);
        }

        if (!count) {
            sql += " order by ORDER_, CREATION_DATE_ desc";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectRiderByIdList(List<String> RIDER_ID_LIST) {
        if (RIDER_ID_LIST == null || RIDER_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(RIDER_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_RIDER where RIDER_ID_ in (:RIDER_ID_LIST)");
        paramMap.put("RIDER_ID_LIST", RIDER_ID_LIST);
        sql.append(" order by DECODE(RIDER_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < RIDER_ID_LIST.size(); i++) {
            sql.append(" '").append(RIDER_ID_LIST.get(i)).append("', ").append(i);
            if (i < RIDER_ID_LIST.size() - 1) {
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
    public int insertRider(String RIDER_ID_, String OBJ_ID_, InputStream RIDER_FILE_, String RIDER_FILE_NAME_, Integer RIDER_FILE_LENGTH_, String MEMO_, String RIDER_TAG_, Integer ORDER_, String RIDER_STATUS_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        RIDER_TAG_ = StringUtils.join(tagService.splitTag(RIDER_TAG_), ",");
        tagService.updateTagByObjId(RIDER_ID_, "RIDER", RIDER_TAG_);

        String sql = "insert into CB_RIDER (RIDER_ID_, OBJ_ID_, RIDER_FILE_, RIDER_FILE_NAME_, RIDER_FILE_LENGTH_, MEMO_, RIDER_TAG_, ORDER_, RIDER_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, new Object[] { RIDER_ID_, OBJ_ID_, new SqlLobValue(RIDER_FILE_, RIDER_FILE_LENGTH_, new DefaultLobHandler()), RIDER_FILE_NAME_, RIDER_FILE_LENGTH_, MEMO_, RIDER_TAG_, ORDER_, RIDER_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_ }, new int[] { Types.VARCHAR, Types.VARCHAR, Types.BLOB, Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.TIMESTAMP, Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR });
    }

    @Override
    public int updateRider(String RIDER_ID_, InputStream RIDER_FILE_, String RIDER_FILE_NAME_, Integer RIDER_FILE_LENGTH_, String MEMO_, String RIDER_TAG_, Integer ORDER_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        RIDER_TAG_ = StringUtils.join(tagService.splitTag(RIDER_TAG_), ",");
        tagService.updateTagByObjId(RIDER_ID_, "RIDER", RIDER_TAG_);

        String sql = "update CB_RIDER set RIDER_ID_ = :RIDER_ID_";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        if (RIDER_FILE_LENGTH_ != 0) {// 更新文件
            sql += ", RIDER_FILE_ = :RIDER_FILE_, RIDER_FILE_NAME_ = :RIDER_FILE_NAME_, RIDER_FILE_LENGTH_ = :RIDER_FILE_LENGTH_";
            parameterSource.addValue("RIDER_FILE_", new SqlLobValue(RIDER_FILE_, RIDER_FILE_LENGTH_, new DefaultLobHandler()), Types.BLOB);
            parameterSource.addValue("RIDER_FILE_NAME_", RIDER_FILE_NAME_, Types.VARCHAR);
            parameterSource.addValue("RIDER_FILE_LENGTH_", RIDER_FILE_LENGTH_, Types.INTEGER);
        }
        sql += " , MEMO_ = :MEMO_, RIDER_TAG_ = :RIDER_TAG_, ORDER_ = :ORDER_, UPDATE_DATE_ = :UPDATE_DATE_, OPERATOR_ID_ = :OPERATOR_ID_, OPERATOR_NAME_ = :OPERATOR_NAME_ where RIDER_ID_ = :RIDER_ID_";
        parameterSource.addValue("MEMO_", MEMO_, Types.VARCHAR);
        parameterSource.addValue("RIDER_TAG_", RIDER_TAG_, Types.VARCHAR);
        parameterSource.addValue("ORDER_", ORDER_, Types.INTEGER);
        parameterSource.addValue("UPDATE_DATE_", UPDATE_DATE_, Types.TIMESTAMP);
        parameterSource.addValue("OPERATOR_ID_", OPERATOR_ID_, Types.VARCHAR);
        parameterSource.addValue("OPERATOR_NAME_", OPERATOR_NAME_, Types.VARCHAR);
        parameterSource.addValue("RIDER_ID_", RIDER_ID_, Types.VARCHAR);

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.update(sql, parameterSource);
    }

    @Override
    public int updateRiderOrder(final List<String> RIDER_ID_LIST, final List<Integer> ORDER_LIST, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        if (RIDER_ID_LIST == null || RIDER_ID_LIST.size() == 0) {
            return 0;
        }
        if (RIDER_ID_LIST.size() != ORDER_LIST.size()) {
            return 0;
        }

        String sql = "update CB_RIDER set ORDER_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where RIDER_ID_ = ?";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setInt(1, ORDER_LIST.get(i));
                ps.setTimestamp(2, UPDATE_DATE_ == null ? null : new java.sql.Timestamp(UPDATE_DATE_.getTime()));
                ps.setString(3, OPERATOR_ID_);
                ps.setString(4, OPERATOR_NAME_);
                ps.setString(5, RIDER_ID_LIST.get(i));
            }

            public int getBatchSize() {
                return RIDER_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int disableRider(String RIDER_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update CB_RIDER set RIDER_STATUS_ = '0', UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where RIDER_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, RIDER_ID_);
    }

    @Override
    public int enableRider(String RIDER_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update CB_RIDER set RIDER_STATUS_ = '1', UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where RIDER_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, RIDER_ID_);
    }

    @Override
    public int deleteRider(String RIDER_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        tagService.deleteTagByObjId(RIDER_ID_);

        String sql = "delete from CB_RIDER where RIDER_ID_ = ?";
        return msJdbcTemplate.update(sql, RIDER_ID_);
    }

    @Override
    public int deleteRiderByObjId(String OBJ_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        List<Map<String, Object>> riderList = selectRider(null, OBJ_ID_, null, null, null, false, 1, -1);
        for (Map<String, Object> rider : riderList) {
            deleteRider((String) rider.get("RIDER_ID_"), UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);
        }

        return riderList.size();
    }
}