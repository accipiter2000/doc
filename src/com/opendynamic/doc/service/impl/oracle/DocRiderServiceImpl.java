package com.opendynamic.doc.service.impl.oracle;

import java.io.InputStream;
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
import com.opendynamic.OdUtils;
import com.opendynamic.doc.service.DocRiderService;
import com.opendynamic.doc.service.DocService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class DocRiderServiceImpl implements DocRiderService {
    @Autowired
    private DocService docService;
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadDocRider(String DOC_RIDER_ID_) {
        String sql = "select * from KV_DOC_RIDER where DOC_RIDER_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, DOC_RIDER_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public InputStream loadDocRiderFile(String DOC_RIDER_ID_) {
        String sql = "select DOC_RIDER_FILE_ from K_DOC_RIDER where DOC_RIDER_ID_ = ?";
        return msJdbcTemplate.queryForObject(sql, new Object[] { DOC_RIDER_ID_ }, new RowMapper<InputStream>() {
            public InputStream mapRow(ResultSet rs, int rowNum) throws SQLException {
                return rs.getBinaryStream(1);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectDocRider(String DOC_RIDER_ID_, String DOC_ID_, String DOC_RIDER_FILE_NAME_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDocRider(false, DOC_RIDER_ID_, DOC_ID_, DOC_RIDER_FILE_NAME_);// 根据查询条件组装查询SQL语句
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
    public int countDocRider(String DOC_RIDER_ID_, String DOC_ID_, String DOC_RIDER_FILE_NAME_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDocRider(true, DOC_RIDER_ID_, DOC_ID_, DOC_RIDER_FILE_NAME_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaDocRider(boolean count, String DOC_RIDER_ID_, String DOC_ID_, String DOC_RIDER_FILE_NAME_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from KV_DOC_RIDER where 1 = 1";
        }
        else {
            sql = "select * from KV_DOC_RIDER where 1 = 1";
        }

        if (StringUtils.isNotEmpty(DOC_RIDER_ID_)) {
            sql += " and DOC_RIDER_ID_ = :DOC_RIDER_ID_";
            paramMap.put("DOC_RIDER_ID_", DOC_RIDER_ID_);
        }
        if (StringUtils.isNotEmpty(DOC_ID_)) {
            sql += " and DOC_ID_ = :DOC_ID_";
            paramMap.put("DOC_ID_", DOC_ID_);
        }
        if (StringUtils.isNotEmpty(DOC_RIDER_FILE_NAME_)) {
            sql += " and DOC_RIDER_FILE_NAME_ like '%' || :DOC_RIDER_FILE_NAME_ || '%'";
            paramMap.put("DOC_RIDER_FILE_NAME_", DOC_RIDER_FILE_NAME_);
        }

        if (!count) {
            sql += " order by CREATION_DATE_ desc";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectDocRiderByIdList(List<String> DOC_RIDER_ID_LIST) {
        if (DOC_RIDER_ID_LIST == null || DOC_RIDER_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(DOC_RIDER_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from KV_DOC_RIDER where DOC_RIDER_ID_ in (:DOC_RIDER_ID_LIST)");
        paramMap.put("DOC_RIDER_ID_LIST", DOC_RIDER_ID_LIST);
        sql.append(" order by DECODE(DOC_RIDER_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < DOC_RIDER_ID_LIST.size(); i++) {
            sql.append(" '").append(DOC_RIDER_ID_LIST.get(i)).append("', ").append(i);
            if (i < DOC_RIDER_ID_LIST.size() - 1) {
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
    public int insertDocRider(String DOC_RIDER_ID_, String DOC_ID_, InputStream DOC_RIDER_FILE_, String DOC_RIDER_FILE_NAME_, Integer DOC_RIDER_FILE_LENGTH_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        Map<String, Object> doc = docService.loadDoc(DOC_ID_);
        if (!doc.get("PROC_STATUS_").equals("0") && !doc.get("PROC_STATUS_").equals("8")) {
            throw new RuntimeException("errors.cannotUpdateRunningDoc");
        }

        String sql = "insert into K_DOC_RIDER (DOC_RIDER_ID_, DOC_ID_, DOC_RIDER_FILE_, DOC_RIDER_FILE_NAME_, DOC_RIDER_FILE_LENGTH_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int count = msJdbcTemplate.update(sql, new Object[] { DOC_RIDER_ID_, DOC_ID_, new SqlLobValue(DOC_RIDER_FILE_, DOC_RIDER_FILE_LENGTH_, new DefaultLobHandler()), DOC_RIDER_FILE_NAME_, DOC_RIDER_FILE_LENGTH_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_ }, new int[] { Types.VARCHAR, Types.VARCHAR, Types.BLOB, Types.VARCHAR, Types.INTEGER, Types.TIMESTAMP, Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR });
        updateDocRiderMd5(DOC_RIDER_ID_);

        return count;
    }

    @Override
    public int updateDocRider(String DOC_RIDER_ID_, InputStream DOC_RIDER_FILE_, String DOC_RIDER_FILE_NAME_, Integer DOC_RIDER_FILE_LENGTH_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "select PROC_STATUS_ from K_DOC C inner join K_DOC_RIDER CR on CR.DOC_ID_ = C.DOC_ID_ where CR.DOC_RIDER_ID_ = ?";
        List<Map<String, Object>> docList = msJdbcTemplate.queryForList(sql, DOC_RIDER_ID_);
        if (docList.size() != 1 || (!docList.get(0).get("PROC_STATUS_").equals("0") && !docList.get(0).get("PROC_STATUS_").equals("8"))) {
            throw new RuntimeException("errors.cannotUpdateRunningDoc");
        }

        sql = "update K_DOC_RIDER set DOC_RIDER_ID_ = :DOC_RIDER_ID_";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        if (DOC_RIDER_FILE_LENGTH_ != 0) {// 更新文件
            sql += ", DOC_RIDER_FILE_ = :DOC_RIDER_FILE_, DOC_RIDER_FILE_NAME_ = :DOC_RIDER_FILE_NAME_, DOC_RIDER_FILE_LENGTH_ = :DOC_RIDER_FILE_LENGTH_";
            parameterSource.addValue("DOC_RIDER_FILE_", new SqlLobValue(DOC_RIDER_FILE_, DOC_RIDER_FILE_LENGTH_, new DefaultLobHandler()), Types.BLOB);
            parameterSource.addValue("DOC_RIDER_FILE_NAME_", DOC_RIDER_FILE_NAME_, Types.VARCHAR);
            parameterSource.addValue("DOC_RIDER_FILE_LENGTH_", DOC_RIDER_FILE_LENGTH_, Types.INTEGER);
        }
        sql += " , UPDATE_DATE_ = :UPDATE_DATE_, OPERATOR_ID_ = :OPERATOR_ID_, OPERATOR_NAME_ = :OPERATOR_NAME_ where DOC_RIDER_ID_ = :DOC_RIDER_ID_";
        parameterSource.addValue("UPDATE_DATE_", UPDATE_DATE_, Types.TIMESTAMP);
        parameterSource.addValue("OPERATOR_ID_", OPERATOR_ID_, Types.VARCHAR);
        parameterSource.addValue("OPERATOR_NAME_", OPERATOR_NAME_, Types.VARCHAR);
        parameterSource.addValue("DOC_RIDER_ID_", DOC_RIDER_ID_, Types.VARCHAR);

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        int count = namedParameterJdbcTemplate.update(sql, parameterSource);
        updateDocRiderMd5(DOC_RIDER_ID_);

        return count;
    }

    private void updateDocRiderMd5(String DOC_RIDER_ID_) {
        try {
            InputStream docRiderFileInputStream = loadDocRiderFile(DOC_RIDER_ID_);
            String md5 = OdUtils.getMd5(docRiderFileInputStream);
            docRiderFileInputStream.close();

            String sql = "update K_DOC_RIDER set MD5_ = ? where DOC_RIDER_ID_ = ?";
            msJdbcTemplate.update(sql, md5, DOC_RIDER_ID_);
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int deleteDocRider(String DOC_RIDER_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "select PROC_STATUS_ from K_DOC C inner join K_DOC_RIDER CR on CR.DOC_ID_ = C.DOC_ID_ where CR.DOC_RIDER_ID_ = ?";
        List<Map<String, Object>> docList = msJdbcTemplate.queryForList(sql, DOC_RIDER_ID_);
        if (docList.size() != 1 || (!docList.get(0).get("PROC_STATUS_").equals("0") && !docList.get(0).get("PROC_STATUS_").equals("8"))) {
            throw new RuntimeException("errors.cannotUpdateRunningDoc");
        }

        sql = "delete from K_DOC_RIDER where DOC_RIDER_ID_ = ?";
        return msJdbcTemplate.update(sql, DOC_RIDER_ID_);
    }

    @Override
    public int deleteDocRiderByDocId(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        Map<String, Object> doc = docService.loadDoc(DOC_ID_);
        if (!doc.get("PROC_STATUS_").equals("0") && !doc.get("PROC_STATUS_").equals("8")) {
            throw new RuntimeException("errors.cannotUpdateRunningDoc");
        }

        List<Map<String, Object>> docRiderList = selectDocRider(null, DOC_ID_, null, 1, -1);
        for (Map<String, Object> docRider : docRiderList) {
            deleteDocRider((String) docRider.get("DOC_RIDER_ID_"), UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);
        }

        return docRiderList.size();
    }
}