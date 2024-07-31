package com.opendynamic.cb.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface WorkingCalendarService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadWorkingCalendar(String WORKING_CALENDAR_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectWorkingCalendar(String WORKING_CALENDAR_ID_, String EMP_ID_, Date FROM_DATE_, Date TO_DATE_, List<String> WORKING_DAY_LIST, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countWorkingCalendar(String WORKING_CALENDAR_ID_, String EMP_ID_, Date FROM_DATE_, Date TO_DATE_, List<String> WORKING_DAY_LIST);

    public List<Map<String, Object>> selectCommonWorkingCalendar(Date FROM_DATE_, Date TO_DATE_, List<String> WORKING_DAY_LIST, Boolean hasMark);

    public List<Map<String, Object>> selectMyWorkingCalendar(String EMP_ID_, Date FROM_DATE_, Date TO_DATE_, List<String> WORKING_DAY_LIST, Boolean hasMark);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectWorkingCalendarByIdList(List<String> WORKING_CALENDAR_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertWorkingCalendar(String WORKING_CALENDAR_ID_, String EMP_ID_, Date DATE_, String WORKING_DAY_, String MARK_);

    /**
     * 修改对象。
     */
    public int updateWorkingCalendar(String WORKING_CALENDAR_ID_, String EMP_ID_, Date DATE_, String WORKING_DAY_, String MARK_);

    public String updateCommonWorkingCalendar(Date DATE_, String WORKING_DAY_, String MARK_);

    public String updateMyWorkingCalendar(String EMP_ID_, Date DATE_, String WORKING_DAY_, String MARK_);

    /**
     * 删除对象。
     */
    public int deleteWorkingCalendar(String WORKING_CALENDAR_ID_);

    public int initWorkingCalendar(int year);

    public Date getNextWorkingDay(String EMP_ID_, Date FROM_DATE_, int days);
}