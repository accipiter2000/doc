package com.opendynamic.doc.service;

import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opendynamic.doc.query.DocQuery;

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

    public String loadHtml(String DOC_ID_, Boolean editable);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectDoc(String DOC_ID_, List<String> DOC_ID_LIST, String DOC_CODE_, List<String> DOC_CODE_LIST, String DOC_NAME_, List<String> DOC_NAME_LIST, String DOC_TYPE_NAME_, List<String> DOC_TYPE_NAME_LIST, String OWNER_ID_, List<String> OWNER_ID_LIST, String OWNER_NAME_, List<String> OWNER_NAME_LIST, String OWNER_ORG_ID_, List<String> OWNER_ORG_ID_LIST, String OWNER_ORG_NAME_, List<String> OWNER_ORG_NAME_LIST, String USING_TEMPLATE_, List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, List<String> PROC_DEF_CODE_LIST, String PROC_ID_, List<String> PROC_ID_LIST, String PROC_STATUS_, List<String> PROC_STATUS_LIST, String DOC_STATUS_, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_EFFECTIVE_DATE_,
            Date TO_EFFECTIVE_DATE_, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countDoc(String DOC_ID_, List<String> DOC_ID_LIST, String DOC_CODE_, List<String> DOC_CODE_LIST, String DOC_NAME_, List<String> DOC_NAME_LIST, String DOC_TYPE_NAME_, List<String> DOC_TYPE_NAME_LIST, String OWNER_ID_, List<String> OWNER_ID_LIST, String OWNER_NAME_, List<String> OWNER_NAME_LIST, String OWNER_ORG_ID_, List<String> OWNER_ORG_ID_LIST, String OWNER_ORG_NAME_, List<String> OWNER_ORG_NAME_LIST, String USING_TEMPLATE_, List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, List<String> PROC_DEF_CODE_LIST, String PROC_ID_, List<String> PROC_ID_LIST, String PROC_STATUS_, List<String> PROC_STATUS_LIST, String DOC_STATUS_, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_EFFECTIVE_DATE_, Date TO_EFFECTIVE_DATE_);

    public List<Map<String, Object>> selectMyAdminDoc(String DOC_ID_, List<String> DOC_ID_LIST, String DOC_CODE_, List<String> DOC_CODE_LIST, String DOC_NAME_, List<String> DOC_NAME_LIST, String DOC_TYPE_NAME_, List<String> DOC_TYPE_NAME_LIST, String OWNER_ID_, List<String> OWNER_ID_LIST, String OWNER_NAME_, List<String> OWNER_NAME_LIST, String OWNER_ORG_ID_, List<String> OWNER_ORG_ID_LIST, String OWNER_ORG_NAME_, List<String> OWNER_ORG_NAME_LIST, String USING_TEMPLATE_, List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, List<String> PROC_DEF_CODE_LIST, String PROC_ID_, List<String> PROC_ID_LIST, String PROC_STATUS_, List<String> PROC_STATUS_LIST, String DOC_STATUS_, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_EFFECTIVE_DATE_,
            Date TO_EFFECTIVE_DATE_, Integer page, Integer limit);

    public int countMyAdminDoc(String DOC_ID_, List<String> DOC_ID_LIST, String DOC_CODE_, List<String> DOC_CODE_LIST, String DOC_NAME_, List<String> DOC_NAME_LIST, String DOC_TYPE_NAME_, List<String> DOC_TYPE_NAME_LIST, String OWNER_ID_, List<String> OWNER_ID_LIST, String OWNER_NAME_, List<String> OWNER_NAME_LIST, String OWNER_ORG_ID_, List<String> OWNER_ORG_ID_LIST, String OWNER_ORG_NAME_, List<String> OWNER_ORG_NAME_LIST, String USING_TEMPLATE_, List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, List<String> PROC_DEF_CODE_LIST, String PROC_ID_, List<String> PROC_ID_LIST, String PROC_STATUS_, List<String> PROC_STATUS_LIST, String DOC_STATUS_, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_EFFECTIVE_DATE_, Date TO_EFFECTIVE_DATE_);

    public List<Map<String, Object>> selectMyInvolvedDoc(List<String> POSI_EMP_ID_LIST, String DOC_ID_, List<String> DOC_ID_LIST, String DOC_CODE_, List<String> DOC_CODE_LIST, String DOC_NAME_, List<String> DOC_NAME_LIST, String DOC_TYPE_NAME_, List<String> DOC_TYPE_NAME_LIST, String OWNER_ID_, List<String> OWNER_ID_LIST, String OWNER_NAME_, List<String> OWNER_NAME_LIST, String OWNER_ORG_ID_, List<String> OWNER_ORG_ID_LIST, String OWNER_ORG_NAME_, List<String> OWNER_ORG_NAME_LIST, String USING_TEMPLATE_, List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, List<String> PROC_DEF_CODE_LIST, String PROC_ID_, List<String> PROC_ID_LIST, String PROC_STATUS_, List<String> PROC_STATUS_LIST, String DOC_STATUS_, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_,
            Date FROM_EFFECTIVE_DATE_, Date TO_EFFECTIVE_DATE_, Integer page, Integer limit);

    public int countMyInvolvedDoc(List<String> POSI_EMP_ID_LIST, String DOC_ID_, List<String> DOC_ID_LIST, String DOC_CODE_, List<String> DOC_CODE_LIST, String DOC_NAME_, List<String> DOC_NAME_LIST, String DOC_TYPE_NAME_, List<String> DOC_TYPE_NAME_LIST, String OWNER_ID_, List<String> OWNER_ID_LIST, String OWNER_NAME_, List<String> OWNER_NAME_LIST, String OWNER_ORG_ID_, List<String> OWNER_ORG_ID_LIST, String OWNER_ORG_NAME_, List<String> OWNER_ORG_NAME_LIST, String USING_TEMPLATE_, List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, List<String> PROC_DEF_CODE_LIST, String PROC_ID_, List<String> PROC_ID_LIST, String PROC_STATUS_, List<String> PROC_STATUS_LIST, String DOC_STATUS_, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_EFFECTIVE_DATE_,
            Date TO_EFFECTIVE_DATE_);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectDocByIdList(List<String> DOC_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertDocByDocType(String DOC_TYPE_ID_, String DOC_ID_, String DOC_CODE_, String DOC_NAME_, String OWNER_ID_, String OWNER_NAME_, String OWNER_ORG_ID_, String OWNER_ORG_NAME_, String MEMO_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 修改对象。
     */
    public int updateDoc(String DOC_ID_, String DOC_CODE_, String DOC_NAME_, String MEMO_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int updateDocDocType(String DOC_ID_, String DOC_TYPE_ID_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int updateHtml(String DOC_ID_, String HTML_);

    public int updateIndex(String DOC_ID_, String INDEX_);

    public int updateDocTemplateFile(String DOC_ID_, InputStream TEMPLATE_FILE_, String TEMPLATE_FILE_NAME_, Integer TEMPLATE_FILE_LENGTH_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int updateDocFile(String DOC_ID_, InputStream DOC_FILE_, String DOC_FILE_NAME_, Integer DOC_FILE_LENGTH_, String OPERATOR_ID_, String OPERATOR_NAME_);

    public int updateDocData(String DOC_ID_, List<String> BOOK_MARK_LIST, List<String> VALUE_LIST, List<String> DATA_TYPE_LIST, List<Integer> ORDER_LIST, String OPERATOR_ID_, String OPERATOR_NAME_) throws Exception;

    public int updateDocProcId(String DOC_ID_, String PROC_ID_);

    public int updateDocProcStatus(String DOC_ID_, String PROC_STATUS_);

    public int updateDocStatus(String DOC_ID_, String DOC_STATUS_);

    public int updateDocEffectiveDate(String DOC_ID_, Date EFFECTIVE_DATE_);

    /**
     * 记录公文历史
     * 
     * @param DOC_ID_
     * @return
     */
    public void updateDocHis(String DOC_ID_);

    /**
     * 增加版本
     * 
     * @param DOC_ID_
     * @return
     */
    public int updateDocVersion(String DOC_ID_);

    /**
     * 删除对象。
     */
    public int deleteDoc(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除文件。
     */
    public int deleteTemplateFile(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除文件。
     */
    public int deleteDocFile(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 获取公文模板标签
     *
     * @param DOC_ID_
     * @return
     */
    public String getBookmark(String DOC_ID_);

    /**
     * 是否有公文文件
     *
     * @param DOC_ID_
     * @return
     */
    public boolean hasDocFile(String DOC_ID_);

    /**
     * 是否使用模板生成
     *
     * @param DOC_ID_
     * @return
     */
    public boolean isUsingTemplate(String DOC_ID_);

    /**
     * 获取公文版本差异。VERSION_为空取当前公文版本
     * 
     * @param DOC_ID_
     * @return
     */
    public Map<String, Object> getDocDiff(String DOC_ID_, Integer VERSION_);

    public DocQuery createDocQuery();

    public void testService();
}