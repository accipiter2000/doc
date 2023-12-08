package com.opendynamic.cb.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface DashboardService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadDashboard(String DASHBOARD_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectDashboard(String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, String POSI_EMP_ID_, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countDashboard(String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, String POSI_EMP_ID_);

    public List<Map<String, Object>> selectCommonDashboard(Integer page, Integer limit);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectMyDashboard(String POSI_EMP_ID_, Boolean alternative, Integer page, Integer limit);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectDashboardByIdList(List<String> DASHBOARD_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertDashboard(String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, String POSI_EMP_ID_, String DASHBOARD_MODULE_NAME_, String URL_, String WIDTH_, String HEIGHT_, Integer ORDER_);

    public int insertDashboardByDashboardModule(String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, String POSI_EMP_ID_);

    /**
     * 修改对象。
     */
    public int updateDashboard(String DASHBOARD_ID_, String DASHBOARD_MODULE_NAME_, String URL_, String WIDTH_, String HEIGHT_, Integer ORDER_);

    /**
     * 拖动排序。
     */
    public int updateDashboardOrder(List<String> DASHBOARD_ID_LIST);

    /**
     * 删除对象。
     */
    public int deleteDashboard(String DASHBOARD_ID_);

    public int deleteDashboardByPosiEmpId(String POSI_EMP_ID_);
}