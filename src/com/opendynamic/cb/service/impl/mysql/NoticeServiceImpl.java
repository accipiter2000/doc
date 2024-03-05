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
import com.opendynamic.cb.service.NoticeService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadNotice(String NOTICE_ID_) {
        String sql = "select * from CBV_NOTICE where NOTICE_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, NOTICE_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectNotice(String NOTICE_ID_, String POSI_EMP_ID_, String EMP_ID_, String EMP_CODE_, String SOURCE_, String IDENTITY_, Date FROM_EXP_DATE_, Date TO_EXP_DATE_, List<String> NOTICE_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaNotice(false, NOTICE_ID_, POSI_EMP_ID_, EMP_ID_, EMP_CODE_, SOURCE_, IDENTITY_, FROM_EXP_DATE_, TO_EXP_DATE_, NOTICE_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countNotice(String NOTICE_ID_, String POSI_EMP_ID_, String EMP_ID_, String EMP_CODE_, String SOURCE_, String IDENTITY_, Date FROM_EXP_DATE_, Date TO_EXP_DATE_, List<String> NOTICE_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaNotice(true, NOTICE_ID_, POSI_EMP_ID_, EMP_ID_, EMP_CODE_, SOURCE_, IDENTITY_, FROM_EXP_DATE_, TO_EXP_DATE_, NOTICE_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaNotice(boolean count, String NOTICE_ID_, String POSI_EMP_ID_, String EMP_ID_, String EMP_CODE_, String SOURCE_, String IDENTITY_, Date FROM_EXP_DATE_, Date TO_EXP_DATE_, List<String> NOTICE_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_NOTICE where 1 = 1";
        }
        else {
            sql = "select * from CBV_NOTICE where 1 = 1";
        }

        if (StringUtils.isNotEmpty(NOTICE_ID_)) {
            sql += " and NOTICE_ID_ = :NOTICE_ID_";
            paramMap.put("NOTICE_ID_", NOTICE_ID_);
        }
        if (StringUtils.isNotEmpty(POSI_EMP_ID_)) {
            sql += " and POSI_EMP_ID_ = :POSI_EMP_ID_";
            paramMap.put("POSI_EMP_ID_", POSI_EMP_ID_);
        }
        if (StringUtils.isNotEmpty(EMP_ID_)) {
            sql += " and EMP_ID_ = :EMP_ID_";
            paramMap.put("EMP_ID_", EMP_ID_);
        }
        if (StringUtils.isNotEmpty(EMP_CODE_)) {
            sql += " and EMP_CODE_ = :EMP_CODE_";
            paramMap.put("EMP_CODE_", EMP_CODE_);
        }
        if (StringUtils.isNotEmpty(SOURCE_)) {
            sql += " and SOURCE_ = :SOURCE_";
            paramMap.put("SOURCE_", SOURCE_);
        }
        if (StringUtils.isNotEmpty(IDENTITY_)) {
            sql += " and IDENTITY_ = :IDENTITY_";
            paramMap.put("IDENTITY_", IDENTITY_);
        }
        if (FROM_EXP_DATE_ != null) {
            sql += " and EXP_DATE_ >= :FROM_EXP_DATE_";
            paramMap.put("FROM_EXP_DATE_", FROM_EXP_DATE_);
        }
        if (TO_EXP_DATE_ != null) {
            sql += " and EXP_DATE_ <= :TO_EXP_DATE_";
            paramMap.put("TO_EXP_DATE_", TO_EXP_DATE_);
        }
        if (NOTICE_STATUS_LIST != null && NOTICE_STATUS_LIST.size() > 0) {
            sql += " and NOTICE_STATUS_ in (:NOTICE_STATUS_LIST)";
            paramMap.put("NOTICE_STATUS_LIST", NOTICE_STATUS_LIST);
        }
        if (FROM_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ >= :FROM_CREATION_DATE_";
            paramMap.put("FROM_CREATION_DATE_", FROM_CREATION_DATE_);
        }
        if (TO_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ <= :TO_CREATION_DATE_";
            paramMap.put("TO_CREATION_DATE_", TO_CREATION_DATE_);
        }

        if (!count) {
            sql += " order by CREATION_DATE_ desc";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectNoticeByIdList(List<String> NOTICE_ID_LIST) {
        if (NOTICE_ID_LIST == null || NOTICE_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(NOTICE_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_NOTICE where NOTICE_ID_ in (:NOTICE_ID_LIST)");
        paramMap.put("NOTICE_ID_LIST", NOTICE_ID_LIST);
        sql.append(" order by FIELD(NOTICE_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < NOTICE_ID_LIST.size(); i++) {
            sql.append(" '").append(NOTICE_ID_LIST.get(i)).append("'");
            if (i < NOTICE_ID_LIST.size() - 1) {
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
    public int insertNotice(String NOTICE_ID_, String POSI_EMP_ID_, String EMP_ID_, String EMP_CODE_, String EMP_NAME_, String CONTENT_, String SOURCE_, String IDENTITY_, String REDIRECT_URL_, String BIZ_URL_, Date EXP_DATE_, String NOTICE_STATUS_, Date CREATION_DATE_) {
        String sql = "insert into CB_NOTICE (NOTICE_ID_, POSI_EMP_ID_, EMP_ID_, EMP_CODE_, EMP_NAME_, CONTENT_, SOURCE_, IDENTITY_, REDIRECT_URL_, BIZ_URL_, EXP_DATE_, NOTICE_STATUS_, CREATION_DATE_) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, NOTICE_ID_, POSI_EMP_ID_, EMP_ID_, EMP_CODE_, EMP_NAME_, CONTENT_, SOURCE_, IDENTITY_, REDIRECT_URL_, BIZ_URL_, EXP_DATE_, NOTICE_STATUS_, CREATION_DATE_);
    }

    @Override
    public int updateNotice(String NOTICE_ID_, String POSI_EMP_ID_, String EMP_ID_, String EMP_CODE_, String EMP_NAME_, String CONTENT_, String SOURCE_, String IDENTITY_, String REDIRECT_URL_, String BIZ_URL_, Date EXP_DATE_) {
        String sql = "update CB_NOTICE set POSI_EMP_ID_ = ?, EMP_ID_ = ?, EMP_CODE_ = ?, EMP_NAME_ = ?, CONTENT_ = ?, SOURCE_ = ?, IDENTITY_ = ?, REDIRECT_URL_ = ?, BIZ_URL_ = ?, EXP_DATE_ = ? where NOTICE_ID_ = ?";
        return msJdbcTemplate.update(sql, POSI_EMP_ID_, EMP_ID_, EMP_CODE_, EMP_NAME_, CONTENT_, SOURCE_, IDENTITY_, REDIRECT_URL_, BIZ_URL_, EXP_DATE_, NOTICE_ID_);
    }

    @Override
    public int updateNoticeStatus(String NOTICE_ID_, String NOTICE_STATUS_) {
        String sql = "update CB_NOTICE set NOTICE_STATUS_ = ? where NOTICE_ID_ = ?";
        return msJdbcTemplate.update(sql, NOTICE_STATUS_, NOTICE_ID_);

    }

    @Override
    public int deleteNotice(String NOTICE_ID_) {
        String sql = "delete from CB_NOTICE where NOTICE_ID_ = ?";
        return msJdbcTemplate.update(sql, NOTICE_ID_);
    }
}