package com.opendynamic;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class OdConfig {
    private static Properties properties;

    static {
        try {
            properties = new Properties();
            InputStream inputStream = OdConfig.class.getResource("/config.properties").openStream();
            properties.load(inputStream);
            inputStream.close();
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取服务地址
     * 
     * @return
     */
    public static String getServer() {
        return properties.getProperty("server");
    }

    /**
     * 获取上传文件大小限制
     * 
     * @return
     */
    public static long getMaxUploadSize() {
        return Long.valueOf(properties.getProperty("maxUploadSize"));
    }

    /**
     * 获取组织架构套ID
     * 
     * @return
     */
    public static String getOrgnSetId() {
        return properties.getProperty("orgnSetId");
    }

    /**
     * 获取组织架构套编码
     * 
     * @return
     */
    public static String getOrgnSetCode() {
        return properties.getProperty("orgnSetCode");
    }

    /**
     * 获取默认css链接
     * 
     * @return
     */
    public static String getDefaultCssHref() {
        return properties.getProperty("defaultCssHref");
    }
}