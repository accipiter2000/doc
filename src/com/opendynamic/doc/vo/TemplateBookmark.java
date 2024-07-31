package com.opendynamic.doc.vo;

import java.io.Serializable;

public class TemplateBookmark implements Serializable {
    private static final long serialVersionUID = 1L;

    public final static String DATA_TYPE_TEXT = "TEXT";
    public final static String DATA_TYPE_LONGTEXT = "LONGTEXT";
    public final static String DATA_TYPE_INTEGER = "INTEGER";
    public final static String DATA_TYPE_NUMBER = "NUMBER";
    public final static String DATA_TYPE_TIMESTAMP = "TIMESTAMP";

    private String bookmark;
    private String defalutValueRef;
    private String dataType;
    private Integer order;
    private Integer inputWidth;

    public TemplateBookmark(String bookmark, String defalutValueRef, String dataType, Integer order, Integer inputWidth) {
        super();
        this.bookmark = bookmark;
        this.defalutValueRef = defalutValueRef;
        this.dataType = dataType;
        this.order = order;
        this.inputWidth = inputWidth;
    }

    public String getBookmark() {
        return bookmark;
    }

    public void setBookmark(String bookmark) {
        this.bookmark = bookmark;
    }

    public String getDefalutValueRef() {
        return defalutValueRef;
    }

    public void setDefalutValueRef(String defalutValueRef) {
        this.defalutValueRef = defalutValueRef;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public Integer getOrder() {
        return order;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }

    public Integer getInputWidth() {
        return inputWidth;
    }

    public void setInputWidth(Integer inputWidth) {
        this.inputWidth = inputWidth;
    }
}
