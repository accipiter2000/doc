package com.opendynamic.cb.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface CodeService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadCode(String CODE_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectCode(String CODE_ID_, String PARENT_CODE_ID_, List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean rootOnly, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countCode(String CODE_ID_, String PARENT_CODE_ID_, List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean rootOnly);

    /**
     * 通用上级对象查询，返回上级对象列表。
     * 
     * @param recursive
     *        是否递归，默认为false。
     * @param includeSelf
     *        是否包含自己，默认为false。
     */
    public List<Map<String, Object>> selectParentCode(String CODE_ID_, List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean recursive, Boolean includeSelf);

    /**
     * 通用下级对象查询，返回下级对象列表。
     * 
     * @param recursive
     *        是否递归，默认为false。
     * @param includeSelf
     *        是否包含自己，默认为false。
     */
    public List<Map<String, Object>> selectChildCode(String CODE_ID_, List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean recursive, Boolean includeSelf);

    /**
     * 查询分类。
     * 
     * @return
     */
    public List<Map<String, Object>> selectCodeCategory();

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectCodeByIdList(List<String> CODE_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertCode(String CODE_ID_, String PARENT_CODE_ID_, String CATEGORY_, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Integer ORDER_);

    /**
     * 修改对象。
     */
    public int updateCode(String CODE_ID_, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Integer ORDER_);

    /**
     * 拖动排序。
     */
    public int updateCodeOrder(List<String> CODE_ID_LIST, List<Integer> ORDER_LIST);

    /**
     * 移动对象。
     */
    public int moveCode(String CODE_ID_, String PARENT_CODE_ID_);

    /**
     * 删除对象。
     */
    public int deleteCode(String CODE_ID_);
}