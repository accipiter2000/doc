package com.opendynamic.doc.service;

import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface DocTypeService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadDocType(String DOC_TYPE_ID_);

    /**
     * 获取文件。
     */
    public InputStream loadTemplateFile(String DOC_TYPE_ID_);

    public String loadHtml(String DOC_TYPE_ID_, Boolean editable);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, List<String> DOC_TYPE_STATUS_LIST, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, List<String> DOC_TYPE_STATUS_LIST);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectDocTypeByIdList(List<String> DOC_TYPE_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, InputStream TEMPLATE_FILE_, String TEMPLATE_FILE_NAME_, Integer TEMPLATE_FILE_LENGTH_, String HTML_, String BOOKMARK_, String INDEX_, String USING_TEMPLATE_, String PROC_DEF_CODE_, String DESC_, Integer ORDER_, String DOC_TYPE_STATUS_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 修改对象。
     */
    public int updateDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, InputStream TEMPLATE_FILE_, String TEMPLATE_FILE_NAME_, Integer TEMPLATE_FILE_LENGTH_, String INDEX_, String USING_TEMPLATE_, String PROC_DEF_CODE_, String DESC_, Integer ORDER_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int updateTemplateFile(String DOC_TYPE_ID_, InputStream TEMPLATE_FILE_, String TEMPLATE_FILE_NAME_, Integer TEMPLATE_FILE_LENGTH_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int updateHtml(String DOC_TYPE_ID_, String HTML_);

    /**
     * 拖动排序。
     */
    public int updateDocTypeOrder(List<String> DOC_TYPE_ID_LIST, List<Integer> ORDER_LIST, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 废弃对象。
     */
    public int disableDocType(String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 恢复对象。
     */
    public int enableDocType(String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteDocType(String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除文件。
     */
    public int deleteTemplateFile(String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);
}