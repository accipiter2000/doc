package com.opendynamic.cb.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface PosiEmpMenuService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadPosiEmpMenu(String POSI_EMP_MENU_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectPosiEmpMenu(String POSI_EMP_MENU_ID_, String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countPosiEmpMenu(String POSI_EMP_MENU_ID_, String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectPosiEmpMenuByIdList(List<String> POSI_EMP_MENU_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertPosiEmpMenu(String POSI_EMP_MENU_ID_, String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, String MENU_ID_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 批量新增对象。
     */
    public int insertPosiEmpMenu(List<String> POSI_EMP_ID_LIST, List<String> POSI_NAME_LIST, List<String> EMP_NAME_LIST, List<String> MENU_ID_LIST, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 修改对象。
     */
    public int updatePosiEmpMenu(String POSI_EMP_MENU_ID_, String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 修改对象。
     */
    public int updatePosiEmpMenuByMenuIdList(String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, List<String> MENU_ID_LIST, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deletePosiEmpMenu(String POSI_EMP_MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deletePosiEmpMenuByPosiEmpId(String POSI_EMP_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deletePosiEmpMenuByMenuId(String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);
}