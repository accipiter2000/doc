package com.opendynamic.doc.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface CustomDocTypeService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadCustomDocType(String CUSTOM_DOC_TYPE_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectCustomDocType(String CUSTOM_DOC_TYPE_ID_, String EMP_ID_, String DOC_TYPE_ID_, List<String> DOC_TYPE_STATUS_LIST, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countCustomDocType(String CUSTOM_DOC_TYPE_ID_, String EMP_ID_, String DOC_TYPE_ID_, List<String> DOC_TYPE_STATUS_LIST);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectCustomDocTypeByIdList(List<String> CUSTOM_DOC_TYPE_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertCustomDocType(String CUSTOM_DOC_TYPE_ID_, String EMP_ID_, String DOC_TYPE_ID_);

    /**
     * 修改对象。
     */
    public int updateCustomDocType(String CUSTOM_DOC_TYPE_ID_, String DOC_TYPE_ID_);

    /**
     * 拖动排序。
     */
    public int updateCustomDocTypeOrder(List<String> CUSTOM_DOC_TYPE_ID_LIST, List<Integer> ORDER_LIST, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteCustomDocType(String CUSTOM_DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteCustomDocTypeByDocTypeId(String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);
}