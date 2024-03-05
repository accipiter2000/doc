package com.opendynamic.doc.service.impl.mysql;

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
import com.opendynamic.doc.service.DocDataService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class DocDataServiceImpl implements DocDataService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadDocData(String DOC_DATA_ID_) {
        String sql = "select * from KV_DOC_DATA where DOC_DATA_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, DOC_DATA_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectDocData(String DOC_DATA_ID_, String DOC_ID_, String BOOKMARK_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDocData(false, DOC_DATA_ID_, DOC_ID_, BOOKMARK_);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countDocData(String DOC_DATA_ID_, String DOC_ID_, String BOOKMARK_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDocData(true, DOC_DATA_ID_, DOC_ID_, BOOKMARK_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaDocData(boolean count, String DOC_DATA_ID_, String DOC_ID_, String BOOKMARK_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from KV_DOC_DATA where 1 = 1";
        }
        else {
            sql = "select * from KV_DOC_DATA where 1 = 1";
        }

        if (StringUtils.isNotEmpty(DOC_DATA_ID_)) {
            sql += " and DOC_DATA_ID_ = :DOC_DATA_ID_";
            paramMap.put("DOC_DATA_ID_", DOC_DATA_ID_);
        }
        if (StringUtils.isNotEmpty(DOC_ID_)) {
            sql += " and DOC_ID_ = :DOC_ID_";
            paramMap.put("DOC_ID_", DOC_ID_);
        }
        if (StringUtils.isNotEmpty(BOOKMARK_)) {
            sql += " and BOOKMARK_ = :BOOKMARK_";
            paramMap.put("BOOKMARK_", BOOKMARK_);
        }

        if (!count) {
            sql += " order by ORDER_";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectDocDataByIdList(List<String> DOC_DATA_ID_LIST) {
        if (DOC_DATA_ID_LIST == null || DOC_DATA_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(DOC_DATA_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from KV_DOC_DATA where DOC_DATA_ID_ in (:DOC_DATA_ID_LIST)");
        paramMap.put("DOC_DATA_ID_LIST", DOC_DATA_ID_LIST);
        sql.append(" order by FIELD(DOC_DATA_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < DOC_DATA_ID_LIST.size(); i++) {
            sql.append(" '").append(DOC_DATA_ID_LIST.get(i)).append("'");
            if (i < DOC_DATA_ID_LIST.size() - 1) {
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
    public int insertDocData(String DOC_DATA_ID_, String DOC_ID_, String BOOKMARK_, String VALUE_, String DATA_TYPE_, Integer ORDER_) {
        String sql = "insert into K_DOC_DATA (DOC_DATA_ID_, DOC_ID_, BOOKMARK_, VALUE_, DATA_TYPE_, ORDER_) values (?, ?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, DOC_DATA_ID_, DOC_ID_, BOOKMARK_, VALUE_, DATA_TYPE_, ORDER_);
    }

    @Override
    public int updateDocData(String DOC_DATA_ID_, String BOOKMARK_, String VALUE_, String DATA_TYPE_, Integer ORDER_) {
        String sql = "update K_DOC_DATA set BOOKMARK_ = ?, VALUE_ = ?, DATA_TYPE_ = ?, ORDER_ = ? where DOC_DATA_ID_ = ?";
        return msJdbcTemplate.update(sql, BOOKMARK_, VALUE_, DATA_TYPE_, ORDER_, DOC_DATA_ID_);
    }

    @Override
    public int updateDocDataOrder(final List<String> DOC_DATA_ID_LIST, final List<Integer> ORDER_LIST, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        if (DOC_DATA_ID_LIST == null || DOC_DATA_ID_LIST.size() == 0) {
            return 0;
        }
        if (DOC_DATA_ID_LIST.size() != ORDER_LIST.size()) {
            return 0;
        }

        String sql = "update K_DOC_DATA set ORDER_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where DOC_DATA_ID_ = ?";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setInt(1, ORDER_LIST.get(i));
                ps.setTimestamp(2, UPDATE_DATE_ == null ? null : new java.sql.Timestamp(UPDATE_DATE_.getTime()));
                ps.setString(3, OPERATOR_ID_);
                ps.setString(4, OPERATOR_NAME_);
                ps.setString(5, DOC_DATA_ID_LIST.get(i));
            }

            public int getBatchSize() {
                return DOC_DATA_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int deleteDocData(String DOC_DATA_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from K_DOC_DATA where DOC_DATA_ID_ = ?";
        return msJdbcTemplate.update(sql, DOC_DATA_ID_);
    }

    @Override
    public int deleteDocDataByDocId(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from K_DOC_DATA where DOC_ID_ = ?";
        return msJdbcTemplate.update(sql, DOC_ID_);
    }

    @Override
    public int deleteDocDataByDocIdBookmark(String DOC_ID_, String BOOKMARK_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from K_DOC_DATA where DOC_ID_ = ? and BOOKMARK_ = ?";
        return msJdbcTemplate.update(sql, DOC_ID_, BOOKMARK_);
    }
}