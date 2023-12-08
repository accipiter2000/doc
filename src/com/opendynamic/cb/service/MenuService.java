package com.opendynamic.cb.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface MenuService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadMenu(String MENU_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectMenu(String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countMenu(String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean rootOnly);

    /**
     * 通用父对象查询，返回父对象列表。
     * 
     * @param recursive
     *        是否递归，默认为false。
     * @param includeSelf
     *        是否包含自己，默认为false。
     */
    public List<Map<String, Object>> selectParentMenu(String MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean recursive, Boolean includeSelf);

    /**
     * 通用子对象查询，返回子对象列表。
     * 
     * @param recursive
     *        是否递归，默认为false。
     * @param includeSelf
     *        是否包含自己，默认为false。
     */
    public List<Map<String, Object>> selectChildMenu(String MENU_ID_, String MENU_NAME_, List<String> MENU_TYPE_LIST, List<String> MENU_STATUS_LIST, Boolean recursive, Boolean includeSelf);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectMenuByIdList(List<String> MENU_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertMenu(String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, String MENU_TYPE_, String URL_, String ICON_, Integer ORDER_, String MENU_STATUS_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 修改对象。
     */
    public int updateMenu(String MENU_ID_, String MENU_NAME_, String MENU_TYPE_, String URL_, String ICON_, Integer ORDER_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 拖动排序。
     */
    public int updateMenuOrder(List<String> MENU_ID_LIST, List<Integer> ORDER_LIST, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 移动对象。
     */
    public int moveMenu(String MENU_ID_, String PARENT_MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 废弃对象。
     */
    public int disableMenu(String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 恢复对象。
     */
    public int enableMenu(String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteMenu(String MENU_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);
}