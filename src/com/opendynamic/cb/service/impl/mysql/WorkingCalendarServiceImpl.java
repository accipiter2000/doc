package com.opendynamic.cb.service.impl.mysql;

import java.util.ArrayList;
import java.util.Calendar;
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
import com.opendynamic.OdUtils;
import com.opendynamic.cb.service.WorkingCalendarService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class WorkingCalendarServiceImpl implements WorkingCalendarService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadWorkingCalendar(String WORKING_CALENDAR_ID_) {
        String sql = "select * from CBV_WORKING_CALENDAR where WORKING_CALENDAR_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, WORKING_CALENDAR_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectWorkingCalendar(String WORKING_CALENDAR_ID_, String EMP_ID_, Date FROM_DATE_, Date TO_DATE_, List<String> WORKING_DAY_LIST, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaWorkingCalendar(false, WORKING_CALENDAR_ID_, EMP_ID_, FROM_DATE_, TO_DATE_, WORKING_DAY_LIST);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countWorkingCalendar(String WORKING_CALENDAR_ID_, String EMP_ID_, Date FROM_DATE_, Date TO_DATE_, List<String> WORKING_DAY_LIST) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaWorkingCalendar(true, WORKING_CALENDAR_ID_, EMP_ID_, FROM_DATE_, TO_DATE_, WORKING_DAY_LIST);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaWorkingCalendar(boolean count, String WORKING_CALENDAR_ID_, String EMP_ID_, Date FROM_DATE_, Date TO_DATE_, List<String> WORKING_DAY_LIST) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (count) {
            sql = "select count(*) from CBV_WORKING_CALENDAR where 1 = 1";
        }
        else {
            sql = "select * from CBV_WORKING_CALENDAR where 1 = 1";
        }

        if (StringUtils.isNotEmpty(WORKING_CALENDAR_ID_)) {
            sql += " and WORKING_CALENDAR_ID_ = :WORKING_CALENDAR_ID_";
            paramMap.put("WORKING_CALENDAR_ID_", WORKING_CALENDAR_ID_);
        }
        if (StringUtils.isNotEmpty(EMP_ID_)) {
            sql += " and EMP_ID_ = :EMP_ID_";
            paramMap.put("EMP_ID_", EMP_ID_);
        }
        if (FROM_DATE_ != null) {
            sql += " and DATE_ >= :FROM_DATE_";
            paramMap.put("FROM_DATE_", FROM_DATE_);
        }
        if (TO_DATE_ != null) {
            sql += " and DATE_ <= :TO_DATE_";
            paramMap.put("TO_DATE_", TO_DATE_);
        }
        if (WORKING_DAY_LIST != null && WORKING_DAY_LIST.size() > 0) {
            sql += " and WORKING_DAY_ in (:WORKING_DAY_LIST)";
            paramMap.put("WORKING_DAY_LIST", WORKING_DAY_LIST);
        }

        if (!count) {
            sql += " order by DATE_ desc";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectCommonWorkingCalendar(Date FROM_DATE_, Date TO_DATE_, List<String> WORKING_DAY_LIST, Boolean hasMark) {
        String sql = "select * from CBV_WORKING_CALENDAR where EMP_ID_ is null";
        Map<String, Object> paramMap = new HashMap<String, Object>();

        if (FROM_DATE_ != null) {
            sql += " and DATE_ >= :FROM_DATE_";
            paramMap.put("FROM_DATE_", FROM_DATE_);
        }
//        if (TO_DATE_ != null) {
//            sql += " and DATE_ <= :TO_DATE_";
//            paramMap.put("TO_DATE_", TO_DATE_);
//        }
        if (WORKING_DAY_LIST != null && WORKING_DAY_LIST.size() > 0) {
            sql += " and WORKING_DAY_ in (:WORKING_DAY_LIST)";
            paramMap.put("WORKING_DAY_LIST", WORKING_DAY_LIST);
        }
        if (hasMark != null) {
            if (hasMark) {
                sql += " and MARK is not null";
            }
            else {
                sql += " and MARK is null";
            }
        }
        
        sql+=" order by DATE_  ";

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectMyWorkingCalendar(String EMP_ID_, Date FROM_DATE_, Date TO_DATE_, List<String> WORKING_DAY_LIST, Boolean hasMark) {
        String sql = "select * from (select WC.*, ROW_NUMBER() OVER(partition by DATE_ order by FIELD(EMP_ID_, :EMP_ID_) desc) as RN from CB_WORKING_CALENDAR WC where (EMP_ID_ = :EMP_ID_ or EMP_ID_ is null)";
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("EMP_ID_", EMP_ID_);

        if (FROM_DATE_ != null) {
            sql += " and DATE_ >= :FROM_DATE_";
            paramMap.put("FROM_DATE_", FROM_DATE_);
        }
        if (TO_DATE_ != null) {
            sql += " and DATE_ <= :TO_DATE_";
            paramMap.put("TO_DATE_", TO_DATE_);
        }
        if (WORKING_DAY_LIST != null && WORKING_DAY_LIST.size() > 0) {
            sql += " and WORKING_DAY_ in (:WORKING_DAY_LIST)";
            paramMap.put("WORKING_DAY_LIST", WORKING_DAY_LIST);
        }
        if (hasMark != null) {
            if (hasMark) {
                sql += " and MARK is not null";
            }
            else {
                sql += " and MARK is null";
            }
        }
        sql += ") T where RN = 1";

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectWorkingCalendarByIdList(List<String> WORKING_CALENDAR_ID_LIST) {
        if (WORKING_CALENDAR_ID_LIST == null || WORKING_CALENDAR_ID_LIST.size() == 0) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(WORKING_CALENDAR_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<String, Object>();

        sql.append("select * from CBV_WORKING_CALENDAR where WORKING_CALENDAR_ID_ in (:WORKING_CALENDAR_ID_LIST)");
        paramMap.put("WORKING_CALENDAR_ID_LIST", WORKING_CALENDAR_ID_LIST);
        sql.append(" order by FIELD(WORKING_CALENDAR_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < WORKING_CALENDAR_ID_LIST.size(); i++) {
            sql.append(" '").append(WORKING_CALENDAR_ID_LIST.get(i)).append("'");
            if (i < WORKING_CALENDAR_ID_LIST.size() - 1) {
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
    public int insertWorkingCalendar(String WORKING_CALENDAR_ID_, String EMP_ID_, Date DATE_, String WORKING_DAY_, String MARK_) {
        String sql = "insert into CB_WORKING_CALENDAR (WORKING_CALENDAR_ID_, EMP_ID_, DATE_, WORKING_DAY_, MARK_) values (?, ?, ?, ?, ?)";
        return msJdbcTemplate.update(sql, WORKING_CALENDAR_ID_, EMP_ID_, DATE_, WORKING_DAY_, MARK_);
    }

    @Override
    public int updateWorkingCalendar(String WORKING_CALENDAR_ID_, String EMP_ID_, Date DATE_, String WORKING_DAY_, String MARK_) {
        String sql = "update CB_WORKING_CALENDAR set EMP_ID_ = ?, DATE_ = ?, WORKING_DAY_ = ?, MARK_ = ? where WORKING_CALENDAR_ID_ = ?";
        return msJdbcTemplate.update(sql, EMP_ID_, DATE_, WORKING_DAY_, MARK_, WORKING_CALENDAR_ID_);
    }

    @Override
    public String updateCommonWorkingCalendar(Date DATE_, String WORKING_DAY_, String MARK_) {
        List<Map<String, Object>> workingCalendarList = selectCommonWorkingCalendar(DATE_, DATE_, null, null);
        String WORKING_CALENDAR_ID_;
        if (workingCalendarList.size() == 0) {
            WORKING_CALENDAR_ID_ = OdUtils.getUuid();
            insertWorkingCalendar(WORKING_CALENDAR_ID_, null, DATE_, WORKING_DAY_, MARK_);
        }
        else {
            WORKING_CALENDAR_ID_ = (String) workingCalendarList.get(0).get("WORKING_CALENDAR_ID_");
            updateWorkingCalendar(WORKING_CALENDAR_ID_, null, DATE_, WORKING_DAY_, MARK_);
        }

        return WORKING_CALENDAR_ID_;
    }

    @Override
    public String updateMyWorkingCalendar(String EMP_ID_, Date DATE_, String WORKING_DAY_, String MARK_) {
        List<Map<String,Object>> workingCalendarLis = selectCommonWorkingCalendar(DATE_, DATE_, null, null);
        Map<String, Object> commonWorkingCalendar = workingCalendarLis.get(0);
        System.out.println(commonWorkingCalendar);
        List<Map<String, Object>> workingCalendarList = selectWorkingCalendar(null, EMP_ID_, DATE_, DATE_, null, 1, -1);
        String WORKING_CALENDAR_ID_ = null;
        if (workingCalendarList.size() == 0) {
            if (!commonWorkingCalendar.get("WORKING_DAY_").equals(WORKING_DAY_) || StringUtils.isNotEmpty(MARK_)) {
                WORKING_CALENDAR_ID_ = OdUtils.getUuid();
                insertWorkingCalendar(WORKING_CALENDAR_ID_, EMP_ID_, DATE_, WORKING_DAY_, MARK_);
            }
        }
        else {
            WORKING_CALENDAR_ID_ = (String) workingCalendarList.get(0).get("WORKING_CALENDAR_ID_");
            if (commonWorkingCalendar.get("WORKING_DAY_").equals(WORKING_DAY_) && StringUtils.isEmpty(MARK_)) {
                deleteWorkingCalendar(WORKING_CALENDAR_ID_);
                WORKING_CALENDAR_ID_ = null;
            }
            else {
                updateWorkingCalendar(WORKING_CALENDAR_ID_, EMP_ID_, DATE_, WORKING_DAY_, MARK_);
            }
        }

        return WORKING_CALENDAR_ID_;
    }

    @Override
    public int deleteWorkingCalendar(String WORKING_CALENDAR_ID_) {
        String sql = "delete from CB_WORKING_CALENDAR where WORKING_CALENDAR_ID_ = ?";
        return msJdbcTemplate.update(sql, WORKING_CALENDAR_ID_);
    }

    @Override
    public int initWorkingCalendar(int year) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, year);
        calendar.set(Calendar.DAY_OF_YEAR, 1);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        String WORKING_DAY_;
        int count = 0;
        while (true) {
            if (calendar.get(Calendar.YEAR) > year) {
                break;
            }

            if (calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
                WORKING_DAY_ = "0";
            }
            else {
                WORKING_DAY_ = "1";
            }

            insertWorkingCalendar(OdUtils.getUuid(), null, calendar.getTime(), WORKING_DAY_, null);

            calendar.add(Calendar.DATE, 1);
            count++;
        }

        return count;
    }

    @Override
    public Date getNextWorkingDay(String EMP_ID_, Date FROM_DATE_, int days) {
        String sql = "select * from (select WC.*, ROW_NUMBER() OVER(partition by DATE_ order by FIELD(EMP_ID_, :EMP_ID_) desc) as ROW_NUM from CB_WORKING_CALENDAR WC where (EMP_ID_ = :EMP_ID_ or EMP_ID_ is null) and DATE_ >= :FROM_DATE_) where ROW_NUM = 1 and WORKING_DAY_ = '1' order by DATE_";
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("EMP_ID_", EMP_ID_);
        paramMap.put("FROM_DATE_", FROM_DATE_);

        int start = 1;
        int end = days;
        sql = "select * from (select FULLTABLE.*, ROWNUM RN from (" + sql + ") FULLTABLE where ROWNUM <= " + end + ") where RN >= " + start;

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        List<Map<String, Object>> nextWorkingDateList = namedParameterJdbcTemplate.queryForList(sql, paramMap);

        if (nextWorkingDateList.size() >= days) {
            return (Date) nextWorkingDateList.get(days - 1).get("DATE_");
        }

        return null;
    }
}