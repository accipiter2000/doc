package com.opendynamic.cb.service.impl.oracle;

import java.util.ArrayList;
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
import com.opendynamic.OdUtils;
import com.opendynamic.cb.service.TagService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class TagServiceImpl implements TagService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadTag(String TAG_ID_) {
        String sql = "select * from CBV_TAG where TAG_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, TAG_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaTag(false, TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_);// 根据查询条件组装查询SQL语句
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
    public int countTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaTag(true, TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaTag(boolean count, String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_TAG where 1 = 1";
        }
        else {
            sql = "select * from CBV_TAG where 1 = 1";
        }

        if (StringUtils.isNotEmpty(TAG_ID_)) {
            sql += " and TAG_ID_ = :TAG_ID_";
            paramMap.put("TAG_ID_", TAG_ID_);
        }
        if (StringUtils.isNotEmpty(OBJ_ID_)) {
            sql += " and OBJ_ID_ = :OBJ_ID_";
            paramMap.put("OBJ_ID_", OBJ_ID_);
        }
        if (StringUtils.isNotEmpty(OBJ_TYPE_)) {
            sql += " and OBJ_TYPE_ = :OBJ_TYPE_";
            paramMap.put("OBJ_TYPE_", OBJ_TYPE_);
        }
        if (StringUtils.isNotEmpty(TAG_)) {
            sql += " and TAG_ = :TAG_";
            paramMap.put("TAG_", TAG_);
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectTagByIdList(List<String> TAG_ID_LIST) {
        if (TAG_ID_LIST == null || TAG_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(TAG_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_TAG where TAG_ID_ in (:TAG_ID_LIST)");
        paramMap.put("TAG_ID_LIST", TAG_ID_LIST);
        sql.append(" order by DECODE(TAG_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < TAG_ID_LIST.size(); i++) {
            sql.append(" '").append(TAG_ID_LIST.get(i)).append("', ").append(i);
            if (i < TAG_ID_LIST.size() - 1) {
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
    public int insertTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_) {
        String sql = "insert into CB_TAG (TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_) values (?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_);
    }

    @Override
    public int updateTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_) {
        String sql = "update CB_TAG set OBJ_ID_ = ?, OBJ_TYPE_ = ?, TAG_ = ? where TAG_ID_ = ?";
        return msJdbcTemplate.update(sql, OBJ_ID_, OBJ_TYPE_, TAG_, TAG_ID_);
    }

    @Override
    public void updateTagByObjId(String OBJ_ID_, String OBJ_TYPE_, String TAG_) {
        deleteTagByObjId(OBJ_ID_);

        List<String> tagList = splitTag(TAG_);
        for (String tag : tagList) {
            insertTag(OdUtils.getUuid(), OBJ_ID_, OBJ_TYPE_, tag);
        }
    }

    @Override
    public int deleteTag(String TAG_ID_) {
        String sql = "delete from CB_TAG where TAG_ID_ = ?";
        return msJdbcTemplate.update(sql, TAG_ID_);
    }

    @Override
    public int deleteTagByObjId(String OBJ_ID_) {
        String sql = "delete from CB_TAG where OBJ_ID_ = ?";
        return msJdbcTemplate.update(sql, OBJ_ID_);
    }

    @Override
    public List<String> splitTag(String TAG_) {
        List<String> tagList = new ArrayList<>();

        if (StringUtils.isNotEmpty(TAG_)) {
            String[] tags = TAG_.split(",|，| |　");
            for (int i = 0; i < tags.length; i++) {
                if (StringUtils.isNotEmpty(tags[i])) {
                    tagList.add(tags[i]);
                }
            }
        }

        return tagList;
    }
}