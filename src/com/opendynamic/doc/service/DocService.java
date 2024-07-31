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
public interface DocService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadDoc(String DOC_ID_);

    /**
     * 按编码查询,返回单个对象。
     */
    public Map<String, Object> loadDocByCode(String DOC_CODE_);

    /**
     * 获取文件。
     */
    public InputStream loadTemplateFile(String DOC_ID_);

    /**
     * 获取文件。
     */
    public InputStream loadDocFile(String DOC_ID_, Boolean readOnly);

    public InputStream loadPdfDocFile(String DOC_ID_);

    public String loadTemplateHtml(String DOC_ID_, Boolean editable);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectDoc(String DOC_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countDoc(String DOC_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_);

    public List<Map<String, Object>> selectMyDraftDoc(String DRAFTER_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit);

    public int countMyDraftDoc(String DRAFTER_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_);

    public List<Map<String, Object>> selectMyInvolvedDoc(List<String> POSI_EMP_ID_LIST, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit);

    public int countMyInvolvedDoc(List<String> POSI_EMP_ID_LIST, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectDocByIdList(List<String> DOC_ID_LIST);

    public int insertDocByDocType(String DOC_ID_, String DOC_TYPE_ID_, String DOC_CODE_, String DOC_NAME_, String MEMO_, String DRAFTER_ID_, String DRAFTER_NAME_, String DRAFTER_COM_ID_, String DRAFTER_COM_NAME_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int updateDocByDocType(String DOC_ID_, String DOC_TYPE_ID, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int updateDoc(String DOC_ID_, String DOC_CODE_, String DOC_NAME_, String MEMO_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int updateDocFile(String DOC_ID_, InputStream DOC_FILE_, String DOC_FILE_NAME_, Integer DOC_FILE_LENGTH_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int updateDocData(String DOC_ID_, List<String> BOOK_MARK_LIST, List<String> VALUE_LIST, List<String> DATA_TYPE_LIST, List<Integer> ORDER_LIST, String OPERATOR_ID_, String OPERATOR_NAME_) throws Exception;

    public int updateProcId(String DOC_ID_, String PROC_ID_);

    public int updateProcStatus(String DOC_ID_, String PROC_STATUS_);

    public int updateDocStatus(String DOC_ID_, String DOC_STATUS_);

    public int updateDocVersion(String DOC_ID_);

    /**
     * 记录文档历史
     * 
     * @param DOC_ID_
     * @return
     */
    public void updateDocHis(String DOC_ID_);

    /**
     * 废弃对象。
     */
    public int disableDoc(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 恢复对象。
     */
    public int enableDoc(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteDoc(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 是否使用模板生成
     *
     * @param DOC_ID_
     * @return
     */
    public boolean isUsingTemplatePlaceholders(String DOC_ID_);

    /**
     * 获取模板标签
     *
     * @param DOC_ID_
     * @return
     */
    public String getTemplateBookmark(String DOC_ID_);

    /**
     * 获取文档版本差异。VERSION_为空取当前文档版本
     * 
     * @param DOC_ID_
     * @return
     */
    public Map<String, Object> getDocDiff(String DOC_ID_, Integer VERSION_);
}