package com.opendynamic.cb.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface LogService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadLog(String LOG_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectLog(String LOG_ID_, String CATEGORY_, String IP_, String ACTION_, String BUSINESS_KEY_, List<String> ERROR_LIST, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countLog(String LOG_ID_, String CATEGORY_, String IP_, String ACTION_, String BUSINESS_KEY_, List<String> ERROR_LIST, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectLogByIdList(List<String> LOG_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertLog(String LOG_ID_, String CATEGORY_, String IP_, String USER_AGENT_, String URL_, String ACTION_, String PARAMETER_MAP_, String BUSINESS_KEY_, String ERROR_, String MESSAGE_, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_, Date CREATION_DATE_);

    /**
     * 修改对象。
     */
    public int updateLog(String LOG_ID_, String CATEGORY_, String IP_, String USER_AGENT_, String URL_, String ACTION_, String PARAMETER_MAP_, String BUSINESS_KEY_, String ERROR_, String MESSAGE_, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_);

    /**
     * 删除对象。
     */
    public int deleteLog(String LOG_ID_);
}