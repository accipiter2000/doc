package com.opendynamic.cb.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface DashboardModuleService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadDashboardModule(String DASHBOARD_MODULE_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, List<String> DASHBOARD_MODULE_TYPE_LIST, String DASHBOARD_MODULE_TAG_, List<String> DASHBOARD_MODULE_STATUS_LIST, Boolean tagUnion, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, List<String> DASHBOARD_MODULE_TYPE_LIST, String DASHBOARD_MODULE_TAG_, List<String> DASHBOARD_MODULE_STATUS_LIST, Boolean tagUnion);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectDashboardModuleByIdList(List<String> DASHBOARD_MODULE_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, String DASHBOARD_MODULE_TYPE_, String DEFAULT_URL_, String DEFAULT_WIDTH_, String DEFAULT_HEIGHT_, String DASHBOARD_MODULE_TAG_, Integer ORDER_, String DASHBOARD_MODULE_STATUS_);

    /**
     * 修改对象。
     */
    public int updateDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, String DASHBOARD_MODULE_TYPE_, String DEFAULT_URL_, String DEFAULT_WIDTH_, String DEFAULT_HEIGHT_, String DASHBOARD_MODULE_TAG_, Integer ORDER_);

    /**
     * 拖动排序。
     */
    public int updateDashboardModuleOrder(List<String> DASHBOARD_MODULE_ID_LIST, List<Integer> ORDER_LIST);

    /**
     * 废弃对象。
     */
    public int disableDashboardModule(String DASHBOARD_MODULE_ID_);

    /**
     * 恢复对象。
     */
    public int enableDashboardModule(String DASHBOARD_MODULE_ID_);

    /**
     * 删除对象。
     */
    public int deleteDashboardModule(String DASHBOARD_MODULE_ID_);
}