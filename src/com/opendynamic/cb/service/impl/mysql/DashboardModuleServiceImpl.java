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
import com.opendynamic.cb.service.DashboardModuleService;
import com.opendynamic.cb.service.TagService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class DashboardModuleServiceImpl implements DashboardModuleService {
    @Autowired
    private TagService tagService;
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadDashboardModule(String DASHBOARD_MODULE_ID_) {
        String sql = "select * from CBV_DASHBOARD_MODULE where DASHBOARD_MODULE_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, DASHBOARD_MODULE_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, List<String> DASHBOARD_MODULE_TYPE_LIST, String DASHBOARD_MODULE_TAG_, List<String> DASHBOARD_MODULE_STATUS_LIST, Boolean tagUnion, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDashboardModule(false, DASHBOARD_MODULE_ID_, DASHBOARD_MODULE_NAME_, DASHBOARD_MODULE_TYPE_LIST, DASHBOARD_MODULE_TAG_, DASHBOARD_MODULE_STATUS_LIST, tagUnion);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, List<String> DASHBOARD_MODULE_TYPE_LIST, String DASHBOARD_MODULE_TAG_, List<String> DASHBOARD_MODULE_STATUS_LIST, Boolean tagUnion) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDashboardModule(true, DASHBOARD_MODULE_ID_, DASHBOARD_MODULE_NAME_, DASHBOARD_MODULE_TYPE_LIST, DASHBOARD_MODULE_TAG_, DASHBOARD_MODULE_STATUS_LIST, tagUnion);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaDashboardModule(boolean count, String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, List<String> DASHBOARD_MODULE_TYPE_LIST, String DASHBOARD_MODULE_TAG_, List<String> DASHBOARD_MODULE_STATUS_LIST, Boolean tagUnion) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_DASHBOARD_MODULE where 1 = 1";
        }
        else {
            sql = "select * from CBV_DASHBOARD_MODULE where 1 = 1";
        }

        if (StringUtils.isNotEmpty(DASHBOARD_MODULE_ID_)) {
            sql += " and DASHBOARD_MODULE_ID_ = :DASHBOARD_MODULE_ID_";
            paramMap.put("DASHBOARD_MODULE_ID_", DASHBOARD_MODULE_ID_);
        }
        if (StringUtils.isNotEmpty(DASHBOARD_MODULE_NAME_)) {
            sql += " and DASHBOARD_MODULE_NAME_ like concat('%',:DASHBOARD_MODULE_NAME_,'%')";
            paramMap.put("DASHBOARD_MODULE_NAME_", DASHBOARD_MODULE_NAME_);
        }
        if (DASHBOARD_MODULE_TYPE_LIST != null && DASHBOARD_MODULE_TYPE_LIST.size() > 0) {
            sql += " and DASHBOARD_MODULE_TYPE_ in (:DASHBOARD_MODULE_TYPE_LIST)";
            paramMap.put("DASHBOARD_MODULE_TYPE_LIST", DASHBOARD_MODULE_TYPE_LIST);
        }
        if (StringUtils.isNotEmpty(DASHBOARD_MODULE_TAG_)) {
            List<String> tagList = tagService.splitTag(DASHBOARD_MODULE_TAG_);
            if (tagList.size() > 0) {
                if (tagUnion != null && tagUnion.equals(false)) {
                    sql += " and DASHBOARD_MODULE_ID_ in (select DASHBOARD_MODULE_ID_ from (select OBJ_ID_ as DASHBOARD_MODULE_ID_ from CB_TAG where OBJ_TYPE_ = 'DASHBOARD_MODULE' and TAG_ in (:DASHBOARD_MODULE_TAG_LIST)) T group by DASHBOARD_MODULE_ID_ having count(*) >= 1)";
                    paramMap.put("DASHBOARD_MODULE_TAG_LIST", tagList);
                }
                else {
                    sql += " and DASHBOARD_MODULE_ID_ in (select DASHBOARD_MODULE_ID_ from (select OBJ_ID_ as DASHBOARD_MODULE_ID_ from CB_TAG where OBJ_TYPE_ = 'DASHBOARD_MODULE' and TAG_ in (:DASHBOARD_MODULE_TAG_LIST)) T group by DASHBOARD_MODULE_ID_ having count(*) >= :dashboardModuleTagCount)";
                    paramMap.put("DASHBOARD_MODULE_TAG_LIST", tagList);
                    paramMap.put("dashboardModuleTagCount", tagList.size());
                }
            }
        }
        if (DASHBOARD_MODULE_STATUS_LIST != null && DASHBOARD_MODULE_STATUS_LIST.size() > 0) {
            sql += " and DASHBOARD_MODULE_STATUS_ in (:DASHBOARD_MODULE_STATUS_LIST)";
            paramMap.put("DASHBOARD_MODULE_STATUS_LIST", DASHBOARD_MODULE_STATUS_LIST);
        }

        if (!count) {
            sql += " order by ORDER_";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectDashboardModuleByIdList(List<String> DASHBOARD_MODULE_ID_LIST) {
        if (DASHBOARD_MODULE_ID_LIST == null || DASHBOARD_MODULE_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(DASHBOARD_MODULE_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_DASHBOARD_MODULE where DASHBOARD_MODULE_ID_ in (:DASHBOARD_MODULE_ID_LIST)");
        paramMap.put("DASHBOARD_MODULE_ID_LIST", DASHBOARD_MODULE_ID_LIST);
        sql.append(" order by FIELD(DASHBOARD_MODULE_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < DASHBOARD_MODULE_ID_LIST.size(); i++) {
            sql.append(" '").append(DASHBOARD_MODULE_ID_LIST.get(i)).append("'");
            if (i < DASHBOARD_MODULE_ID_LIST.size() - 1) {
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
    public int insertDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, String DASHBOARD_MODULE_TYPE_, String DEFAULT_URL_, String DEFAULT_WIDTH_, String DEFAULT_HEIGHT_, String DASHBOARD_MODULE_TAG_, Integer ORDER_, String DASHBOARD_MODULE_STATUS_) {
        DASHBOARD_MODULE_TAG_ = StringUtils.join(tagService.splitTag(DASHBOARD_MODULE_TAG_), ",");
        tagService.updateTagByObjId(DASHBOARD_MODULE_ID_, "DASHBOARD_MODULE", DASHBOARD_MODULE_TAG_);

        String sql = "insert into CB_DASHBOARD_MODULE (DASHBOARD_MODULE_ID_, DASHBOARD_MODULE_NAME_, DASHBOARD_MODULE_TYPE_, DEFAULT_URL_, DEFAULT_WIDTH_, DEFAULT_HEIGHT_, DASHBOARD_MODULE_TAG_, ORDER_, DASHBOARD_MODULE_STATUS_) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, DASHBOARD_MODULE_ID_, DASHBOARD_MODULE_NAME_, DASHBOARD_MODULE_TYPE_, DEFAULT_URL_, DEFAULT_WIDTH_, DEFAULT_HEIGHT_, DASHBOARD_MODULE_TAG_, ORDER_, DASHBOARD_MODULE_STATUS_);
    }

    @Override
    public int updateDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, String DASHBOARD_MODULE_TYPE_, String DEFAULT_URL_, String DEFAULT_WIDTH_, String DEFAULT_HEIGHT_, String DASHBOARD_MODULE_TAG_, Integer ORDER_) {
        DASHBOARD_MODULE_TAG_ = StringUtils.join(tagService.splitTag(DASHBOARD_MODULE_TAG_), ",");
        tagService.updateTagByObjId(DASHBOARD_MODULE_ID_, "DASHBOARD_MODULE", DASHBOARD_MODULE_TAG_);

        String sql = "update CB_DASHBOARD_MODULE set DASHBOARD_MODULE_NAME_ = ?, DASHBOARD_MODULE_TYPE_ = ?, DEFAULT_URL_ = ?, DEFAULT_WIDTH_ = ?, DEFAULT_HEIGHT_ = ?, DASHBOARD_MODULE_TAG_ = ?, ORDER_ = ? where DASHBOARD_MODULE_ID_ = ?";
        return msJdbcTemplate.update(sql, DASHBOARD_MODULE_NAME_, DASHBOARD_MODULE_TYPE_, DEFAULT_URL_, DEFAULT_WIDTH_, DEFAULT_HEIGHT_, DASHBOARD_MODULE_TAG_, ORDER_, DASHBOARD_MODULE_ID_);
    }

    @Override
    public int updateDashboardModuleOrder(final List<String> DASHBOARD_MODULE_ID_LIST, final List<Integer> ORDER_LIST) {
        if (DASHBOARD_MODULE_ID_LIST == null || DASHBOARD_MODULE_ID_LIST.size() == 0) {
            return 0;
        }
        if (DASHBOARD_MODULE_ID_LIST.size() != ORDER_LIST.size()) {
            return 0;
        }

        String sql = "update CB_DASHBOARD_MODULE set ORDER_ = ? where DASHBOARD_MODULE_ID_ = ?";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setInt(1, ORDER_LIST.get(i));
                ps.setString(2, DASHBOARD_MODULE_ID_LIST.get(i));
            }

            public int getBatchSize() {
                return DASHBOARD_MODULE_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int disableDashboardModule(String DASHBOARD_MODULE_ID_) {
        String sql = "update CB_DASHBOARD_MODULE set DASHBOARD_MODULE_STATUS_ = '0' where DASHBOARD_MODULE_ID_ = ?";
        return msJdbcTemplate.update(sql, DASHBOARD_MODULE_ID_);
    }

    @Override
    public int enableDashboardModule(String DASHBOARD_MODULE_ID_) {
        String sql = "update CB_DASHBOARD_MODULE set DASHBOARD_MODULE_STATUS_ = '1' where DASHBOARD_MODULE_ID_ = ?";
        return msJdbcTemplate.update(sql, DASHBOARD_MODULE_ID_);
    }

    @Override
    public int deleteDashboardModule(String DASHBOARD_MODULE_ID_) {
        tagService.deleteTagByObjId(DASHBOARD_MODULE_ID_);

        String sql = "delete from CB_DASHBOARD_MODULE where DASHBOARD_MODULE_ID_ = ?";
        return msJdbcTemplate.update(sql, DASHBOARD_MODULE_ID_);
    }
}