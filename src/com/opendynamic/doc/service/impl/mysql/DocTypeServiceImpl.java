package com.opendynamic.doc.service.impl.mysql;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.PreparedStatement;
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
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
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
import com.aspose.words.HtmlSaveOptions;
import com.aspose.words.SaveFormat;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opendynamic.OdSqlCriteria;
import com.opendynamic.doc.service.DocTypeService;
import com.opendynamic.doc.vo.TemplateBookmark;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class DocTypeServiceImpl implements DocTypeService {
    @Autowired
    private JdbcTemplate msJdbcTemplate;

    @Override
    public Map<String, Object> loadDocType(String DOC_TYPE_ID_) {
        String sql = "select * from KV_DOC_TYPE where DOC_TYPE_ID_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, DOC_TYPE_ID_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public Map<String, Object> loadDocTypeByName(String DOC_TYPE_NAME_) {
        String sql = "select * from KV_DOC_TYPE where DOC_TYPE_NAME_ = ?";
        List<Map<String, Object>> result = msJdbcTemplate.queryForList(sql, DOC_TYPE_NAME_);
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public InputStream loadTemplateFile(String DOC_TYPE_ID_) {
        String sql = "select TEMPLATE_FILE_ from K_DOC_TYPE where DOC_TYPE_ID_ = ?";
        return msJdbcTemplate.queryForObject(sql, new Object[] { DOC_TYPE_ID_ }, new RowMapper<InputStream>() {
            public InputStream mapRow(ResultSet rs, int rowNum) throws SQLException {
                return rs.getBinaryStream(1);
            }
        });
    }

    @Override
    public String loadTemplateHtml(String DOC_TYPE_ID_, Boolean editable) {
        String sql = "select TEMPLATE_HTML_ from K_DOC_TYPE where DOC_TYPE_ID_ = ?";
        String templateHtml = msJdbcTemplate.queryForObject(sql, new Object[] { DOC_TYPE_ID_ }, String.class);

        if (templateHtml == null) {
            return null;
        }

        // 将标签${...}转为input标签
        if (editable != null && editable == true) {
            // 正则表达式查找替换${...}
            Pattern pattern = Pattern.compile("\\$\\{.*?\\}");
            Matcher matcher;
            matcher = pattern.matcher(templateHtml);
            StringBuffer stringBuffer = new StringBuffer(templateHtml.length());
            String substring;
            String bookmark;
            String[] splits;
            Integer inputWidth;
            while (matcher.find()) {
                inputWidth = 60;
                substring = templateHtml.substring(matcher.start(), matcher.end());
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
            templateHtml = stringBuffer.toString();
        }

        return templateHtml;
    }

    @Override
    public List<Map<String, Object>> selectDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String PROC_DEF_CODE_, List<String> DOC_TYPE_STATUS_LIST, Integer page, Integer limit) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDocType(false, DOC_TYPE_ID_, DOC_TYPE_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, PROC_DEF_CODE_, DOC_TYPE_STATUS_LIST);// 根据查询条件组装查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        if (page != null && limit != null && limit > 0) {// 分页
            sql = sql + " limit " + (page - 1) * limit + ", " + limit;
        }

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForList(sql, paramMap);
    }

    @Override
    public int countDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String PROC_DEF_CODE_, List<String> DOC_TYPE_STATUS_LIST) {
        OdSqlCriteria odSqlCriteria = buildSqlCriteriaDocType(true, DOC_TYPE_ID_, DOC_TYPE_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, PROC_DEF_CODE_, DOC_TYPE_STATUS_LIST);// 根据查询条件组装总数查询SQL语句
        String sql = odSqlCriteria.getSql();
        Map<String, Object> paramMap = odSqlCriteria.getParamMap();

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        return namedParameterJdbcTemplate.queryForObject(sql, paramMap, Integer.class);
    }

    private OdSqlCriteria buildSqlCriteriaDocType(boolean count, String DOC_TYPE_ID_, String DOC_TYPE_NAME_, List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String PROC_DEF_CODE_, List<String> DOC_TYPE_STATUS_LIST) {// 组装查询SQL语句
        String sql;
        Map<String, Object> paramMap = new HashMap<>();

        if (count) {
            sql = "select count(*) from KV_DOC_TYPE where 1 = 1";
        }
        else {
            sql = "select * from KV_DOC_TYPE where 1 = 1";
        }

        if (DOC_TYPE_ID_ != null) {
            sql += " and DOC_TYPE_ID_ = :DOC_TYPE_ID_";
            paramMap.put("DOC_TYPE_ID_", DOC_TYPE_ID_);
        }
        if (DOC_TYPE_NAME_ != null) {
            sql += " and DOC_TYPE_NAME_ like concat('%',:DOC_TYPE_NAME_,'%')";
            paramMap.put("DOC_TYPE_NAME_", DOC_TYPE_NAME_);
        }
        if (USING_TEMPLATE_PLACEHOLDERS_LIST != null && !USING_TEMPLATE_PLACEHOLDERS_LIST.isEmpty()) {
            sql += " and USING_TEMPLATE_PLACEHOLDERS_ in (:USING_TEMPLATE_PLACEHOLDERS_LIST)";
            paramMap.put("USING_TEMPLATE_PLACEHOLDERS_LIST", USING_TEMPLATE_PLACEHOLDERS_LIST);
        }
        if (PROC_DEF_CODE_ != null) {
            sql += " and PROC_DEF_CODE_ = :PROC_DEF_CODE_";
            paramMap.put("PROC_DEF_CODE_", PROC_DEF_CODE_);
        }
        if (DOC_TYPE_STATUS_LIST != null && !DOC_TYPE_STATUS_LIST.isEmpty()) {
            sql += " and DOC_TYPE_STATUS_ in (:DOC_TYPE_STATUS_LIST)";
            paramMap.put("DOC_TYPE_STATUS_LIST", DOC_TYPE_STATUS_LIST);
        }

        if (!count) {
            sql += " order by ORDER_";
        }

        return new OdSqlCriteria(sql, paramMap);
    }

    @Override
    public List<Map<String, Object>> selectDocTypeByIdList(List<String> DOC_TYPE_ID_LIST) {
        if (DOC_TYPE_ID_LIST == null || DOC_TYPE_ID_LIST.isEmpty()) {
            return new ArrayList<>();
        }

        StringBuilder sql = new StringBuilder(DOC_TYPE_ID_LIST.size() * 50 + 200);
        Map<String, Object> paramMap = new HashMap<>();

        sql.append("select * from KV_DOC_TYPE where DOC_TYPE_ID_ in (:DOC_TYPE_ID_LIST)");
        paramMap.put("DOC_TYPE_ID_LIST", DOC_TYPE_ID_LIST);
        sql.append(" order by FIELD(DOC_TYPE_ID_,");// 按主键列表顺序排序
        for (int i = 0; i < DOC_TYPE_ID_LIST.size(); i++) {
            sql.append(" '").append(DOC_TYPE_ID_LIST.get(i)).append("'");
            if (i < DOC_TYPE_ID_LIST.size() - 1) {
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
    public int insertDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, InputStream TEMPLATE_FILE_, String TEMPLATE_FILE_NAME_, Integer TEMPLATE_FILE_LENGTH_, String TEMPLATE_INDEX_, String USING_TEMPLATE_PLACEHOLDERS_, String PROC_DEF_CODE_, String DESC_, Integer ORDER_, String DOC_TYPE_STATUS_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "insert into K_DOC_TYPE (DOC_TYPE_ID_, DOC_TYPE_NAME_, TEMPLATE_FILE_, TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_, TEMPLATE_INDEX_, USING_TEMPLATE_PLACEHOLDERS_, PROC_DEF_CODE_, DESC_, ORDER_, DOC_TYPE_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int count = msJdbcTemplate.update(sql, new Object[] { DOC_TYPE_ID_, DOC_TYPE_NAME_, new SqlLobValue(TEMPLATE_FILE_, TEMPLATE_FILE_LENGTH_, new DefaultLobHandler()), TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_, TEMPLATE_INDEX_, USING_TEMPLATE_PLACEHOLDERS_, PROC_DEF_CODE_, DESC_, ORDER_, DOC_TYPE_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_ }, new int[] { Types.VARCHAR, Types.VARCHAR, Types.BLOB, Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.TIMESTAMP, Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR });

        if (TEMPLATE_FILE_LENGTH_ == 0 || "0".equals(USING_TEMPLATE_PLACEHOLDERS_)) {
            initTemplateBookmark(DOC_TYPE_ID_, true);
            initTemplateHtml(DOC_TYPE_ID_, true);
        }
        else {
            initTemplateBookmark(DOC_TYPE_ID_, false);
            initTemplateHtml(DOC_TYPE_ID_, false);
        }

        return count;
    }

    @Override
    public int updateDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, InputStream TEMPLATE_FILE_, String TEMPLATE_FILE_NAME_, Integer TEMPLATE_FILE_LENGTH_, String TEMPLATE_INDEX_, String USING_TEMPLATE_PLACEHOLDERS_, String PROC_DEF_CODE_, String DESC_, Integer ORDER_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_DOC_TYPE set DOC_TYPE_ID_ = :DOC_TYPE_ID_";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        if (TEMPLATE_FILE_LENGTH_ != 0) {// 更新文件
            sql += ", TEMPLATE_FILE_ = :TEMPLATE_FILE_, TEMPLATE_FILE_NAME_ = :TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_ = :TEMPLATE_FILE_LENGTH_";
            parameterSource.addValue("TEMPLATE_FILE_", new SqlLobValue(TEMPLATE_FILE_, TEMPLATE_FILE_LENGTH_, new DefaultLobHandler()), Types.BLOB);
            parameterSource.addValue("TEMPLATE_FILE_NAME_", TEMPLATE_FILE_NAME_, Types.VARCHAR);
            parameterSource.addValue("TEMPLATE_FILE_LENGTH_", TEMPLATE_FILE_LENGTH_, Types.INTEGER);
        }
        sql += ", DOC_TYPE_NAME_ = :DOC_TYPE_NAME_, TEMPLATE_INDEX_ = :TEMPLATE_INDEX_, USING_TEMPLATE_PLACEHOLDERS_ = :USING_TEMPLATE_PLACEHOLDERS_, PROC_DEF_CODE_ = :PROC_DEF_CODE_, DESC_ = :DESC_, ORDER_ = :ORDER_, UPDATE_DATE_ = :UPDATE_DATE_, OPERATOR_ID_ = :OPERATOR_ID_, OPERATOR_NAME_ = :OPERATOR_NAME_ where DOC_TYPE_ID_ = :DOC_TYPE_ID_";
        parameterSource.addValue("DOC_TYPE_NAME_", DOC_TYPE_NAME_, Types.VARCHAR);
        parameterSource.addValue("TEMPLATE_INDEX_", TEMPLATE_INDEX_, Types.VARCHAR);
        parameterSource.addValue("USING_TEMPLATE_PLACEHOLDERS_", USING_TEMPLATE_PLACEHOLDERS_, Types.VARCHAR);
        parameterSource.addValue("PROC_DEF_CODE_", PROC_DEF_CODE_, Types.VARCHAR);
        parameterSource.addValue("DESC_", DESC_, Types.VARCHAR);
        parameterSource.addValue("ORDER_", ORDER_, Types.INTEGER);
        parameterSource.addValue("UPDATE_DATE_", UPDATE_DATE_, Types.TIMESTAMP);
        parameterSource.addValue("OPERATOR_ID_", OPERATOR_ID_, Types.VARCHAR);
        parameterSource.addValue("OPERATOR_NAME_", OPERATOR_NAME_, Types.VARCHAR);
        parameterSource.addValue("DOC_TYPE_ID_", DOC_TYPE_ID_, Types.VARCHAR);

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        int count = namedParameterJdbcTemplate.update(sql, parameterSource);

        if ("0".equals(USING_TEMPLATE_PLACEHOLDERS_)) {
            initTemplateBookmark(DOC_TYPE_ID_, true);
            initTemplateHtml(DOC_TYPE_ID_, true);
        }
        else {
            initTemplateBookmark(DOC_TYPE_ID_, false);
            initTemplateHtml(DOC_TYPE_ID_, false);
        }

        return count;
    }

    @Override
    public int updateTemplateFile(String DOC_TYPE_ID_, InputStream TEMPLATE_FILE_, String TEMPLATE_FILE_NAME_, Integer TEMPLATE_FILE_LENGTH_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_DOC_TYPE set DOC_TYPE_ID_ = :DOC_TYPE_ID_";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        if (TEMPLATE_FILE_LENGTH_ != 0) {// 更新文件
            sql += ", TEMPLATE_FILE_ = :TEMPLATE_FILE_, TEMPLATE_FILE_NAME_ = :TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_ = :TEMPLATE_FILE_LENGTH_";
            parameterSource.addValue("TEMPLATE_FILE_", new SqlLobValue(TEMPLATE_FILE_, TEMPLATE_FILE_LENGTH_, new DefaultLobHandler()), Types.BLOB);
            parameterSource.addValue("TEMPLATE_FILE_NAME_", TEMPLATE_FILE_NAME_, Types.VARCHAR);
            parameterSource.addValue("TEMPLATE_FILE_LENGTH_", TEMPLATE_FILE_LENGTH_, Types.INTEGER);
        }
        sql += " , UPDATE_DATE_ = :UPDATE_DATE_, OPERATOR_ID_ = :OPERATOR_ID_, OPERATOR_NAME_ = :OPERATOR_NAME_ where DOC_TYPE_ID_ = :DOC_TYPE_ID_";
        parameterSource.addValue("UPDATE_DATE_", UPDATE_DATE_, Types.TIMESTAMP);
        parameterSource.addValue("OPERATOR_ID_", OPERATOR_ID_, Types.VARCHAR);
        parameterSource.addValue("OPERATOR_NAME_", OPERATOR_NAME_, Types.VARCHAR);
        parameterSource.addValue("DOC_TYPE_ID_", DOC_TYPE_ID_, Types.VARCHAR);

        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(msJdbcTemplate);
        int count = namedParameterJdbcTemplate.update(sql, parameterSource);

        if (TEMPLATE_FILE_LENGTH_ == 0) {
            initTemplateBookmark(DOC_TYPE_ID_, true);
            initTemplateHtml(DOC_TYPE_ID_, true);
        }
        else {
            Map<String, Object> docType = loadDocType(DOC_TYPE_ID_);
            if ("0".equals(docType.get("USING_TEMPLATE_PLACEHOLDERS_"))) {
                initTemplateBookmark(DOC_TYPE_ID_, true);
                initTemplateHtml(DOC_TYPE_ID_, true);
            }
            else {
                initTemplateBookmark(DOC_TYPE_ID_, false);
                initTemplateHtml(DOC_TYPE_ID_, false);
            }
        }

        return count;
    }

    @Override
    public int updateTemplateHtml(String DOC_TYPE_ID_, String TEMPLATE_HTML_) {
        String sql = "update K_DOC_TYPE set TEMPLATE_HTML_ = ? where DOC_TYPE_ID_ = ?";
        return msJdbcTemplate.update(sql, TEMPLATE_HTML_, DOC_TYPE_ID_);
    }

    @Override
    public int updateDocTypeOrder(final List<String> DOC_TYPE_ID_LIST, final List<Integer> ORDER_LIST, final Date UPDATE_DATE_, final String OPERATOR_ID_, final String OPERATOR_NAME_) {
        if (DOC_TYPE_ID_LIST == null || DOC_TYPE_ID_LIST.isEmpty()) {
            return 0;
        }
        if (DOC_TYPE_ID_LIST.size() != ORDER_LIST.size()) {
            return 0;
        }

        String sql = "update K_DOC_TYPE set ORDER_ = ?, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where DOC_TYPE_ID_ = ?";
        BatchPreparedStatementSetter batch = new BatchPreparedStatementSetter() {
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                ps.setInt(1, ORDER_LIST.get(i));
                ps.setTimestamp(2, UPDATE_DATE_ == null ? null : new java.sql.Timestamp(UPDATE_DATE_.getTime()));
                ps.setString(3, OPERATOR_ID_);
                ps.setString(4, OPERATOR_NAME_);
                ps.setString(5, DOC_TYPE_ID_LIST.get(i));
            }

            public int getBatchSize() {
                return DOC_TYPE_ID_LIST.size();
            }
        };

        return msJdbcTemplate.batchUpdate(sql, batch).length;
    }

    @Override
    public int disableDocType(String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_DOC_TYPE set DOC_TYPE_STATUS_ = '0', UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where DOC_TYPE_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, DOC_TYPE_ID_);
    }

    @Override
    public int enableDocType(String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_DOC_TYPE set DOC_TYPE_STATUS_ = '1', UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where DOC_TYPE_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, DOC_TYPE_ID_);
    }

    @Override
    public int deleteDocType(String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "delete from K_DOC_TYPE where DOC_TYPE_ID_ = ?";
        return msJdbcTemplate.update(sql, DOC_TYPE_ID_);
    }

    @Override
    public int deleteTemplateFile(String DOC_TYPE_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_) {
        String sql = "update K_DOC_TYPE set TEMPLATE_FILE_ = null, TEMPLATE_FILE_NAME_ = null, TEMPLATE_FILE_LENGTH_ = 0, UPDATE_DATE_ = ?, OPERATOR_ID_ = ?, OPERATOR_NAME_ = ? where DOC_TYPE_ID_ = ?";
        return msJdbcTemplate.update(sql, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, DOC_TYPE_ID_);
    }

    private int initTemplateBookmark(String DOC_TYPE_ID_, boolean removeOnly) {
        String sql = "update K_DOC_TYPE set TEMPLATE_BOOKMARK_ = null where DOC_TYPE_ID_ = ?";
        if (removeOnly) {
            return msJdbcTemplate.update(sql, DOC_TYPE_ID_);
        }

        InputStream inputStream = loadTemplateFile(DOC_TYPE_ID_);
        if (inputStream == null) {
            return msJdbcTemplate.update(sql, DOC_TYPE_ID_);
        }

        List<TemplateBookmark> templateBookmarkList = new ArrayList<>();

        XWPFDocument document;
        try {
            document = new XWPFDocument(inputStream);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        List<XWPFParagraph> paragraphList = new ArrayList<>();
        paragraphList.addAll(document.getParagraphs());
        for (XWPFTable table : document.getTables()) {
            for (XWPFTableRow row : table.getRows()) {
                for (XWPFTableCell cell : row.getTableCells()) {
                    paragraphList.addAll(cell.getParagraphs());
                }
            }
        }

        Pattern pattern = Pattern.compile("\\$\\{.*?\\}");
        Matcher matcher;
        String text;
        String bookmark;
        String defaultValueRef;
        String dataType;
        String[] splits;
        Integer inputWidth;
        for (XWPFParagraph paragraph : paragraphList) {
            text = paragraph.getText();
            if (StringUtils.isEmpty(text)) {
                continue;
            }
            matcher = pattern.matcher(text);
            while (matcher.find()) {
                bookmark = text.substring(matcher.start() + 2, matcher.end() - 1);
                defaultValueRef = null;
                dataType = TemplateBookmark.DATA_TYPE_TEXT;
                inputWidth = 60;
                if (bookmark.contains(":")) {
                    splits = bookmark.split(":");
                    bookmark = splits[0];
                    defaultValueRef = splits[1];
                    if (splits.length == 3) {
                        dataType = splits[2];
                    }
                    if (splits.length == 4) {
                        inputWidth = Integer.parseInt(splits[3]);
                    }
                }

                if (!contains(templateBookmarkList, bookmark)) {
                    templateBookmarkList.add(new TemplateBookmark(bookmark, defaultValueRef, dataType, templateBookmarkList.size(), inputWidth));
                }
            }
        }

        try {
            document.close();
            inputStream.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        Map<String, Object> templateBookmarkMap = new HashMap<>();
        templateBookmarkMap.put("templateBookmarkList", templateBookmarkList);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        sql = "update K_DOC_TYPE set TEMPLATE_BOOKMARK_ = ? where DOC_TYPE_ID_ = ?";
        return msJdbcTemplate.update(sql, gson.toJson(templateBookmarkMap), DOC_TYPE_ID_);
    }

    private boolean contains(List<TemplateBookmark> templateBookmarkList, String bookmark) {
        for (TemplateBookmark _templateBookmark : templateBookmarkList) {
            if (_templateBookmark.getBookmark().equals(bookmark)) {
                return true;
            }
        }

        return false;
    }

    private int initTemplateHtml(String DOC_TYPE_ID_, boolean removeOnly) {
        String sql = "update K_DOC_TYPE set TEMPLATE_HTML_ = null where DOC_TYPE_ID_ = ?";
        if (removeOnly) {
            return msJdbcTemplate.update(sql, DOC_TYPE_ID_);
        }

        InputStream inputStream = loadTemplateFile(DOC_TYPE_ID_);
        if (inputStream == null) {
            return msJdbcTemplate.update(sql, DOC_TYPE_ID_);
        }

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            Document doc = new Document(inputStream);
            HtmlSaveOptions options = new HtmlSaveOptions(SaveFormat.HTML);// 带图片转换
            options.setExportImagesAsBase64(true);// 图片全部转为base64编码
            options.setSaveFormat(SaveFormat.HTML);
            doc.save(baos, options);

            inputStream.close();
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }

        sql = "update K_DOC_TYPE set TEMPLATE_HTML_ = ? where DOC_TYPE_ID_ = ?";
        try {
            return msJdbcTemplate.update(sql, baos.toString("UTF-8"), DOC_TYPE_ID_);
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}