package com.opendynamic.k.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Map;

public class Doc implements Serializable {
    private static final long serialVersionUID = 1L;

    private String docId; // 公文ID
    private String docCode; // 公文编码
    private String docName; // 公文名称
    private String docTypeName; // 公文类型名称
    private String ownerId; // 所有人ID
    private String ownerName; // 所有人名称
    private String ownerOrgId; // 所有机构ID
    private String ownerOrgName; // 所有机构名称
    private String memo; // 备注
    private String templateFileName; // 模版文件名称
    private Integer templateFileLength; // 模版文件长度
    private String docFileName; // 公文文件名称
    private Integer docFileLength; // 公文文件长度
    private String bookmark; // 标签
    private String index; // 定位
    private String usingTemplate; // 使用模板生成
    private String procDefCode; // 流程定义编码
    private String procId; // 流程ID
    private String procStatus; // 流程状态(0草稿/1审批中/8审批驳回/9审批通过)
    private Integer version; // 版本
    private String docStatus; // 公文状态(1生效/0废弃)
    private Date creationDate; // 创建日期
    private Date updateDate; // 更新日期
    private Date effectiveDate; // 生效日期
    private String operatorId; // 操作人员ID
    private String operatorName; // 操作人员名称

    public Doc() {
    }

    /**
     * 通过数据库记录构造。
     * 
     * @param data
     */
    public Doc(Map<String, Object> data) {
        this.docId = (String) data.get("DOC_ID_ ");
        this.docCode = (String) data.get("DOC_CODE_ ");
        this.docName = (String) data.get("DOC_NAME_ ");
        this.docTypeName = (String) data.get("DOC_TYPE_NAME_ ");
        this.ownerId = (String) data.get("OWNER_ID_ ");
        this.ownerName = (String) data.get("OWNER_NAME_ ");
        this.ownerOrgId = (String) data.get("OWNER_ORG_ID_ ");
        this.ownerOrgName = (String) data.get("OWNER_ORG_NAME_ ");
        this.memo = (String) data.get("MEMO_ ");
        this.templateFileName = (String) data.get("TEMPLATE_FILE_NAME_ ");
        this.templateFileLength = (data.get("TEMPLATE_FILE_LENGTH_") != null) ? (((BigDecimal) data.get("TEMPLATE_FILE_LENGTH_")).intValue()) : null;
        this.docFileName = (String) data.get("DOC_FILE_NAME_ ");
        this.docFileLength = (data.get("DOC_FILE_LENGTH_") != null) ? (((BigDecimal) data.get("DOC_FILE_LENGTH_")).intValue()) : null;
        this.bookmark = (String) data.get("BOOKMARK_ ");
        this.index = (String) data.get("INDEX_ ");
        this.usingTemplate = (String) data.get("USING_TEMPLATE_ ");
        this.procDefCode = (String) data.get("PROC_DEF_CODE_ ");
        this.procId = (String) data.get("PROC_ID_ ");
        this.procStatus = (String) data.get("PROC_STATUS_ ");
        this.version = (data.get("VERSION_") != null) ? (((BigDecimal) data.get("VERSION_")).intValue()) : null;
        this.docStatus = (String) data.get("DOC_STATUS_ ");
        this.creationDate = (Date) data.get("CREATION_DATE_ ");
        this.updateDate = (Date) data.get("UPDATE_DATE_ ");
        this.effectiveDate = (Date) data.get("EFFECTIVE_DATE_ ");
        this.operatorId = (String) data.get("OPERATOR_ID_ ");
        this.operatorName = (String) data.get("OPERATOR_NAME_");
    }

    public String getDocId() {
        return docId;
    }

    public void setDocId(String docId) {
        this.docId = docId;
    }

    public String getDocCode() {
        return docCode;
    }

    public void setDocCode(String docCode) {
        this.docCode = docCode;
    }

    public String getDocName() {
        return docName;
    }

    public void setDocName(String docName) {
        this.docName = docName;
    }

    public String getDocTypeName() {
        return docTypeName;
    }

    public void setDocTypeName(String docTypeName) {
        this.docTypeName = docTypeName;
    }

    public String getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getOwnerOrgId() {
        return ownerOrgId;
    }

    public void setOwnerOrgId(String ownerOrgId) {
        this.ownerOrgId = ownerOrgId;
    }

    public String getOwnerOrgName() {
        return ownerOrgName;
    }

    public void setOwnerOrgName(String ownerOrgName) {
        this.ownerOrgName = ownerOrgName;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getTemplateFileName() {
        return templateFileName;
    }

    public void setTemplateFileName(String templateFileName) {
        this.templateFileName = templateFileName;
    }

    public Integer getTemplateFileLength() {
        return templateFileLength;
    }

    public void setTemplateFileLength(Integer templateFileLength) {
        this.templateFileLength = templateFileLength;
    }

    public String getDocFileName() {
        return docFileName;
    }

    public void setDocFileName(String docFileName) {
        this.docFileName = docFileName;
    }

    public Integer getDocFileLength() {
        return docFileLength;
    }

    public void setDocFileLength(Integer docFileLength) {
        this.docFileLength = docFileLength;
    }

    public String getBookmark() {
        return bookmark;
    }

    public void setBookmark(String bookmark) {
        this.bookmark = bookmark;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    public String getUsingTemplate() {
        return usingTemplate;
    }

    public void setUsingTemplate(String usingTemplate) {
        this.usingTemplate = usingTemplate;
    }

    public String getProcDefCode() {
        return procDefCode;
    }

    public void setProcDefCode(String procDefCode) {
        this.procDefCode = procDefCode;
    }

    public String getProcId() {
        return procId;
    }

    public void setProcId(String procId) {
        this.procId = procId;
    }

    public String getProcStatus() {
        return procStatus;
    }

    public void setProcStatus(String procStatus) {
        this.procStatus = procStatus;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public String getDocStatus() {
        return docStatus;
    }

    public void setDocStatus(String docStatus) {
        this.docStatus = docStatus;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Date getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    public String getOperatorId() {
        return operatorId;
    }

    public void setOperatorId(String operatorId) {
        this.operatorId = operatorId;
    }

    public String getOperatorName() {
        return operatorName;
    }

    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }
}