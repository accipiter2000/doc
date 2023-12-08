package com.opendynamic;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@Documented
public @interface OdControllerWrapper {
    boolean loginRequired() default false;// 是否需要检查登录

    boolean accessRequired() default false;// 是否需要检查访问权限

    String logCategory() default "";// 日志分类

    String businessKeyParameterName() default "";// 业务主键所在的入参变量名称

    boolean businessKeyInitRequired() default false;// 业务主键所在的入参变量是否需要初始化

    String logger() default "";// 日志服务名称
}