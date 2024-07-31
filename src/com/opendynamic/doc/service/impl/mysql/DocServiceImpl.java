package com.opendynamic.doc.service.impl.mysql;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.support.SqlLobValue;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.aspose.words.Document;
import com.aspose.words.PdfSaveOptions;
import com.aspose.words.ProtectionType;
import com.aspose.words.SaveFormat;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opendynamic.OdSqlCriteria;
import com.opendynamic.OdUtils;
import com.opendynamic.doc.service.ApprovalMemoService;
import com.opendynamic.doc.service.DocDataService;
import com.opendynamic.doc.service.DocRiderService;
import com.opendynamic.doc.service.DocService;
import com.opendynamic.ff.service.FfService;

import name.fraser.neil.plaintext.diff_match_patch;
import name.fraser.neil.plaintext.diff_match_patch.Diff;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class DocServiceImpl implements DocService {
    @Autowired
    private DocDataService docDataService;
    @Autowired
    private DocRiderService docRiderService;
    @Autowired
    private ApprovalMemoService approvalMemoService;
    @Autowired
    private JdbcTemplate msJdbcTemplate;
    @Autowired
    private FfService ffService;

    @Override
    public Map<String, Object> loadDoc(String DOC_ID_) {
        String sql = "select * from KV_DOC where DOC_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, DOC_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public Map<String, Object> loadDocByCode(String DOC_CODE_) {
        String sql = "select * from KV_DOC where DOC_CODE_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, DOC_CODE_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public InputStream loadTemplateFile(String DOC_ID_) {
        String sql = "select TEMPLATE_FILE_ from K_DOC where DOC_ID_ = ?";
        return msJdbcTemplate.queryForObject(sql, new Object[] { DOC_ID_ }, new RowMapper<InputStream>() {
            public InputStream mapRow(ResultSet rs, int rowNum) throws SQLException {
                return rs.getBinaryStream(1);
            }
        });
    }

    @Override
    public InputStream loadDocFile(String DOC_ID_, Boolean readOnly) {
        String sql = "select DOC_FILE_ from K_DOC where DOC_ID_ = ?";
        InputStream inputStream = msJdbcTemplate.queryForObject(sql, new Object[] { DOC_ID_ }, new RowMapper<InputStream>() {
            public InputStream mapRow(ResultSet rs, int rowNum) throws SQLException {
                return rs.getBinaryStream(1);
            }
        });

        if (readOnly != null && readOnly == false) {
            return inputStream;
        }

        // 只读
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        try {
            Document document = new Document(inputStream);
            inputStream.close();

            document.protect(ProtectionType.READ_ONLY, OdUtils.getUuid());

            document.save(os, SaveFormat.DOCX);
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }

        return new ByteArrayInputStream(os.toByteArray());
    }

    @Override
    public InputStream loadPdfDocFile(String DOC_ID_) {
        InputStream inputStream = loadDocFile(DOC_ID_, false);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            Document doc = new Document(inputStream);

            // 创建字体嵌入选项
            PdfSaveOptions options = new PdfSaveOptions();
            options.setSaveFormat(SaveFormat.PDF);
            doc.save(baos, options);

            inputStream.close();
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }
        ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());

        return bais;
    }

    @Override
    public String loadTemplateHtml(String DOC_ID_, Boolean editable) {
        String sql = "select TEMPLATE_HTML_ from K_DOC where DOC_ID_ = ?";
        String docTemplateHtml = msJdbcTemplate.queryForObject(sql, new Object[] { DOC_ID_ }, String.class);

        if (docTemplateHtml == null) {
            return null;
        }

        // 将标签${...}转为input标签
        if (editable != null && editable == true) {
            // 正则表达式查找替换${...}
            Pattern pattern = Pattern.compile("\\$\\{.*?\\}");
            Matcher matcher;
            matcher = pattern.matcher(docTemplateHtml);
            StringBuffer stringBuffer = new StringBuffer(docTemplateHtml.length());
            String substring;
            String bookmark;
            String[] splits;
            Integer inputWidth;
            while (matcher.find()) {
                inputWidth = 60;
                substring = docTemplateHtml.substring(matcher.start(), matcher.end());
                substring = substring.replaceAll("<.*?>", "");
                substring = substring.substring(2, substring.length() - 1);
                bookmark = substring;
                if (substring.contains(":")) {
                    splits = substring.split(":");
                    bookmark = splits[0];
                    if (splits.length == 4) {
                        inputWidth = Integer.parseInt(splits[3]);
                    }
                }

                matcher.appendReplacement(stringBuffer, "<input name=\"" + bookmark + "\" style=\"width:" + inputWidth + "\"/>");
            }
            matcher.appendTail(stringBuffer);
            docTemplateHtml = stringBuffer.toString();
        }

        return docTemplateHtml;
    }

    @Override
    public List<Map<String, Object>> selectDoc(String DOC_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDoc(false, DOC_ID_, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_ID_, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countDoc(String DOC_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDoc(true, DOC_ID_, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_ID_, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaDoc(boolean count, String DOC_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<>();

        if (count) {
            sql = "select count(*) from KV_DOC where 1 = 1";
        }
        else {
            sql = "select * from KV_DOC where 1 = 1";
        }

        if (DOC_ID_ != null) {
            sql += " and DOC_ID_ = :DOC_ID_";
            paramMap.put("DOC_ID_", DOC_ID_);
        }
        if (DOC_TYPE_NAME_ != null) {
            sql += " and DOC_TYPE_NAME_ like concat('%',:DOC_TYPE_NAME_,'%')";
            paramMap.put("DOC_TYPE_NAME_", DOC_TYPE_NAME_);
        }
        if (DOC_CODE_ != null) {
            sql += " and DOC_CODE_ = :DOC_CODE_";
            paramMap.put("DOC_CODE_", DOC_CODE_);
        }
        if (DOC_NAME_ != null) {
            sql += " and DOC_NAME_ like concat('%',:DOC_NAME_,'%')";
            paramMap.put("DOC_NAME_", DOC_NAME_);
        }
        if (USING_TEMPLATE_PLACEHOLDERS_LIST != null && !USING_TEMPLATE_PLACEHOLDERS_LIST.isEmpty()) {
            sql += " and USING_TEMPLATE_PLACEHOLDERS_ in (:USING_TEMPLATE_PLACEHOLDERS_LIST)";
            paramMap.put("USING_TEMPLATE_PLACEHOLDERS_LIST", USING_TEMPLATE_PLACEHOLDERS_LIST);
        }
        if (DRAFTER_ID_ != null) {
            sql += " and DRAFTER_ID_ = :DRAFTER_ID_";
            paramMap.put("DRAFTER_ID_", DRAFTER_ID_);
        }
        if (DRAFTER_COM_ID_ != null) {
            sql += " and DRAFTER_COM_ID_ = :DRAFTER_COM_ID_";
            paramMap.put("DRAFTER_COM_ID_", DRAFTER_COM_ID_);
        }
        if (PROC_DEF_CODE_ != null) {
            sql += " and PROC_DEF_CODE_ = :PROC_DEF_CODE_";
            paramMap.put("PROC_DEF_CODE_", PROC_DEF_CODE_);
        }
        if (PROC_ID_ != null) {
            sql += " and PROC_ID_ = :PROC_ID_";
            paramMap.put("PROC_ID_", PROC_ID_);
        }
        if (PROC_STATUS_LIST != null && !PROC_STATUS_LIST.isEmpty()) {
            sql += " and PROC_STATUS_ in (:PROC_STATUS_LIST)";
            paramMap.put("PROC_STATUS_LIST", PROC_STATUS_LIST);
        }
        if (DOC_STATUS_LIST != null && !DOC_STATUS_LIST.isEmpty()) {
            sql += " and DOC_STATUS_ in (:DOC_STATUS_LIST)";
            paramMap.put("DOC_STATUS_LIST", DOC_STATUS_LIST);
        }
        if (FROM_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ >= :FROM_CREATION_DATE_";
            paramMap.put("FROM_CREATION_DATE_", FROM_CREATION_DATE_);
        }
        if (TO_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ <= :TO_CREATION_DATE_";
            paramMap.put("TO_CREATION_DATE_", TO_CREATION_DATE_);
        }

        if (!count) {
            sql += " order by CREATION_DATE_ desc";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectMyDraftDoc(String DRAFTER_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaMyDraftDoc(false, DRAFTER_ID_, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countMyDraftDoc(String DRAFTER_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaMyDraftDoc(true, DRAFTER_ID_, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaMyDraftDoc(boolean count, String DRAFTER_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<>();

        if (count) {
            sql = "select count(*) from KV_DOC where DRAFTER_ID_ = :DRAFTER_ID_";
        }
        else {
            sql = "select * from KV_DOC where DRAFTER_ID_ = :DRAFTER_ID_";
        }
        paramMap.put("DRAFTER_ID_", DRAFTER_ID_);

        if (DOC_TYPE_NAME_ != null) {
            sql += " and DOC_TYPE_NAME_ like concat('%',:DOC_TYPE_NAME_,'%')";
            paramMap.put("DOC_TYPE_NAME_", DOC_TYPE_NAME_);
        }
        if (DOC_CODE_ != null) {
            sql += " and DOC_CODE_ = :DOC_CODE_";
            paramMap.put("DOC_CODE_", DOC_CODE_);
        }
        if (DOC_NAME_ != null) {
            sql += " and DOC_NAME_ like concat('%',:DOC_NAME_,'%')";
            paramMap.put("DOC_NAME_", DOC_NAME_);
        }
        if (USING_TEMPLATE_PLACEHOLDERS_LIST != null && !USING_TEMPLATE_PLACEHOLDERS_LIST.isEmpty()) {
            sql += " and USING_TEMPLATE_PLACEHOLDERS_ in (:USING_TEMPLATE_PLACEHOLDERS_LIST)";
            paramMap.put("USING_TEMPLATE_PLACEHOLDERS_LIST", USING_TEMPLATE_PLACEHOLDERS_LIST);
        }
        if (DRAFTER_COM_ID_ != null) {
            sql += " and DRAFTER_COM_ID_ = :DRAFTER_COM_ID_";
            paramMap.put("DRAFTER_COM_ID_", DRAFTER_COM_ID_);
        }
        if (PROC_DEF_CODE_ != null) {
            sql += " and PROC_DEF_CODE_ = :PROC_DEF_CODE_";
            paramMap.put("PROC_DEF_CODE_", PROC_DEF_CODE_);
        }
        if (PROC_ID_ != null) {
            sql += " and PROC_ID_ = :PROC_ID_";
            paramMap.put("PROC_ID_", PROC_ID_);
        }
        if (PROC_STATUS_LIST != null && !PROC_STATUS_LIST.isEmpty()) {
            sql += " and PROC_STATUS_ in (:PROC_STATUS_LIST)";
            paramMap.put("PROC_STATUS_LIST", PROC_STATUS_LIST);
        }
        if (DOC_STATUS_LIST != null && !DOC_STATUS_LIST.isEmpty()) {
            sql += " and DOC_STATUS_ in (:DOC_STATUS_LIST)";
            paramMap.put("DOC_STATUS_LIST", DOC_STATUS_LIST);
        }
        if (FROM_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ >= :FROM_CREATION_DATE_";
            paramMap.put("FROM_CREATION_DATE_", FROM_CREATION_DATE_);
        }
        if (TO_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ <= :TO_CREATION_DATE_";
            paramMap.put("TO_CREATION_DATE_", TO_CREATION_DATE_);
        }

        if (!count) {
            sql += " order by CREATION_DATE_ desc";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectMyInvolvedDoc(List<String> POSI_EMP_ID_LIST, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaMyInvolvedDoc(false, POSI_EMP_ID_LIST, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_ID_, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countMyInvolvedDoc(List<String> POSI_EMP_ID_LIST, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaMyInvolvedDoc(true, POSI_EMP_ID_LIST, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_ID_, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaMyInvolvedDoc(boolean count, List<String> POSI_EMP_ID_LIST, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, List<String> PROC_STATUS_LIST, List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<>();

        if (count) {
            sql = "select count(*) from KV_DOC where DOC_ID_ in (select BIZ_ID_ from K_APPROVAL_MEMO where ASSIGNEE_ in (:POSI_EMP_ID_LIST) and APPROVAL_MEMO_STATUS_ != '0')";
        }
        else {
            sql = "select * from KV_DOC where DOC_ID_ in (select BIZ_ID_ from K_APPROVAL_MEMO where ASSIGNEE_ in (:POSI_EMP_ID_LIST) and APPROVAL_MEMO_STATUS_ != '0')";
        }
        paramMap.put("POSI_EMP_ID_LIST", POSI_EMP_ID_LIST);

        if (DOC_TYPE_NAME_ != null) {
            sql += " and DOC_TYPE_NAME_ like concat('%',:DOC_TYPE_NAME_,'%')";
            paramMap.put("DOC_TYPE_NAME_", DOC_TYPE_NAME_);
        }
        if (DOC_CODE_ != null) {
            sql += " and DOC_CODE_ = :DOC_CODE_";
            paramMap.put("DOC_CODE_", DOC_CODE_);
        }
        if (DOC_NAME_ != null) {
            sql += " and DOC_NAME_ like concat('%',:DOC_NAME_,'%')";
            paramMap.put("DOC_NAME_", DOC_NAME_);
        }
        if (USING_TEMPLATE_PLACEHOLDERS_LIST != null && !USING_TEMPLATE_PLACEHOLDERS_LIST.isEmpty()) {
            sql += " and USING_TEMPLATE_PLACEHOLDERS_ in (:USING_TEMPLATE_PLACEHOLDERS_LIST)";
            paramMap.put("USING_TEMPLATE_PLACEHOLDERS_LIST", USING_TEMPLATE_PLACEHOLDERS_LIST);
        }
        if (DRAFTER_ID_ != null) {
            sql += " and DRAFTER_ID_ = :DRAFTER_ID_";
            paramMap.put("DRAFTER_ID_", DRAFTER_ID_);
        }
        if (DRAFTER_COM_ID_ != null) {
            sql += " and DRAFTER_COM_ID_ = :DRAFTER_COM_ID_";
            paramMap.put("DRAFTER_COM_ID_", DRAFTER_COM_ID_);
        }
        if (PROC_DEF_CODE_ != null) {
            sql += " and PROC_DEF_CODE_ = :PROC_DEF_CODE_";
            paramMap.put("PROC_DEF_CODE_", PROC_DEF_CODE_);
        }
        if (PROC_ID_ != null) {
            sql += " and PROC_ID_ = :PROC_ID_";
            paramMap.put("PROC_ID_", PROC_ID_);
        }
        if (PROC_STATUS_LIST != null && !PROC_STATUS_LIST.isEmpty()) {
            sql += " and PROC_STATUS_ in (:PROC_STATUS_LIST)";
            paramMap.put("PROC_STATUS_LIST", PROC_STATUS_LIST);
        }
        if (DOC_STATUS_LIST != null && !DOC_STATUS_LIST.isEmpty()) {
            sql += " and DOC_STATUS_ in (:DOC_STATUS_LIST)";
            paramMap.put("DOC_STATUS_LIST", DOC_STATUS_LIST);
        }
        if (FROM_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ >= :FROM_CREATION_DATE_";
            paramMap.put("FROM_CREATION_DATE_", FROM_CREATION_DATE_);
        }
        if (TO_CREATION_DATE_ != null) {
            sql += " and CREATION_DATE_ <= :TO_CREATION_DATE_";
            paramMap.put("TO_CREATION_DATE_", TO_CREATION_DATE_);
        }

        if (!count) {
            sql += " order by CREATION_DATE_ desc";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectDocByIdList(List<String> DOC_ID_LIST) {
        if (DOC_ID_LIST == null || DOC_ID_LIST.isEmpty()) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(DOC_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<>();

        sql.append("select * from KV_DOC where DOC_ID_ in (:DOC_ID_LIST)");
        paramMap.put("DOC_ID_LIST", DOC_ID_LIST);
        sql.append(" order by FIELD(DOC_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < DOC_ID_LIST.size(); i++) {
            sql.append(" '").append(DOC_ID_LIST.get(i)).append("'");
            if (i < DOC_ID_LIST.size() - 1) {
                sql.append(",");
            }
            else {
                sql.append(")");
            }
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql.toString(), paramMap);
    }

    @Override
    public int insertDocByDocType(String DOC_ID_, String DOC_TYPE_ID_, String DOC_CODE_, String DOC_NAME_, String MEMO_, String DRAFTER_ID_, String DRAFTER_NAME_, String DRAFTER_COM_ID_, String DRAFTER_COM_NAME_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "insert into K_DOC (DOC_ID_, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, MEMO_, TEMPLATE_FILE_, TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_, DOC_FILE_, DOC_FILE_NAME_, DOC_FILE_LENGTH_, TEMPLATE_BOOKMARK_, TEMPLATE_INDEX_, TEMPLATE_HTML_, USING_TEMPLATE_PLACEHOLDERS_, PROC_DEF_CODE_, PROC_STATUS_, DRAFTER_ID_, DRAFTER_NAME_, DRAFTER_COM_ID_, DRAFTER_COM_NAME_, DOC_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, VERSION_) select ?, DOC_TYPE_NAME_, ?, ?, ?, TEMPLATE_FILE_, TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_, TEMPLATE_FILE_, concat(?,'.docx'), TEMPLATE_FILE_LENGTH_, TEMPLATE_BOOKMARK_, TEMPLATE_INDEX_, TEMPLATE_HTML_, USING_TEMPLATE_PLACEHOLDERS_, PROC_DEF_CODE_, '0', ?, ?, ?, ?, '0', ?, ?, ?, ?, 1 from K_DOC_TYPE where DOC_TYPE_ID_ = ?";
        int count = msJdbcTemplate.update(sql, DOC_ID_, DOC_CODE_, DOC_NAME_, MEMO_, DOC_NAME_, DRAFTER_ID_, DRAFTER_NAME_, DRAFTER_COM_ID_, DRAFTER_COM_NAME_, new Date(), new Date(), OPERATOR_ID_, OPERATOR_NAME_, DOC_TYPE_ID_);

        updateDocDataAndGenerateContactByDoc(DOC_ID_, true);

        return count;
    }

    @Override
    public int updateDocByDocType(String DOC_ID_, String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_DOC D inner join K_DOC_TYPE KT on D.DOC_ID_ = ? and KT.DOC_TYPE_ID_ = ? set D.DOC_TYPE_NAME_ = KT.DOC_TYPE_NAME_, D.TEMPLATE_FILE_ = KT.TEMPLATE_FILE_, D.TEMPLATE_FILE_NAME_ = KT.TEMPLATE_FILE_NAME_, D.TEMPLATE_FILE_LENGTH_ = KT.TEMPLATE_FILE_LENGTH_, D.TEMPLATE_BOOKMARK_ = KT.TEMPLATE_BOOKMARK_, D.TEMPLATE_INDEX_ = KT.TEMPLATE_INDEX_, D.TEMPLATE_HTML_ = KT.TEMPLATE_HTML_, D.USING_TEMPLATE_PLACEHOLDERS_ = KT.USING_TEMPLATE_PLACEHOLDERS_, D.PROC_DEF_CODE_ = KT.PROC_DEF_CODE_, D.UPDATE_DATE_ = ?";
        int count = msJdbcTemplate.update(sql, DOC_ID_, DOC_TYPE_ID_, new Date());

        generateDocByDocData(DOC_ID_);

        return count;
    }

    @Override
    public int updateDoc(String DOC_ID_, String DOC_CODE_, String DOC_NAME_, String MEMO_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_DOC set DOC_CODE_ = ?, DOC_NAME_ = ?, MEMO_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ?  where DOC_ID_ = ?";
        return msJdbcTemplate.update(sql, DOC_CODE_, DOC_NAME_, MEMO_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, DOC_ID_);
    }

    @SuppressWarnings("unchecked")
    private void updateDocDataAndGenerateContactByDoc(String DOC_ID_, boolean rebuild) {
        if (rebuild) {
            docDataService.deleteDocDataByDocId(DOC_ID_, new Date(), null, null);
        }

        Map<String, Object> doc = loadDoc(DOC_ID_);
        String TEMPLATE_BOOKMARK_ = (String) doc.get("TEMPLATE_BOOKMARK_");
        if (StringUtils.isNotEmpty(TEMPLATE_BOOKMARK_)) {
            Map<String, Object> map = new Gson().fromJson(TEMPLATE_BOOKMARK_, Map.class);
            List<Map<String, Object>> templateBookmarkList = (List<Map<String, Object>>) map.get("templateBookmarkList");
            String defalutValueRef;
            String defalutValue;
            for (Map<String, Object> templateBookmark : templateBookmarkList) {
                defalutValue = null;
                defalutValueRef = (String) templateBookmark.get("defalutValueRef");
                if (StringUtils.isNotEmpty(defalutValueRef)) {
                    if (doc.get(defalutValueRef) != null) {
                        defalutValue = doc.get(defalutValueRef).toString();
                    }
                    docDataService.deleteDocDataByDocIdAndBookmark(DOC_ID_, (String) templateBookmark.get("bookmark"), new Date(), null, null);
                    docDataService.insertDocData(OdUtils.getUuid(), DOC_ID_, (String) templateBookmark.get("bookmark"), (String) templateBookmark.get("dataType"), defalutValue, ((Double) templateBookmark.get("order")).intValue());
                }
            }
        }

        generateDocByDocData(DOC_ID_);
    }

    @Override
    public int updateDocFile(String DOC_ID_, InputStream DOC_FILE_, String DOC_FILE_NAME_, Integer DOC_FILE_LENGTH_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_DOC set DOC_ID_ = :DOC_ID_";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        if (DOC_FILE_LENGTH_ != 0) {// 更新文件
            sql += ", DOC_FILE_ = :DOC_FILE_, DOC_FILE_NAME_ = :DOC_FILE_NAME_, DOC_FILE_LENGTH_ = :DOC_FILE_LENGTH_";
            parameterSource.addValue("DOC_FILE_", new SqlLobValue(DOC_FILE_, DOC_FILE_LENGTH_, new DefaultLobHandler()), Types.BLOB);
            parameterSource.addValue("DOC_FILE_NAME_", DOC_FILE_NAME_, Types.VARCHAR);
            parameterSource.addValue("DOC_FILE_LENGTH_", DOC_FILE_LENGTH_, Types.INTEGER);
        }
        sql += " , USING_TEMPLATE_PLACEHOLDERS_ = '0', UPDATE_DATE_ = :UPDATE_DATE_, OPERATOR_ID_ = :OPERATOR_ID_, OPERATOR_NAME_ = :OPERATOR_NAME_ where DOC_ID_ = :DOC_ID_";
        parameterSource.addValue("UPDATE_DATE_", new Date(), Types.TIMESTAMP);
        parameterSource.addValue("OPERATOR_ID_", OPERATOR_ID_, Types.VARCHAR);
        parameterSource.addValue("OPERATOR_NAME_", OPERATOR_NAME_, Types.VARCHAR);
        parameterSource.addValue("DOC_ID_", DOC_ID_, Types.VARCHAR);

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.update(sql, parameterSource);
    }

    @SuppressWarnings("unchecked")
    @Override
    public int updateDocData(String DOC_ID_, List<String> BOOK_MARK_LIST, List<String> VALUE_LIST, List<String> DATA_TYPE_LIST, List<Integer> ORDER_LIST, String OPERATOR_ID_, String OPERATOR_NAME_) {
        docDataService.deleteDocDataByDocId(DOC_ID_, new Date(), OPERATOR_ID_, OPERATOR_NAME_);// 删除原有文档数值

        // 保存新的文档数值
        if (BOOK_MARK_LIST != null) {
            for (int i = 0; i < BOOK_MARK_LIST.size(); i++) {
                docDataService.insertDocData(OdUtils.getUuid(), DOC_ID_, BOOK_MARK_LIST.get(i), DATA_TYPE_LIST.get(i), VALUE_LIST.get(i), ORDER_LIST.get(i));
            }
        }

        generateDocByDocData(DOC_ID_);

        // 反向同步。将DocData中相关的值更新到文档表中
        String BOOKMARK_ = (String) loadDoc(DOC_ID_).get("BOOKMARK_");
        if (StringUtils.isNotEmpty(BOOKMARK_)) {
            Map<String, Object> map = new Gson().fromJson(BOOKMARK_, Map.class);
            List<Map<String, Object>> templateBookmarkList = (List<Map<String, Object>>) map.get("templateBookmarkList");
            String bookmark;
            String defalutValueRef;
            // 依照文档中templateBookmark，查找其中定义了defalutValueRef的标签，将这些标签的值反向更新到文档表中
            for (Map<String, Object> templateBookmark : templateBookmarkList) {
                bookmark = (String) templateBookmark.get("bookmark");
                defalutValueRef = (String) templateBookmark.get("defalutValueRef");
                if (StringUtils.isNotEmpty(defalutValueRef)) {
                    if (defalutValueRef.indexOf(".") == -1) {// 只处理直接引用文档表的标签，不处理其它表的，比如甲方
                        int index = -1;
                        for (int i = 0; i < BOOK_MARK_LIST.size(); i++) {
                            if (BOOK_MARK_LIST.get(i).equals(bookmark)) {
                                index = i;
                                break;
                            }
                        }
                        if (index != -1) {
                            String sql = "update K_DOC set " + defalutValueRef + " = ? where DOC_ID_ = ?";
                            msJdbcTemplate.update(sql, VALUE_LIST.get(index), DOC_ID_);
                        }
                    }
                }
            }
        }

        return 1;
    }

    private void generateDocByDocData(String DOC_ID_) {
        InputStream inputStream = loadTemplateFile(DOC_ID_);
        if (inputStream == null) {
            return;
        }

        List<Map<String, Object>> docDataList = docDataService.selectDocData(null, DOC_ID_, null, 1, -1);
        Map<String, String> docDataMap = new HashMap<>();
        for (Map<String, Object> docData : docDataList) {
            docDataMap.put((String) docData.get("BOOKMARK_"), (String) docData.get("VALUE_"));
        }

        XWPFDocument document;
        try {
            document = new XWPFDocument(inputStream);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        // 替换标签为文档数值
        if (!docDataMap.isEmpty()) {
            // 获取所有paragraph
            List<XWPFParagraph> paragraphList = new ArrayList<>();
            paragraphList.addAll(document.getParagraphs());
            for (XWPFTable table : document.getTables()) {
                for (XWPFTableRow row : table.getRows()) {
                    for (XWPFTableCell cell : row.getTableCells()) {
                        paragraphList.addAll(cell.getParagraphs());
                    }
                }
            }
            // 正则表达式查找替换
            Pattern pattern = Pattern.compile("\\$\\{.*?\\}");
            Matcher matcher;
            String text;
            String bookmark;
            List<String> protoBookmarkList;// 原始标签
            List<String> bookmarkList;// 解析后的标签
            List<XWPFRun> runList;
            XWPFRun run;
            for (XWPFParagraph paragraph : paragraphList) {
                // 先在paragraph查询标签，记录该paragraph内所含标签数量和内容
                protoBookmarkList = new ArrayList<>();// 原始标签
                bookmarkList = new ArrayList<>();// 解析后标签
                text = paragraph.getText();
                if (StringUtils.isEmpty(text)) {
                    continue;
                }
                matcher = pattern.matcher(text);
                while (matcher.find()) {
                    protoBookmarkList.add(text.substring(matcher.start(), matcher.end()));
                    bookmark = text.substring(matcher.start() + 2, matcher.end() - 1);
                    if (bookmark.contains(":")) {
                        bookmark = bookmark.split(":")[0];
                    }
                    bookmarkList.add(bookmark);
                }

                // 该paragraph未找到标签，跳过，继续处理下一个paragraph。
                if (protoBookmarkList.isEmpty()) {
                    continue;
                }

                // 继续在run里依次处理在paragraph里找到的标签，并替换。一个标签可能被分割在多个run中。
                runList = paragraph.getRuns();
                int bookmarkIndex = 0;// 用于查找在paragraph中找到的标签
                for (int i = 0; i < runList.size(); i++) {
                    text = "";
                    int increment = 0;// 合并的run个数
                    run = runList.get(i);
                    while (text.indexOf(protoBookmarkList.get(bookmarkIndex)) == -1) {// 在run中查找标签，如没有，在更多run中合并查找，直到找到为止。
                        text = runList.get(i + increment).getText(0) != null ? text + runList.get(i + increment).getText(0) : text;
                        increment++;
                    }

                    // 替换标签
                    run = runList.get(i + increment - 1);
                    text = run.getText(0);
                    if (text.indexOf(protoBookmarkList.get(bookmarkIndex)) != -1) {// 最后一个run中包含完整的标签，整个替换
                        text = text.replace(protoBookmarkList.get(bookmarkIndex), docDataMap.get(bookmarkList.get(bookmarkIndex)) != null ? docDataMap.get(bookmarkList.get(bookmarkIndex)) : "");
                        run.setText(text, 0);
                    }
                    else {// 标签分割在多个run中
                        run.setText(text.substring(text.indexOf("}") + 1), 0);// 最后一个run删除标签

                        for (int j = increment - 2; j >= 0; j--) {// 中间和第一个run处理
                            run = runList.get(i + j);
                            text = run.getText(0);
                            if (text.lastIndexOf("$") == -1) {// 中间run删除标签
                                run.setText("", 0);
                            }
                            else {
                                run.setText(text.substring(0, text.lastIndexOf("$")).concat(docDataMap.get(bookmarkList.get(bookmarkIndex)) != null ? docDataMap.get(bookmarkList.get(bookmarkIndex)) : ""), 0);// 第一个run替换标签
                                break;
                            }
                        }
                    }

                    bookmarkIndex++;
                    if (bookmarkIndex >= protoBookmarkList.size()) {// 如该paragraph所有标签都已替换完，继续处理下一个paragraph。
                        break;
                    }

                    i = -1;// 继续处理该paragraph剩余标签
                }
            }
        }

        // 输出保存
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        try {
            document.write(os);
        }
        catch (Exception e) {
            e.printStackTrace();
            try {
                document.close();
            }
            catch (Exception ex) {
                ex.printStackTrace();
            }
            throw new RuntimeException(e);
        }

        ByteArrayInputStream is = new ByteArrayInputStream(os.toByteArray());
        String sql = "update K_DOC set ";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        sql += "DOC_FILE_ = :DOC_FILE_, DOC_FILE_LENGTH_ = :DOC_FILE_LENGTH_";
        parameterSource.addValue("DOC_FILE_", new SqlLobValue(is, os.size(), new DefaultLobHandler()), Types.BLOB);
        parameterSource.addValue("DOC_FILE_LENGTH_", os.size(), Types.INTEGER);
        sql += " where DOC_ID_ = :DOC_ID_";
        parameterSource.addValue("DOC_ID_", DOC_ID_, Types.VARCHAR);

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        namedParameterJdbcTemplate.update(sql, parameterSource);

        try {
            os.close();
            document.close();
            inputStream.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int updateProcId(String DOC_ID_, String PROC_ID_) {
        String sql = "update K_DOC C set C.PROC_ID_ = ? where C.DOC_ID_ = ?";
        return msJdbcTemplate.update(sql, PROC_ID_, DOC_ID_);
    }

    @Override
    public int updateProcStatus(String DOC_ID_, String PROC_STATUS_) {
        String sql = "update K_DOC C set C.PROC_STATUS_ = ? where C.DOC_ID_ = ?";
        return msJdbcTemplate.update(sql, PROC_STATUS_, DOC_ID_);
    }

    @Override
    public int updateDocStatus(String DOC_ID_, String DOC_STATUS_) {
        String sql = "update K_DOC C set C.DOC_STATUS_ = ? where C.DOC_ID_ = ?";
        return msJdbcTemplate.update(sql, DOC_STATUS_, DOC_ID_);
    }

    @Override
    public int updateDocVersion(String DOC_ID_) {
        String sql = "update K_DOC set VERSION_ = VERSION_ + 1 where DOC_ID_ = ?";
        return msJdbcTemplate.update(sql, DOC_ID_);
    }

    @Override
    public void updateDocHis(final String DOC_ID_) {
        new Thread() {// 该方法耗时且不重要，因此使用线程执行。
            public void run() {
                try {
                    Thread.sleep(6000);// 延时，因为不在一个事务内，保证前事务完成后执行。
                }
                catch (InterruptedException e) {
                    e.printStackTrace();
                }

                Map<String, Object> doc = loadDoc(DOC_ID_);
                int VERSION_ = ((BigDecimal) doc.get("VERSION_")).intValue();

                String sql;

                // 先删除，防止主动撤回的文档没有更新版本
                sql = "delete from K_DOC_HIS where DOC_ID_ = ? and VERSION_ = ?";
                msJdbcTemplate.update(sql, DOC_ID_, VERSION_);
                sql = "delete from K_DOC_DATA_HIS where DOC_ID_ = ? and VERSION_ = ?";
                msJdbcTemplate.update(sql, DOC_ID_, VERSION_);
                sql = "delete from K_DOC_RIDER_HIS where DOC_ID_ = ? and VERSION_ = ?";
                msJdbcTemplate.update(sql, DOC_ID_, VERSION_);

                sql = "insert into K_DOC_HIS (DOC_HIS_ID_, DOC_ID_, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, MEMO_, TEMPLATE_FILE_, TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_, DOC_FILE_, DOC_FILE_NAME_, DOC_FILE_LENGTH_, TEMPLATE_BOOKMARK_, TEMPLATE_INDEX_, TEMPLATE_HTML_, USING_TEMPLATE_PLACEHOLDERS_, DRAFTER_ID_, DRAFTER_NAME_, DRAFTER_COM_ID_, DRAFTER_COM_NAME_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_, DOC_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, VERSION_, HIS_DATE_) select UUID(), DOC_ID_, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, MEMO_, TEMPLATE_FILE_, TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_, DOC_FILE_, DOC_FILE_NAME_, DOC_FILE_LENGTH_, TEMPLATE_BOOKMARK_, TEMPLATE_INDEX_, TEMPLATE_HTML_, USING_TEMPLATE_PLACEHOLDERS_, DRAFTER_ID_, DRAFTER_NAME_, DRAFTER_COM_ID_, DRAFTER_COM_NAME_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_, DOC_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, VERSION_, SYSDATE() from K_DOC where DOC_ID_ = ?";
                msJdbcTemplate.update(sql, DOC_ID_);
                sql = "insert into K_DOC_DATA_HIS (DOC_DATA_HIS_ID_, DOC_DATA_ID_, DOC_ID_, BOOKMARK_, VALUE_, DATA_TYPE_, ORDER_, VERSION_, HIS_DATE_) select UUID(), DOC_DATA_ID_, DOC_ID_, BOOKMARK_, VALUE_, DATA_TYPE_, ORDER_, ?, SYSDATE() from K_DOC_DATA where DOC_ID_ = ?";
                msJdbcTemplate.update(sql, VERSION_, DOC_ID_);
                sql = "insert into K_DOC_RIDER_HIS (DOC_RIDER_HIS_ID_, DOC_RIDER_ID_, DOC_ID_, DOC_RIDER_FILE_, DOC_RIDER_FILE_NAME_, DOC_RIDER_FILE_LENGTH_, MD5_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, VERSION_, HIS_DATE_) select UUID(), DOC_RIDER_ID_, DOC_ID_, DOC_RIDER_FILE_, DOC_RIDER_FILE_NAME_, DOC_RIDER_FILE_LENGTH_, MD5_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, ?, SYSDATE() from K_DOC_RIDER where DOC_ID_ = ?";
                msJdbcTemplate.update(sql, VERSION_, DOC_ID_);

                updateDocFileDiff(DOC_ID_, VERSION_);
                updateDocDataDiff(DOC_ID_, VERSION_);
                updateDocRiderDiff(DOC_ID_, VERSION_);
            }
        }.start();
    }

    private void updateDocFileDiff(String DOC_ID_, Integer VERSION_) {
        List<Diff> docFileDiff = new ArrayList<>();

        if (VERSION_ > 1) {
            String sql = "select DOC_FILE_ from K_DOC_HIS where DOC_ID_ = ? and VERSION_ = ?";
            InputStream docFileInputStream = msJdbcTemplate.queryForObject(sql, new Object[] { DOC_ID_, VERSION_ }, new RowMapper<InputStream>() {
                public InputStream mapRow(ResultSet rs, int rowNum) throws SQLException {
                    return rs.getBinaryStream(1);
                }
            });
            InputStream previousDocFileInputStream = msJdbcTemplate.queryForObject(sql, new Object[] { DOC_ID_, VERSION_ - 1 }, new RowMapper<InputStream>() {
                public InputStream mapRow(ResultSet rs, int rowNum) throws SQLException {
                    return rs.getBinaryStream(1);
                }
            });

            String docFileText = "";
            String previousDocFileText = "";
            try {
                XWPFWordExtractor wordExtractor;
                if (docFileInputStream != null) {
                    wordExtractor = new XWPFWordExtractor(new XWPFDocument(docFileInputStream));
                    docFileText = wordExtractor.getText();
                    docFileText = docFileText.replaceAll("null", "");
                    wordExtractor.close();
                    docFileInputStream.close();
                }
                if (previousDocFileInputStream != null) {
                    wordExtractor = new XWPFWordExtractor(new XWPFDocument(previousDocFileInputStream));
                    previousDocFileText = wordExtractor.getText();
                    previousDocFileText = previousDocFileText.replaceAll("null", "");
                    wordExtractor.close();
                    previousDocFileInputStream.close();
                }
            }
            catch (Exception e) {
                throw new RuntimeException(e);
            }

            docFileDiff = new diff_match_patch().diff_main(previousDocFileText, docFileText);
        }

        String sql = "update K_DOC_HIS set DOC_FILE_DIFF_ = ? where DOC_ID_ = ? and VERSION_ = ?";
        msJdbcTemplate.update(sql, new GsonBuilder().setPrettyPrinting().create().toJson(docFileDiff), DOC_ID_, VERSION_);
    }

    private void updateDocDataDiff(String DOC_ID_, Integer VERSION_) {

    }

    private void updateDocRiderDiff(String DOC_ID_, Integer VERSION_) {
        List<Map<String, Object>> docRiderDiff = new ArrayList<>();

        List<Map<String, Object>> docRiderInsertList = new ArrayList<>();
        List<Map<String, Object>> docRiderUpdateList = new ArrayList<>();
        List<Map<String, Object>> docRiderDeleteList = new ArrayList<>();
        if (VERSION_ > 1) {
            String sql = "select DOC_RIDER_HIS_ID_, DOC_RIDER_ID_, DOC_ID_, DOC_RIDER_FILE_NAME_, MD5_, VERSION_ from K_DOC_RIDER_HIS where DOC_ID_ = ? and VERSION_ = ?";
            List<Map<String, Object>> docRiderList = msJdbcTemplate.queryForList(sql, DOC_ID_, VERSION_);
            List<Map<String, Object>> previousDocRiderList = msJdbcTemplate.queryForList(sql, DOC_ID_, VERSION_ - 1);
            List<String> docRiderIdList = OdUtils.collect(docRiderList, "DOC_RIDER_ID_", String.class);
            List<String> previousDocRiderIdList = OdUtils.collect(previousDocRiderList, "DOC_RIDER_ID_", String.class);
            for (Map<String, Object> docRider : docRiderList) {
                int index = previousDocRiderIdList.indexOf(docRider.get("DOC_RIDER_ID_"));
                if (index == -1) {
                    docRiderInsertList.add(docRider);
                }
                else {
                    if (!previousDocRiderList.get(index).get("MD5_").equals(docRider.get("MD5_"))) {
                        docRiderUpdateList.add(docRider);
                    }
                }
            }
            for (Map<String, Object> previousDocRider : previousDocRiderList) {
                if (!docRiderIdList.contains(previousDocRider.get("DOC_RIDER_ID_"))) {
                    docRiderDeleteList.add(previousDocRider);
                }
            }

            for (Map<String, Object> docRider : docRiderInsertList) {
                docRider.put("OPERATION_", "新增");
                docRiderDiff.add(docRider);
            }
            for (Map<String, Object> docRider : docRiderUpdateList) {
                docRider.put("OPERATION_", "修改");
                docRiderDiff.add(docRider);
            }
            for (Map<String, Object> docRider : docRiderDeleteList) {
                docRider.put("OPERATION_", "删除");
                docRiderDiff.add(docRider);
            }
        }

        String sql = "update K_DOC_HIS set DOC_RIDER_DIFF_ = ? where DOC_ID_ = ? and VERSION_ = ?";
        msJdbcTemplate.update(sql, new GsonBuilder().setPrettyPrinting().create().toJson(docRiderDiff), DOC_ID_, VERSION_);
    }

    @Override
    public int disableDoc(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_DOC set DOC_STATUS_ = '0', UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where DOC_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, DOC_ID_);
    }

    @Override
    public int enableDoc(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_DOC set DOC_STATUS_ = '1', UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where DOC_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, DOC_ID_);
    }

    @Override
    public int deleteDoc(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        Map<String, Object> doc = loadDoc(DOC_ID_);

        String sql;
        sql = "delete from K_DOC_RIDER_HIS where DOC_ID_ = ? ";
        msJdbcTemplate.update(sql, DOC_ID_);
        sql = "delete from K_DOC_DATA_HIS where DOC_ID_ = ? ";
        msJdbcTemplate.update(sql, DOC_ID_);
        sql = "delete from K_DOC_HIS where DOC_ID_ = ? ";
        msJdbcTemplate.update(sql, DOC_ID_);

        docDataService.deleteDocDataByDocId(DOC_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);
        docRiderService.deleteDocRiderByDocId(DOC_ID_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);
        approvalMemoService.deleteApprovalMemoByProcId((String) doc.get("PROC_ID_"), UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_);

        sql = "delete from K_DOC where DOC_ID_ = ?";
        int count = msJdbcTemplate.update(sql, DOC_ID_);

        String PROC_ID_ = (String) doc.get("PROC_ID_");
        if (StringUtils.isNotEmpty(PROC_ID_)) {
            ffService.cleanProc(PROC_ID_);
        }

        return count;
    }

    @Override
    public boolean isUsingTemplatePlaceholders(String DOC_ID_) {
        Map<String, Object> doc = loadDoc(DOC_ID_);
        if (doc.get("USING_TEMPLATE_PLACEHOLDERS_").equals("1")) {
            return true;
        }

        return false;
    }

    @Override
    public String getTemplateBookmark(String DOC_ID_) {
        String sql = "select TEMPLATE_BOOKMARK_ from K_DOC where DOC_ID_ = :DOC_ID_";
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("DOC_ID_", DOC_ID_);
        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, String.class);
    }

    @Override
    public Map<String, Object> getDocDiff(String DOC_ID_, Integer VERSION_) {
        Map<String, Object> docDiff = new HashMap<>();

        if (VERSION_ == null) {
            Map<String, Object> doc = loadDoc(DOC_ID_);
            VERSION_ = ((BigDecimal) doc.get("VERSION_")).intValue();
        }

        String sql = "select DOC_FILE_DIFF_, DOC_DATA_DIFF_, DOC_RIDER_DIFF_ from K_DOC_HIS where DOC_ID_ = ? and VERSION_ = ?";
        List<Map<String, Object>> docHisList = msJdbcTemplate.queryForList(sql, DOC_ID_, VERSION_);
        if (docHisList.size() == 1) {
            Map<String, Object> docHis = docHisList.get(0);
            docDiff.put("DOC_FILE_DIFF_", new Gson().fromJson((String) docHis.get("DOC_FILE_DIFF_"), Object.class));
            docDiff.put("DOC_DATA_DIFF_", new Gson().fromJson((String) docHis.get("DOC_DATA_DIFF_"), Object.class));
            docDiff.put("DOC_RIDER_DIFF_", new Gson().fromJson((String) docHis.get("DOC_RIDER_DIFF_"), Object.class));
        }

        return docDiff;
    }
}