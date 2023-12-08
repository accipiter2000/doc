package com.opendynamic.k.query;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.opendynamic.k.service.DocService;
import com.opendynamic.k.vo.Doc;

@Service
public class DocQuery {
    private DocService docService;

    private String docId;
    private List<String> docIdList;
    private String docCode;
    private List<String> docCodeList;
    private String docName;
    private List<String> docNameList;
    private String docTypeName;
    private List<String> docTypeNameList;
    private String ownerId;
    private List<String> ownerIdList;
    private String ownerName;
    private List<String> ownerNameList;
    private String ownerOrgId;
    private List<String> ownerOrgIdList;
    private String ownerOrgName;
    private List<String> ownerOrgNameList;
    private String usingTemplate;
    private List<String> usingTemplateList;
    private String procDefCode;
    private List<String> procDefCodeList;
    private String procId;
    private List<String> procIdList;
    private String procStatus;
    private List<String> procStatusList;
    private String docStatus;
    private List<String> docStatusList;
    private Date fromCreationDate;
    private Date toCreationDate;
    private Date fromEffectiveDate;
    private Date toEffectiveDate;
    private Integer page;
    private Integer limit;

    public DocQuery(DocService docService) {
        super();
        this.docService = docService;
    }

    public DocQuery setDocService(DocService docService) {
        this.docService = docService;
        return this;
    }

    public DocQuery setDocId(String docId) {
        this.docId = docId;
        return this;
    }

    public DocQuery setDocIdList(List<String> docIdList) {
        this.docIdList = docIdList;
        return this;
    }

    public DocQuery setDocCode(String docCode) {
        this.docCode = docCode;
        return this;
    }

    public DocQuery setDocCodeList(List<String> docCodeList) {
        this.docCodeList = docCodeList;
        return this;
    }

    public DocQuery setDocName(String docName) {
        this.docName = docName;
        return this;
    }

    public DocQuery setDocNameList(List<String> docNameList) {
        this.docNameList = docNameList;
        return this;
    }

    public DocQuery setDocTypeName(String docTypeName) {
        this.docTypeName = docTypeName;
        return this;
    }

    public DocQuery setDocTypeNameList(List<String> docTypeNameList) {
        this.docTypeNameList = docTypeNameList;
        return this;
    }

    public DocQuery setOwnerId(String ownerId) {
        this.ownerId = ownerId;
        return this;
    }

    public DocQuery setOwnerIdList(List<String> ownerIdList) {
        this.ownerIdList = ownerIdList;
        return this;
    }

    public DocQuery setOwnerName(String ownerName) {
        this.ownerName = ownerName;
        return this;
    }

    public DocQuery setOwnerNameList(List<String> ownerNameList) {
        this.ownerNameList = ownerNameList;
        return this;
    }

    public DocQuery setOwnerOrgId(String ownerOrgId) {
        this.ownerOrgId = ownerOrgId;
        return this;
    }

    public DocQuery setOwnerOrgIdList(List<String> ownerOrgIdList) {
        this.ownerOrgIdList = ownerOrgIdList;
        return this;
    }

    public DocQuery setOwnerOrgName(String ownerOrgName) {
        this.ownerOrgName = ownerOrgName;
        return this;
    }

    public DocQuery setOwnerOrgNameList(List<String> ownerOrgNameList) {
        this.ownerOrgNameList = ownerOrgNameList;
        return this;
    }

    public DocQuery setUsingTemplate(String usingTemplate) {
        this.usingTemplate = usingTemplate;
        return this;
    }

    public DocQuery setUsingTemplateList(List<String> usingTemplateList) {
        this.usingTemplateList = usingTemplateList;
        return this;
    }

    public DocQuery setProcDefCode(String procDefCode) {
        this.procDefCode = procDefCode;
        return this;
    }

    public DocQuery setProcDefCodeList(List<String> procDefCodeList) {
        this.procDefCodeList = procDefCodeList;
        return this;
    }

    public DocQuery setProcId(String procId) {
        this.procId = procId;
        return this;
    }

    public DocQuery setProcIdList(List<String> procIdList) {
        this.procIdList = procIdList;
        return this;
    }

    public DocQuery setProcStatus(String procStatus) {
        this.procStatus = procStatus;
        return this;
    }

    public DocQuery setProcStatusList(List<String> procStatusList) {
        this.procStatusList = procStatusList;
        return this;
    }

    public DocQuery setDocStatus(String docStatus) {
        this.docStatus = docStatus;
        return this;
    }

    public DocQuery setDocStatusList(List<String> docStatusList) {
        this.docStatusList = docStatusList;
        return this;
    }

    public DocQuery setFromCreationDate(Date fromCreationDate) {
        this.fromCreationDate = fromCreationDate;
        return this;
    }

    public DocQuery setToCreationDate(Date toCreationDate) {
        this.toCreationDate = toCreationDate;
        return this;
    }

    public DocQuery setFromEffectiveDate(Date fromEffectiveDate) {
        this.fromEffectiveDate = fromEffectiveDate;
        return this;
    }

    public DocQuery setToEffectiveDate(Date toEffectiveDate) {
        this.toEffectiveDate = toEffectiveDate;
        return this;
    }

    public DocQuery setPage(Integer page) {
        this.page = page;
        return this;
    }

    public DocQuery setLimit(Integer limit) {
        this.limit = limit;
        return this;
    }

    /**
     * 查询对象列表。对象格式为Map。
     * 
     * @return
     */
    public List<Map<String, Object>> queryForMapList() {
        return docService.selectDoc(docId, docIdList, docCode, docCodeList, docName, docNameList, docTypeName, docTypeNameList, ownerId, ownerIdList, ownerName, ownerNameList, ownerOrgId, ownerOrgIdList, ownerOrgName, ownerOrgNameList, usingTemplate, usingTemplateList, procDefCode, procDefCodeList, procId, procIdList, procStatus, procStatusList, docStatus, docStatusList, fromCreationDate, toCreationDate, fromEffectiveDate, toEffectiveDate, page, limit);
    }

    /**
     * 查询单个对象。对象格式为Map。
     * 
     * @return
     */
    public Map<String, Object> queryForMap() {
        List<Map<String, Object>> result = queryForMapList();
        if (result.size() == 1) {
            return result.get(0);
        }
        else {
            return null;
        }
    }

    /**
     * 查询对象列表。对象格式为实体Bean。
     * 
     * @return
     */
    public List<Doc> queryForObjectList() {
        List<Map<String, Object>> result = queryForMapList();
        List<Doc> docList = new ArrayList<>();
        for (int i = 0; i < result.size(); i++) {
            docList.add(new Doc(result.get(i)));
        }

        return docList;
    }

    /**
     * 查询单个对象。对象格式为实体Bean。
     * 
     * @return
     */
    public Doc queryForObject() {
        List<Map<String, Object>> result = queryForMapList();
        if (result.size() == 1) {
            return new Doc(result.get(0));
        }
        else {
            return null;
        }
    }

    /**
     * 查询总数。
     * 
     * @return
     */
    public int count() {
        return docService.countDoc(docId, docIdList, docCode, docCodeList, docName, docNameList, docTypeName, docTypeNameList, ownerId, ownerIdList, ownerName, ownerNameList, ownerOrgId, ownerOrgIdList, ownerOrgName, ownerOrgNameList, usingTemplate, usingTemplateList, procDefCode, procDefCodeList, procId, procIdList, procStatus, procStatusList, docStatus, docStatusList, fromCreationDate, toCreationDate, fromEffectiveDate, toEffectiveDate);
    }
}