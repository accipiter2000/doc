-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 10.18.26.90    Database: DOC
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `CBV_CODE`
--

DROP TABLE IF EXISTS `CBV_CODE`;
/*!50001 DROP VIEW IF EXISTS `CBV_CODE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_CODE` AS SELECT 
 1 AS `CODE_ID_`,
 1 AS `PARENT_CODE_ID_`,
 1 AS `CATEGORY_`,
 1 AS `CODE_`,
 1 AS `NAME_`,
 1 AS `EXT_ATTR_1_`,
 1 AS `EXT_ATTR_2_`,
 1 AS `EXT_ATTR_3_`,
 1 AS `EXT_ATTR_4_`,
 1 AS `EXT_ATTR_5_`,
 1 AS `EXT_ATTR_6_`,
 1 AS `ORDER_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_CUSTOM_THEME`
--

DROP TABLE IF EXISTS `CBV_CUSTOM_THEME`;
/*!50001 DROP VIEW IF EXISTS `CBV_CUSTOM_THEME`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_CUSTOM_THEME` AS SELECT 
 1 AS `CUSTOM_THEME_ID_`,
 1 AS `OPERATOR_ID_`,
 1 AS `CSS_HREF_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_DASHBOARD`
--

DROP TABLE IF EXISTS `CBV_DASHBOARD`;
/*!50001 DROP VIEW IF EXISTS `CBV_DASHBOARD`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_DASHBOARD` AS SELECT 
 1 AS `DASHBOARD_ID_`,
 1 AS `DASHBOARD_MODULE_ID_`,
 1 AS `POSI_EMP_ID_`,
 1 AS `DASHBOARD_MODULE_NAME_`,
 1 AS `URL_`,
 1 AS `WIDTH_`,
 1 AS `HEIGHT_`,
 1 AS `ORDER_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_DASHBOARD_MODULE`
--

DROP TABLE IF EXISTS `CBV_DASHBOARD_MODULE`;
/*!50001 DROP VIEW IF EXISTS `CBV_DASHBOARD_MODULE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_DASHBOARD_MODULE` AS SELECT 
 1 AS `DASHBOARD_MODULE_ID_`,
 1 AS `DASHBOARD_MODULE_NAME_`,
 1 AS `DASHBOARD_MODULE_TYPE_`,
 1 AS `DEFAULT_URL_`,
 1 AS `DEFAULT_WIDTH_`,
 1 AS `DEFAULT_HEIGHT_`,
 1 AS `DASHBOARD_MODULE_TAG_`,
 1 AS `ORDER_`,
 1 AS `DASHBOARD_MODULE_STATUS_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_DUTY_MENU`
--

DROP TABLE IF EXISTS `CBV_DUTY_MENU`;
/*!50001 DROP VIEW IF EXISTS `CBV_DUTY_MENU`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_DUTY_MENU` AS SELECT 
 1 AS `DUTY_MENU_ID_`,
 1 AS `DUTY_ID_`,
 1 AS `DUTY_NAME_`,
 1 AS `MENU_ID_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `PARENT_MENU_ID_`,
 1 AS `MENU_NAME_`,
 1 AS `MENU_TYPE_`,
 1 AS `URL_`,
 1 AS `ORDER_`,
 1 AS `MENU_STATUS_`,
 1 AS `ICON_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_LOG`
--

DROP TABLE IF EXISTS `CBV_LOG`;
/*!50001 DROP VIEW IF EXISTS `CBV_LOG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_LOG` AS SELECT 
 1 AS `LOG_ID_`,
 1 AS `CATEGORY_`,
 1 AS `IP_`,
 1 AS `USER_AGENT_`,
 1 AS `URL_`,
 1 AS `ACTION_`,
 1 AS `PARAMETER_MAP_`,
 1 AS `BUSINESS_KEY_`,
 1 AS `ERROR_`,
 1 AS `MESSAGE_`,
 1 AS `ORG_ID_`,
 1 AS `ORG_NAME_`,
 1 AS `POSI_ID_`,
 1 AS `POSI_NAME_`,
 1 AS `EMP_ID_`,
 1 AS `EMP_NAME_`,
 1 AS `CREATION_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_MENU`
--

DROP TABLE IF EXISTS `CBV_MENU`;
/*!50001 DROP VIEW IF EXISTS `CBV_MENU`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_MENU` AS SELECT 
 1 AS `MENU_ID_`,
 1 AS `PARENT_MENU_ID_`,
 1 AS `MENU_NAME_`,
 1 AS `MENU_TYPE_`,
 1 AS `URL_`,
 1 AS `ORDER_`,
 1 AS `MENU_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `ICON_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_NOTICE`
--

DROP TABLE IF EXISTS `CBV_NOTICE`;
/*!50001 DROP VIEW IF EXISTS `CBV_NOTICE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_NOTICE` AS SELECT 
 1 AS `NOTICE_ID_`,
 1 AS `POSI_EMP_ID_`,
 1 AS `EMP_ID_`,
 1 AS `EMP_CODE_`,
 1 AS `EMP_NAME_`,
 1 AS `CONTENT_`,
 1 AS `SOURCE_`,
 1 AS `IDENTITY_`,
 1 AS `REDIRECT_URL_`,
 1 AS `BIZ_URL_`,
 1 AS `EXP_DATE_`,
 1 AS `NOTICE_STATUS_`,
 1 AS `CREATION_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_POSI_EMP_MENU`
--

DROP TABLE IF EXISTS `CBV_POSI_EMP_MENU`;
/*!50001 DROP VIEW IF EXISTS `CBV_POSI_EMP_MENU`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_POSI_EMP_MENU` AS SELECT 
 1 AS `POSI_EMP_MENU_ID_`,
 1 AS `POSI_EMP_ID_`,
 1 AS `POSI_NAME_`,
 1 AS `EMP_NAME_`,
 1 AS `MENU_ID_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `PARENT_MENU_ID_`,
 1 AS `MENU_NAME_`,
 1 AS `MENU_TYPE_`,
 1 AS `URL_`,
 1 AS `ORDER_`,
 1 AS `MENU_STATUS_`,
 1 AS `ICON_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_POSI_MENU`
--

DROP TABLE IF EXISTS `CBV_POSI_MENU`;
/*!50001 DROP VIEW IF EXISTS `CBV_POSI_MENU`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_POSI_MENU` AS SELECT 
 1 AS `POSI_MENU_ID_`,
 1 AS `POSI_ID_`,
 1 AS `POSI_NAME_`,
 1 AS `MENU_ID_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `PARENT_MENU_ID_`,
 1 AS `MENU_NAME_`,
 1 AS `MENU_TYPE_`,
 1 AS `URL_`,
 1 AS `ORDER_`,
 1 AS `MENU_STATUS_`,
 1 AS `ICON_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_RIDER`
--

DROP TABLE IF EXISTS `CBV_RIDER`;
/*!50001 DROP VIEW IF EXISTS `CBV_RIDER`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_RIDER` AS SELECT 
 1 AS `RIDER_ID_`,
 1 AS `OBJ_ID_`,
 1 AS `RIDER_FILE_NAME_`,
 1 AS `RIDER_FILE_LENGTH_`,
 1 AS `MEMO_`,
 1 AS `RIDER_TAG_`,
 1 AS `ORDER_`,
 1 AS `RIDER_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_TAG`
--

DROP TABLE IF EXISTS `CBV_TAG`;
/*!50001 DROP VIEW IF EXISTS `CBV_TAG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_TAG` AS SELECT 
 1 AS `TAG_ID_`,
 1 AS `OBJ_ID_`,
 1 AS `OBJ_TYPE_`,
 1 AS `TAG_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CBV_WORKING_CALENDAR`
--

DROP TABLE IF EXISTS `CBV_WORKING_CALENDAR`;
/*!50001 DROP VIEW IF EXISTS `CBV_WORKING_CALENDAR`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CBV_WORKING_CALENDAR` AS SELECT 
 1 AS `WORKING_CALENDAR_ID_`,
 1 AS `EMP_ID_`,
 1 AS `DATE_`,
 1 AS `WORKING_DAY_`,
 1 AS `MARK_`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `CB_CODE`
--

DROP TABLE IF EXISTS `CB_CODE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_CODE` (
  `CODE_ID_` varchar(40) NOT NULL COMMENT '代码ID',
  `PARENT_CODE_ID_` varchar(40) DEFAULT NULL COMMENT '上级代码ID',
  `CATEGORY_` varchar(40) NOT NULL COMMENT '分类',
  `CODE_` varchar(60) NOT NULL COMMENT '代码',
  `NAME_` varchar(60) DEFAULT NULL COMMENT '名称',
  `EXT_ATTR_1_` varchar(60) DEFAULT NULL COMMENT '扩展属性1',
  `EXT_ATTR_2_` varchar(60) DEFAULT NULL COMMENT '扩展属性2',
  `EXT_ATTR_3_` varchar(60) DEFAULT NULL COMMENT '扩展属性3',
  `EXT_ATTR_4_` varchar(60) DEFAULT NULL COMMENT '扩展属性4',
  `EXT_ATTR_5_` varchar(60) DEFAULT NULL COMMENT '扩展属性5',
  `EXT_ATTR_6_` varchar(60) DEFAULT NULL COMMENT '扩展属性6',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`CODE_ID_`),
  KEY `UQ_CODE` (`CATEGORY_`,`CODE_`),
  KEY `FK_CODE` (`PARENT_CODE_ID_`),
  CONSTRAINT `FK_CODE` FOREIGN KEY (`PARENT_CODE_ID_`) REFERENCES `CB_CODE` (`CODE_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_CODE`
--

LOCK TABLES `CB_CODE` WRITE;
/*!40000 ALTER TABLE `CB_CODE` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_CODE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_CUSTOM_THEME`
--

DROP TABLE IF EXISTS `CB_CUSTOM_THEME`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_CUSTOM_THEME` (
  `CUSTOM_THEME_ID_` varchar(40) NOT NULL COMMENT '定制主题ID',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `CSS_HREF_` varchar(60) DEFAULT NULL COMMENT 'CSS链接',
  PRIMARY KEY (`CUSTOM_THEME_ID_`),
  KEY `UQ_CUSTOM_THEME` (`OPERATOR_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定制主题';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_CUSTOM_THEME`
--

LOCK TABLES `CB_CUSTOM_THEME` WRITE;
/*!40000 ALTER TABLE `CB_CUSTOM_THEME` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_CUSTOM_THEME` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_DASHBOARD`
--

DROP TABLE IF EXISTS `CB_DASHBOARD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_DASHBOARD` (
  `DASHBOARD_ID_` varchar(40) NOT NULL COMMENT '仪表盘ID',
  `DASHBOARD_MODULE_ID_` varchar(40) NOT NULL COMMENT '仪表盘模块ID',
  `POSI_EMP_ID_` varchar(40) DEFAULT NULL COMMENT '岗位人员ID',
  `DASHBOARD_MODULE_NAME_` varchar(60) NOT NULL COMMENT '仪表盘模块名称',
  `URL_` varchar(300) NOT NULL COMMENT '链接',
  `WIDTH_` varchar(10) NOT NULL COMMENT '宽度',
  `HEIGHT_` varchar(10) NOT NULL COMMENT '高度',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`DASHBOARD_ID_`),
  KEY `FK_DASHBOARD_DASHBOARD_MODULE` (`DASHBOARD_MODULE_ID_`),
  CONSTRAINT `FK_DASHBOARD_DASHBOARD_MODULE` FOREIGN KEY (`DASHBOARD_MODULE_ID_`) REFERENCES `CB_DASHBOARD_MODULE` (`DASHBOARD_MODULE_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='仪表盘';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_DASHBOARD`
--

LOCK TABLES `CB_DASHBOARD` WRITE;
/*!40000 ALTER TABLE `CB_DASHBOARD` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_DASHBOARD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_DASHBOARD_MODULE`
--

DROP TABLE IF EXISTS `CB_DASHBOARD_MODULE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_DASHBOARD_MODULE` (
  `DASHBOARD_MODULE_ID_` varchar(40) NOT NULL COMMENT '仪表盘模块ID',
  `DASHBOARD_MODULE_NAME_` varchar(60) NOT NULL COMMENT '仪表盘模块名称',
  `DASHBOARD_MODULE_TYPE_` varchar(60) DEFAULT NULL COMMENT '仪表盘模块类型',
  `DEFAULT_URL_` varchar(300) NOT NULL COMMENT '默认链接',
  `DEFAULT_WIDTH_` varchar(10) NOT NULL COMMENT '默认宽度',
  `DEFAULT_HEIGHT_` varchar(10) NOT NULL COMMENT '默认高度',
  `DASHBOARD_MODULE_TAG_` varchar(60) DEFAULT NULL COMMENT '仪表盘模块标签',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `DASHBOARD_MODULE_STATUS_` varchar(20) NOT NULL COMMENT '仪表盘模块状态',
  PRIMARY KEY (`DASHBOARD_MODULE_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='仪表盘模块';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_DASHBOARD_MODULE`
--

LOCK TABLES `CB_DASHBOARD_MODULE` WRITE;
/*!40000 ALTER TABLE `CB_DASHBOARD_MODULE` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_DASHBOARD_MODULE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_DUTY_MENU`
--

DROP TABLE IF EXISTS `CB_DUTY_MENU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_DUTY_MENU` (
  `DUTY_MENU_ID_` varchar(40) NOT NULL COMMENT '职务菜单ID',
  `DUTY_ID_` varchar(40) NOT NULL COMMENT '职务ID',
  `DUTY_NAME_` varchar(60) DEFAULT NULL COMMENT '职务名称',
  `MENU_ID_` varchar(40) NOT NULL COMMENT '菜单ID',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`DUTY_MENU_ID_`),
  KEY `UQ_DUTY_MENU` (`DUTY_ID_`,`MENU_ID_`),
  KEY `IX_DUTY_MENU_DUTY` (`DUTY_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='职务菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_DUTY_MENU`
--

LOCK TABLES `CB_DUTY_MENU` WRITE;
/*!40000 ALTER TABLE `CB_DUTY_MENU` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_DUTY_MENU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_LOG`
--

DROP TABLE IF EXISTS `CB_LOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_LOG` (
  `LOG_ID_` varchar(40) NOT NULL COMMENT '日志ID',
  `CATEGORY_` varchar(60) DEFAULT NULL COMMENT '分类',
  `IP_` varchar(60) DEFAULT NULL COMMENT 'IP',
  `URL_` text COMMENT '调用URL',
  `ACTION_` varchar(200) DEFAULT NULL COMMENT '调用控制层接口',
  `PARAMETER_MAP_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '调用参数',
  `BUSINESS_KEY_` varchar(100) DEFAULT NULL COMMENT '业务主键',
  `ERROR_` varchar(20) DEFAULT NULL COMMENT '错误',
  `MESSAGE_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '信息',
  `ORG_ID_` varchar(40) DEFAULT NULL COMMENT '机构ID',
  `ORG_NAME_` varchar(60) DEFAULT NULL COMMENT '机构名称',
  `POSI_ID_` varchar(40) DEFAULT NULL COMMENT '岗位ID',
  `POSI_NAME_` varchar(60) DEFAULT NULL COMMENT '岗位名称',
  `EMP_ID_` varchar(40) DEFAULT NULL COMMENT '人员ID',
  `EMP_NAME_` varchar(60) DEFAULT NULL COMMENT '人员名称',
  `CREATION_DATE_` datetime NOT NULL COMMENT '创建日期',
  `USER_AGENT_` varchar(400) DEFAULT NULL COMMENT '用户代理',
  PRIMARY KEY (`LOG_ID_`),
  KEY `IX_LOG_ACTION` (`ACTION_`),
  KEY `IX_LOG_BUSINESS_KEY` (`BUSINESS_KEY_`),
  KEY `IX_LOG_CREATION_DATE` (`CREATION_DATE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_LOG`
--

LOCK TABLES `CB_LOG` WRITE;
/*!40000 ALTER TABLE `CB_LOG` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_LOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_MENU`
--

DROP TABLE IF EXISTS `CB_MENU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_MENU` (
  `MENU_ID_` varchar(40) NOT NULL COMMENT '菜单ID',
  `PARENT_MENU_ID_` varchar(40) DEFAULT NULL COMMENT '上级菜单ID',
  `MENU_NAME_` varchar(60) NOT NULL COMMENT '菜单名称',
  `MENU_TYPE_` varchar(20) NOT NULL COMMENT '菜单类型',
  `URL_` varchar(200) DEFAULT NULL COMMENT '链接地址',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `MENU_STATUS_` varchar(20) NOT NULL COMMENT '菜单状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  `ICON_` varchar(40) DEFAULT NULL COMMENT '图标地址',
  PRIMARY KEY (`MENU_ID_`),
  KEY `FK_MENU_PARENT` (`PARENT_MENU_ID_`),
  CONSTRAINT `FK_MENU_PARENT` FOREIGN KEY (`PARENT_MENU_ID_`) REFERENCES `CB_MENU` (`MENU_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_MENU`
--

LOCK TABLES `CB_MENU` WRITE;
/*!40000 ALTER TABLE `CB_MENU` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_MENU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_NOTICE`
--

DROP TABLE IF EXISTS `CB_NOTICE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_NOTICE` (
  `NOTICE_ID_` varchar(40) NOT NULL COMMENT '通知ID',
  `POSI_EMP_ID_` varchar(40) DEFAULT NULL COMMENT '岗位人员ID',
  `EMP_ID_` varchar(40) NOT NULL COMMENT '人员ID',
  `EMP_CODE_` varchar(60) DEFAULT NULL COMMENT '人员编码',
  `EMP_NAME_` varchar(60) DEFAULT NULL COMMENT '人员名称',
  `CONTENT_` varchar(600) NOT NULL COMMENT '内容',
  `SOURCE_` varchar(60) DEFAULT NULL COMMENT '来源',
  `IDENTITY_` varchar(40) DEFAULT NULL COMMENT '令牌',
  `REDIRECT_URL_` varchar(200) DEFAULT NULL COMMENT '重定向链接',
  `BIZ_URL_` varchar(500) DEFAULT NULL COMMENT '业务链接',
  `EXP_DATE_` datetime DEFAULT NULL COMMENT '过期日期',
  `NOTICE_STATUS_` varchar(20) NOT NULL COMMENT '通知状态',
  `CREATION_DATE_` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`NOTICE_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_NOTICE`
--

LOCK TABLES `CB_NOTICE` WRITE;
/*!40000 ALTER TABLE `CB_NOTICE` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_NOTICE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_POSI_EMP_MENU`
--

DROP TABLE IF EXISTS `CB_POSI_EMP_MENU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_POSI_EMP_MENU` (
  `POSI_EMP_MENU_ID_` varchar(40) NOT NULL COMMENT '岗位人员菜单ID',
  `POSI_EMP_ID_` varchar(40) NOT NULL COMMENT '岗位人员ID',
  `POSI_NAME_` varchar(60) DEFAULT NULL COMMENT '岗位名称',
  `EMP_NAME_` varchar(60) DEFAULT NULL COMMENT '人员名称',
  `MENU_ID_` varchar(40) NOT NULL COMMENT '菜单ID',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`POSI_EMP_MENU_ID_`),
  KEY `IX_POSI_EMP_MENU_POSI` (`POSI_EMP_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位人员菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_POSI_EMP_MENU`
--

LOCK TABLES `CB_POSI_EMP_MENU` WRITE;
/*!40000 ALTER TABLE `CB_POSI_EMP_MENU` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_POSI_EMP_MENU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_POSI_MENU`
--

DROP TABLE IF EXISTS `CB_POSI_MENU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_POSI_MENU` (
  `POSI_MENU_ID_` varchar(40) NOT NULL COMMENT '岗位菜单ID',
  `POSI_ID_` varchar(40) NOT NULL COMMENT '岗位ID',
  `POSI_NAME_` varchar(60) DEFAULT NULL COMMENT '岗位名称',
  `MENU_ID_` varchar(40) NOT NULL COMMENT '菜单ID',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`POSI_MENU_ID_`),
  KEY `IX_POSI_MENU_POSI` (`POSI_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_POSI_MENU`
--

LOCK TABLES `CB_POSI_MENU` WRITE;
/*!40000 ALTER TABLE `CB_POSI_MENU` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_POSI_MENU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_RIDER`
--

DROP TABLE IF EXISTS `CB_RIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_RIDER` (
  `RIDER_ID_` varchar(40) NOT NULL COMMENT '附件ID',
  `OBJ_ID_` varchar(40) DEFAULT NULL COMMENT '对象ID',
  `RIDER_FILE_` longblob NOT NULL COMMENT '附件文件',
  `RIDER_FILE_NAME_` varchar(300) DEFAULT NULL COMMENT '附件文件名称',
  `RIDER_FILE_LENGTH_` decimal(8,0) DEFAULT NULL COMMENT '附件文件长度',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `RIDER_TAG_` varchar(120) DEFAULT NULL COMMENT '附件标签',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `RIDER_STATUS_` varchar(20) NOT NULL COMMENT '附件状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`RIDER_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='附件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_RIDER`
--

LOCK TABLES `CB_RIDER` WRITE;
/*!40000 ALTER TABLE `CB_RIDER` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_RIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_TAG`
--

DROP TABLE IF EXISTS `CB_TAG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_TAG` (
  `TAG_ID_` varchar(40) NOT NULL COMMENT '标签ID',
  `OBJ_ID_` varchar(40) NOT NULL COMMENT '对象ID',
  `OBJ_TYPE_` varchar(60) DEFAULT NULL COMMENT '对象类型',
  `TAG_` varchar(60) NOT NULL COMMENT '标签',
  PRIMARY KEY (`TAG_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='标签';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_TAG`
--

LOCK TABLES `CB_TAG` WRITE;
/*!40000 ALTER TABLE `CB_TAG` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_TAG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CB_WORKING_CALENDAR`
--

DROP TABLE IF EXISTS `CB_WORKING_CALENDAR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CB_WORKING_CALENDAR` (
  `WORKING_CALENDAR_ID_` varchar(40) NOT NULL COMMENT '工作日历ID',
  `EMP_ID_` varchar(40) DEFAULT NULL COMMENT '人员ID',
  `DATE_` datetime NOT NULL COMMENT '日期',
  `WORKING_DAY_` varchar(20) NOT NULL COMMENT '工作日',
  `MARK_` varchar(300) DEFAULT NULL COMMENT '标注',
  PRIMARY KEY (`WORKING_CALENDAR_ID_`),
  KEY `UQ_WORKING_CALENDAR` (`EMP_ID_`,`DATE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作日历';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CB_WORKING_CALENDAR`
--

LOCK TABLES `CB_WORKING_CALENDAR` WRITE;
/*!40000 ALTER TABLE `CB_WORKING_CALENDAR` DISABLE KEYS */;/*!40000 ALTER TABLE `CB_WORKING_CALENDAR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `FFV_ADJUST_PROC_DEF`
--

DROP TABLE IF EXISTS `FFV_ADJUST_PROC_DEF`;
/*!50001 DROP VIEW IF EXISTS `FFV_ADJUST_PROC_DEF`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_ADJUST_PROC_DEF` AS SELECT 
 1 AS `ADJUST_PROC_DEF_ID_`,
 1 AS `PROC_DEF_ID_`,
 1 AS `PROC_DEF_MODEL_`,
 1 AS `PROC_DEF_DIAGRAM_FILE_`,
 1 AS `PROC_DEF_DIAGRAM_FILE_NAME_`,
 1 AS `PROC_DEF_DIAGRAM_FILE_LENGTH_`,
 1 AS `PROC_DEF_DIAGRAM_WIDTH_`,
 1 AS `PROC_DEF_DIAGRAM_HEIGHT_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_DELEGATE`
--

DROP TABLE IF EXISTS `FFV_DELEGATE`;
/*!50001 DROP VIEW IF EXISTS `FFV_DELEGATE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_DELEGATE` AS SELECT 
 1 AS `DELEGATE_ID_`,
 1 AS `ASSIGNEE_`,
 1 AS `ASSIGNEE_NAME_`,
 1 AS `DELEGATOR_`,
 1 AS `DELEGATOR_NAME_`,
 1 AS `START_DATE_`,
 1 AS `END_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_NODE`
--

DROP TABLE IF EXISTS `FFV_NODE`;
/*!50001 DROP VIEW IF EXISTS `FFV_NODE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_NODE` AS SELECT 
 1 AS `NODE_ID_`,
 1 AS `PARENT_NODE_ID_`,
 1 AS `PROC_ID_`,
 1 AS `PREVIOUS_NODE_IDS_`,
 1 AS `LAST_COMPLETE_NODE_IDS_`,
 1 AS `SUB_PROC_DEF_ID_`,
 1 AS `ADJUST_SUB_PROC_DEF_ID_`,
 1 AS `NODE_TYPE_`,
 1 AS `NODE_CODE_`,
 1 AS `NODE_NAME_`,
 1 AS `PARENT_NODE_CODE_`,
 1 AS `CANDIDATE_ASSIGNEE_`,
 1 AS `COMPLETE_EXPRESSION_`,
 1 AS `COMPLETE_RETURN_`,
 1 AS `EXCLUSIVE_`,
 1 AS `WAITING_FOR_COMPLETE_NODE_`,
 1 AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,
 1 AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,
 1 AS `INFORM_`,
 1 AS `ASSIGNEE_`,
 1 AS `ACTION_`,
 1 AS `DUE_DATE_`,
 1 AS `CLAIM_`,
 1 AS `FORWARDABLE_`,
 1 AS `PRIORITY_`,
 1 AS `NODE_END_USER_`,
 1 AS `NODE_END_USER_NAME_`,
 1 AS `NODE_END_DATE_`,
 1 AS `NEXT_CANDIDATE_`,
 1 AS `ISOLATE_SUB_PROC_DEF_CODE_`,
 1 AS `ISOLATE_SUB_PROC_CANDIDATE_`,
 1 AS `ISOLATE_SUB_PROC_STATUS_`,
 1 AS `NODE_STATUS_`,
 1 AS `CREATION_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_NODE_P`
--

DROP TABLE IF EXISTS `FFV_NODE_P`;
/*!50001 DROP VIEW IF EXISTS `FFV_NODE_P`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_NODE_P` AS SELECT 
 1 AS `NODE_ID_`,
 1 AS `PARENT_NODE_ID_`,
 1 AS `PREVIOUS_NODE_IDS_`,
 1 AS `LAST_COMPLETE_NODE_IDS_`,
 1 AS `SUB_PROC_DEF_ID_`,
 1 AS `ADJUST_SUB_PROC_DEF_ID_`,
 1 AS `NODE_TYPE_`,
 1 AS `NODE_CODE_`,
 1 AS `NODE_NAME_`,
 1 AS `PARENT_NODE_CODE_`,
 1 AS `CANDIDATE_ASSIGNEE_`,
 1 AS `COMPLETE_EXPRESSION_`,
 1 AS `COMPLETE_RETURN_`,
 1 AS `EXCLUSIVE_`,
 1 AS `WAITING_FOR_COMPLETE_NODE_`,
 1 AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,
 1 AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,
 1 AS `INFORM_`,
 1 AS `ASSIGNEE_`,
 1 AS `ACTION_`,
 1 AS `DUE_DATE_`,
 1 AS `CLAIM_`,
 1 AS `FORWARDABLE_`,
 1 AS `PRIORITY_`,
 1 AS `NODE_END_USER_`,
 1 AS `NODE_END_USER_NAME_`,
 1 AS `NODE_END_DATE_`,
 1 AS `NEXT_CANDIDATE_`,
 1 AS `ISOLATE_SUB_PROC_DEF_CODE_`,
 1 AS `ISOLATE_SUB_PROC_CANDIDATE_`,
 1 AS `ISOLATE_SUB_PROC_STATUS_`,
 1 AS `NODE_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `PROC_ID_`,
 1 AS `PROC_DEF_ID_`,
 1 AS `ADJUST_PROC_DEF_ID_`,
 1 AS `ISOLATE_SUB_PROC_NODE_ID_`,
 1 AS `BIZ_ID_`,
 1 AS `BIZ_TYPE_`,
 1 AS `BIZ_CODE_`,
 1 AS `BIZ_NAME_`,
 1 AS `BIZ_DESC_`,
 1 AS `PROC_START_USER_`,
 1 AS `PROC_START_USER_NAME_`,
 1 AS `PROC_END_USER_`,
 1 AS `PROC_END_USER_NAME_`,
 1 AS `PROC_END_DATE_`,
 1 AS `PROC_STATUS_`,
 1 AS `PROC_CREATION_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_NODE_PD`
--

DROP TABLE IF EXISTS `FFV_NODE_PD`;
/*!50001 DROP VIEW IF EXISTS `FFV_NODE_PD`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_NODE_PD` AS SELECT 
 1 AS `NODE_ID_`,
 1 AS `PARENT_NODE_ID_`,
 1 AS `PREVIOUS_NODE_IDS_`,
 1 AS `LAST_COMPLETE_NODE_IDS_`,
 1 AS `SUB_PROC_DEF_ID_`,
 1 AS `ADJUST_SUB_PROC_DEF_ID_`,
 1 AS `NODE_TYPE_`,
 1 AS `NODE_CODE_`,
 1 AS `NODE_NAME_`,
 1 AS `PARENT_NODE_CODE_`,
 1 AS `CANDIDATE_ASSIGNEE_`,
 1 AS `COMPLETE_EXPRESSION_`,
 1 AS `COMPLETE_RETURN_`,
 1 AS `EXCLUSIVE_`,
 1 AS `WAITING_FOR_COMPLETE_NODE_`,
 1 AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,
 1 AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,
 1 AS `INFORM_`,
 1 AS `ASSIGNEE_`,
 1 AS `ACTION_`,
 1 AS `DUE_DATE_`,
 1 AS `CLAIM_`,
 1 AS `FORWARDABLE_`,
 1 AS `PRIORITY_`,
 1 AS `NODE_END_USER_`,
 1 AS `NODE_END_USER_NAME_`,
 1 AS `NODE_END_DATE_`,
 1 AS `NEXT_CANDIDATE_`,
 1 AS `ISOLATE_SUB_PROC_DEF_CODE_`,
 1 AS `ISOLATE_SUB_PROC_CANDIDATE_`,
 1 AS `ISOLATE_SUB_PROC_STATUS_`,
 1 AS `NODE_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `PROC_ID_`,
 1 AS `ADJUST_PROC_DEF_ID_`,
 1 AS `ISOLATE_SUB_PROC_NODE_ID_`,
 1 AS `BIZ_ID_`,
 1 AS `BIZ_TYPE_`,
 1 AS `BIZ_CODE_`,
 1 AS `BIZ_NAME_`,
 1 AS `BIZ_DESC_`,
 1 AS `PROC_START_USER_`,
 1 AS `PROC_START_USER_NAME_`,
 1 AS `PROC_END_USER_`,
 1 AS `PROC_END_USER_NAME_`,
 1 AS `PROC_END_DATE_`,
 1 AS `PROC_STATUS_`,
 1 AS `PROC_CREATION_DATE_`,
 1 AS `PROC_DEF_ID_`,
 1 AS `PROC_DEF_CODE_`,
 1 AS `PROC_DEF_NAME_`,
 1 AS `PROC_DEF_CAT_`,
 1 AS `VERSION_`,
 1 AS `PROC_DEF_STATUS_`,
 1 AS `SUB_PROC_DEF_CODE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_NODE_VAR`
--

DROP TABLE IF EXISTS `FFV_NODE_VAR`;
/*!50001 DROP VIEW IF EXISTS `FFV_NODE_VAR`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_NODE_VAR` AS SELECT 
 1 AS `NODE_VAR_ID_`,
 1 AS `NODE_ID_`,
 1 AS `VAR_TYPE_`,
 1 AS `VAR_NAME_`,
 1 AS `VALUE_`,
 1 AS `OBJ_`,
 1 AS `CREATION_DATE_`,
 1 AS `PARENT_NODE_ID_`,
 1 AS `PROC_ID_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_OPERATION`
--

DROP TABLE IF EXISTS `FFV_OPERATION`;
/*!50001 DROP VIEW IF EXISTS `FFV_OPERATION`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_OPERATION` AS SELECT 
 1 AS `OPERATION_ID_`,
 1 AS `OPERATION_`,
 1 AS `PROC_ID_`,
 1 AS `NODE_ID_`,
 1 AS `TASK_ID_`,
 1 AS `MEMO_`,
 1 AS `OPERATOR_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `OPERATION_DATE_`,
 1 AS `OPERATION_STATUS_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_OPERATION_P`
--

DROP TABLE IF EXISTS `FFV_OPERATION_P`;
/*!50001 DROP VIEW IF EXISTS `FFV_OPERATION_P`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_OPERATION_P` AS SELECT 
 1 AS `OPERATION_ID_`,
 1 AS `OPERATION_`,
 1 AS `NODE_ID_`,
 1 AS `TASK_ID_`,
 1 AS `MEMO_`,
 1 AS `OPERATOR_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `OPERATION_DATE_`,
 1 AS `OPERATION_STATUS_`,
 1 AS `PROC_ID_`,
 1 AS `PROC_DEF_ID_`,
 1 AS `ADJUST_PROC_DEF_ID_`,
 1 AS `ISOLATE_SUB_PROC_NODE_ID_`,
 1 AS `BIZ_ID_`,
 1 AS `BIZ_TYPE_`,
 1 AS `BIZ_CODE_`,
 1 AS `BIZ_NAME_`,
 1 AS `BIZ_DESC_`,
 1 AS `PROC_START_USER_`,
 1 AS `PROC_START_USER_NAME_`,
 1 AS `PROC_END_USER_`,
 1 AS `PROC_END_USER_NAME_`,
 1 AS `PROC_END_DATE_`,
 1 AS `PROC_STATUS_`,
 1 AS `CREATION_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_OPERATION_PD`
--

DROP TABLE IF EXISTS `FFV_OPERATION_PD`;
/*!50001 DROP VIEW IF EXISTS `FFV_OPERATION_PD`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_OPERATION_PD` AS SELECT 
 1 AS `OPERATION_ID_`,
 1 AS `OPERATION_`,
 1 AS `NODE_ID_`,
 1 AS `TASK_ID_`,
 1 AS `MEMO_`,
 1 AS `OPERATOR_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `OPERATION_DATE_`,
 1 AS `OPERATION_STATUS_`,
 1 AS `PROC_ID_`,
 1 AS `ADJUST_PROC_DEF_ID_`,
 1 AS `ISOLATE_SUB_PROC_NODE_ID_`,
 1 AS `BIZ_ID_`,
 1 AS `BIZ_TYPE_`,
 1 AS `BIZ_CODE_`,
 1 AS `BIZ_NAME_`,
 1 AS `BIZ_DESC_`,
 1 AS `PROC_START_USER_`,
 1 AS `PROC_START_USER_NAME_`,
 1 AS `PROC_END_USER_`,
 1 AS `PROC_END_USER_NAME_`,
 1 AS `PROC_END_DATE_`,
 1 AS `PROC_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `PROC_DEF_ID_`,
 1 AS `PROC_DEF_CODE_`,
 1 AS `PROC_DEF_NAME_`,
 1 AS `PROC_DEF_CAT_`,
 1 AS `VERSION_`,
 1 AS `PROC_DEF_STATUS_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_PROC`
--

DROP TABLE IF EXISTS `FFV_PROC`;
/*!50001 DROP VIEW IF EXISTS `FFV_PROC`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_PROC` AS SELECT 
 1 AS `PROC_ID_`,
 1 AS `PROC_DEF_ID_`,
 1 AS `ADJUST_PROC_DEF_ID_`,
 1 AS `ISOLATE_SUB_PROC_NODE_ID_`,
 1 AS `BIZ_ID_`,
 1 AS `BIZ_TYPE_`,
 1 AS `BIZ_CODE_`,
 1 AS `BIZ_NAME_`,
 1 AS `BIZ_DESC_`,
 1 AS `PROC_START_USER_`,
 1 AS `PROC_START_USER_NAME_`,
 1 AS `PROC_END_USER_`,
 1 AS `PROC_END_USER_NAME_`,
 1 AS `PROC_END_DATE_`,
 1 AS `PROC_STATUS_`,
 1 AS `CREATION_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_PROC_DEF`
--

DROP TABLE IF EXISTS `FFV_PROC_DEF`;
/*!50001 DROP VIEW IF EXISTS `FFV_PROC_DEF`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_PROC_DEF` AS SELECT 
 1 AS `PROC_DEF_ID_`,
 1 AS `PROC_DEF_CODE_`,
 1 AS `PROC_DEF_NAME_`,
 1 AS `PROC_DEF_CAT_`,
 1 AS `PROC_DEF_MODEL_`,
 1 AS `PROC_DEF_DIAGRAM_FILE_`,
 1 AS `PROC_DEF_DIAGRAM_FILE_NAME_`,
 1 AS `PROC_DEF_DIAGRAM_FILE_LENGTH_`,
 1 AS `PROC_DEF_DIAGRAM_WIDTH_`,
 1 AS `PROC_DEF_DIAGRAM_HEIGHT_`,
 1 AS `MEMO_`,
 1 AS `EXT_ATTR_1_`,
 1 AS `EXT_ATTR_2_`,
 1 AS `EXT_ATTR_3_`,
 1 AS `EXT_ATTR_4_`,
 1 AS `EXT_ATTR_5_`,
 1 AS `EXT_ATTR_6_`,
 1 AS `EXT_ATTR_7_`,
 1 AS `EXT_ATTR_8_`,
 1 AS `VERSION_`,
 1 AS `PROC_DEF_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_PROC_PD`
--

DROP TABLE IF EXISTS `FFV_PROC_PD`;
/*!50001 DROP VIEW IF EXISTS `FFV_PROC_PD`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_PROC_PD` AS SELECT 
 1 AS `PROC_ID_`,
 1 AS `ADJUST_PROC_DEF_ID_`,
 1 AS `ISOLATE_SUB_PROC_NODE_ID_`,
 1 AS `BIZ_ID_`,
 1 AS `BIZ_TYPE_`,
 1 AS `BIZ_CODE_`,
 1 AS `BIZ_NAME_`,
 1 AS `BIZ_DESC_`,
 1 AS `PROC_START_USER_`,
 1 AS `PROC_START_USER_NAME_`,
 1 AS `PROC_END_USER_`,
 1 AS `PROC_END_USER_NAME_`,
 1 AS `PROC_END_DATE_`,
 1 AS `PROC_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `PROC_DEF_ID_`,
 1 AS `PROC_DEF_CODE_`,
 1 AS `PROC_DEF_NAME_`,
 1 AS `PROC_DEF_CAT_`,
 1 AS `VERSION_`,
 1 AS `PROC_DEF_STATUS_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_TASK`
--

DROP TABLE IF EXISTS `FFV_TASK`;
/*!50001 DROP VIEW IF EXISTS `FFV_TASK`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_TASK` AS SELECT 
 1 AS `TASK_ID_`,
 1 AS `NODE_ID_`,
 1 AS `PREVIOUS_TASK_ID_`,
 1 AS `TASK_TYPE_`,
 1 AS `ASSIGNEE_`,
 1 AS `ASSIGNEE_NAME_`,
 1 AS `ACTION_`,
 1 AS `DUE_DATE_`,
 1 AS `CLAIM_`,
 1 AS `FORWARDABLE_`,
 1 AS `PRIORITY_`,
 1 AS `FORWARD_STATUS_`,
 1 AS `TASK_END_USER_`,
 1 AS `TASK_END_USER_NAME_`,
 1 AS `TASK_END_DATE_`,
 1 AS `NEXT_CANDIDATE_`,
 1 AS `TASK_STATUS_`,
 1 AS `CREATION_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_TASK_N`
--

DROP TABLE IF EXISTS `FFV_TASK_N`;
/*!50001 DROP VIEW IF EXISTS `FFV_TASK_N`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_TASK_N` AS SELECT 
 1 AS `TASK_ID_`,
 1 AS `PREVIOUS_TASK_ID_`,
 1 AS `TASK_TYPE_`,
 1 AS `ASSIGNEE_`,
 1 AS `ASSIGNEE_NAME_`,
 1 AS `ACTION_`,
 1 AS `DUE_DATE_`,
 1 AS `CLAIM_`,
 1 AS `FORWARDABLE_`,
 1 AS `PRIORITY_`,
 1 AS `FORWARD_STATUS_`,
 1 AS `TASK_END_USER_`,
 1 AS `TASK_END_USER_NAME_`,
 1 AS `TASK_END_DATE_`,
 1 AS `NEXT_CANDIDATE_`,
 1 AS `TASK_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `NODE_ID_`,
 1 AS `PARENT_NODE_ID_`,
 1 AS `PROC_ID_`,
 1 AS `PREVIOUS_NODE_IDS_`,
 1 AS `LAST_COMPLETE_NODE_IDS_`,
 1 AS `SUB_PROC_DEF_ID_`,
 1 AS `ADJUST_SUB_PROC_DEF_ID_`,
 1 AS `NODE_TYPE_`,
 1 AS `NODE_CODE_`,
 1 AS `NODE_NAME_`,
 1 AS `PARENT_NODE_CODE_`,
 1 AS `CANDIDATE_ASSIGNEE_`,
 1 AS `COMPLETE_EXPRESSION_`,
 1 AS `COMPLETE_RETURN_`,
 1 AS `EXCLUSIVE_`,
 1 AS `WAITING_FOR_COMPLETE_NODE_`,
 1 AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,
 1 AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,
 1 AS `INFORM_`,
 1 AS `NODE_END_USER_`,
 1 AS `NODE_END_USER_NAME_`,
 1 AS `NODE_END_DATE_`,
 1 AS `ISOLATE_SUB_PROC_DEF_CODE_`,
 1 AS `ISOLATE_SUB_PROC_CANDIDATE_`,
 1 AS `ISOLATE_SUB_PROC_STATUS_`,
 1 AS `NODE_STATUS_`,
 1 AS `NODE_CREATION_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_TASK_P`
--

DROP TABLE IF EXISTS `FFV_TASK_P`;
/*!50001 DROP VIEW IF EXISTS `FFV_TASK_P`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_TASK_P` AS SELECT 
 1 AS `TASK_ID_`,
 1 AS `PREVIOUS_TASK_ID_`,
 1 AS `TASK_TYPE_`,
 1 AS `ASSIGNEE_`,
 1 AS `ASSIGNEE_NAME_`,
 1 AS `ACTION_`,
 1 AS `DUE_DATE_`,
 1 AS `CLAIM_`,
 1 AS `FORWARDABLE_`,
 1 AS `PRIORITY_`,
 1 AS `FORWARD_STATUS_`,
 1 AS `TASK_END_USER_`,
 1 AS `TASK_END_USER_NAME_`,
 1 AS `TASK_END_DATE_`,
 1 AS `NEXT_CANDIDATE_`,
 1 AS `TASK_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `NODE_ID_`,
 1 AS `PARENT_NODE_ID_`,
 1 AS `PREVIOUS_NODE_IDS_`,
 1 AS `LAST_COMPLETE_NODE_IDS_`,
 1 AS `SUB_PROC_DEF_ID_`,
 1 AS `ADJUST_SUB_PROC_DEF_ID_`,
 1 AS `NODE_TYPE_`,
 1 AS `NODE_CODE_`,
 1 AS `NODE_NAME_`,
 1 AS `PARENT_NODE_CODE_`,
 1 AS `CANDIDATE_ASSIGNEE_`,
 1 AS `COMPLETE_EXPRESSION_`,
 1 AS `COMPLETE_RETURN_`,
 1 AS `EXCLUSIVE_`,
 1 AS `WAITING_FOR_COMPLETE_NODE_`,
 1 AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,
 1 AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,
 1 AS `INFORM_`,
 1 AS `NODE_END_USER_`,
 1 AS `NODE_END_USER_NAME_`,
 1 AS `NODE_END_DATE_`,
 1 AS `ISOLATE_SUB_PROC_DEF_CODE_`,
 1 AS `ISOLATE_SUB_PROC_CANDIDATE_`,
 1 AS `ISOLATE_SUB_PROC_STATUS_`,
 1 AS `NODE_STATUS_`,
 1 AS `NODE_CREATION_DATE_`,
 1 AS `PROC_ID_`,
 1 AS `PROC_DEF_ID_`,
 1 AS `ADJUST_PROC_DEF_ID_`,
 1 AS `ISOLATE_SUB_PROC_NODE_ID_`,
 1 AS `BIZ_ID_`,
 1 AS `BIZ_TYPE_`,
 1 AS `BIZ_CODE_`,
 1 AS `BIZ_NAME_`,
 1 AS `BIZ_DESC_`,
 1 AS `PROC_START_USER_`,
 1 AS `PROC_START_USER_NAME_`,
 1 AS `PROC_END_USER_`,
 1 AS `PROC_END_USER_NAME_`,
 1 AS `PROC_END_DATE_`,
 1 AS `PROC_STATUS_`,
 1 AS `PROC_CREATION_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FFV_TASK_PD`
--

DROP TABLE IF EXISTS `FFV_TASK_PD`;
/*!50001 DROP VIEW IF EXISTS `FFV_TASK_PD`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FFV_TASK_PD` AS SELECT 
 1 AS `TASK_ID_`,
 1 AS `PREVIOUS_TASK_ID_`,
 1 AS `TASK_TYPE_`,
 1 AS `ASSIGNEE_`,
 1 AS `ASSIGNEE_NAME_`,
 1 AS `ACTION_`,
 1 AS `DUE_DATE_`,
 1 AS `CLAIM_`,
 1 AS `FORWARDABLE_`,
 1 AS `PRIORITY_`,
 1 AS `FORWARD_STATUS_`,
 1 AS `TASK_END_USER_`,
 1 AS `TASK_END_USER_NAME_`,
 1 AS `TASK_END_DATE_`,
 1 AS `NEXT_CANDIDATE_`,
 1 AS `TASK_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `NODE_ID_`,
 1 AS `PARENT_NODE_ID_`,
 1 AS `PREVIOUS_NODE_IDS_`,
 1 AS `LAST_COMPLETE_NODE_IDS_`,
 1 AS `SUB_PROC_DEF_ID_`,
 1 AS `ADJUST_SUB_PROC_DEF_ID_`,
 1 AS `NODE_TYPE_`,
 1 AS `NODE_CODE_`,
 1 AS `NODE_NAME_`,
 1 AS `PARENT_NODE_CODE_`,
 1 AS `CANDIDATE_ASSIGNEE_`,
 1 AS `COMPLETE_EXPRESSION_`,
 1 AS `COMPLETE_RETURN_`,
 1 AS `EXCLUSIVE_`,
 1 AS `WAITING_FOR_COMPLETE_NODE_`,
 1 AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,
 1 AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,
 1 AS `INFORM_`,
 1 AS `NODE_END_USER_`,
 1 AS `NODE_END_USER_NAME_`,
 1 AS `NODE_END_DATE_`,
 1 AS `ISOLATE_SUB_PROC_DEF_CODE_`,
 1 AS `ISOLATE_SUB_PROC_CANDIDATE_`,
 1 AS `ISOLATE_SUB_PROC_STATUS_`,
 1 AS `NODE_STATUS_`,
 1 AS `NODE_CREATION_DATE_`,
 1 AS `PROC_ID_`,
 1 AS `ADJUST_PROC_DEF_ID_`,
 1 AS `ISOLATE_SUB_PROC_NODE_ID_`,
 1 AS `BIZ_ID_`,
 1 AS `BIZ_TYPE_`,
 1 AS `BIZ_CODE_`,
 1 AS `BIZ_NAME_`,
 1 AS `BIZ_DESC_`,
 1 AS `PROC_START_USER_`,
 1 AS `PROC_START_USER_NAME_`,
 1 AS `PROC_END_USER_`,
 1 AS `PROC_END_USER_NAME_`,
 1 AS `PROC_END_DATE_`,
 1 AS `PROC_STATUS_`,
 1 AS `PROC_CREATION_DATE_`,
 1 AS `PROC_DEF_ID_`,
 1 AS `PROC_DEF_CODE_`,
 1 AS `PROC_DEF_NAME_`,
 1 AS `PROC_DEF_CAT_`,
 1 AS `VERSION_`,
 1 AS `PROC_DEF_STATUS_`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `FF_ADJUST_PROC_DEF`
--

DROP TABLE IF EXISTS `FF_ADJUST_PROC_DEF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_ADJUST_PROC_DEF` (
  `ADJUST_PROC_DEF_ID_` varchar(40) NOT NULL COMMENT '调整流程定义ID',
  `PROC_DEF_ID_` varchar(40) NOT NULL COMMENT '流程定义ID',
  `PROC_DEF_MODEL_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程定义模型',
  `PROC_DEF_DIAGRAM_FILE_` longblob COMMENT '流程定义图文件',
  `PROC_DEF_DIAGRAM_FILE_NAME_` varchar(300) DEFAULT NULL COMMENT '流程定义图文件名称',
  `PROC_DEF_DIAGRAM_FILE_LENGTH_` decimal(8,0) DEFAULT NULL COMMENT '流程定义图文件长度',
  `PROC_DEF_DIAGRAM_WIDTH_` decimal(8,0) DEFAULT NULL COMMENT '流程定义图宽度',
  `PROC_DEF_DIAGRAM_HEIGHT_` decimal(8,0) DEFAULT NULL COMMENT '流程定义图高度',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`ADJUST_PROC_DEF_ID_`),
  KEY `FK_FF_ADJUST_PROC_DEF_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `FK_FF_ADJUST_PROC_DEF_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `FF_PROC_DEF` (`PROC_DEF_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='调整流程定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_ADJUST_PROC_DEF`
--

LOCK TABLES `FF_ADJUST_PROC_DEF` WRITE;
/*!40000 ALTER TABLE `FF_ADJUST_PROC_DEF` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_ADJUST_PROC_DEF` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_DELEGATE`
--

DROP TABLE IF EXISTS `FF_DELEGATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_DELEGATE` (
  `DELEGATE_ID_` varchar(40) NOT NULL COMMENT '代理ID',
  `ASSIGNEE_` varchar(60) DEFAULT NULL COMMENT '办理人',
  `ASSIGNEE_NAME_` varchar(60) DEFAULT NULL COMMENT '办理人名称',
  `DELEGATOR_` varchar(60) NOT NULL COMMENT '代理人',
  `DELEGATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '代理人名称',
  `START_DATE_` datetime DEFAULT NULL COMMENT '开始日期',
  `END_DATE_` datetime DEFAULT NULL COMMENT '结束日期',
  PRIMARY KEY (`DELEGATE_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_DELEGATE`
--

LOCK TABLES `FF_DELEGATE` WRITE;
/*!40000 ALTER TABLE `FF_DELEGATE` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_DELEGATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_NODE`
--

DROP TABLE IF EXISTS `FF_NODE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_NODE` (
  `NODE_ID_` varchar(40) NOT NULL COMMENT '节点ID',
  `PARENT_NODE_ID_` varchar(40) DEFAULT NULL COMMENT '上级节点ID',
  `PROC_ID_` varchar(40) NOT NULL COMMENT '流程ID',
  `PREVIOUS_NODE_IDS_` varchar(280) DEFAULT NULL COMMENT '前节点IDs',
  `LAST_COMPLETE_NODE_IDS_` varchar(280) DEFAULT NULL COMMENT '最后完成节点IDs',
  `SUB_PROC_DEF_ID_` varchar(40) DEFAULT NULL COMMENT '子流程定义ID',
  `ADJUST_SUB_PROC_DEF_ID_` varchar(40) DEFAULT NULL COMMENT '调整子流程定义ID',
  `NODE_TYPE_` varchar(20) NOT NULL COMMENT '节点类型',
  `NODE_CODE_` varchar(60) DEFAULT NULL COMMENT '节点编码',
  `NODE_NAME_` varchar(60) DEFAULT NULL COMMENT '节点名称',
  `PARENT_NODE_CODE_` varchar(100) DEFAULT NULL COMMENT '上级节点编码',
  `CANDIDATE_ASSIGNEE_` varchar(200) DEFAULT NULL COMMENT '候选人',
  `COMPLETE_EXPRESSION_` varchar(200) DEFAULT NULL COMMENT '完成表达式',
  `COMPLETE_RETURN_` varchar(200) DEFAULT NULL COMMENT '完成后返回前一个节点',
  `EXCLUSIVE_` varchar(200) DEFAULT NULL COMMENT '排他',
  `AUTO_COMPLETE_SAME_ASSIGNEE_` varchar(200) DEFAULT NULL COMMENT '自动完成相同办理人任务',
  `AUTO_COMPLETE_EMPTY_ASSIGNEE_` varchar(200) DEFAULT NULL COMMENT '自动完成没有办理人节点',
  `INFORM_` varchar(200) DEFAULT NULL COMMENT '通知',
  `ASSIGNEE_` varchar(200) DEFAULT NULL COMMENT '办理人',
  `ACTION_` varchar(300) DEFAULT NULL COMMENT '业务行为',
  `DUE_DATE_` varchar(200) DEFAULT NULL COMMENT '截止日期',
  `CLAIM_` varchar(200) DEFAULT NULL COMMENT '认领',
  `FORWARDABLE_` varchar(200) DEFAULT NULL COMMENT '可转发',
  `PRIORITY_` varchar(200) DEFAULT NULL COMMENT '优先级',
  `NODE_END_USER_` varchar(40) DEFAULT NULL COMMENT '节点完成人员',
  `NODE_END_USER_NAME_` varchar(60) DEFAULT NULL COMMENT '节点完成人员名称',
  `NODE_END_DATE_` datetime DEFAULT NULL COMMENT '节点完成日期',
  `NEXT_CANDIDATE_` text COMMENT '下个候选人',
  `ISOLATE_SUB_PROC_DEF_CODE_` varchar(60) DEFAULT NULL COMMENT '独立子流程定义编码',
  `ISOLATE_SUB_PROC_CANDIDATE_` varchar(500) DEFAULT NULL COMMENT '独立子流程候选人',
  `ISOLATE_SUB_PROC_STATUS_` varchar(60) DEFAULT NULL COMMENT '独立子流程状态',
  `NODE_STATUS_` varchar(20) NOT NULL COMMENT '节点状态',
  `CREATION_DATE_` datetime NOT NULL COMMENT '创建日期',
  `WAITING_FOR_COMPLETE_NODE_` varchar(200) DEFAULT NULL COMMENT '等待完成节点',
  PRIMARY KEY (`NODE_ID_`),
  KEY `FK_FF_NODE_ADJUST_PROC_DEF` (`ADJUST_SUB_PROC_DEF_ID_`),
  KEY `FK_FF_NODE_PARENT` (`PARENT_NODE_ID_`),
  KEY `FK_FF_NODE_PROC` (`PROC_ID_`),
  KEY `FK_FF_NODE_PROC_DEF` (`SUB_PROC_DEF_ID_`),
  CONSTRAINT `FK_FF_NODE_ADJUST_PROC_DEF` FOREIGN KEY (`ADJUST_SUB_PROC_DEF_ID_`) REFERENCES `FF_ADJUST_PROC_DEF` (`ADJUST_PROC_DEF_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_FF_NODE_PARENT` FOREIGN KEY (`PARENT_NODE_ID_`) REFERENCES `FF_NODE` (`NODE_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_FF_NODE_PROC` FOREIGN KEY (`PROC_ID_`) REFERENCES `FF_PROC` (`PROC_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_FF_NODE_PROC_DEF` FOREIGN KEY (`SUB_PROC_DEF_ID_`) REFERENCES `FF_PROC_DEF` (`PROC_DEF_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='节点';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_NODE`
--

LOCK TABLES `FF_NODE` WRITE;
/*!40000 ALTER TABLE `FF_NODE` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_NODE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_NODE_OP`
--

DROP TABLE IF EXISTS `FF_NODE_OP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_NODE_OP` (
  `NODE_OP_ID_` varchar(40) NOT NULL COMMENT '节点操作ID',
  `OPERATION_ID_` varchar(40) NOT NULL COMMENT '操作ID',
  `OPERATION_TYPE_` varchar(20) NOT NULL COMMENT '操作类型',
  `OPERATION_ORDER_` decimal(8,0) DEFAULT NULL COMMENT '操作顺序',
  `OPERATION_DATE_` datetime DEFAULT NULL COMMENT '操作日期',
  `OPERATION_STATUS_` varchar(20) DEFAULT NULL COMMENT '操作状态',
  `NODE_ID_` varchar(40) NOT NULL COMMENT '节点ID',
  `PARENT_NODE_ID_` varchar(40) DEFAULT NULL COMMENT '上级节点ID',
  `PROC_ID_` varchar(40) DEFAULT NULL COMMENT '流程ID',
  `PREVIOUS_NODE_IDS_` varchar(280) DEFAULT NULL COMMENT '前节点IDs',
  `LAST_COMPLETE_NODE_IDS_` varchar(280) DEFAULT NULL COMMENT '最后完成节点IDs',
  `SUB_PROC_DEF_ID_` varchar(40) DEFAULT NULL COMMENT '子流程定义ID',
  `ADJUST_SUB_PROC_DEF_ID_` varchar(40) DEFAULT NULL COMMENT '调整子流程定义ID',
  `NODE_TYPE_` varchar(20) DEFAULT NULL COMMENT '节点类型',
  `NODE_CODE_` varchar(60) DEFAULT NULL COMMENT '节点编码',
  `NODE_NAME_` varchar(60) DEFAULT NULL COMMENT '节点名称',
  `PARENT_NODE_CODE_` varchar(60) DEFAULT NULL COMMENT '上级节点编码',
  `CANDIDATE_ASSIGNEE_` varchar(200) DEFAULT NULL COMMENT '候选人',
  `COMPLETE_EXPRESSION_` varchar(200) DEFAULT NULL COMMENT '完成表达式',
  `COMPLETE_RETURN_` varchar(200) DEFAULT NULL COMMENT '完成后返回前一个节点',
  `EXCLUSIVE_` varchar(200) DEFAULT NULL COMMENT '排他',
  `AUTO_COMPLETE_SAME_ASSIGNEE_` varchar(200) DEFAULT NULL COMMENT '自动完成相同办理人任务',
  `AUTO_COMPLETE_EMPTY_ASSIGNEE_` varchar(200) DEFAULT NULL COMMENT '自动完成没有办理人节点',
  `INFORM_` varchar(200) DEFAULT NULL COMMENT '通知',
  `ASSIGNEE_` varchar(200) DEFAULT NULL COMMENT '办理人',
  `ACTION_` varchar(200) DEFAULT NULL COMMENT '业务行为',
  `DUE_DATE_` varchar(200) DEFAULT NULL COMMENT '截止日期',
  `CLAIM_` varchar(200) DEFAULT NULL COMMENT '认领',
  `FORWARDABLE_` varchar(200) DEFAULT NULL COMMENT '可转发',
  `PRIORITY_` varchar(200) DEFAULT NULL COMMENT '优先级',
  `NODE_END_USER_` varchar(40) DEFAULT NULL COMMENT '节点完成人员',
  `NODE_END_USER_NAME_` varchar(60) DEFAULT NULL COMMENT '节点完成人员名称',
  `NODE_END_DATE_` datetime DEFAULT NULL COMMENT '节点完成日期',
  `NEXT_CANDIDATE_` text COMMENT '下个候选人',
  `ISOLATE_SUB_PROC_DEF_CODE_` varchar(60) DEFAULT NULL COMMENT '独立子流程定义编码',
  `ISOLATE_SUB_PROC_CANDIDATE_` varchar(500) DEFAULT NULL COMMENT '独立子流程候选人',
  `ISOLATE_SUB_PROC_STATUS_` varchar(60) DEFAULT NULL COMMENT '独立子流程状态',
  `NODE_STATUS_` varchar(20) DEFAULT NULL COMMENT '节点状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `WAITING_FOR_COMPLETE_NODE_` varchar(200) DEFAULT NULL COMMENT '等待完成节点',
  PRIMARY KEY (`NODE_OP_ID_`),
  KEY `FK_FF_NODE_OP_OPERATION` (`OPERATION_ID_`),
  CONSTRAINT `FK_FF_NODE_OP_OPERATION` FOREIGN KEY (`OPERATION_ID_`) REFERENCES `FF_OPERATION` (`OPERATION_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='节点操作';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_NODE_OP`
--

LOCK TABLES `FF_NODE_OP` WRITE;
/*!40000 ALTER TABLE `FF_NODE_OP` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_NODE_OP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_NODE_VAR`
--

DROP TABLE IF EXISTS `FF_NODE_VAR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_NODE_VAR` (
  `NODE_VAR_ID_` varchar(40) NOT NULL COMMENT '节点变量ID',
  `NODE_ID_` varchar(40) NOT NULL COMMENT '节点ID',
  `VAR_TYPE_` varchar(20) NOT NULL COMMENT '变量类型',
  `VAR_NAME_` varchar(60) NOT NULL COMMENT '变量名称',
  `VALUE_` varchar(3000) DEFAULT NULL COMMENT '值',
  `OBJ_` longblob COMMENT '对象',
  `CREATION_DATE_` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`NODE_VAR_ID_`),
  KEY `IX_SUB_PROC_VAR_NAME` (`VAR_NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='节点变量';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_NODE_VAR`
--

LOCK TABLES `FF_NODE_VAR` WRITE;
/*!40000 ALTER TABLE `FF_NODE_VAR` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_NODE_VAR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_NODE_VAR_OP`
--

DROP TABLE IF EXISTS `FF_NODE_VAR_OP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_NODE_VAR_OP` (
  `NODE_VAR_OP_ID_` varchar(40) NOT NULL COMMENT '节点变量操作ID',
  `OPERATION_ID_` varchar(40) NOT NULL COMMENT '操作ID',
  `OPERATION_TYPE_` varchar(20) NOT NULL COMMENT '操作类型',
  `OPERATION_ORDER_` decimal(8,0) DEFAULT NULL COMMENT '操作顺序',
  `OPERATION_DATE_` datetime DEFAULT NULL COMMENT '操作日期',
  `OPERATION_STATUS_` varchar(20) DEFAULT NULL COMMENT '操作状态',
  `NODE_VAR_ID_` varchar(40) NOT NULL COMMENT '节点变量ID',
  `NODE_ID_` varchar(40) DEFAULT NULL COMMENT '节点ID',
  `VAR_TYPE_` varchar(20) DEFAULT NULL COMMENT '变量类型',
  `VAR_NAME_` varchar(60) DEFAULT NULL COMMENT '变量名称',
  `VALUE_` varchar(3000) DEFAULT NULL COMMENT '值',
  `OBJ_` longblob COMMENT '对象',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`NODE_VAR_OP_ID_`),
  KEY `FK_FF_NODE_VAR_OP_OPERATION` (`OPERATION_ID_`),
  CONSTRAINT `FK_FF_NODE_VAR_OP_OPERATION` FOREIGN KEY (`OPERATION_ID_`) REFERENCES `FF_OPERATION` (`OPERATION_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='节点变量操作';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_NODE_VAR_OP`
--

LOCK TABLES `FF_NODE_VAR_OP` WRITE;
/*!40000 ALTER TABLE `FF_NODE_VAR_OP` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_NODE_VAR_OP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_OPERATION`
--

DROP TABLE IF EXISTS `FF_OPERATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_OPERATION` (
  `OPERATION_ID_` varchar(40) NOT NULL COMMENT '操作ID',
  `OPERATION_` varchar(40) NOT NULL COMMENT '操作',
  `PROC_ID_` varchar(40) DEFAULT NULL COMMENT '流程ID',
  `NODE_ID_` varchar(40) DEFAULT NULL COMMENT '节点ID',
  `TASK_ID_` varchar(40) DEFAULT NULL COMMENT '任务ID',
  `MEMO_` varchar(1000) DEFAULT NULL COMMENT '备注',
  `OPERATOR_` varchar(40) DEFAULT NULL COMMENT '操作人',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人名称',
  `OPERATION_DATE_` datetime NOT NULL COMMENT '操作日期',
  `OPERATION_STATUS_` varchar(20) NOT NULL COMMENT '操作状态',
  PRIMARY KEY (`OPERATION_ID_`),
  KEY `IX_FF_OPERATION_OPERATOR` (`OPERATOR_`),
  KEY `IX_FF_OPERATION_PROC` (`PROC_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_OPERATION`
--

LOCK TABLES `FF_OPERATION` WRITE;
/*!40000 ALTER TABLE `FF_OPERATION` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_OPERATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_OPERATION_FOLLOW_UP`
--

DROP TABLE IF EXISTS `FF_OPERATION_FOLLOW_UP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_OPERATION_FOLLOW_UP` (
  `OPERATION_FOLLOW_UP_ID_` varchar(40) NOT NULL COMMENT '操作后续ID',
  `OPERATION_ID_` varchar(40) NOT NULL COMMENT '操作ID',
  `FOLLOW_UP_OPERATION_ID_` varchar(40) NOT NULL COMMENT '后续操作ID',
  `OPERATION_DATE_` datetime NOT NULL COMMENT '操作日期',
  PRIMARY KEY (`OPERATION_FOLLOW_UP_ID_`),
  KEY `FK_FF_OPERATION_FOLOW_UP_O` (`OPERATION_ID_`),
  KEY `FK_FF_OPERATION_FOLOW_UP_OFU` (`FOLLOW_UP_OPERATION_ID_`),
  CONSTRAINT `FK_FF_OPERATION_FOLOW_UP_O` FOREIGN KEY (`OPERATION_ID_`) REFERENCES `FF_OPERATION` (`OPERATION_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_FF_OPERATION_FOLOW_UP_OFU` FOREIGN KEY (`FOLLOW_UP_OPERATION_ID_`) REFERENCES `FF_OPERATION` (`OPERATION_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作后续';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_OPERATION_FOLLOW_UP`
--

LOCK TABLES `FF_OPERATION_FOLLOW_UP` WRITE;
/*!40000 ALTER TABLE `FF_OPERATION_FOLLOW_UP` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_OPERATION_FOLLOW_UP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_PROC`
--

DROP TABLE IF EXISTS `FF_PROC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_PROC` (
  `PROC_ID_` varchar(40) NOT NULL COMMENT '流程ID',
  `PROC_DEF_ID_` varchar(40) NOT NULL COMMENT '流程定义ID',
  `ADJUST_PROC_DEF_ID_` varchar(40) DEFAULT NULL COMMENT '调整流程定义ID',
  `ISOLATE_SUB_PROC_NODE_ID_` varchar(40) DEFAULT NULL COMMENT '独立子流程所属节点ID',
  `BIZ_ID_` varchar(40) DEFAULT NULL COMMENT '业务主键',
  `BIZ_TYPE_` varchar(60) DEFAULT NULL COMMENT '业务类型',
  `BIZ_CODE_` varchar(100) DEFAULT NULL COMMENT '业务编码',
  `BIZ_NAME_` varchar(100) DEFAULT NULL COMMENT '业务名称',
  `BIZ_DESC_` varchar(300) DEFAULT NULL COMMENT '业务备注',
  `PROC_START_USER_` varchar(40) DEFAULT NULL COMMENT '流程开始人员',
  `PROC_START_USER_NAME_` varchar(60) DEFAULT NULL COMMENT '流程开始人员名称',
  `PROC_END_USER_` varchar(40) DEFAULT NULL COMMENT '流程完成人员',
  `PROC_END_USER_NAME_` varchar(60) DEFAULT NULL COMMENT '流程完成人员名称',
  `PROC_END_DATE_` datetime DEFAULT NULL COMMENT '流程完成日期',
  `PROC_STATUS_` varchar(20) NOT NULL COMMENT '流程状态',
  `CREATION_DATE_` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`PROC_ID_`),
  KEY `FK_FF_PROC_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `FK_FF_PROC_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `FF_PROC_DEF` (`PROC_DEF_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_PROC`
--

LOCK TABLES `FF_PROC` WRITE;
/*!40000 ALTER TABLE `FF_PROC` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_PROC` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_PROC_DEF`
--

DROP TABLE IF EXISTS `FF_PROC_DEF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_PROC_DEF` (
  `PROC_DEF_ID_` varchar(40) NOT NULL COMMENT '流程定义ID',
  `PROC_DEF_CODE_` varchar(60) NOT NULL COMMENT '流程定义编码',
  `PROC_DEF_NAME_` varchar(60) NOT NULL COMMENT '流程定义名称',
  `PROC_DEF_CAT_` varchar(100) DEFAULT NULL COMMENT '流程定义分类',
  `PROC_DEF_MODEL_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程定义模型',
  `PROC_DEF_DIAGRAM_FILE_` longblob COMMENT '流程定义图文件',
  `PROC_DEF_DIAGRAM_FILE_NAME_` varchar(300) DEFAULT NULL COMMENT '流程定义图文件名称',
  `PROC_DEF_DIAGRAM_FILE_LENGTH_` decimal(8,0) DEFAULT NULL COMMENT '流程定义图文件长度',
  `PROC_DEF_DIAGRAM_WIDTH_` decimal(8,0) DEFAULT NULL COMMENT '流程定义图宽度',
  `PROC_DEF_DIAGRAM_HEIGHT_` decimal(8,0) DEFAULT NULL COMMENT '流程定义图高度',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `VERSION_` decimal(8,0) NOT NULL COMMENT '版本',
  `PROC_DEF_STATUS_` varchar(20) NOT NULL COMMENT '流程定义状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  `EXT_ATTR_1_` varchar(120) DEFAULT NULL COMMENT '扩展属性1',
  `EXT_ATTR_2_` varchar(120) DEFAULT NULL COMMENT '扩展属性2',
  `EXT_ATTR_3_` varchar(120) DEFAULT NULL COMMENT '扩展属性3',
  `EXT_ATTR_4_` varchar(120) DEFAULT NULL COMMENT '扩展属性4',
  `EXT_ATTR_5_` varchar(120) DEFAULT NULL COMMENT '扩展属性5',
  `EXT_ATTR_6_` varchar(120) DEFAULT NULL COMMENT '扩展属性6',
  `EXT_ATTR_7_` varchar(120) DEFAULT NULL COMMENT '扩展属性7',
  `EXT_ATTR_8_` varchar(120) DEFAULT NULL COMMENT '扩展属性8',
  PRIMARY KEY (`PROC_DEF_ID_`),
  KEY `UQ_FF_PROC_DEF` (`PROC_DEF_CODE_`,`VERSION_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_PROC_DEF`
--

LOCK TABLES `FF_PROC_DEF` WRITE;
/*!40000 ALTER TABLE `FF_PROC_DEF` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_PROC_DEF` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_PROC_OP`
--

DROP TABLE IF EXISTS `FF_PROC_OP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_PROC_OP` (
  `PROC_OP_ID_` varchar(40) NOT NULL COMMENT '流程操作ID',
  `OPERATION_ID_` varchar(40) NOT NULL COMMENT '操作ID',
  `OPERATION_TYPE_` varchar(20) NOT NULL COMMENT '操作类型',
  `OPERATION_ORDER_` decimal(8,0) DEFAULT NULL COMMENT '操作顺序',
  `OPERATION_DATE_` datetime DEFAULT NULL COMMENT '操作日期',
  `OPERATION_STATUS_` varchar(20) DEFAULT NULL COMMENT '操作状态',
  `PROC_ID_` varchar(40) NOT NULL COMMENT '流程ID',
  `PROC_DEF_ID_` varchar(40) DEFAULT NULL COMMENT '流程定义ID',
  `ADJUST_PROC_DEF_ID_` varchar(40) DEFAULT NULL COMMENT '调整流程定义ID',
  `ISOLATE_SUB_PROC_NODE_ID_` varchar(40) DEFAULT NULL COMMENT '独立子流程所属节点ID',
  `BIZ_ID_` varchar(40) DEFAULT NULL COMMENT '业务主键',
  `BIZ_TYPE_` varchar(60) DEFAULT NULL COMMENT '业务类型',
  `BIZ_CODE_` varchar(100) DEFAULT NULL COMMENT '业务编码',
  `BIZ_NAME_` varchar(100) DEFAULT NULL COMMENT '业务名称',
  `BIZ_DESC_` varchar(300) DEFAULT NULL COMMENT '业务备注',
  `PROC_START_USER_` varchar(40) DEFAULT NULL COMMENT '流程开始人员',
  `PROC_START_USER_NAME_` varchar(60) DEFAULT NULL COMMENT '流程开始人员名称',
  `PROC_END_USER_` varchar(40) DEFAULT NULL COMMENT '流程完成人员',
  `PROC_END_USER_NAME_` varchar(60) DEFAULT NULL COMMENT '流程完成人员名称',
  `PROC_END_DATE_` datetime DEFAULT NULL COMMENT '流程完成日期',
  `PROC_STATUS_` varchar(20) DEFAULT NULL COMMENT '流程状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`PROC_OP_ID_`),
  KEY `FK_FF_PROC_OP_OPERATION` (`OPERATION_ID_`),
  CONSTRAINT `FK_FF_PROC_OP_OPERATION` FOREIGN KEY (`OPERATION_ID_`) REFERENCES `FF_OPERATION` (`OPERATION_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程操作';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_PROC_OP`
--

LOCK TABLES `FF_PROC_OP` WRITE;
/*!40000 ALTER TABLE `FF_PROC_OP` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_PROC_OP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_TASK`
--

DROP TABLE IF EXISTS `FF_TASK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_TASK` (
  `TASK_ID_` varchar(40) NOT NULL COMMENT '任务ID',
  `NODE_ID_` varchar(40) DEFAULT NULL COMMENT '节点ID',
  `PREVIOUS_TASK_ID_` varchar(40) DEFAULT NULL COMMENT '前一个任务ID',
  `TASK_TYPE_` varchar(20) NOT NULL COMMENT '任务类型',
  `ASSIGNEE_` varchar(40) DEFAULT NULL COMMENT '办理人',
  `ASSIGNEE_NAME_` varchar(60) DEFAULT NULL COMMENT '办理人名称',
  `ACTION_` varchar(300) DEFAULT NULL COMMENT '业务行为',
  `DUE_DATE_` datetime DEFAULT NULL COMMENT '截止日期',
  `CLAIM_` varchar(20) NOT NULL COMMENT '认领',
  `FORWARDABLE_` varchar(20) NOT NULL COMMENT '可转发',
  `PRIORITY_` decimal(8,0) NOT NULL COMMENT '优先级',
  `FORWARD_STATUS_` varchar(20) NOT NULL COMMENT '转发状态',
  `TASK_END_USER_` varchar(40) DEFAULT NULL COMMENT '任务完成人员',
  `TASK_END_USER_NAME_` varchar(60) DEFAULT NULL COMMENT '任务完成人员名称',
  `TASK_END_DATE_` datetime DEFAULT NULL COMMENT '任务完成日期',
  `NEXT_CANDIDATE_` text COMMENT '下个候选人',
  `TASK_STATUS_` varchar(20) NOT NULL COMMENT '任务状态',
  `CREATION_DATE_` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`TASK_ID_`),
  KEY `FK_FF_TASK_NODE` (`NODE_ID_`),
  KEY `FK_FF_TASK_PARENT` (`PREVIOUS_TASK_ID_`),
  CONSTRAINT `FK_FF_TASK_NODE` FOREIGN KEY (`NODE_ID_`) REFERENCES `FF_NODE` (`NODE_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_FF_TASK_PARENT` FOREIGN KEY (`PREVIOUS_TASK_ID_`) REFERENCES `FF_TASK` (`TASK_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_TASK`
--

LOCK TABLES `FF_TASK` WRITE;
/*!40000 ALTER TABLE `FF_TASK` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_TASK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FF_TASK_OP`
--

DROP TABLE IF EXISTS `FF_TASK_OP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FF_TASK_OP` (
  `TASK_OP_ID_` varchar(40) NOT NULL COMMENT '任务操作ID',
  `OPERATION_ID_` varchar(40) NOT NULL COMMENT '操作ID',
  `OPERATION_TYPE_` varchar(20) NOT NULL COMMENT '操作类型',
  `OPERATION_ORDER_` decimal(8,0) DEFAULT NULL COMMENT '操作顺序',
  `OPERATION_DATE_` datetime DEFAULT NULL COMMENT '操作日期',
  `OPERATION_STATUS_` varchar(20) DEFAULT NULL COMMENT '操作状态',
  `TASK_ID_` varchar(40) NOT NULL COMMENT '任务ID',
  `NODE_ID_` varchar(40) DEFAULT NULL COMMENT '节点ID',
  `PREVIOUS_TASK_ID_` varchar(40) DEFAULT NULL COMMENT '前一个任务ID',
  `TASK_TYPE_` varchar(20) DEFAULT NULL COMMENT '任务类型',
  `ASSIGNEE_` varchar(40) DEFAULT NULL COMMENT '办理人',
  `ASSIGNEE_NAME_` varchar(60) DEFAULT NULL COMMENT '办理人名称',
  `ACTION_` varchar(300) DEFAULT NULL COMMENT '业务行为',
  `DUE_DATE_` datetime DEFAULT NULL COMMENT '截止日期',
  `CLAIM_` varchar(20) DEFAULT NULL COMMENT '认领',
  `FORWARDABLE_` varchar(20) DEFAULT NULL COMMENT '可转发',
  `PRIORITY_` decimal(8,0) DEFAULT NULL COMMENT '优先级',
  `FORWARD_STATUS_` varchar(20) DEFAULT NULL COMMENT '转发状态',
  `TASK_END_USER_` varchar(40) DEFAULT NULL COMMENT '任务完成人员',
  `TASK_END_USER_NAME_` varchar(60) DEFAULT NULL COMMENT '任务完成人员名称',
  `TASK_END_DATE_` datetime DEFAULT NULL COMMENT '任务完成日期',
  `NEXT_CANDIDATE_` text COMMENT '下个候选人',
  `TASK_STATUS_` varchar(20) DEFAULT NULL COMMENT '任务状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`TASK_OP_ID_`),
  KEY `FK_FF_TASK_OP_OPERATION` (`OPERATION_ID_`),
  CONSTRAINT `FK_FF_TASK_OP_OPERATION` FOREIGN KEY (`OPERATION_ID_`) REFERENCES `FF_OPERATION` (`OPERATION_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务操作';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FF_TASK_OP`
--

LOCK TABLES `FF_TASK_OP` WRITE;
/*!40000 ALTER TABLE `FF_TASK_OP` DISABLE KEYS */;/*!40000 ALTER TABLE `FF_TASK_OP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `KV_APPROVAL_MEMO`
--

DROP TABLE IF EXISTS `KV_APPROVAL_MEMO`;
/*!50001 DROP VIEW IF EXISTS `KV_APPROVAL_MEMO`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `KV_APPROVAL_MEMO` AS SELECT 
 1 AS `APPROVAL_MEMO_ID_`,
 1 AS `TASK_ID_`,
 1 AS `PREVIOUS_TASK_ID_`,
 1 AS `NODE_ID_`,
 1 AS `NODE_TYPE_`,
 1 AS `NODE_NAME_`,
 1 AS `PARENT_NODE_ID_`,
 1 AS `PROC_ID_`,
 1 AS `BIZ_ID_`,
 1 AS `ASSIGNEE_`,
 1 AS `ASSIGNEE_CODE_`,
 1 AS `ASSIGNEE_NAME_`,
 1 AS `EXECUTOR_`,
 1 AS `EXECUTOR_CODE_`,
 1 AS `EXECUTOR_NAME_`,
 1 AS `ORG_ID_`,
 1 AS `ORG_NAME_`,
 1 AS `COM_ID_`,
 1 AS `COM_NAME_`,
 1 AS `CREATION_DATE_`,
 1 AS `DUE_DATE_`,
 1 AS `APPROVAL_MEMO_TYPE_`,
 1 AS `APPROVAL_MEMO_`,
 1 AS `APPROVAL_DATE_`,
 1 AS `APPROVAL_MEMO_STATUS_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `KV_DOC`
--

DROP TABLE IF EXISTS `KV_DOC`;
/*!50001 DROP VIEW IF EXISTS `KV_DOC`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `KV_DOC` AS SELECT 
 1 AS `DOC_ID_`,
 1 AS `DOC_TYPE_NAME_`,
 1 AS `DOC_CODE_`,
 1 AS `DOC_NAME_`,
 1 AS `MEMO_`,
 1 AS `TEMPLATE_FILE_NAME_`,
 1 AS `TEMPLATE_FILE_LENGTH_`,
 1 AS `DOC_FILE_NAME_`,
 1 AS `DOC_FILE_LENGTH_`,
 1 AS `TEMPLATE_BOOKMARK_`,
 1 AS `TEMPLATE_INDEX_`,
 1 AS `TEMPLATE_HTML_`,
 1 AS `USING_TEMPLATE_PLACEHOLDERS_`,
 1 AS `DRAFTER_ID_`,
 1 AS `DRAFTER_NAME_`,
 1 AS `DRAFTER_COM_ID_`,
 1 AS `DRAFTER_COM_NAME_`,
 1 AS `PROC_DEF_CODE_`,
 1 AS `PROC_ID_`,
 1 AS `PROC_STATUS_`,
 1 AS `DOC_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `VERSION_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `KV_DOC_DATA`
--

DROP TABLE IF EXISTS `KV_DOC_DATA`;
/*!50001 DROP VIEW IF EXISTS `KV_DOC_DATA`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `KV_DOC_DATA` AS SELECT 
 1 AS `DOC_DATA_ID_`,
 1 AS `DOC_ID_`,
 1 AS `BOOKMARK_`,
 1 AS `DATA_TYPE_`,
 1 AS `VALUE_`,
 1 AS `ORDER_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `KV_DOC_RIDER`
--

DROP TABLE IF EXISTS `KV_DOC_RIDER`;
/*!50001 DROP VIEW IF EXISTS `KV_DOC_RIDER`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `KV_DOC_RIDER` AS SELECT 
 1 AS `DOC_RIDER_ID_`,
 1 AS `DOC_ID_`,
 1 AS `DOC_RIDER_FILE_NAME_`,
 1 AS `DOC_RIDER_FILE_LENGTH_`,
 1 AS `MD5_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `KV_DOC_TYPE`
--

DROP TABLE IF EXISTS `KV_DOC_TYPE`;
/*!50001 DROP VIEW IF EXISTS `KV_DOC_TYPE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `KV_DOC_TYPE` AS SELECT 
 1 AS `DOC_TYPE_ID_`,
 1 AS `DOC_TYPE_NAME_`,
 1 AS `TEMPLATE_FILE_NAME_`,
 1 AS `TEMPLATE_FILE_LENGTH_`,
 1 AS `TEMPLATE_BOOKMARK_`,
 1 AS `TEMPLATE_INDEX_`,
 1 AS `TEMPLATE_HTML_`,
 1 AS `USING_TEMPLATE_PLACEHOLDERS_`,
 1 AS `PROC_DEF_CODE_`,
 1 AS `DESC_`,
 1 AS `ORDER_`,
 1 AS `DOC_TYPE_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `K_APPROVAL_MEMO`
--

DROP TABLE IF EXISTS `K_APPROVAL_MEMO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `K_APPROVAL_MEMO` (
  `APPROVAL_MEMO_ID_` varchar(40) NOT NULL COMMENT '审批意见ID',
  `TASK_ID_` varchar(40) DEFAULT NULL COMMENT '任务ID',
  `PREVIOUS_TASK_ID_` varchar(40) DEFAULT NULL COMMENT '前一个任务ID',
  `NODE_ID_` varchar(40) DEFAULT NULL COMMENT '节点ID',
  `NODE_TYPE_` varchar(60) DEFAULT NULL COMMENT '节点类型',
  `NODE_NAME_` varchar(60) DEFAULT NULL COMMENT '节点名称',
  `PARENT_NODE_ID_` varchar(40) DEFAULT NULL COMMENT '上级节点ID',
  `PROC_ID_` varchar(40) NOT NULL COMMENT '流程ID',
  `BIZ_ID_` varchar(40) DEFAULT NULL COMMENT '业务ID',
  `ASSIGNEE_` varchar(40) DEFAULT NULL COMMENT '办理人',
  `ASSIGNEE_CODE_` varchar(40) DEFAULT NULL COMMENT '办理人编码',
  `ASSIGNEE_NAME_` varchar(60) DEFAULT NULL COMMENT '办理人名称',
  `EXECUTOR_` varchar(40) DEFAULT NULL COMMENT '执行人',
  `EXECUTOR_CODE_` varchar(40) DEFAULT NULL COMMENT '执行人编码',
  `EXECUTOR_NAME_` varchar(60) DEFAULT NULL COMMENT '执行人名称',
  `ORG_ID_` varchar(40) DEFAULT NULL COMMENT '机构ID',
  `ORG_NAME_` varchar(60) DEFAULT NULL COMMENT '机构名称',
  `COM_ID_` varchar(40) DEFAULT NULL COMMENT '公司ID',
  `COM_NAME_` varchar(60) DEFAULT NULL COMMENT '公司名称',
  `CREATION_DATE_` datetime NOT NULL COMMENT '创建日期',
  `DUE_DATE_` datetime DEFAULT NULL COMMENT '截止日期',
  `APPROVAL_MEMO_TYPE_` varchar(20) DEFAULT NULL COMMENT '审批意见类型',
  `APPROVAL_MEMO_` varchar(1000) DEFAULT NULL COMMENT '审批意见',
  `APPROVAL_DATE_` datetime DEFAULT NULL COMMENT '审批日期',
  `APPROVAL_MEMO_STATUS_` varchar(20) NOT NULL COMMENT '审批状态',
  `OPERATION_ID_` varchar(40) DEFAULT NULL COMMENT '操作ID',
  PRIMARY KEY (`APPROVAL_MEMO_ID_`),
  KEY `IX_APPROVAL_MEMO_APPROVAL_DATE` (`APPROVAL_DATE_`),
  KEY `IX_APPROVAL_MEMO_CREATION_DATE` (`CREATION_DATE_`),
  KEY `IX_APPROVAL_MEMO_PROC_ID` (`PROC_ID_`),
  KEY `IX_APPROVAL_MEMO_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='审批意见';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `K_APPROVAL_MEMO`
--

LOCK TABLES `K_APPROVAL_MEMO` WRITE;
/*!40000 ALTER TABLE `K_APPROVAL_MEMO` DISABLE KEYS */;/*!40000 ALTER TABLE `K_APPROVAL_MEMO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `K_DOC`
--

DROP TABLE IF EXISTS `K_DOC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `K_DOC` (
  `DOC_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档ID',
  `DOC_TYPE_NAME_` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档类型名称',
  `DOC_CODE_` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档编码',
  `DOC_NAME_` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档名称',
  `MEMO_` varchar(1000) DEFAULT NULL COMMENT '备注',
  `TEMPLATE_FILE_` longblob COMMENT '模版文件',
  `TEMPLATE_FILE_NAME_` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模版文件名称',
  `TEMPLATE_FILE_LENGTH_` decimal(8,0) DEFAULT NULL COMMENT '模版文件长度',
  `DOC_FILE_` longblob COMMENT '文档文件',
  `DOC_FILE_NAME_` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档文件名称',
  `DOC_FILE_LENGTH_` decimal(8,0) DEFAULT NULL COMMENT '文档文件长度',
  `TEMPLATE_BOOKMARK_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '模版标签',
  `TEMPLATE_INDEX_` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模版定位',
  `TEMPLATE_HTML_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '模版HTML',
  `USING_TEMPLATE_PLACEHOLDERS_` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '使用模板生成',
  `DRAFTER_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '起草人员ID',
  `DRAFTER_NAME_` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '起草人员名称',
  `DRAFTER_COM_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '起草单位ID',
  `DRAFTER_COM_NAME_` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '起草单位名称',
  `PROC_DEF_CODE_` varchar(60) DEFAULT NULL COMMENT '流程定义编码',
  `PROC_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '流程ID',
  `PROC_STATUS_` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '流程状态',
  `DOC_STATUS_` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  `VERSION_` decimal(8,0) NOT NULL COMMENT '版本',
  PRIMARY KEY (`DOC_ID_`),
  UNIQUE KEY `K_DOC_UNIQUE` (`DOC_CODE_`),
  KEY `UQ_CONTRACT_CODE` (`DOC_CODE_`),
  KEY `IX_CONTRACT_CREATION_DATE` (`CREATION_DATE_`),
  KEY `IX_CONTRACT_DRATFER_COM_ID` (`DRAFTER_COM_ID_`),
  KEY `IX_CONTRACT_DRATFER_ID` (`DRAFTER_ID_`),
  KEY `IX_CONTRACT_PROC_STATUS` (`PROC_STATUS_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `K_DOC`
--

LOCK TABLES `K_DOC` WRITE;
/*!40000 ALTER TABLE `K_DOC` DISABLE KEYS */;/*!40000 ALTER TABLE `K_DOC` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `K_DOC_DATA`
--

DROP TABLE IF EXISTS `K_DOC_DATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `K_DOC_DATA` (
  `DOC_DATA_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档数据ID',
  `DOC_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档ID',
  `BOOKMARK_` varchar(60) NOT NULL COMMENT '标签',
  `DATA_TYPE_` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '数据类型',
  `VALUE_` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '数值',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`DOC_DATA_ID_`),
  UNIQUE KEY `K_DOC_DATA_UNIQUE` (`DOC_ID_`,`BOOKMARK_`),
  CONSTRAINT `K_DOC_DATA_K_DOC_FK` FOREIGN KEY (`DOC_ID_`) REFERENCES `K_DOC` (`DOC_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文档数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `K_DOC_DATA`
--

LOCK TABLES `K_DOC_DATA` WRITE;
/*!40000 ALTER TABLE `K_DOC_DATA` DISABLE KEYS */;/*!40000 ALTER TABLE `K_DOC_DATA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `K_DOC_DATA_HIS`
--

DROP TABLE IF EXISTS `K_DOC_DATA_HIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `K_DOC_DATA_HIS` (
  `DOC_DATA_HIS_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档数据历史ID',
  `DOC_DATA_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档数据ID',
  `DOC_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档ID',
  `BOOKMARK_` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '标签',
  `DATA_TYPE_` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '数据类型',
  `VALUE_` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '数值',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `VERSION_` decimal(8,0) DEFAULT NULL COMMENT '版本',
  `HIS_DATE_` datetime DEFAULT NULL COMMENT '历史日期',
  PRIMARY KEY (`DOC_DATA_HIS_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文档数据历史';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `K_DOC_DATA_HIS`
--

LOCK TABLES `K_DOC_DATA_HIS` WRITE;
/*!40000 ALTER TABLE `K_DOC_DATA_HIS` DISABLE KEYS */;/*!40000 ALTER TABLE `K_DOC_DATA_HIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `K_DOC_HIS`
--

DROP TABLE IF EXISTS `K_DOC_HIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `K_DOC_HIS` (
  `DOC_HIS_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档历史ID',
  `DOC_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档ID',
  `DOC_TYPE_NAME_` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档类型名称',
  `DOC_CODE_` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档编码',
  `DOC_NAME_` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档名称',
  `MEMO_` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `TEMPLATE_FILE_` longblob COMMENT '模版文件',
  `TEMPLATE_FILE_NAME_` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模版文件名称',
  `TEMPLATE_FILE_LENGTH_` decimal(8,0) DEFAULT NULL COMMENT '模版文件长度',
  `DOC_FILE_` longblob COMMENT '文档文件',
  `DOC_FILE_NAME_` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档文件名称',
  `DOC_FILE_LENGTH_` decimal(8,0) DEFAULT NULL COMMENT '文档文件长度',
  `TEMPLATE_BOOKMARK_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '模版标签',
  `TEMPLATE_INDEX_` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模版定位',
  `TEMPLATE_HTML_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '模版HTML',
  `USING_TEMPLATE_PLACEHOLDERS_` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '使用模板生成',
  `DRAFTER_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '起草人员ID',
  `DRAFTER_NAME_` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '起草人员名称',
  `DRAFTER_COM_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '起草单位ID',
  `DRAFTER_COM_NAME_` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '起草单位名称',
  `PROC_DEF_CODE_` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '流程定义编码',
  `PROC_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '流程ID',
  `PROC_STATUS_` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '流程状态',
  `DOC_STATUS_` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '操作人员名称',
  `VERSION_` decimal(8,0) NOT NULL COMMENT '版本',
  `HIS_DATE_` datetime DEFAULT NULL COMMENT '历史日期',
  `DOC_DATA_DIFF_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '文档数据差别',
  `DOC_FILE_DIFF_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '文档文件差别',
  `DOC_RIDER_DIFF_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '文档附件差别',
  PRIMARY KEY (`DOC_HIS_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文档历史';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `K_DOC_HIS`
--

LOCK TABLES `K_DOC_HIS` WRITE;
/*!40000 ALTER TABLE `K_DOC_HIS` DISABLE KEYS */;/*!40000 ALTER TABLE `K_DOC_HIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `K_DOC_RIDER`
--

DROP TABLE IF EXISTS `K_DOC_RIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `K_DOC_RIDER` (
  `DOC_RIDER_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档附件ID',
  `DOC_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档ID',
  `DOC_RIDER_FILE_` longblob NOT NULL COMMENT '文档附件文件',
  `DOC_RIDER_FILE_NAME_` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档附件文件名称',
  `DOC_RIDER_FILE_LENGTH_` decimal(8,0) DEFAULT NULL COMMENT '文档附件文件长度',
  `MD5_` varchar(40) DEFAULT NULL COMMENT 'MD5',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`DOC_RIDER_ID_`),
  KEY `K_DOC_RIDER_K_DOC_FK` (`DOC_ID_`),
  CONSTRAINT `K_DOC_RIDER_K_DOC_FK` FOREIGN KEY (`DOC_ID_`) REFERENCES `K_DOC` (`DOC_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文档附件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `K_DOC_RIDER`
--

LOCK TABLES `K_DOC_RIDER` WRITE;
/*!40000 ALTER TABLE `K_DOC_RIDER` DISABLE KEYS */;/*!40000 ALTER TABLE `K_DOC_RIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `K_DOC_RIDER_HIS`
--

DROP TABLE IF EXISTS `K_DOC_RIDER_HIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `K_DOC_RIDER_HIS` (
  `DOC_RIDER_HIS_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档附件历史ID',
  `DOC_RIDER_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档附件ID',
  `DOC_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档ID',
  `DOC_RIDER_FILE_` longblob COMMENT '文档附件文件',
  `DOC_RIDER_FILE_NAME_` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文档附件文件名称',
  `DOC_RIDER_FILE_LENGTH_` decimal(8,0) DEFAULT NULL COMMENT '文档附件文件长度',
  `MD5_` varchar(40) DEFAULT NULL COMMENT 'MD5',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  `VERSION_` decimal(8,0) DEFAULT NULL COMMENT '版本',
  `HIS_DATE_` datetime DEFAULT NULL COMMENT '历史日期',
  PRIMARY KEY (`DOC_RIDER_HIS_ID_`),
  KEY `UQ_CONTRACT_RIDER_HIS` (`VERSION_`,`DOC_RIDER_ID_`),
  KEY `IX_CONTRACT_RIDER_HIS_CONTRACT` (`DOC_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文档附件历史';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `K_DOC_RIDER_HIS`
--

LOCK TABLES `K_DOC_RIDER_HIS` WRITE;
/*!40000 ALTER TABLE `K_DOC_RIDER_HIS` DISABLE KEYS */;/*!40000 ALTER TABLE `K_DOC_RIDER_HIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `K_DOC_TYPE`
--

DROP TABLE IF EXISTS `K_DOC_TYPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `K_DOC_TYPE` (
  `DOC_TYPE_ID_` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档类型ID',
  `DOC_TYPE_NAME_` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档类型名称',
  `TEMPLATE_FILE_` longblob NOT NULL COMMENT '模版文件',
  `TEMPLATE_FILE_NAME_` varchar(300) DEFAULT NULL COMMENT '模版文件名称',
  `TEMPLATE_FILE_LENGTH_` decimal(8,0) DEFAULT NULL COMMENT '模版文件长度',
  `TEMPLATE_BOOKMARK_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '模版标签',
  `TEMPLATE_INDEX_` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模版定位',
  `TEMPLATE_HTML_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '模版HTML',
  `USING_TEMPLATE_PLACEHOLDERS_` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '使用模板生成',
  `PROC_DEF_CODE_` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程定义编码',
  `DESC_` varchar(300) DEFAULT NULL COMMENT '描述',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `DOC_TYPE_STATUS_` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档类型状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`DOC_TYPE_ID_`),
  UNIQUE KEY `K_DOC_TYPE_UNIQUE` (`DOC_TYPE_NAME_`),
  KEY `UQ_TEMPLATE` (`DOC_TYPE_NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文档类型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `K_DOC_TYPE`
--

LOCK TABLES `K_DOC_TYPE` WRITE;
/*!40000 ALTER TABLE `K_DOC_TYPE` DISABLE KEYS */;/*!40000 ALTER TABLE `K_DOC_TYPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `OMV_CODE`
--

DROP TABLE IF EXISTS `OMV_CODE`;
/*!50001 DROP VIEW IF EXISTS `OMV_CODE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_CODE` AS SELECT 
 1 AS `CODE_ID_`,
 1 AS `PARENT_CODE_ID_`,
 1 AS `CATEGORY_`,
 1 AS `CODE_`,
 1 AS `NAME_`,
 1 AS `EXT_ATTR_1_`,
 1 AS `EXT_ATTR_2_`,
 1 AS `EXT_ATTR_3_`,
 1 AS `EXT_ATTR_4_`,
 1 AS `EXT_ATTR_5_`,
 1 AS `EXT_ATTR_6_`,
 1 AS `ORDER_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_DUTY`
--

DROP TABLE IF EXISTS `OMV_DUTY`;
/*!50001 DROP VIEW IF EXISTS `OMV_DUTY`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_DUTY` AS SELECT 
 1 AS `ORGN_SET_ID_`,
 1 AS `ORGN_SET_CODE_`,
 1 AS `ORGN_SET_NAME_`,
 1 AS `DUTY_ID_`,
 1 AS `DUTY_CODE_`,
 1 AS `DUTY_NAME_`,
 1 AS `DUTY_CATEGORY_`,
 1 AS `MEMO_`,
 1 AS `DUTY_TAG_`,
 1 AS `DUTY_EXT_ATTR_1_`,
 1 AS `DUTY_EXT_ATTR_2_`,
 1 AS `DUTY_EXT_ATTR_3_`,
 1 AS `DUTY_EXT_ATTR_4_`,
 1 AS `DUTY_EXT_ATTR_5_`,
 1 AS `DUTY_EXT_ATTR_6_`,
 1 AS `DUTY_EXT_ATTR_7_`,
 1 AS `DUTY_EXT_ATTR_8_`,
 1 AS `ORDER_`,
 1 AS `DUTY_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_EMP`
--

DROP TABLE IF EXISTS `OMV_EMP`;
/*!50001 DROP VIEW IF EXISTS `OMV_EMP`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_EMP` AS SELECT 
 1 AS `ORGN_SET_ID_`,
 1 AS `ORGN_SET_CODE_`,
 1 AS `ORGN_SET_NAME_`,
 1 AS `EMP_ID_`,
 1 AS `EMP_CODE_`,
 1 AS `EMP_NAME_`,
 1 AS `PASSWORD_RESET_REQ_`,
 1 AS `PARTY_`,
 1 AS `EMP_LEVEL_`,
 1 AS `GENDER_`,
 1 AS `BIRTH_DATE_`,
 1 AS `TEL_`,
 1 AS `EMAIL_`,
 1 AS `IN_DATE_`,
 1 AS `OUT_DATE_`,
 1 AS `EMP_CATEGORY_`,
 1 AS `MEMO_`,
 1 AS `EMP_TAG_`,
 1 AS `EMP_EXT_ATTR_1_`,
 1 AS `EMP_EXT_ATTR_2_`,
 1 AS `EMP_EXT_ATTR_3_`,
 1 AS `EMP_EXT_ATTR_4_`,
 1 AS `EMP_EXT_ATTR_5_`,
 1 AS `EMP_EXT_ATTR_6_`,
 1 AS `EMP_EXT_ATTR_7_`,
 1 AS `EMP_EXT_ATTR_8_`,
 1 AS `ORDER_`,
 1 AS `EMP_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `ORG_ID_`,
 1 AS `PARENT_ORG_ID_`,
 1 AS `ORG_CODE_`,
 1 AS `ORG_NAME_`,
 1 AS `ORG_ABBR_NAME_`,
 1 AS `ORG_TYPE_`,
 1 AS `ORG_CATEGORY_`,
 1 AS `ORG_TAG_`,
 1 AS `ORG_EXT_ATTR_1_`,
 1 AS `ORG_EXT_ATTR_2_`,
 1 AS `ORG_EXT_ATTR_3_`,
 1 AS `ORG_EXT_ATTR_4_`,
 1 AS `ORG_EXT_ATTR_5_`,
 1 AS `ORG_EXT_ATTR_6_`,
 1 AS `ORG_EXT_ATTR_7_`,
 1 AS `ORG_EXT_ATTR_8_`,
 1 AS `ORG_STATUS_`,
 1 AS `PARENT_ORG_CODE_`,
 1 AS `PARENT_ORG_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_EMP_RELATION`
--

DROP TABLE IF EXISTS `OMV_EMP_RELATION`;
/*!50001 DROP VIEW IF EXISTS `OMV_EMP_RELATION`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_EMP_RELATION` AS SELECT 
 1 AS `ORGN_SET_ID_`,
 1 AS `ORGN_SET_CODE_`,
 1 AS `ORGN_SET_NAME_`,
 1 AS `EMP_RELATION_ID_`,
 1 AS `EMP_RELATION_`,
 1 AS `EMP_RELATION_CATEGORY_`,
 1 AS `MEMO_`,
 1 AS `EMP_RELATION_TAG_`,
 1 AS `EMP_RELATION_EXT_ATTR_1_`,
 1 AS `EMP_RELATION_EXT_ATTR_2_`,
 1 AS `EMP_RELATION_EXT_ATTR_3_`,
 1 AS `EMP_RELATION_EXT_ATTR_4_`,
 1 AS `EMP_RELATION_EXT_ATTR_5_`,
 1 AS `EMP_RELATION_EXT_ATTR_6_`,
 1 AS `EMP_RELATION_EXT_ATTR_7_`,
 1 AS `EMP_RELATION_EXT_ATTR_8_`,
 1 AS `ORDER_`,
 1 AS `EMP_RELATION_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `UPPER_EMP_ID_`,
 1 AS `UPPER_EMP_CODE_`,
 1 AS `UPPER_EMP_NAME_`,
 1 AS `UPPER_PASSWORD_RESET_REQ_`,
 1 AS `UPPER_PARTY_`,
 1 AS `UPPER_EMP_LEVEL_`,
 1 AS `UPPER_GENDER_`,
 1 AS `UPPER_BIRTH_DATE_`,
 1 AS `UPPER_TEL_`,
 1 AS `UPPER_EMAIL_`,
 1 AS `UPPER_IN_DATE_`,
 1 AS `UPPER_OUT_DATE_`,
 1 AS `UPPER_EMP_CATEGORY_`,
 1 AS `UPPER_EMP_TAG_`,
 1 AS `UPPER_EMP_EXT_ATTR_1_`,
 1 AS `UPPER_EMP_EXT_ATTR_2_`,
 1 AS `UPPER_EMP_EXT_ATTR_3_`,
 1 AS `UPPER_EMP_EXT_ATTR_4_`,
 1 AS `UPPER_EMP_EXT_ATTR_5_`,
 1 AS `UPPER_EMP_EXT_ATTR_6_`,
 1 AS `UPPER_EMP_EXT_ATTR_7_`,
 1 AS `UPPER_EMP_EXT_ATTR_8_`,
 1 AS `UPPER_EMP_STATUS_`,
 1 AS `UPPER_ORG_ID_`,
 1 AS `UPPER_PARENT_ORG_ID_`,
 1 AS `UPPER_ORG_CODE_`,
 1 AS `UPPER_ORG_NAME_`,
 1 AS `UPPER_ORG_ABBR_NAME_`,
 1 AS `UPPER_ORG_TYPE_`,
 1 AS `UPPER_ORG_CATEGORY_`,
 1 AS `UPPER_ORG_TAG_`,
 1 AS `UPPER_ORG_EXT_ATTR_1_`,
 1 AS `UPPER_ORG_EXT_ATTR_2_`,
 1 AS `UPPER_ORG_EXT_ATTR_3_`,
 1 AS `UPPER_ORG_EXT_ATTR_4_`,
 1 AS `UPPER_ORG_EXT_ATTR_5_`,
 1 AS `UPPER_ORG_EXT_ATTR_6_`,
 1 AS `UPPER_ORG_EXT_ATTR_7_`,
 1 AS `UPPER_ORG_EXT_ATTR_8_`,
 1 AS `UPPER_ORG_STATUS_`,
 1 AS `UPPER_PARENT_ORG_CODE_`,
 1 AS `UPPER_PARENT_ORG_NAME_`,
 1 AS `LOWER_EMP_ID_`,
 1 AS `LOWER_EMP_CODE_`,
 1 AS `LOWER_EMP_NAME_`,
 1 AS `LOWER_PASSWORD_RESET_REQ_`,
 1 AS `LOWER_PARTY_`,
 1 AS `LOWER_EMP_LEVEL_`,
 1 AS `LOWER_GENDER_`,
 1 AS `LOWER_BIRTH_DATE_`,
 1 AS `LOWER_TEL_`,
 1 AS `LOWER_EMAIL_`,
 1 AS `LOWER_IN_DATE_`,
 1 AS `LOWER_OUT_DATE_`,
 1 AS `LOWER_EMP_CATEGORY_`,
 1 AS `LOWER_EMP_TAG_`,
 1 AS `LOWER_EMP_EXT_ATTR_1_`,
 1 AS `LOWER_EMP_EXT_ATTR_2_`,
 1 AS `LOWER_EMP_EXT_ATTR_3_`,
 1 AS `LOWER_EMP_EXT_ATTR_4_`,
 1 AS `LOWER_EMP_EXT_ATTR_5_`,
 1 AS `LOWER_EMP_EXT_ATTR_6_`,
 1 AS `LOWER_EMP_EXT_ATTR_7_`,
 1 AS `LOWER_EMP_EXT_ATTR_8_`,
 1 AS `LOWER_EMP_STATUS_`,
 1 AS `LOWER_ORG_ID_`,
 1 AS `LOWER_PARENT_ORG_ID_`,
 1 AS `LOWER_ORG_CODE_`,
 1 AS `LOWER_ORG_NAME_`,
 1 AS `LOWER_ORG_ABBR_NAME_`,
 1 AS `LOWER_ORG_TYPE_`,
 1 AS `LOWER_ORG_CATEGORY_`,
 1 AS `LOWER_ORG_TAG_`,
 1 AS `LOWER_ORG_EXT_ATTR_1_`,
 1 AS `LOWER_ORG_EXT_ATTR_2_`,
 1 AS `LOWER_ORG_EXT_ATTR_3_`,
 1 AS `LOWER_ORG_EXT_ATTR_4_`,
 1 AS `LOWER_ORG_EXT_ATTR_5_`,
 1 AS `LOWER_ORG_EXT_ATTR_6_`,
 1 AS `LOWER_ORG_EXT_ATTR_7_`,
 1 AS `LOWER_ORG_EXT_ATTR_8_`,
 1 AS `LOWER_ORG_STATUS_`,
 1 AS `LOWER_PARENT_ORG_CODE_`,
 1 AS `LOWER_PARENT_ORG_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_LOG`
--

DROP TABLE IF EXISTS `OMV_LOG`;
/*!50001 DROP VIEW IF EXISTS `OMV_LOG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_LOG` AS SELECT 
 1 AS `LOG_ID_`,
 1 AS `CATEGORY_`,
 1 AS `IP_`,
 1 AS `USER_AGENT_`,
 1 AS `URL_`,
 1 AS `ACTION_`,
 1 AS `PARAMETER_MAP_`,
 1 AS `BUSINESS_KEY_`,
 1 AS `ERROR_`,
 1 AS `MESSAGE_`,
 1 AS `ORG_ID_`,
 1 AS `ORG_NAME_`,
 1 AS `POSI_ID_`,
 1 AS `POSI_NAME_`,
 1 AS `EMP_ID_`,
 1 AS `EMP_NAME_`,
 1 AS `CREATION_DATE_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_MAIN_SERVER`
--

DROP TABLE IF EXISTS `OMV_MAIN_SERVER`;
/*!50001 DROP VIEW IF EXISTS `OMV_MAIN_SERVER`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_MAIN_SERVER` AS SELECT 
 1 AS `MAIN_SERVER_ID_`,
 1 AS `MAIN_SERVER_NAME_`,
 1 AS `DRIVER_CLASS_NAME_`,
 1 AS `URL_`,
 1 AS `USERNAME_`,
 1 AS `PASSWORD_`,
 1 AS `MEMO_`,
 1 AS `LAST_SYNC_DATE_`,
 1 AS `ORDER_`,
 1 AS `MAIN_SERVER_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_MIRROR_SERVER`
--

DROP TABLE IF EXISTS `OMV_MIRROR_SERVER`;
/*!50001 DROP VIEW IF EXISTS `OMV_MIRROR_SERVER`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_MIRROR_SERVER` AS SELECT 
 1 AS `MIRROR_SERVER_ID_`,
 1 AS `MIRROR_SERVER_NAME_`,
 1 AS `DRIVER_CLASS_NAME_`,
 1 AS `URL_`,
 1 AS `USERNAME_`,
 1 AS `PASSWORD_`,
 1 AS `MEMO_`,
 1 AS `LAST_SYNC_DATE_`,
 1 AS `ORDER_`,
 1 AS `MIRROR_SERVER_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_ORG`
--

DROP TABLE IF EXISTS `OMV_ORG`;
/*!50001 DROP VIEW IF EXISTS `OMV_ORG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_ORG` AS SELECT 
 1 AS `ORGN_SET_ID_`,
 1 AS `ORGN_SET_CODE_`,
 1 AS `ORGN_SET_NAME_`,
 1 AS `ORG_ID_`,
 1 AS `PARENT_ORG_ID_`,
 1 AS `ORG_CODE_`,
 1 AS `ORG_NAME_`,
 1 AS `ORG_ABBR_NAME_`,
 1 AS `ORG_TYPE_`,
 1 AS `ORG_CATEGORY_`,
 1 AS `MEMO_`,
 1 AS `ORG_TAG_`,
 1 AS `ORG_EXT_ATTR_1_`,
 1 AS `ORG_EXT_ATTR_2_`,
 1 AS `ORG_EXT_ATTR_3_`,
 1 AS `ORG_EXT_ATTR_4_`,
 1 AS `ORG_EXT_ATTR_5_`,
 1 AS `ORG_EXT_ATTR_6_`,
 1 AS `ORG_EXT_ATTR_7_`,
 1 AS `ORG_EXT_ATTR_8_`,
 1 AS `ORDER_`,
 1 AS `ORG_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `PARENT_ORG_CODE_`,
 1 AS `PARENT_ORG_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_ORGN_SET`
--

DROP TABLE IF EXISTS `OMV_ORGN_SET`;
/*!50001 DROP VIEW IF EXISTS `OMV_ORGN_SET`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_ORGN_SET` AS SELECT 
 1 AS `ORGN_SET_ID_`,
 1 AS `PARENT_ORGN_SET_ID_`,
 1 AS `ORGN_SET_CODE_`,
 1 AS `ORGN_SET_NAME_`,
 1 AS `ALLOW_SYNC_`,
 1 AS `MEMO_`,
 1 AS `ORDER_`,
 1 AS `ORGN_SET_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `PARENT_ORGN_SET_CODE_`,
 1 AS `PARENT_ORGN_SET_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_POSI`
--

DROP TABLE IF EXISTS `OMV_POSI`;
/*!50001 DROP VIEW IF EXISTS `OMV_POSI`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_POSI` AS SELECT 
 1 AS `ORGN_SET_ID_`,
 1 AS `ORGN_SET_CODE_`,
 1 AS `ORGN_SET_NAME_`,
 1 AS `POSI_ID_`,
 1 AS `POSI_CODE_`,
 1 AS `POSI_NAME_`,
 1 AS `ORG_LEADER_TYPE_`,
 1 AS `POSI_CATEGORY_`,
 1 AS `MEMO_`,
 1 AS `POSI_TAG_`,
 1 AS `POSI_EXT_ATTR_1_`,
 1 AS `POSI_EXT_ATTR_2_`,
 1 AS `POSI_EXT_ATTR_3_`,
 1 AS `POSI_EXT_ATTR_4_`,
 1 AS `POSI_EXT_ATTR_5_`,
 1 AS `POSI_EXT_ATTR_6_`,
 1 AS `POSI_EXT_ATTR_7_`,
 1 AS `POSI_EXT_ATTR_8_`,
 1 AS `ORDER_`,
 1 AS `POSI_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `DUTY_ID_`,
 1 AS `DUTY_CODE_`,
 1 AS `DUTY_NAME_`,
 1 AS `DUTY_CATEGORY_`,
 1 AS `DUTY_TAG_`,
 1 AS `DUTY_EXT_ATTR_1_`,
 1 AS `DUTY_EXT_ATTR_2_`,
 1 AS `DUTY_EXT_ATTR_3_`,
 1 AS `DUTY_EXT_ATTR_4_`,
 1 AS `DUTY_EXT_ATTR_5_`,
 1 AS `DUTY_EXT_ATTR_6_`,
 1 AS `DUTY_EXT_ATTR_7_`,
 1 AS `DUTY_EXT_ATTR_8_`,
 1 AS `DUTY_STATUS_`,
 1 AS `ORG_ID_`,
 1 AS `PARENT_ORG_ID_`,
 1 AS `ORG_CODE_`,
 1 AS `ORG_NAME_`,
 1 AS `ORG_ABBR_NAME_`,
 1 AS `ORG_TYPE_`,
 1 AS `ORG_CATEGORY_`,
 1 AS `ORG_TAG_`,
 1 AS `ORG_EXT_ATTR_1_`,
 1 AS `ORG_EXT_ATTR_2_`,
 1 AS `ORG_EXT_ATTR_3_`,
 1 AS `ORG_EXT_ATTR_4_`,
 1 AS `ORG_EXT_ATTR_5_`,
 1 AS `ORG_EXT_ATTR_6_`,
 1 AS `ORG_EXT_ATTR_7_`,
 1 AS `ORG_EXT_ATTR_8_`,
 1 AS `ORG_STATUS_`,
 1 AS `PARENT_ORG_CODE_`,
 1 AS `PARENT_ORG_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_POSI_EMP`
--

DROP TABLE IF EXISTS `OMV_POSI_EMP`;
/*!50001 DROP VIEW IF EXISTS `OMV_POSI_EMP`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_POSI_EMP` AS SELECT 
 1 AS `ORGN_SET_ID_`,
 1 AS `ORGN_SET_CODE_`,
 1 AS `ORGN_SET_NAME_`,
 1 AS `POSI_EMP_ID_`,
 1 AS `MAIN_`,
 1 AS `POSI_EMP_CATEGORY_`,
 1 AS `MEMO_`,
 1 AS `POSI_EMP_TAG_`,
 1 AS `POSI_EMP_EXT_ATTR_1_`,
 1 AS `POSI_EMP_EXT_ATTR_2_`,
 1 AS `POSI_EMP_EXT_ATTR_3_`,
 1 AS `POSI_EMP_EXT_ATTR_4_`,
 1 AS `POSI_EMP_EXT_ATTR_5_`,
 1 AS `POSI_EMP_EXT_ATTR_6_`,
 1 AS `POSI_EMP_EXT_ATTR_7_`,
 1 AS `POSI_EMP_EXT_ATTR_8_`,
 1 AS `ORDER_`,
 1 AS `POSI_EMP_STATUS_`,
 1 AS `CREATION_DATE_`,
 1 AS `UPDATE_DATE_`,
 1 AS `OPERATOR_ID_`,
 1 AS `OPERATOR_NAME_`,
 1 AS `EMP_ID_`,
 1 AS `EMP_CODE_`,
 1 AS `EMP_NAME_`,
 1 AS `PASSWORD_RESET_REQ_`,
 1 AS `PARTY_`,
 1 AS `EMP_LEVEL_`,
 1 AS `GENDER_`,
 1 AS `BIRTH_DATE_`,
 1 AS `TEL_`,
 1 AS `EMAIL_`,
 1 AS `IN_DATE_`,
 1 AS `OUT_DATE_`,
 1 AS `EMP_CATEGORY_`,
 1 AS `EMP_TAG_`,
 1 AS `EMP_EXT_ATTR_1_`,
 1 AS `EMP_EXT_ATTR_2_`,
 1 AS `EMP_EXT_ATTR_3_`,
 1 AS `EMP_EXT_ATTR_4_`,
 1 AS `EMP_EXT_ATTR_5_`,
 1 AS `EMP_EXT_ATTR_6_`,
 1 AS `EMP_EXT_ATTR_7_`,
 1 AS `EMP_EXT_ATTR_8_`,
 1 AS `EMP_STATUS_`,
 1 AS `POSI_ID_`,
 1 AS `POSI_CODE_`,
 1 AS `POSI_NAME_`,
 1 AS `ORG_LEADER_TYPE_`,
 1 AS `POSI_CATEGORY_`,
 1 AS `POSI_TAG_`,
 1 AS `POSI_EXT_ATTR_1_`,
 1 AS `POSI_EXT_ATTR_2_`,
 1 AS `POSI_EXT_ATTR_3_`,
 1 AS `POSI_EXT_ATTR_4_`,
 1 AS `POSI_EXT_ATTR_5_`,
 1 AS `POSI_EXT_ATTR_6_`,
 1 AS `POSI_EXT_ATTR_7_`,
 1 AS `POSI_EXT_ATTR_8_`,
 1 AS `POSI_STATUS_`,
 1 AS `DUTY_ID_`,
 1 AS `DUTY_CODE_`,
 1 AS `DUTY_NAME_`,
 1 AS `DUTY_CATEGORY_`,
 1 AS `DUTY_TAG_`,
 1 AS `DUTY_EXT_ATTR_1_`,
 1 AS `DUTY_EXT_ATTR_2_`,
 1 AS `DUTY_EXT_ATTR_3_`,
 1 AS `DUTY_EXT_ATTR_4_`,
 1 AS `DUTY_EXT_ATTR_5_`,
 1 AS `DUTY_EXT_ATTR_6_`,
 1 AS `DUTY_EXT_ATTR_7_`,
 1 AS `DUTY_EXT_ATTR_8_`,
 1 AS `DUTY_STATUS_`,
 1 AS `ORG_ID_`,
 1 AS `PARENT_ORG_ID_`,
 1 AS `ORG_CODE_`,
 1 AS `ORG_NAME_`,
 1 AS `ORG_ABBR_NAME_`,
 1 AS `ORG_TYPE_`,
 1 AS `ORG_CATEGORY_`,
 1 AS `ORG_TAG_`,
 1 AS `ORG_EXT_ATTR_1_`,
 1 AS `ORG_EXT_ATTR_2_`,
 1 AS `ORG_EXT_ATTR_3_`,
 1 AS `ORG_EXT_ATTR_4_`,
 1 AS `ORG_EXT_ATTR_5_`,
 1 AS `ORG_EXT_ATTR_6_`,
 1 AS `ORG_EXT_ATTR_7_`,
 1 AS `ORG_EXT_ATTR_8_`,
 1 AS `ORG_STATUS_`,
 1 AS `PARENT_ORG_CODE_`,
 1 AS `PARENT_ORG_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `OMV_TAG`
--

DROP TABLE IF EXISTS `OMV_TAG`;
/*!50001 DROP VIEW IF EXISTS `OMV_TAG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `OMV_TAG` AS SELECT 
 1 AS `ORGN_SET_ID_`,
 1 AS `TAG_ID_`,
 1 AS `OBJ_ID_`,
 1 AS `OBJ_TYPE_`,
 1 AS `TAG_`,
 1 AS `ORGN_SET_CODE_`,
 1 AS `ORGN_SET_NAME_`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `OM_CODE`
--

DROP TABLE IF EXISTS `OM_CODE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_CODE` (
  `CODE_ID_` varchar(40) NOT NULL COMMENT '代码ID',
  `PARENT_CODE_ID_` varchar(40) DEFAULT NULL COMMENT '上级代码ID',
  `CATEGORY_` varchar(20) NOT NULL COMMENT '分类',
  `CODE_` varchar(60) NOT NULL COMMENT '代码',
  `NAME_` varchar(60) DEFAULT NULL COMMENT '名称',
  `EXT_ATTR_1_` varchar(60) DEFAULT NULL COMMENT '扩展属性1',
  `EXT_ATTR_2_` varchar(60) DEFAULT NULL COMMENT '扩展属性2',
  `EXT_ATTR_3_` varchar(60) DEFAULT NULL COMMENT '扩展属性3',
  `EXT_ATTR_4_` varchar(60) DEFAULT NULL COMMENT '扩展属性4',
  `EXT_ATTR_5_` varchar(60) DEFAULT NULL COMMENT '扩展属性5',
  `EXT_ATTR_6_` varchar(60) DEFAULT NULL COMMENT '扩展属性6',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`CODE_ID_`),
  KEY `UQ_OM_CODE` (`CATEGORY_`,`CODE_`),
  KEY `FK_OM_CODE` (`PARENT_CODE_ID_`),
  CONSTRAINT `FK_OM_CODE` FOREIGN KEY (`PARENT_CODE_ID_`) REFERENCES `OM_CODE` (`CODE_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_CODE`
--

LOCK TABLES `OM_CODE` WRITE;
/*!40000 ALTER TABLE `OM_CODE` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_CODE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_DUTY`
--

DROP TABLE IF EXISTS `OM_DUTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_DUTY` (
  `ORGN_SET_ID_` varchar(40) NOT NULL COMMENT '组织架构套ID',
  `DUTY_ID_` varchar(40) NOT NULL COMMENT '职务ID',
  `DUTY_CODE_` varchar(60) NOT NULL COMMENT '职务编码',
  `DUTY_NAME_` varchar(60) NOT NULL COMMENT '职务名称',
  `DUTY_CATEGORY_` varchar(20) NOT NULL COMMENT '分类',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `DUTY_TAG_` varchar(120) DEFAULT NULL COMMENT '职务标签',
  `DUTY_EXT_ATTR_1_` varchar(120) DEFAULT NULL COMMENT '职务扩展属性1',
  `DUTY_EXT_ATTR_2_` varchar(120) DEFAULT NULL COMMENT '职务扩展属性2',
  `DUTY_EXT_ATTR_3_` varchar(120) DEFAULT NULL COMMENT '职务扩展属性3',
  `DUTY_EXT_ATTR_4_` varchar(120) DEFAULT NULL COMMENT '职务扩展属性4',
  `DUTY_EXT_ATTR_5_` varchar(120) DEFAULT NULL COMMENT '职务扩展属性5',
  `DUTY_EXT_ATTR_6_` varchar(120) DEFAULT NULL COMMENT '职务扩展属性6',
  `DUTY_EXT_ATTR_7_` varchar(120) DEFAULT NULL COMMENT '职务扩展属性7',
  `DUTY_EXT_ATTR_8_` varchar(120) DEFAULT NULL COMMENT '职务扩展属性8',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `DUTY_STATUS_` varchar(20) NOT NULL COMMENT '职务状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '修改日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`ORGN_SET_ID_`,`DUTY_ID_`),
  KEY `UQ_OM_DUTY_CODE` (`ORGN_SET_ID_`,`DUTY_CODE_`),
  CONSTRAINT `FK_OM_DUTY_ORGN_SET` FOREIGN KEY (`ORGN_SET_ID_`) REFERENCES `OM_ORGN_SET` (`ORGN_SET_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='职务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_DUTY`
--

LOCK TABLES `OM_DUTY` WRITE;
/*!40000 ALTER TABLE `OM_DUTY` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_DUTY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_EMP`
--

DROP TABLE IF EXISTS `OM_EMP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_EMP` (
  `ORGN_SET_ID_` varchar(40) NOT NULL COMMENT '组织架构套ID',
  `EMP_ID_` varchar(40) NOT NULL COMMENT '人员ID',
  `ORG_ID_` varchar(40) NOT NULL COMMENT '机构ID',
  `EMP_CODE_` varchar(60) NOT NULL COMMENT '人员编码',
  `EMP_NAME_` varchar(60) NOT NULL COMMENT '人员名称',
  `PASSWORD_` varchar(40) DEFAULT NULL COMMENT '密码',
  `PASSWORD_RESET_REQ_` varchar(20) NOT NULL COMMENT '密码重置',
  `PARTY_` varchar(20) DEFAULT NULL COMMENT '政治面貌',
  `EMP_LEVEL_` varchar(20) DEFAULT NULL COMMENT '职级',
  `GENDER_` varchar(20) DEFAULT NULL COMMENT '性别',
  `BIRTH_DATE_` datetime DEFAULT NULL COMMENT '出生日期',
  `TEL_` varchar(60) DEFAULT NULL COMMENT '电话',
  `EMAIL_` varchar(60) DEFAULT NULL COMMENT '电子邮箱',
  `IN_DATE_` datetime DEFAULT NULL COMMENT '入职日期',
  `OUT_DATE_` datetime DEFAULT NULL COMMENT '离职日期',
  `EMP_CATEGORY_` varchar(20) NOT NULL COMMENT '分类',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `EMP_TAG_` varchar(120) DEFAULT NULL COMMENT '人员标签',
  `EMP_EXT_ATTR_1_` varchar(120) DEFAULT NULL COMMENT '人员扩展属性1',
  `EMP_EXT_ATTR_2_` varchar(120) DEFAULT NULL COMMENT '人员扩展属性2',
  `EMP_EXT_ATTR_3_` varchar(120) DEFAULT NULL COMMENT '人员扩展属性3',
  `EMP_EXT_ATTR_4_` varchar(120) DEFAULT NULL COMMENT '人员扩展属性4',
  `EMP_EXT_ATTR_5_` varchar(120) DEFAULT NULL COMMENT '人员扩展属性5',
  `EMP_EXT_ATTR_6_` varchar(120) DEFAULT NULL COMMENT '人员扩展属性6',
  `EMP_EXT_ATTR_7_` varchar(120) DEFAULT NULL COMMENT '人员扩展属性7',
  `EMP_EXT_ATTR_8_` varchar(120) DEFAULT NULL COMMENT '人员扩展属性8',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `EMP_STATUS_` varchar(20) NOT NULL COMMENT '人员状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`ORGN_SET_ID_`,`EMP_ID_`),
  KEY `UQ_OM_EMP_CODE` (`ORGN_SET_ID_`,`EMP_CODE_`),
  KEY `IX_OM_EMP_ORDER` (`ORDER_`),
  KEY `FK_OM_EMP_ORG` (`ORGN_SET_ID_`,`ORG_ID_`),
  CONSTRAINT `FK_OM_EMP_ORG` FOREIGN KEY (`ORGN_SET_ID_`, `ORG_ID_`) REFERENCES `OM_ORG` (`ORGN_SET_ID_`, `ORG_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_OM_EMP_ORGN_SET` FOREIGN KEY (`ORGN_SET_ID_`) REFERENCES `OM_ORGN_SET` (`ORGN_SET_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='人员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_EMP`
--

LOCK TABLES `OM_EMP` WRITE;
/*!40000 ALTER TABLE `OM_EMP` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_EMP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_EMP_RELATION`
--

DROP TABLE IF EXISTS `OM_EMP_RELATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_EMP_RELATION` (
  `ORGN_SET_ID_` varchar(40) NOT NULL COMMENT '组织架构套ID',
  `EMP_RELATION_ID_` varchar(40) NOT NULL COMMENT '人员关系ID',
  `UPPER_EMP_ID_` varchar(40) NOT NULL COMMENT '上级人员ID',
  `LOWER_EMP_ID_` varchar(40) NOT NULL COMMENT '下级人员ID',
  `EMP_RELATION_` varchar(20) NOT NULL COMMENT '人员关系',
  `EMP_RELATION_CATEGORY_` varchar(20) DEFAULT NULL COMMENT '分类',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `EMP_RELATION_TAG_` varchar(120) DEFAULT NULL COMMENT '人员关系标签',
  `EMP_RELATION_EXT_ATTR_1_` varchar(120) DEFAULT NULL COMMENT '人员关系扩展属性1',
  `EMP_RELATION_EXT_ATTR_2_` varchar(120) DEFAULT NULL COMMENT '人员关系扩展属性2',
  `EMP_RELATION_EXT_ATTR_3_` varchar(120) DEFAULT NULL COMMENT '人员关系扩展属性3',
  `EMP_RELATION_EXT_ATTR_4_` varchar(120) DEFAULT NULL COMMENT '人员关系扩展属性4',
  `EMP_RELATION_EXT_ATTR_5_` varchar(120) DEFAULT NULL COMMENT '人员关系扩展属性5',
  `EMP_RELATION_EXT_ATTR_6_` varchar(120) DEFAULT NULL COMMENT '人员关系扩展属性6',
  `EMP_RELATION_EXT_ATTR_7_` varchar(120) DEFAULT NULL COMMENT '人员关系扩展属性7',
  `EMP_RELATION_EXT_ATTR_8_` varchar(120) DEFAULT NULL COMMENT '人员关系扩展属性8',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `EMP_RELATION_STATUS_` varchar(20) NOT NULL COMMENT '人员关系状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '修改日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`ORGN_SET_ID_`,`EMP_RELATION_ID_`),
  KEY `UQ_OM_EMP_RELATION` (`ORGN_SET_ID_`,`UPPER_EMP_ID_`,`LOWER_EMP_ID_`,`EMP_RELATION_`),
  KEY `FK_OM_EMP_RELATION_LOWER_EMP` (`ORGN_SET_ID_`,`LOWER_EMP_ID_`),
  CONSTRAINT `FK_OM_EMP_RELATION_LOWER_EMP` FOREIGN KEY (`ORGN_SET_ID_`, `LOWER_EMP_ID_`) REFERENCES `OM_EMP` (`ORGN_SET_ID_`, `EMP_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_OM_EMP_RELATION_ORNG_SET` FOREIGN KEY (`ORGN_SET_ID_`) REFERENCES `OM_ORGN_SET` (`ORGN_SET_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_OM_EMP_RELATION_UPPER_EMP` FOREIGN KEY (`ORGN_SET_ID_`, `UPPER_EMP_ID_`) REFERENCES `OM_EMP` (`ORGN_SET_ID_`, `EMP_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='人员关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_EMP_RELATION`
--

LOCK TABLES `OM_EMP_RELATION` WRITE;
/*!40000 ALTER TABLE `OM_EMP_RELATION` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_EMP_RELATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_LOG`
--

DROP TABLE IF EXISTS `OM_LOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_LOG` (
  `LOG_ID_` varchar(40) NOT NULL COMMENT '日志ID',
  `CATEGORY_` varchar(60) DEFAULT NULL COMMENT '分类',
  `IP_` varchar(60) DEFAULT NULL COMMENT 'IP',
  `USER_AGENT_` varchar(200) DEFAULT NULL COMMENT '用户代理',
  `URL_` text COMMENT '调用URL',
  `ACTION_` varchar(200) DEFAULT NULL COMMENT '调用控制层接口',
  `PARAMETER_MAP_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '调用参数',
  `BUSINESS_KEY_` varchar(40) DEFAULT NULL COMMENT '业务主键',
  `ERROR_` varchar(20) DEFAULT NULL COMMENT '错误',
  `MESSAGE_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '信息',
  `ORG_ID_` varchar(40) DEFAULT NULL COMMENT '机构ID',
  `ORG_NAME_` varchar(60) DEFAULT NULL COMMENT '机构名称',
  `POSI_ID_` varchar(40) DEFAULT NULL COMMENT '岗位ID',
  `POSI_NAME_` varchar(60) DEFAULT NULL COMMENT '岗位名称',
  `EMP_ID_` varchar(40) DEFAULT NULL COMMENT '人员ID',
  `EMP_NAME_` varchar(60) DEFAULT NULL COMMENT '人员名称',
  `CREATION_DATE_` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`LOG_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_LOG`
--

LOCK TABLES `OM_LOG` WRITE;
/*!40000 ALTER TABLE `OM_LOG` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_LOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_MAIN_SERVER`
--

DROP TABLE IF EXISTS `OM_MAIN_SERVER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_MAIN_SERVER` (
  `MAIN_SERVER_ID_` varchar(40) NOT NULL COMMENT '主服务器ID',
  `MAIN_SERVER_NAME_` varchar(60) NOT NULL COMMENT '主服务器名称',
  `DRIVER_CLASS_NAME_` varchar(100) NOT NULL COMMENT '驱动类名称',
  `URL_` varchar(200) NOT NULL COMMENT '链接',
  `USERNAME_` varchar(40) NOT NULL COMMENT '用户名',
  `PASSWORD_` varchar(40) NOT NULL COMMENT '密码',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `LAST_SYNC_DATE_` datetime DEFAULT NULL COMMENT '上次同步日期',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `MAIN_SERVER_STATUS_` varchar(20) NOT NULL COMMENT '主服务器状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '修改日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`MAIN_SERVER_ID_`),
  KEY `UQ_OM_MAIN_SERVER_NAME` (`MAIN_SERVER_NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='主服务器';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_MAIN_SERVER`
--

LOCK TABLES `OM_MAIN_SERVER` WRITE;
/*!40000 ALTER TABLE `OM_MAIN_SERVER` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_MAIN_SERVER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_MIRROR_SERVER`
--

DROP TABLE IF EXISTS `OM_MIRROR_SERVER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_MIRROR_SERVER` (
  `MIRROR_SERVER_ID_` varchar(40) NOT NULL COMMENT '镜像服务器ID',
  `MIRROR_SERVER_NAME_` varchar(60) NOT NULL COMMENT '镜像服务器名称',
  `DRIVER_CLASS_NAME_` varchar(100) NOT NULL COMMENT '驱动类名称',
  `URL_` varchar(200) NOT NULL COMMENT '链接',
  `USERNAME_` varchar(40) NOT NULL COMMENT '用户名',
  `PASSWORD_` varchar(40) NOT NULL COMMENT '密码',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `LAST_SYNC_DATE_` datetime DEFAULT NULL COMMENT '上次同步日期',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `MIRROR_SERVER_STATUS_` varchar(20) NOT NULL COMMENT '镜像服务器状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '修改日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`MIRROR_SERVER_ID_`),
  KEY `UQ_OM_MIRROR_SERVER_NAME` (`MIRROR_SERVER_NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='镜像服务器';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_MIRROR_SERVER`
--

LOCK TABLES `OM_MIRROR_SERVER` WRITE;
/*!40000 ALTER TABLE `OM_MIRROR_SERVER` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_MIRROR_SERVER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_ORG`
--

DROP TABLE IF EXISTS `OM_ORG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_ORG` (
  `ORGN_SET_ID_` varchar(40) NOT NULL COMMENT '组织架构套ID',
  `ORG_ID_` varchar(40) NOT NULL COMMENT '机构ID',
  `PARENT_ORG_ID_` varchar(40) DEFAULT NULL COMMENT '上级机构ID',
  `ORG_CODE_` varchar(120) NOT NULL COMMENT '机构编码',
  `ORG_NAME_` varchar(120) NOT NULL COMMENT '机构名称',
  `ORG_ABBR_NAME_` varchar(60) DEFAULT NULL COMMENT '机构简称',
  `ORG_TYPE_` varchar(20) NOT NULL COMMENT '机构类型',
  `ORG_CATEGORY_` varchar(20) NOT NULL COMMENT '分类',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `ORG_TAG_` varchar(120) DEFAULT NULL COMMENT '机构标签',
  `ORG_EXT_ATTR_1_` varchar(120) DEFAULT NULL COMMENT '机构扩展属性1',
  `ORG_EXT_ATTR_2_` varchar(120) DEFAULT NULL COMMENT '机构扩展属性2',
  `ORG_EXT_ATTR_3_` varchar(120) DEFAULT NULL COMMENT '机构扩展属性3',
  `ORG_EXT_ATTR_4_` varchar(120) DEFAULT NULL COMMENT '机构扩展属性4',
  `ORG_EXT_ATTR_5_` varchar(120) DEFAULT NULL COMMENT '机构扩展属性5 乙方编码',
  `ORG_EXT_ATTR_6_` varchar(120) DEFAULT NULL COMMENT '机构扩展属性6 甲方简码',
  `ORG_EXT_ATTR_7_` varchar(120) DEFAULT NULL COMMENT '机构扩展属性7 甲方编码',
  `ORG_EXT_ATTR_8_` varchar(120) DEFAULT NULL COMMENT '机构扩展属性8',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `ORG_STATUS_` varchar(20) NOT NULL COMMENT '机构状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '修改日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`ORGN_SET_ID_`,`ORG_ID_`),
  UNIQUE KEY `OM_ORG_UNIQUE` (`ORGN_SET_ID_`,`ORG_CODE_`),
  KEY `UQ_OM_ORG_CODE` (`ORGN_SET_ID_`,`ORG_CODE_`),
  KEY `IX_OM_ORG_ORDER` (`ORDER_`),
  KEY `FK_OM_ORG_PARENT` (`ORGN_SET_ID_`,`PARENT_ORG_ID_`),
  CONSTRAINT `FK_OM_ORG_ORGN_SET` FOREIGN KEY (`ORGN_SET_ID_`) REFERENCES `OM_ORGN_SET` (`ORGN_SET_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_OM_ORG_PARENT` FOREIGN KEY (`ORGN_SET_ID_`, `PARENT_ORG_ID_`) REFERENCES `OM_ORG` (`ORGN_SET_ID_`, `ORG_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='机构';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_ORG`
--

LOCK TABLES `OM_ORG` WRITE;
/*!40000 ALTER TABLE `OM_ORG` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_ORG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_ORGN_SET`
--

DROP TABLE IF EXISTS `OM_ORGN_SET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_ORGN_SET` (
  `ORGN_SET_ID_` varchar(40) NOT NULL COMMENT '组织架构套ID',
  `PARENT_ORGN_SET_ID_` varchar(40) DEFAULT NULL COMMENT '上级组织架构套ID',
  `ORGN_SET_CODE_` varchar(60) NOT NULL COMMENT '组织架构套编码',
  `ORGN_SET_NAME_` varchar(60) NOT NULL COMMENT '组织架构套名称',
  `ALLOW_SYNC_` varchar(20) NOT NULL COMMENT '允许同步',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `ORGN_SET_STATUS_` varchar(20) NOT NULL COMMENT '组织架构套状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '修改日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`ORGN_SET_ID_`),
  KEY `UQ_OM_ORGN_SET_CODE` (`ORGN_SET_CODE_`),
  KEY `FK_OM_ORGN_SET_PARENT` (`PARENT_ORGN_SET_ID_`),
  CONSTRAINT `FK_OM_ORGN_SET_PARENT` FOREIGN KEY (`PARENT_ORGN_SET_ID_`) REFERENCES `OM_ORGN_SET` (`ORGN_SET_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='组织架构套';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_ORGN_SET`
--

LOCK TABLES `OM_ORGN_SET` WRITE;
/*!40000 ALTER TABLE `OM_ORGN_SET` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_ORGN_SET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_POSI`
--

DROP TABLE IF EXISTS `OM_POSI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_POSI` (
  `ORGN_SET_ID_` varchar(40) NOT NULL COMMENT '组织架构套ID',
  `POSI_ID_` varchar(40) NOT NULL COMMENT '岗位ID',
  `ORG_ID_` varchar(40) NOT NULL COMMENT '机构ID',
  `DUTY_ID_` varchar(40) DEFAULT NULL COMMENT '职务ID',
  `POSI_CODE_` varchar(60) DEFAULT NULL COMMENT '岗位编码',
  `POSI_NAME_` varchar(60) NOT NULL COMMENT '岗位名称',
  `ORG_LEADER_TYPE_` varchar(20) DEFAULT NULL COMMENT '机构领导类型',
  `POSI_CATEGORY_` varchar(20) NOT NULL COMMENT '分类',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `POSI_TAG_` varchar(120) DEFAULT NULL COMMENT '岗位标签',
  `POSI_EXT_ATTR_1_` varchar(120) DEFAULT NULL COMMENT '岗位扩展属性1',
  `POSI_EXT_ATTR_2_` varchar(120) DEFAULT NULL COMMENT '岗位扩展属性2',
  `POSI_EXT_ATTR_3_` varchar(120) DEFAULT NULL COMMENT '岗位扩展属性3',
  `POSI_EXT_ATTR_4_` varchar(120) DEFAULT NULL COMMENT '岗位扩展属性4',
  `POSI_EXT_ATTR_5_` varchar(120) DEFAULT NULL COMMENT '岗位扩展属性5',
  `POSI_EXT_ATTR_6_` varchar(120) DEFAULT NULL COMMENT '岗位扩展属性6',
  `POSI_EXT_ATTR_7_` varchar(120) DEFAULT NULL COMMENT '岗位扩展属性7',
  `POSI_EXT_ATTR_8_` varchar(120) DEFAULT NULL COMMENT '岗位扩展属性8',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `POSI_STATUS_` varchar(20) NOT NULL COMMENT '岗位状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '修改日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`ORGN_SET_ID_`,`POSI_ID_`),
  UNIQUE KEY `OM_POSI_UNIQUE` (`ORGN_SET_ID_`,`POSI_CODE_`),
  KEY `UQ_OM_POSI_CODE` (`ORGN_SET_ID_`,`POSI_CODE_`),
  KEY `FK_OM_POSI_DUTY` (`ORGN_SET_ID_`,`DUTY_ID_`),
  KEY `FK_OM_POSI_ORG` (`ORGN_SET_ID_`,`ORG_ID_`),
  CONSTRAINT `FK_OM_POSI_DUTY` FOREIGN KEY (`ORGN_SET_ID_`, `DUTY_ID_`) REFERENCES `OM_DUTY` (`ORGN_SET_ID_`, `DUTY_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_OM_POSI_ORG` FOREIGN KEY (`ORGN_SET_ID_`, `ORG_ID_`) REFERENCES `OM_ORG` (`ORGN_SET_ID_`, `ORG_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_OM_POSI_ORGN_SET` FOREIGN KEY (`ORGN_SET_ID_`) REFERENCES `OM_ORGN_SET` (`ORGN_SET_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_POSI`
--

LOCK TABLES `OM_POSI` WRITE;
/*!40000 ALTER TABLE `OM_POSI` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_POSI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_POSI_EMP`
--

DROP TABLE IF EXISTS `OM_POSI_EMP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_POSI_EMP` (
  `ORGN_SET_ID_` varchar(40) NOT NULL COMMENT '组织架构套ID',
  `POSI_EMP_ID_` varchar(40) NOT NULL COMMENT '岗位人员ID',
  `POSI_ID_` varchar(40) NOT NULL COMMENT '岗位ID',
  `EMP_ID_` varchar(40) NOT NULL COMMENT '人员ID',
  `MAIN_` varchar(20) NOT NULL COMMENT '主岗位',
  `POSI_EMP_CATEGORY_` varchar(20) DEFAULT NULL COMMENT '分类',
  `MEMO_` varchar(300) DEFAULT NULL COMMENT '备注',
  `POSI_EMP_TAG_` varchar(120) DEFAULT NULL COMMENT '岗位人员标签',
  `POSI_EMP_EXT_ATTR_1_` varchar(120) DEFAULT NULL COMMENT '岗位人员扩展属性1',
  `POSI_EMP_EXT_ATTR_2_` varchar(120) DEFAULT NULL COMMENT '岗位人员扩展属性2',
  `POSI_EMP_EXT_ATTR_3_` varchar(120) DEFAULT NULL COMMENT '岗位人员扩展属性3',
  `POSI_EMP_EXT_ATTR_4_` varchar(120) DEFAULT NULL COMMENT '岗位人员扩展属性4',
  `POSI_EMP_EXT_ATTR_5_` varchar(120) DEFAULT NULL COMMENT '岗位人员扩展属性5',
  `POSI_EMP_EXT_ATTR_6_` varchar(120) DEFAULT NULL COMMENT '岗位人员扩展属性6',
  `POSI_EMP_EXT_ATTR_7_` varchar(120) DEFAULT NULL COMMENT '岗位人员扩展属性7',
  `POSI_EMP_EXT_ATTR_8_` varchar(120) DEFAULT NULL COMMENT '岗位人员扩展属性8',
  `ORDER_` decimal(8,0) DEFAULT NULL COMMENT '排序',
  `POSI_EMP_STATUS_` varchar(20) NOT NULL COMMENT '岗位人员状态',
  `CREATION_DATE_` datetime DEFAULT NULL COMMENT '创建日期',
  `UPDATE_DATE_` datetime DEFAULT NULL COMMENT '更新日期',
  `OPERATOR_ID_` varchar(40) DEFAULT NULL COMMENT '操作人员ID',
  `OPERATOR_NAME_` varchar(60) DEFAULT NULL COMMENT '操作人员名称',
  PRIMARY KEY (`ORGN_SET_ID_`,`POSI_EMP_ID_`),
  KEY `UQ_OM_POSI_EMP` (`ORGN_SET_ID_`,`POSI_ID_`,`EMP_ID_`),
  KEY `IX_POSI_EMP_EMP` (`EMP_ID_`),
  KEY `IX_POSI_EMP_POSI` (`POSI_ID_`),
  KEY `FK_OM_POSI_EMP_EMP` (`ORGN_SET_ID_`,`EMP_ID_`),
  CONSTRAINT `FK_OM_POSI_EMP_EMP` FOREIGN KEY (`ORGN_SET_ID_`, `EMP_ID_`) REFERENCES `OM_EMP` (`ORGN_SET_ID_`, `EMP_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_OM_POSI_EMP_ORGN_SET` FOREIGN KEY (`ORGN_SET_ID_`) REFERENCES `OM_ORGN_SET` (`ORGN_SET_ID_`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_OM_POSI_EMP_POSI` FOREIGN KEY (`ORGN_SET_ID_`, `POSI_ID_`) REFERENCES `OM_POSI` (`ORGN_SET_ID_`, `POSI_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位人员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_POSI_EMP`
--

LOCK TABLES `OM_POSI_EMP` WRITE;
/*!40000 ALTER TABLE `OM_POSI_EMP` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_POSI_EMP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OM_TAG`
--

DROP TABLE IF EXISTS `OM_TAG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OM_TAG` (
  `ORGN_SET_ID_` varchar(40) NOT NULL COMMENT '组织架构套ID',
  `TAG_ID_` varchar(40) NOT NULL COMMENT '标签ID',
  `OBJ_ID_` varchar(40) NOT NULL COMMENT '对象ID',
  `OBJ_TYPE_` varchar(60) DEFAULT NULL COMMENT '对象类型',
  `TAG_` varchar(60) NOT NULL COMMENT '标签',
  PRIMARY KEY (`ORGN_SET_ID_`,`TAG_ID_`),
  CONSTRAINT `FK_OM_TAG_ORGN_SET` FOREIGN KEY (`ORGN_SET_ID_`) REFERENCES `OM_ORGN_SET` (`ORGN_SET_ID_`) ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='标签';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OM_TAG`
--

LOCK TABLES `OM_TAG` WRITE;
/*!40000 ALTER TABLE `OM_TAG` DISABLE KEYS */;/*!40000 ALTER TABLE `OM_TAG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'DOC'
--

--
-- Final view structure for view `CBV_CODE`
--

/*!50001 DROP VIEW IF EXISTS `CBV_CODE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_CODE` AS select `CB_CODE`.`CODE_ID_` AS `CODE_ID_`,`CB_CODE`.`PARENT_CODE_ID_` AS `PARENT_CODE_ID_`,`CB_CODE`.`CATEGORY_` AS `CATEGORY_`,`CB_CODE`.`CODE_` AS `CODE_`,`CB_CODE`.`NAME_` AS `NAME_`,`CB_CODE`.`EXT_ATTR_1_` AS `EXT_ATTR_1_`,`CB_CODE`.`EXT_ATTR_2_` AS `EXT_ATTR_2_`,`CB_CODE`.`EXT_ATTR_3_` AS `EXT_ATTR_3_`,`CB_CODE`.`EXT_ATTR_4_` AS `EXT_ATTR_4_`,`CB_CODE`.`EXT_ATTR_5_` AS `EXT_ATTR_5_`,`CB_CODE`.`EXT_ATTR_6_` AS `EXT_ATTR_6_`,`CB_CODE`.`ORDER_` AS `ORDER_` from `CB_CODE` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_CUSTOM_THEME`
--

/*!50001 DROP VIEW IF EXISTS `CBV_CUSTOM_THEME`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_CUSTOM_THEME` AS select `CT`.`CUSTOM_THEME_ID_` AS `CUSTOM_THEME_ID_`,`CT`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`CT`.`CSS_HREF_` AS `CSS_HREF_` from `CB_CUSTOM_THEME` `CT` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_DASHBOARD`
--

/*!50001 DROP VIEW IF EXISTS `CBV_DASHBOARD`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_DASHBOARD` AS select `D`.`DASHBOARD_ID_` AS `DASHBOARD_ID_`,`D`.`DASHBOARD_MODULE_ID_` AS `DASHBOARD_MODULE_ID_`,`D`.`POSI_EMP_ID_` AS `POSI_EMP_ID_`,`D`.`DASHBOARD_MODULE_NAME_` AS `DASHBOARD_MODULE_NAME_`,`D`.`URL_` AS `URL_`,`D`.`WIDTH_` AS `WIDTH_`,`D`.`HEIGHT_` AS `HEIGHT_`,`D`.`ORDER_` AS `ORDER_` from `CB_DASHBOARD` `D` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_DASHBOARD_MODULE`
--

/*!50001 DROP VIEW IF EXISTS `CBV_DASHBOARD_MODULE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_DASHBOARD_MODULE` AS select `DM`.`DASHBOARD_MODULE_ID_` AS `DASHBOARD_MODULE_ID_`,`DM`.`DASHBOARD_MODULE_NAME_` AS `DASHBOARD_MODULE_NAME_`,`DM`.`DASHBOARD_MODULE_TYPE_` AS `DASHBOARD_MODULE_TYPE_`,`DM`.`DEFAULT_URL_` AS `DEFAULT_URL_`,`DM`.`DEFAULT_WIDTH_` AS `DEFAULT_WIDTH_`,`DM`.`DEFAULT_HEIGHT_` AS `DEFAULT_HEIGHT_`,`DM`.`DASHBOARD_MODULE_TAG_` AS `DASHBOARD_MODULE_TAG_`,`DM`.`ORDER_` AS `ORDER_`,`DM`.`DASHBOARD_MODULE_STATUS_` AS `DASHBOARD_MODULE_STATUS_` from `CB_DASHBOARD_MODULE` `DM` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_DUTY_MENU`
--

/*!50001 DROP VIEW IF EXISTS `CBV_DUTY_MENU`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_DUTY_MENU` AS select `PM`.`DUTY_MENU_ID_` AS `DUTY_MENU_ID_`,`PM`.`DUTY_ID_` AS `DUTY_ID_`,`PM`.`DUTY_NAME_` AS `DUTY_NAME_`,`PM`.`MENU_ID_` AS `MENU_ID_`,`PM`.`CREATION_DATE_` AS `CREATION_DATE_`,`PM`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`PM`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`PM`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`M`.`PARENT_MENU_ID_` AS `PARENT_MENU_ID_`,`M`.`MENU_NAME_` AS `MENU_NAME_`,`M`.`MENU_TYPE_` AS `MENU_TYPE_`,`M`.`URL_` AS `URL_`,`M`.`ORDER_` AS `ORDER_`,`M`.`MENU_STATUS_` AS `MENU_STATUS_`,`M`.`ICON_` AS `ICON_` from (`CB_DUTY_MENU` `PM` join `CB_MENU` `M` on((`M`.`MENU_ID_` = `PM`.`MENU_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_LOG`
--

/*!50001 DROP VIEW IF EXISTS `CBV_LOG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_LOG` AS select `CB_LOG`.`LOG_ID_` AS `LOG_ID_`,`CB_LOG`.`CATEGORY_` AS `CATEGORY_`,`CB_LOG`.`IP_` AS `IP_`,`CB_LOG`.`USER_AGENT_` AS `USER_AGENT_`,`CB_LOG`.`URL_` AS `URL_`,`CB_LOG`.`ACTION_` AS `ACTION_`,`CB_LOG`.`PARAMETER_MAP_` AS `PARAMETER_MAP_`,`CB_LOG`.`BUSINESS_KEY_` AS `BUSINESS_KEY_`,`CB_LOG`.`ERROR_` AS `ERROR_`,`CB_LOG`.`MESSAGE_` AS `MESSAGE_`,`CB_LOG`.`ORG_ID_` AS `ORG_ID_`,`CB_LOG`.`ORG_NAME_` AS `ORG_NAME_`,`CB_LOG`.`POSI_ID_` AS `POSI_ID_`,`CB_LOG`.`POSI_NAME_` AS `POSI_NAME_`,`CB_LOG`.`EMP_ID_` AS `EMP_ID_`,`CB_LOG`.`EMP_NAME_` AS `EMP_NAME_`,`CB_LOG`.`CREATION_DATE_` AS `CREATION_DATE_` from `CB_LOG` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_MENU`
--

/*!50001 DROP VIEW IF EXISTS `CBV_MENU`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_MENU` AS select `CB_MENU`.`MENU_ID_` AS `MENU_ID_`,`CB_MENU`.`PARENT_MENU_ID_` AS `PARENT_MENU_ID_`,`CB_MENU`.`MENU_NAME_` AS `MENU_NAME_`,`CB_MENU`.`MENU_TYPE_` AS `MENU_TYPE_`,`CB_MENU`.`URL_` AS `URL_`,`CB_MENU`.`ORDER_` AS `ORDER_`,`CB_MENU`.`MENU_STATUS_` AS `MENU_STATUS_`,`CB_MENU`.`CREATION_DATE_` AS `CREATION_DATE_`,`CB_MENU`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`CB_MENU`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`CB_MENU`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`CB_MENU`.`ICON_` AS `ICON_` from `CB_MENU` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_NOTICE`
--

/*!50001 DROP VIEW IF EXISTS `CBV_NOTICE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_NOTICE` AS select `N`.`NOTICE_ID_` AS `NOTICE_ID_`,`N`.`POSI_EMP_ID_` AS `POSI_EMP_ID_`,`N`.`EMP_ID_` AS `EMP_ID_`,`N`.`EMP_CODE_` AS `EMP_CODE_`,`N`.`EMP_NAME_` AS `EMP_NAME_`,`N`.`CONTENT_` AS `CONTENT_`,`N`.`SOURCE_` AS `SOURCE_`,`N`.`IDENTITY_` AS `IDENTITY_`,`N`.`REDIRECT_URL_` AS `REDIRECT_URL_`,`N`.`BIZ_URL_` AS `BIZ_URL_`,`N`.`EXP_DATE_` AS `EXP_DATE_`,`N`.`NOTICE_STATUS_` AS `NOTICE_STATUS_`,`N`.`CREATION_DATE_` AS `CREATION_DATE_` from `CB_NOTICE` `N` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_POSI_EMP_MENU`
--

/*!50001 DROP VIEW IF EXISTS `CBV_POSI_EMP_MENU`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_POSI_EMP_MENU` AS select `PEM`.`POSI_EMP_MENU_ID_` AS `POSI_EMP_MENU_ID_`,`PEM`.`POSI_EMP_ID_` AS `POSI_EMP_ID_`,`PEM`.`POSI_NAME_` AS `POSI_NAME_`,`PEM`.`EMP_NAME_` AS `EMP_NAME_`,`PEM`.`MENU_ID_` AS `MENU_ID_`,`PEM`.`CREATION_DATE_` AS `CREATION_DATE_`,`PEM`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`PEM`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`PEM`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`M`.`PARENT_MENU_ID_` AS `PARENT_MENU_ID_`,`M`.`MENU_NAME_` AS `MENU_NAME_`,`M`.`MENU_TYPE_` AS `MENU_TYPE_`,`M`.`URL_` AS `URL_`,`M`.`ORDER_` AS `ORDER_`,`M`.`MENU_STATUS_` AS `MENU_STATUS_`,`M`.`ICON_` AS `ICON_` from (`CB_POSI_EMP_MENU` `PEM` join `CB_MENU` `M` on((`M`.`MENU_ID_` = `PEM`.`MENU_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_POSI_MENU`
--

/*!50001 DROP VIEW IF EXISTS `CBV_POSI_MENU`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_POSI_MENU` AS select `PM`.`POSI_MENU_ID_` AS `POSI_MENU_ID_`,`PM`.`POSI_ID_` AS `POSI_ID_`,`PM`.`POSI_NAME_` AS `POSI_NAME_`,`PM`.`MENU_ID_` AS `MENU_ID_`,`PM`.`CREATION_DATE_` AS `CREATION_DATE_`,`PM`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`PM`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`PM`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`M`.`PARENT_MENU_ID_` AS `PARENT_MENU_ID_`,`M`.`MENU_NAME_` AS `MENU_NAME_`,`M`.`MENU_TYPE_` AS `MENU_TYPE_`,`M`.`URL_` AS `URL_`,`M`.`ORDER_` AS `ORDER_`,`M`.`MENU_STATUS_` AS `MENU_STATUS_`,`M`.`ICON_` AS `ICON_` from (`CB_POSI_MENU` `PM` join `CB_MENU` `M` on((`M`.`MENU_ID_` = `PM`.`MENU_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_RIDER`
--

/*!50001 DROP VIEW IF EXISTS `CBV_RIDER`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_RIDER` AS select `CB_RIDER`.`RIDER_ID_` AS `RIDER_ID_`,`CB_RIDER`.`OBJ_ID_` AS `OBJ_ID_`,`CB_RIDER`.`RIDER_FILE_NAME_` AS `RIDER_FILE_NAME_`,`CB_RIDER`.`RIDER_FILE_LENGTH_` AS `RIDER_FILE_LENGTH_`,`CB_RIDER`.`MEMO_` AS `MEMO_`,`CB_RIDER`.`RIDER_TAG_` AS `RIDER_TAG_`,`CB_RIDER`.`ORDER_` AS `ORDER_`,`CB_RIDER`.`RIDER_STATUS_` AS `RIDER_STATUS_`,`CB_RIDER`.`CREATION_DATE_` AS `CREATION_DATE_`,`CB_RIDER`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`CB_RIDER`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`CB_RIDER`.`OPERATOR_NAME_` AS `OPERATOR_NAME_` from `CB_RIDER` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_TAG`
--

/*!50001 DROP VIEW IF EXISTS `CBV_TAG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_TAG` AS select `CB_TAG`.`TAG_ID_` AS `TAG_ID_`,`CB_TAG`.`OBJ_ID_` AS `OBJ_ID_`,`CB_TAG`.`OBJ_TYPE_` AS `OBJ_TYPE_`,`CB_TAG`.`TAG_` AS `TAG_` from `CB_TAG` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CBV_WORKING_CALENDAR`
--

/*!50001 DROP VIEW IF EXISTS `CBV_WORKING_CALENDAR`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `CBV_WORKING_CALENDAR` AS select `WC`.`WORKING_CALENDAR_ID_` AS `WORKING_CALENDAR_ID_`,`WC`.`EMP_ID_` AS `EMP_ID_`,`WC`.`DATE_` AS `DATE_`,`WC`.`WORKING_DAY_` AS `WORKING_DAY_`,`WC`.`MARK_` AS `MARK_` from `CB_WORKING_CALENDAR` `WC` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_ADJUST_PROC_DEF`
--

/*!50001 DROP VIEW IF EXISTS `FFV_ADJUST_PROC_DEF`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_ADJUST_PROC_DEF` AS select `APD`.`ADJUST_PROC_DEF_ID_` AS `ADJUST_PROC_DEF_ID_`,`APD`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`APD`.`PROC_DEF_MODEL_` AS `PROC_DEF_MODEL_`,`APD`.`PROC_DEF_DIAGRAM_FILE_` AS `PROC_DEF_DIAGRAM_FILE_`,`APD`.`PROC_DEF_DIAGRAM_FILE_NAME_` AS `PROC_DEF_DIAGRAM_FILE_NAME_`,`APD`.`PROC_DEF_DIAGRAM_FILE_LENGTH_` AS `PROC_DEF_DIAGRAM_FILE_LENGTH_`,`APD`.`PROC_DEF_DIAGRAM_WIDTH_` AS `PROC_DEF_DIAGRAM_WIDTH_`,`APD`.`PROC_DEF_DIAGRAM_HEIGHT_` AS `PROC_DEF_DIAGRAM_HEIGHT_`,`APD`.`CREATION_DATE_` AS `CREATION_DATE_`,`APD`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`APD`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`APD`.`OPERATOR_NAME_` AS `OPERATOR_NAME_` from `FF_ADJUST_PROC_DEF` `APD` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_DELEGATE`
--

/*!50001 DROP VIEW IF EXISTS `FFV_DELEGATE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_DELEGATE` AS select `D`.`DELEGATE_ID_` AS `DELEGATE_ID_`,`D`.`ASSIGNEE_` AS `ASSIGNEE_`,`D`.`ASSIGNEE_NAME_` AS `ASSIGNEE_NAME_`,`D`.`DELEGATOR_` AS `DELEGATOR_`,`D`.`DELEGATOR_NAME_` AS `DELEGATOR_NAME_`,`D`.`START_DATE_` AS `START_DATE_`,`D`.`END_DATE_` AS `END_DATE_` from `FF_DELEGATE` `D` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_NODE`
--

/*!50001 DROP VIEW IF EXISTS `FFV_NODE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_NODE` AS select `N`.`NODE_ID_` AS `NODE_ID_`,`N`.`PARENT_NODE_ID_` AS `PARENT_NODE_ID_`,`N`.`PROC_ID_` AS `PROC_ID_`,`N`.`PREVIOUS_NODE_IDS_` AS `PREVIOUS_NODE_IDS_`,`N`.`LAST_COMPLETE_NODE_IDS_` AS `LAST_COMPLETE_NODE_IDS_`,`N`.`SUB_PROC_DEF_ID_` AS `SUB_PROC_DEF_ID_`,`N`.`ADJUST_SUB_PROC_DEF_ID_` AS `ADJUST_SUB_PROC_DEF_ID_`,`N`.`NODE_TYPE_` AS `NODE_TYPE_`,`N`.`NODE_CODE_` AS `NODE_CODE_`,`N`.`NODE_NAME_` AS `NODE_NAME_`,`N`.`PARENT_NODE_CODE_` AS `PARENT_NODE_CODE_`,`N`.`CANDIDATE_ASSIGNEE_` AS `CANDIDATE_ASSIGNEE_`,`N`.`COMPLETE_EXPRESSION_` AS `COMPLETE_EXPRESSION_`,`N`.`COMPLETE_RETURN_` AS `COMPLETE_RETURN_`,`N`.`EXCLUSIVE_` AS `EXCLUSIVE_`,`N`.`WAITING_FOR_COMPLETE_NODE_` AS `WAITING_FOR_COMPLETE_NODE_`,`N`.`AUTO_COMPLETE_SAME_ASSIGNEE_` AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,`N`.`AUTO_COMPLETE_EMPTY_ASSIGNEE_` AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,`N`.`INFORM_` AS `INFORM_`,`N`.`ASSIGNEE_` AS `ASSIGNEE_`,`N`.`ACTION_` AS `ACTION_`,`N`.`DUE_DATE_` AS `DUE_DATE_`,`N`.`CLAIM_` AS `CLAIM_`,`N`.`FORWARDABLE_` AS `FORWARDABLE_`,`N`.`PRIORITY_` AS `PRIORITY_`,`N`.`NODE_END_USER_` AS `NODE_END_USER_`,`N`.`NODE_END_USER_NAME_` AS `NODE_END_USER_NAME_`,`N`.`NODE_END_DATE_` AS `NODE_END_DATE_`,`N`.`NEXT_CANDIDATE_` AS `NEXT_CANDIDATE_`,`N`.`ISOLATE_SUB_PROC_DEF_CODE_` AS `ISOLATE_SUB_PROC_DEF_CODE_`,`N`.`ISOLATE_SUB_PROC_CANDIDATE_` AS `ISOLATE_SUB_PROC_CANDIDATE_`,`N`.`ISOLATE_SUB_PROC_STATUS_` AS `ISOLATE_SUB_PROC_STATUS_`,`N`.`NODE_STATUS_` AS `NODE_STATUS_`,`N`.`CREATION_DATE_` AS `CREATION_DATE_` from `FF_NODE` `N` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_NODE_P`
--

/*!50001 DROP VIEW IF EXISTS `FFV_NODE_P`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_NODE_P` AS select `N`.`NODE_ID_` AS `NODE_ID_`,`N`.`PARENT_NODE_ID_` AS `PARENT_NODE_ID_`,`N`.`PREVIOUS_NODE_IDS_` AS `PREVIOUS_NODE_IDS_`,`N`.`LAST_COMPLETE_NODE_IDS_` AS `LAST_COMPLETE_NODE_IDS_`,`N`.`SUB_PROC_DEF_ID_` AS `SUB_PROC_DEF_ID_`,`N`.`ADJUST_SUB_PROC_DEF_ID_` AS `ADJUST_SUB_PROC_DEF_ID_`,`N`.`NODE_TYPE_` AS `NODE_TYPE_`,`N`.`NODE_CODE_` AS `NODE_CODE_`,`N`.`NODE_NAME_` AS `NODE_NAME_`,`N`.`PARENT_NODE_CODE_` AS `PARENT_NODE_CODE_`,`N`.`CANDIDATE_ASSIGNEE_` AS `CANDIDATE_ASSIGNEE_`,`N`.`COMPLETE_EXPRESSION_` AS `COMPLETE_EXPRESSION_`,`N`.`COMPLETE_RETURN_` AS `COMPLETE_RETURN_`,`N`.`EXCLUSIVE_` AS `EXCLUSIVE_`,`N`.`WAITING_FOR_COMPLETE_NODE_` AS `WAITING_FOR_COMPLETE_NODE_`,`N`.`AUTO_COMPLETE_SAME_ASSIGNEE_` AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,`N`.`AUTO_COMPLETE_EMPTY_ASSIGNEE_` AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,`N`.`INFORM_` AS `INFORM_`,`N`.`ASSIGNEE_` AS `ASSIGNEE_`,`N`.`ACTION_` AS `ACTION_`,`N`.`DUE_DATE_` AS `DUE_DATE_`,`N`.`CLAIM_` AS `CLAIM_`,`N`.`FORWARDABLE_` AS `FORWARDABLE_`,`N`.`PRIORITY_` AS `PRIORITY_`,`N`.`NODE_END_USER_` AS `NODE_END_USER_`,`N`.`NODE_END_USER_NAME_` AS `NODE_END_USER_NAME_`,`N`.`NODE_END_DATE_` AS `NODE_END_DATE_`,`N`.`NEXT_CANDIDATE_` AS `NEXT_CANDIDATE_`,`N`.`ISOLATE_SUB_PROC_DEF_CODE_` AS `ISOLATE_SUB_PROC_DEF_CODE_`,`N`.`ISOLATE_SUB_PROC_CANDIDATE_` AS `ISOLATE_SUB_PROC_CANDIDATE_`,`N`.`ISOLATE_SUB_PROC_STATUS_` AS `ISOLATE_SUB_PROC_STATUS_`,`N`.`NODE_STATUS_` AS `NODE_STATUS_`,`N`.`CREATION_DATE_` AS `CREATION_DATE_`,`P`.`PROC_ID_` AS `PROC_ID_`,`P`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`P`.`ADJUST_PROC_DEF_ID_` AS `ADJUST_PROC_DEF_ID_`,`P`.`ISOLATE_SUB_PROC_NODE_ID_` AS `ISOLATE_SUB_PROC_NODE_ID_`,`P`.`BIZ_ID_` AS `BIZ_ID_`,`P`.`BIZ_TYPE_` AS `BIZ_TYPE_`,`P`.`BIZ_CODE_` AS `BIZ_CODE_`,`P`.`BIZ_NAME_` AS `BIZ_NAME_`,`P`.`BIZ_DESC_` AS `BIZ_DESC_`,`P`.`PROC_START_USER_` AS `PROC_START_USER_`,`P`.`PROC_START_USER_NAME_` AS `PROC_START_USER_NAME_`,`P`.`PROC_END_USER_` AS `PROC_END_USER_`,`P`.`PROC_END_USER_NAME_` AS `PROC_END_USER_NAME_`,`P`.`PROC_END_DATE_` AS `PROC_END_DATE_`,`P`.`PROC_STATUS_` AS `PROC_STATUS_`,`P`.`CREATION_DATE_` AS `PROC_CREATION_DATE_` from (`FF_NODE` `N` join `FF_PROC` `P` on((`P`.`PROC_ID_` = `N`.`PROC_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_NODE_PD`
--

/*!50001 DROP VIEW IF EXISTS `FFV_NODE_PD`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_NODE_PD` AS select `N`.`NODE_ID_` AS `NODE_ID_`,`N`.`PARENT_NODE_ID_` AS `PARENT_NODE_ID_`,`N`.`PREVIOUS_NODE_IDS_` AS `PREVIOUS_NODE_IDS_`,`N`.`LAST_COMPLETE_NODE_IDS_` AS `LAST_COMPLETE_NODE_IDS_`,`N`.`SUB_PROC_DEF_ID_` AS `SUB_PROC_DEF_ID_`,`N`.`ADJUST_SUB_PROC_DEF_ID_` AS `ADJUST_SUB_PROC_DEF_ID_`,`N`.`NODE_TYPE_` AS `NODE_TYPE_`,`N`.`NODE_CODE_` AS `NODE_CODE_`,`N`.`NODE_NAME_` AS `NODE_NAME_`,`N`.`PARENT_NODE_CODE_` AS `PARENT_NODE_CODE_`,`N`.`CANDIDATE_ASSIGNEE_` AS `CANDIDATE_ASSIGNEE_`,`N`.`COMPLETE_EXPRESSION_` AS `COMPLETE_EXPRESSION_`,`N`.`COMPLETE_RETURN_` AS `COMPLETE_RETURN_`,`N`.`EXCLUSIVE_` AS `EXCLUSIVE_`,`N`.`WAITING_FOR_COMPLETE_NODE_` AS `WAITING_FOR_COMPLETE_NODE_`,`N`.`AUTO_COMPLETE_SAME_ASSIGNEE_` AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,`N`.`AUTO_COMPLETE_EMPTY_ASSIGNEE_` AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,`N`.`INFORM_` AS `INFORM_`,`N`.`ASSIGNEE_` AS `ASSIGNEE_`,`N`.`ACTION_` AS `ACTION_`,`N`.`DUE_DATE_` AS `DUE_DATE_`,`N`.`CLAIM_` AS `CLAIM_`,`N`.`FORWARDABLE_` AS `FORWARDABLE_`,`N`.`PRIORITY_` AS `PRIORITY_`,`N`.`NODE_END_USER_` AS `NODE_END_USER_`,`N`.`NODE_END_USER_NAME_` AS `NODE_END_USER_NAME_`,`N`.`NODE_END_DATE_` AS `NODE_END_DATE_`,`N`.`NEXT_CANDIDATE_` AS `NEXT_CANDIDATE_`,`N`.`ISOLATE_SUB_PROC_DEF_CODE_` AS `ISOLATE_SUB_PROC_DEF_CODE_`,`N`.`ISOLATE_SUB_PROC_CANDIDATE_` AS `ISOLATE_SUB_PROC_CANDIDATE_`,`N`.`ISOLATE_SUB_PROC_STATUS_` AS `ISOLATE_SUB_PROC_STATUS_`,`N`.`NODE_STATUS_` AS `NODE_STATUS_`,`N`.`CREATION_DATE_` AS `CREATION_DATE_`,`P`.`PROC_ID_` AS `PROC_ID_`,`P`.`ADJUST_PROC_DEF_ID_` AS `ADJUST_PROC_DEF_ID_`,`P`.`ISOLATE_SUB_PROC_NODE_ID_` AS `ISOLATE_SUB_PROC_NODE_ID_`,`P`.`BIZ_ID_` AS `BIZ_ID_`,`P`.`BIZ_TYPE_` AS `BIZ_TYPE_`,`P`.`BIZ_CODE_` AS `BIZ_CODE_`,`P`.`BIZ_NAME_` AS `BIZ_NAME_`,`P`.`BIZ_DESC_` AS `BIZ_DESC_`,`P`.`PROC_START_USER_` AS `PROC_START_USER_`,`P`.`PROC_START_USER_NAME_` AS `PROC_START_USER_NAME_`,`P`.`PROC_END_USER_` AS `PROC_END_USER_`,`P`.`PROC_END_USER_NAME_` AS `PROC_END_USER_NAME_`,`P`.`PROC_END_DATE_` AS `PROC_END_DATE_`,`P`.`PROC_STATUS_` AS `PROC_STATUS_`,`P`.`CREATION_DATE_` AS `PROC_CREATION_DATE_`,`PD`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`PD`.`PROC_DEF_CODE_` AS `PROC_DEF_CODE_`,`PD`.`PROC_DEF_NAME_` AS `PROC_DEF_NAME_`,`PD`.`PROC_DEF_CAT_` AS `PROC_DEF_CAT_`,`PD`.`VERSION_` AS `VERSION_`,`PD`.`PROC_DEF_STATUS_` AS `PROC_DEF_STATUS_`,`SPD`.`PROC_DEF_CODE_` AS `SUB_PROC_DEF_CODE_` from (((`FF_NODE` `N` join `FF_PROC` `P` on((`P`.`PROC_ID_` = `N`.`PROC_ID_`))) join `FF_PROC_DEF` `PD` on((`PD`.`PROC_DEF_ID_` = `P`.`PROC_DEF_ID_`))) join `FF_PROC_DEF` `SPD` on((`SPD`.`PROC_DEF_ID_` = `N`.`SUB_PROC_DEF_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_NODE_VAR`
--

/*!50001 DROP VIEW IF EXISTS `FFV_NODE_VAR`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_NODE_VAR` AS select `PV`.`NODE_VAR_ID_` AS `NODE_VAR_ID_`,`PV`.`NODE_ID_` AS `NODE_ID_`,`PV`.`VAR_TYPE_` AS `VAR_TYPE_`,`PV`.`VAR_NAME_` AS `VAR_NAME_`,`PV`.`VALUE_` AS `VALUE_`,`PV`.`OBJ_` AS `OBJ_`,`PV`.`CREATION_DATE_` AS `CREATION_DATE_`,`N`.`PARENT_NODE_ID_` AS `PARENT_NODE_ID_`,`N`.`PROC_ID_` AS `PROC_ID_` from (`FF_NODE_VAR` `PV` join `FF_NODE` `N` on((`N`.`NODE_ID_` = `PV`.`NODE_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_OPERATION`
--

/*!50001 DROP VIEW IF EXISTS `FFV_OPERATION`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_OPERATION` AS select `O`.`OPERATION_ID_` AS `OPERATION_ID_`,`O`.`OPERATION_` AS `OPERATION_`,`O`.`PROC_ID_` AS `PROC_ID_`,`O`.`NODE_ID_` AS `NODE_ID_`,`O`.`TASK_ID_` AS `TASK_ID_`,`O`.`MEMO_` AS `MEMO_`,`O`.`OPERATOR_` AS `OPERATOR_`,`O`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`O`.`OPERATION_DATE_` AS `OPERATION_DATE_`,`O`.`OPERATION_STATUS_` AS `OPERATION_STATUS_` from `FF_OPERATION` `O` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_OPERATION_P`
--

/*!50001 DROP VIEW IF EXISTS `FFV_OPERATION_P`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_OPERATION_P` AS select `O`.`OPERATION_ID_` AS `OPERATION_ID_`,`O`.`OPERATION_` AS `OPERATION_`,`O`.`NODE_ID_` AS `NODE_ID_`,`O`.`TASK_ID_` AS `TASK_ID_`,`O`.`MEMO_` AS `MEMO_`,`O`.`OPERATOR_` AS `OPERATOR_`,`O`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`O`.`OPERATION_DATE_` AS `OPERATION_DATE_`,`O`.`OPERATION_STATUS_` AS `OPERATION_STATUS_`,`P`.`PROC_ID_` AS `PROC_ID_`,`P`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`P`.`ADJUST_PROC_DEF_ID_` AS `ADJUST_PROC_DEF_ID_`,`P`.`ISOLATE_SUB_PROC_NODE_ID_` AS `ISOLATE_SUB_PROC_NODE_ID_`,`P`.`BIZ_ID_` AS `BIZ_ID_`,`P`.`BIZ_TYPE_` AS `BIZ_TYPE_`,`P`.`BIZ_CODE_` AS `BIZ_CODE_`,`P`.`BIZ_NAME_` AS `BIZ_NAME_`,`P`.`BIZ_DESC_` AS `BIZ_DESC_`,`P`.`PROC_START_USER_` AS `PROC_START_USER_`,`P`.`PROC_START_USER_NAME_` AS `PROC_START_USER_NAME_`,`P`.`PROC_END_USER_` AS `PROC_END_USER_`,`P`.`PROC_END_USER_NAME_` AS `PROC_END_USER_NAME_`,`P`.`PROC_END_DATE_` AS `PROC_END_DATE_`,`P`.`PROC_STATUS_` AS `PROC_STATUS_`,`P`.`CREATION_DATE_` AS `CREATION_DATE_` from (`FF_OPERATION` `O` left join `FF_PROC` `P` on((`P`.`PROC_ID_` = `O`.`PROC_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_OPERATION_PD`
--

/*!50001 DROP VIEW IF EXISTS `FFV_OPERATION_PD`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_OPERATION_PD` AS select `O`.`OPERATION_ID_` AS `OPERATION_ID_`,`O`.`OPERATION_` AS `OPERATION_`,`O`.`NODE_ID_` AS `NODE_ID_`,`O`.`TASK_ID_` AS `TASK_ID_`,`O`.`MEMO_` AS `MEMO_`,`O`.`OPERATOR_` AS `OPERATOR_`,`O`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`O`.`OPERATION_DATE_` AS `OPERATION_DATE_`,`O`.`OPERATION_STATUS_` AS `OPERATION_STATUS_`,`P`.`PROC_ID_` AS `PROC_ID_`,`P`.`ADJUST_PROC_DEF_ID_` AS `ADJUST_PROC_DEF_ID_`,`P`.`ISOLATE_SUB_PROC_NODE_ID_` AS `ISOLATE_SUB_PROC_NODE_ID_`,`P`.`BIZ_ID_` AS `BIZ_ID_`,`P`.`BIZ_TYPE_` AS `BIZ_TYPE_`,`P`.`BIZ_CODE_` AS `BIZ_CODE_`,`P`.`BIZ_NAME_` AS `BIZ_NAME_`,`P`.`BIZ_DESC_` AS `BIZ_DESC_`,`P`.`PROC_START_USER_` AS `PROC_START_USER_`,`P`.`PROC_START_USER_NAME_` AS `PROC_START_USER_NAME_`,`P`.`PROC_END_USER_` AS `PROC_END_USER_`,`P`.`PROC_END_USER_NAME_` AS `PROC_END_USER_NAME_`,`P`.`PROC_END_DATE_` AS `PROC_END_DATE_`,`P`.`PROC_STATUS_` AS `PROC_STATUS_`,`P`.`CREATION_DATE_` AS `CREATION_DATE_`,`PD`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`PD`.`PROC_DEF_CODE_` AS `PROC_DEF_CODE_`,`PD`.`PROC_DEF_NAME_` AS `PROC_DEF_NAME_`,`PD`.`PROC_DEF_CAT_` AS `PROC_DEF_CAT_`,`PD`.`VERSION_` AS `VERSION_`,`PD`.`PROC_DEF_STATUS_` AS `PROC_DEF_STATUS_` from ((`FF_OPERATION` `O` left join `FF_PROC` `P` on((`P`.`PROC_ID_` = `O`.`PROC_ID_`))) join `FF_PROC_DEF` `PD` on((`PD`.`PROC_DEF_ID_` = `P`.`PROC_DEF_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_PROC`
--

/*!50001 DROP VIEW IF EXISTS `FFV_PROC`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_PROC` AS select `P`.`PROC_ID_` AS `PROC_ID_`,`P`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`P`.`ADJUST_PROC_DEF_ID_` AS `ADJUST_PROC_DEF_ID_`,`P`.`ISOLATE_SUB_PROC_NODE_ID_` AS `ISOLATE_SUB_PROC_NODE_ID_`,`P`.`BIZ_ID_` AS `BIZ_ID_`,`P`.`BIZ_TYPE_` AS `BIZ_TYPE_`,`P`.`BIZ_CODE_` AS `BIZ_CODE_`,`P`.`BIZ_NAME_` AS `BIZ_NAME_`,`P`.`BIZ_DESC_` AS `BIZ_DESC_`,`P`.`PROC_START_USER_` AS `PROC_START_USER_`,`P`.`PROC_START_USER_NAME_` AS `PROC_START_USER_NAME_`,`P`.`PROC_END_USER_` AS `PROC_END_USER_`,`P`.`PROC_END_USER_NAME_` AS `PROC_END_USER_NAME_`,`P`.`PROC_END_DATE_` AS `PROC_END_DATE_`,`P`.`PROC_STATUS_` AS `PROC_STATUS_`,`P`.`CREATION_DATE_` AS `CREATION_DATE_` from `FF_PROC` `P` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_PROC_DEF`
--

/*!50001 DROP VIEW IF EXISTS `FFV_PROC_DEF`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_PROC_DEF` AS select `FF_PROC_DEF`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`FF_PROC_DEF`.`PROC_DEF_CODE_` AS `PROC_DEF_CODE_`,`FF_PROC_DEF`.`PROC_DEF_NAME_` AS `PROC_DEF_NAME_`,`FF_PROC_DEF`.`PROC_DEF_CAT_` AS `PROC_DEF_CAT_`,`FF_PROC_DEF`.`PROC_DEF_MODEL_` AS `PROC_DEF_MODEL_`,`FF_PROC_DEF`.`PROC_DEF_DIAGRAM_FILE_` AS `PROC_DEF_DIAGRAM_FILE_`,`FF_PROC_DEF`.`PROC_DEF_DIAGRAM_FILE_NAME_` AS `PROC_DEF_DIAGRAM_FILE_NAME_`,`FF_PROC_DEF`.`PROC_DEF_DIAGRAM_FILE_LENGTH_` AS `PROC_DEF_DIAGRAM_FILE_LENGTH_`,`FF_PROC_DEF`.`PROC_DEF_DIAGRAM_WIDTH_` AS `PROC_DEF_DIAGRAM_WIDTH_`,`FF_PROC_DEF`.`PROC_DEF_DIAGRAM_HEIGHT_` AS `PROC_DEF_DIAGRAM_HEIGHT_`,`FF_PROC_DEF`.`MEMO_` AS `MEMO_`,`FF_PROC_DEF`.`EXT_ATTR_1_` AS `EXT_ATTR_1_`,`FF_PROC_DEF`.`EXT_ATTR_2_` AS `EXT_ATTR_2_`,`FF_PROC_DEF`.`EXT_ATTR_3_` AS `EXT_ATTR_3_`,`FF_PROC_DEF`.`EXT_ATTR_4_` AS `EXT_ATTR_4_`,`FF_PROC_DEF`.`EXT_ATTR_5_` AS `EXT_ATTR_5_`,`FF_PROC_DEF`.`EXT_ATTR_6_` AS `EXT_ATTR_6_`,`FF_PROC_DEF`.`EXT_ATTR_7_` AS `EXT_ATTR_7_`,`FF_PROC_DEF`.`EXT_ATTR_8_` AS `EXT_ATTR_8_`,`FF_PROC_DEF`.`VERSION_` AS `VERSION_`,`FF_PROC_DEF`.`PROC_DEF_STATUS_` AS `PROC_DEF_STATUS_`,`FF_PROC_DEF`.`CREATION_DATE_` AS `CREATION_DATE_`,`FF_PROC_DEF`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`FF_PROC_DEF`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`FF_PROC_DEF`.`OPERATOR_NAME_` AS `OPERATOR_NAME_` from `FF_PROC_DEF` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_PROC_PD`
--

/*!50001 DROP VIEW IF EXISTS `FFV_PROC_PD`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_PROC_PD` AS select `P`.`PROC_ID_` AS `PROC_ID_`,`P`.`ADJUST_PROC_DEF_ID_` AS `ADJUST_PROC_DEF_ID_`,`P`.`ISOLATE_SUB_PROC_NODE_ID_` AS `ISOLATE_SUB_PROC_NODE_ID_`,`P`.`BIZ_ID_` AS `BIZ_ID_`,`P`.`BIZ_TYPE_` AS `BIZ_TYPE_`,`P`.`BIZ_CODE_` AS `BIZ_CODE_`,`P`.`BIZ_NAME_` AS `BIZ_NAME_`,`P`.`BIZ_DESC_` AS `BIZ_DESC_`,`P`.`PROC_START_USER_` AS `PROC_START_USER_`,`P`.`PROC_START_USER_NAME_` AS `PROC_START_USER_NAME_`,`P`.`PROC_END_USER_` AS `PROC_END_USER_`,`P`.`PROC_END_USER_NAME_` AS `PROC_END_USER_NAME_`,`P`.`PROC_END_DATE_` AS `PROC_END_DATE_`,`P`.`PROC_STATUS_` AS `PROC_STATUS_`,`P`.`CREATION_DATE_` AS `CREATION_DATE_`,`PD`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`PD`.`PROC_DEF_CODE_` AS `PROC_DEF_CODE_`,`PD`.`PROC_DEF_NAME_` AS `PROC_DEF_NAME_`,`PD`.`PROC_DEF_CAT_` AS `PROC_DEF_CAT_`,`PD`.`VERSION_` AS `VERSION_`,`PD`.`PROC_DEF_STATUS_` AS `PROC_DEF_STATUS_` from (`FF_PROC` `P` join `FF_PROC_DEF` `PD` on((`PD`.`PROC_DEF_ID_` = `P`.`PROC_DEF_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_TASK`
--

/*!50001 DROP VIEW IF EXISTS `FFV_TASK`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_TASK` AS select `T`.`TASK_ID_` AS `TASK_ID_`,`T`.`NODE_ID_` AS `NODE_ID_`,`T`.`PREVIOUS_TASK_ID_` AS `PREVIOUS_TASK_ID_`,`T`.`TASK_TYPE_` AS `TASK_TYPE_`,`T`.`ASSIGNEE_` AS `ASSIGNEE_`,`T`.`ASSIGNEE_NAME_` AS `ASSIGNEE_NAME_`,`T`.`ACTION_` AS `ACTION_`,`T`.`DUE_DATE_` AS `DUE_DATE_`,`T`.`CLAIM_` AS `CLAIM_`,`T`.`FORWARDABLE_` AS `FORWARDABLE_`,`T`.`PRIORITY_` AS `PRIORITY_`,`T`.`FORWARD_STATUS_` AS `FORWARD_STATUS_`,`T`.`TASK_END_USER_` AS `TASK_END_USER_`,`T`.`TASK_END_USER_NAME_` AS `TASK_END_USER_NAME_`,`T`.`TASK_END_DATE_` AS `TASK_END_DATE_`,`T`.`NEXT_CANDIDATE_` AS `NEXT_CANDIDATE_`,`T`.`TASK_STATUS_` AS `TASK_STATUS_`,`T`.`CREATION_DATE_` AS `CREATION_DATE_` from `FF_TASK` `T` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_TASK_N`
--

/*!50001 DROP VIEW IF EXISTS `FFV_TASK_N`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_TASK_N` AS select `T`.`TASK_ID_` AS `TASK_ID_`,`T`.`PREVIOUS_TASK_ID_` AS `PREVIOUS_TASK_ID_`,`T`.`TASK_TYPE_` AS `TASK_TYPE_`,`T`.`ASSIGNEE_` AS `ASSIGNEE_`,`T`.`ASSIGNEE_NAME_` AS `ASSIGNEE_NAME_`,`T`.`ACTION_` AS `ACTION_`,`T`.`DUE_DATE_` AS `DUE_DATE_`,`T`.`CLAIM_` AS `CLAIM_`,`T`.`FORWARDABLE_` AS `FORWARDABLE_`,`T`.`PRIORITY_` AS `PRIORITY_`,`T`.`FORWARD_STATUS_` AS `FORWARD_STATUS_`,`T`.`TASK_END_USER_` AS `TASK_END_USER_`,`T`.`TASK_END_USER_NAME_` AS `TASK_END_USER_NAME_`,`T`.`TASK_END_DATE_` AS `TASK_END_DATE_`,`T`.`NEXT_CANDIDATE_` AS `NEXT_CANDIDATE_`,`T`.`TASK_STATUS_` AS `TASK_STATUS_`,`T`.`CREATION_DATE_` AS `CREATION_DATE_`,`N`.`NODE_ID_` AS `NODE_ID_`,`N`.`PARENT_NODE_ID_` AS `PARENT_NODE_ID_`,`N`.`PROC_ID_` AS `PROC_ID_`,`N`.`PREVIOUS_NODE_IDS_` AS `PREVIOUS_NODE_IDS_`,`N`.`LAST_COMPLETE_NODE_IDS_` AS `LAST_COMPLETE_NODE_IDS_`,`N`.`SUB_PROC_DEF_ID_` AS `SUB_PROC_DEF_ID_`,`N`.`ADJUST_SUB_PROC_DEF_ID_` AS `ADJUST_SUB_PROC_DEF_ID_`,`N`.`NODE_TYPE_` AS `NODE_TYPE_`,`N`.`NODE_CODE_` AS `NODE_CODE_`,`N`.`NODE_NAME_` AS `NODE_NAME_`,`N`.`PARENT_NODE_CODE_` AS `PARENT_NODE_CODE_`,`N`.`CANDIDATE_ASSIGNEE_` AS `CANDIDATE_ASSIGNEE_`,`N`.`COMPLETE_EXPRESSION_` AS `COMPLETE_EXPRESSION_`,`N`.`COMPLETE_RETURN_` AS `COMPLETE_RETURN_`,`N`.`EXCLUSIVE_` AS `EXCLUSIVE_`,`N`.`WAITING_FOR_COMPLETE_NODE_` AS `WAITING_FOR_COMPLETE_NODE_`,`N`.`AUTO_COMPLETE_SAME_ASSIGNEE_` AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,`N`.`AUTO_COMPLETE_EMPTY_ASSIGNEE_` AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,`N`.`INFORM_` AS `INFORM_`,`N`.`NODE_END_USER_` AS `NODE_END_USER_`,`N`.`NODE_END_USER_NAME_` AS `NODE_END_USER_NAME_`,`N`.`NODE_END_DATE_` AS `NODE_END_DATE_`,`N`.`ISOLATE_SUB_PROC_DEF_CODE_` AS `ISOLATE_SUB_PROC_DEF_CODE_`,`N`.`ISOLATE_SUB_PROC_CANDIDATE_` AS `ISOLATE_SUB_PROC_CANDIDATE_`,`N`.`ISOLATE_SUB_PROC_STATUS_` AS `ISOLATE_SUB_PROC_STATUS_`,`N`.`NODE_STATUS_` AS `NODE_STATUS_`,`N`.`CREATION_DATE_` AS `NODE_CREATION_DATE_` from (`FF_TASK` `T` join `FF_NODE` `N` on((`N`.`NODE_ID_` = `T`.`NODE_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_TASK_P`
--

/*!50001 DROP VIEW IF EXISTS `FFV_TASK_P`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_TASK_P` AS select `T`.`TASK_ID_` AS `TASK_ID_`,`T`.`PREVIOUS_TASK_ID_` AS `PREVIOUS_TASK_ID_`,`T`.`TASK_TYPE_` AS `TASK_TYPE_`,`T`.`ASSIGNEE_` AS `ASSIGNEE_`,`T`.`ASSIGNEE_NAME_` AS `ASSIGNEE_NAME_`,`T`.`ACTION_` AS `ACTION_`,`T`.`DUE_DATE_` AS `DUE_DATE_`,`T`.`CLAIM_` AS `CLAIM_`,`T`.`FORWARDABLE_` AS `FORWARDABLE_`,`T`.`PRIORITY_` AS `PRIORITY_`,`T`.`FORWARD_STATUS_` AS `FORWARD_STATUS_`,`T`.`TASK_END_USER_` AS `TASK_END_USER_`,`T`.`TASK_END_USER_NAME_` AS `TASK_END_USER_NAME_`,`T`.`TASK_END_DATE_` AS `TASK_END_DATE_`,`T`.`NEXT_CANDIDATE_` AS `NEXT_CANDIDATE_`,`T`.`TASK_STATUS_` AS `TASK_STATUS_`,`T`.`CREATION_DATE_` AS `CREATION_DATE_`,`N`.`NODE_ID_` AS `NODE_ID_`,`N`.`PARENT_NODE_ID_` AS `PARENT_NODE_ID_`,`N`.`PREVIOUS_NODE_IDS_` AS `PREVIOUS_NODE_IDS_`,`N`.`LAST_COMPLETE_NODE_IDS_` AS `LAST_COMPLETE_NODE_IDS_`,`N`.`SUB_PROC_DEF_ID_` AS `SUB_PROC_DEF_ID_`,`N`.`ADJUST_SUB_PROC_DEF_ID_` AS `ADJUST_SUB_PROC_DEF_ID_`,`N`.`NODE_TYPE_` AS `NODE_TYPE_`,`N`.`NODE_CODE_` AS `NODE_CODE_`,`N`.`NODE_NAME_` AS `NODE_NAME_`,`N`.`PARENT_NODE_CODE_` AS `PARENT_NODE_CODE_`,`N`.`CANDIDATE_ASSIGNEE_` AS `CANDIDATE_ASSIGNEE_`,`N`.`COMPLETE_EXPRESSION_` AS `COMPLETE_EXPRESSION_`,`N`.`COMPLETE_RETURN_` AS `COMPLETE_RETURN_`,`N`.`EXCLUSIVE_` AS `EXCLUSIVE_`,`N`.`WAITING_FOR_COMPLETE_NODE_` AS `WAITING_FOR_COMPLETE_NODE_`,`N`.`AUTO_COMPLETE_SAME_ASSIGNEE_` AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,`N`.`AUTO_COMPLETE_EMPTY_ASSIGNEE_` AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,`N`.`INFORM_` AS `INFORM_`,`N`.`NODE_END_USER_` AS `NODE_END_USER_`,`N`.`NODE_END_USER_NAME_` AS `NODE_END_USER_NAME_`,`N`.`NODE_END_DATE_` AS `NODE_END_DATE_`,`N`.`ISOLATE_SUB_PROC_DEF_CODE_` AS `ISOLATE_SUB_PROC_DEF_CODE_`,`N`.`ISOLATE_SUB_PROC_CANDIDATE_` AS `ISOLATE_SUB_PROC_CANDIDATE_`,`N`.`ISOLATE_SUB_PROC_STATUS_` AS `ISOLATE_SUB_PROC_STATUS_`,`N`.`NODE_STATUS_` AS `NODE_STATUS_`,`N`.`CREATION_DATE_` AS `NODE_CREATION_DATE_`,`P`.`PROC_ID_` AS `PROC_ID_`,`P`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`P`.`ADJUST_PROC_DEF_ID_` AS `ADJUST_PROC_DEF_ID_`,`P`.`ISOLATE_SUB_PROC_NODE_ID_` AS `ISOLATE_SUB_PROC_NODE_ID_`,`P`.`BIZ_ID_` AS `BIZ_ID_`,`P`.`BIZ_TYPE_` AS `BIZ_TYPE_`,`P`.`BIZ_CODE_` AS `BIZ_CODE_`,`P`.`BIZ_NAME_` AS `BIZ_NAME_`,`P`.`BIZ_DESC_` AS `BIZ_DESC_`,`P`.`PROC_START_USER_` AS `PROC_START_USER_`,`P`.`PROC_START_USER_NAME_` AS `PROC_START_USER_NAME_`,`P`.`PROC_END_USER_` AS `PROC_END_USER_`,`P`.`PROC_END_USER_NAME_` AS `PROC_END_USER_NAME_`,`P`.`PROC_END_DATE_` AS `PROC_END_DATE_`,`P`.`PROC_STATUS_` AS `PROC_STATUS_`,`P`.`CREATION_DATE_` AS `PROC_CREATION_DATE_` from ((`FF_TASK` `T` join `FF_NODE` `N` on((`N`.`NODE_ID_` = `T`.`NODE_ID_`))) join `FF_PROC` `P` on((`P`.`PROC_ID_` = `N`.`PROC_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FFV_TASK_PD`
--

/*!50001 DROP VIEW IF EXISTS `FFV_TASK_PD`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `FFV_TASK_PD` AS select `T`.`TASK_ID_` AS `TASK_ID_`,`T`.`PREVIOUS_TASK_ID_` AS `PREVIOUS_TASK_ID_`,`T`.`TASK_TYPE_` AS `TASK_TYPE_`,`T`.`ASSIGNEE_` AS `ASSIGNEE_`,`T`.`ASSIGNEE_NAME_` AS `ASSIGNEE_NAME_`,`T`.`ACTION_` AS `ACTION_`,`T`.`DUE_DATE_` AS `DUE_DATE_`,`T`.`CLAIM_` AS `CLAIM_`,`T`.`FORWARDABLE_` AS `FORWARDABLE_`,`T`.`PRIORITY_` AS `PRIORITY_`,`T`.`FORWARD_STATUS_` AS `FORWARD_STATUS_`,`T`.`TASK_END_USER_` AS `TASK_END_USER_`,`T`.`TASK_END_USER_NAME_` AS `TASK_END_USER_NAME_`,`T`.`TASK_END_DATE_` AS `TASK_END_DATE_`,`T`.`NEXT_CANDIDATE_` AS `NEXT_CANDIDATE_`,`T`.`TASK_STATUS_` AS `TASK_STATUS_`,`T`.`CREATION_DATE_` AS `CREATION_DATE_`,`N`.`NODE_ID_` AS `NODE_ID_`,`N`.`PARENT_NODE_ID_` AS `PARENT_NODE_ID_`,`N`.`PREVIOUS_NODE_IDS_` AS `PREVIOUS_NODE_IDS_`,`N`.`LAST_COMPLETE_NODE_IDS_` AS `LAST_COMPLETE_NODE_IDS_`,`N`.`SUB_PROC_DEF_ID_` AS `SUB_PROC_DEF_ID_`,`N`.`ADJUST_SUB_PROC_DEF_ID_` AS `ADJUST_SUB_PROC_DEF_ID_`,`N`.`NODE_TYPE_` AS `NODE_TYPE_`,`N`.`NODE_CODE_` AS `NODE_CODE_`,`N`.`NODE_NAME_` AS `NODE_NAME_`,`N`.`PARENT_NODE_CODE_` AS `PARENT_NODE_CODE_`,`N`.`CANDIDATE_ASSIGNEE_` AS `CANDIDATE_ASSIGNEE_`,`N`.`COMPLETE_EXPRESSION_` AS `COMPLETE_EXPRESSION_`,`N`.`COMPLETE_RETURN_` AS `COMPLETE_RETURN_`,`N`.`EXCLUSIVE_` AS `EXCLUSIVE_`,`N`.`WAITING_FOR_COMPLETE_NODE_` AS `WAITING_FOR_COMPLETE_NODE_`,`N`.`AUTO_COMPLETE_SAME_ASSIGNEE_` AS `AUTO_COMPLETE_SAME_ASSIGNEE_`,`N`.`AUTO_COMPLETE_EMPTY_ASSIGNEE_` AS `AUTO_COMPLETE_EMPTY_ASSIGNEE_`,`N`.`INFORM_` AS `INFORM_`,`N`.`NODE_END_USER_` AS `NODE_END_USER_`,`N`.`NODE_END_USER_NAME_` AS `NODE_END_USER_NAME_`,`N`.`NODE_END_DATE_` AS `NODE_END_DATE_`,`N`.`ISOLATE_SUB_PROC_DEF_CODE_` AS `ISOLATE_SUB_PROC_DEF_CODE_`,`N`.`ISOLATE_SUB_PROC_CANDIDATE_` AS `ISOLATE_SUB_PROC_CANDIDATE_`,`N`.`ISOLATE_SUB_PROC_STATUS_` AS `ISOLATE_SUB_PROC_STATUS_`,`N`.`NODE_STATUS_` AS `NODE_STATUS_`,`N`.`CREATION_DATE_` AS `NODE_CREATION_DATE_`,`P`.`PROC_ID_` AS `PROC_ID_`,`P`.`ADJUST_PROC_DEF_ID_` AS `ADJUST_PROC_DEF_ID_`,`P`.`ISOLATE_SUB_PROC_NODE_ID_` AS `ISOLATE_SUB_PROC_NODE_ID_`,`P`.`BIZ_ID_` AS `BIZ_ID_`,`P`.`BIZ_TYPE_` AS `BIZ_TYPE_`,`P`.`BIZ_CODE_` AS `BIZ_CODE_`,`P`.`BIZ_NAME_` AS `BIZ_NAME_`,`P`.`BIZ_DESC_` AS `BIZ_DESC_`,`P`.`PROC_START_USER_` AS `PROC_START_USER_`,`P`.`PROC_START_USER_NAME_` AS `PROC_START_USER_NAME_`,`P`.`PROC_END_USER_` AS `PROC_END_USER_`,`P`.`PROC_END_USER_NAME_` AS `PROC_END_USER_NAME_`,`P`.`PROC_END_DATE_` AS `PROC_END_DATE_`,`P`.`PROC_STATUS_` AS `PROC_STATUS_`,`P`.`CREATION_DATE_` AS `PROC_CREATION_DATE_`,`PD`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`PD`.`PROC_DEF_CODE_` AS `PROC_DEF_CODE_`,`PD`.`PROC_DEF_NAME_` AS `PROC_DEF_NAME_`,`PD`.`PROC_DEF_CAT_` AS `PROC_DEF_CAT_`,`PD`.`VERSION_` AS `VERSION_`,`PD`.`PROC_DEF_STATUS_` AS `PROC_DEF_STATUS_` from (((`FF_TASK` `T` join `FF_NODE` `N` on((`N`.`NODE_ID_` = `T`.`NODE_ID_`))) join `FF_PROC` `P` on((`P`.`PROC_ID_` = `N`.`PROC_ID_`))) join `FF_PROC_DEF` `PD` on((`PD`.`PROC_DEF_ID_` = `P`.`PROC_DEF_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `KV_APPROVAL_MEMO`
--

/*!50001 DROP VIEW IF EXISTS `KV_APPROVAL_MEMO`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `KV_APPROVAL_MEMO` AS select `AM`.`APPROVAL_MEMO_ID_` AS `APPROVAL_MEMO_ID_`,`AM`.`TASK_ID_` AS `TASK_ID_`,`AM`.`PREVIOUS_TASK_ID_` AS `PREVIOUS_TASK_ID_`,`AM`.`NODE_ID_` AS `NODE_ID_`,`AM`.`NODE_TYPE_` AS `NODE_TYPE_`,`AM`.`NODE_NAME_` AS `NODE_NAME_`,`AM`.`PARENT_NODE_ID_` AS `PARENT_NODE_ID_`,`AM`.`PROC_ID_` AS `PROC_ID_`,`AM`.`BIZ_ID_` AS `BIZ_ID_`,`AM`.`ASSIGNEE_` AS `ASSIGNEE_`,`AM`.`ASSIGNEE_CODE_` AS `ASSIGNEE_CODE_`,`AM`.`ASSIGNEE_NAME_` AS `ASSIGNEE_NAME_`,`AM`.`EXECUTOR_` AS `EXECUTOR_`,`AM`.`EXECUTOR_CODE_` AS `EXECUTOR_CODE_`,`AM`.`EXECUTOR_NAME_` AS `EXECUTOR_NAME_`,`AM`.`ORG_ID_` AS `ORG_ID_`,`AM`.`ORG_NAME_` AS `ORG_NAME_`,`AM`.`COM_ID_` AS `COM_ID_`,`AM`.`COM_NAME_` AS `COM_NAME_`,`AM`.`CREATION_DATE_` AS `CREATION_DATE_`,`AM`.`DUE_DATE_` AS `DUE_DATE_`,`AM`.`APPROVAL_MEMO_TYPE_` AS `APPROVAL_MEMO_TYPE_`,`AM`.`APPROVAL_MEMO_` AS `APPROVAL_MEMO_`,`AM`.`APPROVAL_DATE_` AS `APPROVAL_DATE_`,`AM`.`APPROVAL_MEMO_STATUS_` AS `APPROVAL_MEMO_STATUS_` from `K_APPROVAL_MEMO` `AM` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `KV_DOC`
--

/*!50001 DROP VIEW IF EXISTS `KV_DOC`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `KV_DOC` AS select `D`.`DOC_ID_` AS `DOC_ID_`,`D`.`DOC_TYPE_NAME_` AS `DOC_TYPE_NAME_`,`D`.`DOC_CODE_` AS `DOC_CODE_`,`D`.`DOC_NAME_` AS `DOC_NAME_`,`D`.`MEMO_` AS `MEMO_`,`D`.`TEMPLATE_FILE_NAME_` AS `TEMPLATE_FILE_NAME_`,`D`.`TEMPLATE_FILE_LENGTH_` AS `TEMPLATE_FILE_LENGTH_`,`D`.`DOC_FILE_NAME_` AS `DOC_FILE_NAME_`,`D`.`DOC_FILE_LENGTH_` AS `DOC_FILE_LENGTH_`,`D`.`TEMPLATE_BOOKMARK_` AS `TEMPLATE_BOOKMARK_`,`D`.`TEMPLATE_INDEX_` AS `TEMPLATE_INDEX_`,`D`.`TEMPLATE_HTML_` AS `TEMPLATE_HTML_`,`D`.`USING_TEMPLATE_PLACEHOLDERS_` AS `USING_TEMPLATE_PLACEHOLDERS_`,`D`.`DRAFTER_ID_` AS `DRAFTER_ID_`,`D`.`DRAFTER_NAME_` AS `DRAFTER_NAME_`,`D`.`DRAFTER_COM_ID_` AS `DRAFTER_COM_ID_`,`D`.`DRAFTER_COM_NAME_` AS `DRAFTER_COM_NAME_`,`D`.`PROC_DEF_CODE_` AS `PROC_DEF_CODE_`,`D`.`PROC_ID_` AS `PROC_ID_`,`D`.`PROC_STATUS_` AS `PROC_STATUS_`,`D`.`DOC_STATUS_` AS `DOC_STATUS_`,`D`.`CREATION_DATE_` AS `CREATION_DATE_`,`D`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`D`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`D`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`D`.`VERSION_` AS `VERSION_` from `K_DOC` `D` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `KV_DOC_DATA`
--

/*!50001 DROP VIEW IF EXISTS `KV_DOC_DATA`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `KV_DOC_DATA` AS select `DD`.`DOC_DATA_ID_` AS `DOC_DATA_ID_`,`DD`.`DOC_ID_` AS `DOC_ID_`,`DD`.`BOOKMARK_` AS `BOOKMARK_`,`DD`.`DATA_TYPE_` AS `DATA_TYPE_`,`DD`.`VALUE_` AS `VALUE_`,`DD`.`ORDER_` AS `ORDER_` from `K_DOC_DATA` `DD` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `KV_DOC_RIDER`
--

/*!50001 DROP VIEW IF EXISTS `KV_DOC_RIDER`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `KV_DOC_RIDER` AS select `DR`.`DOC_RIDER_ID_` AS `DOC_RIDER_ID_`,`DR`.`DOC_ID_` AS `DOC_ID_`,`DR`.`DOC_RIDER_FILE_NAME_` AS `DOC_RIDER_FILE_NAME_`,`DR`.`DOC_RIDER_FILE_LENGTH_` AS `DOC_RIDER_FILE_LENGTH_`,`DR`.`MD5_` AS `MD5_`,`DR`.`CREATION_DATE_` AS `CREATION_DATE_`,`DR`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`DR`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`DR`.`OPERATOR_NAME_` AS `OPERATOR_NAME_` from `K_DOC_RIDER` `DR` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `KV_DOC_TYPE`
--

/*!50001 DROP VIEW IF EXISTS `KV_DOC_TYPE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `KV_DOC_TYPE` AS select `DT`.`DOC_TYPE_ID_` AS `DOC_TYPE_ID_`,`DT`.`DOC_TYPE_NAME_` AS `DOC_TYPE_NAME_`,`DT`.`TEMPLATE_FILE_NAME_` AS `TEMPLATE_FILE_NAME_`,`DT`.`TEMPLATE_FILE_LENGTH_` AS `TEMPLATE_FILE_LENGTH_`,`DT`.`TEMPLATE_BOOKMARK_` AS `TEMPLATE_BOOKMARK_`,`DT`.`TEMPLATE_INDEX_` AS `TEMPLATE_INDEX_`,`DT`.`TEMPLATE_HTML_` AS `TEMPLATE_HTML_`,`DT`.`USING_TEMPLATE_PLACEHOLDERS_` AS `USING_TEMPLATE_PLACEHOLDERS_`,`DT`.`PROC_DEF_CODE_` AS `PROC_DEF_CODE_`,`DT`.`DESC_` AS `DESC_`,`DT`.`ORDER_` AS `ORDER_`,`DT`.`DOC_TYPE_STATUS_` AS `DOC_TYPE_STATUS_`,`DT`.`CREATION_DATE_` AS `CREATION_DATE_`,`DT`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`DT`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`DT`.`OPERATOR_NAME_` AS `OPERATOR_NAME_` from `K_DOC_TYPE` `DT` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_CODE`
--

/*!50001 DROP VIEW IF EXISTS `OMV_CODE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_CODE` AS select `OM_CODE`.`CODE_ID_` AS `CODE_ID_`,`OM_CODE`.`PARENT_CODE_ID_` AS `PARENT_CODE_ID_`,`OM_CODE`.`CATEGORY_` AS `CATEGORY_`,`OM_CODE`.`CODE_` AS `CODE_`,`OM_CODE`.`NAME_` AS `NAME_`,`OM_CODE`.`EXT_ATTR_1_` AS `EXT_ATTR_1_`,`OM_CODE`.`EXT_ATTR_2_` AS `EXT_ATTR_2_`,`OM_CODE`.`EXT_ATTR_3_` AS `EXT_ATTR_3_`,`OM_CODE`.`EXT_ATTR_4_` AS `EXT_ATTR_4_`,`OM_CODE`.`EXT_ATTR_5_` AS `EXT_ATTR_5_`,`OM_CODE`.`EXT_ATTR_6_` AS `EXT_ATTR_6_`,`OM_CODE`.`ORDER_` AS `ORDER_` from `OM_CODE` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_DUTY`
--

/*!50001 DROP VIEW IF EXISTS `OMV_DUTY`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_DUTY` AS select `ORGN_SET`.`ORGN_SET_ID_` AS `ORGN_SET_ID_`,`ORGN_SET`.`ORGN_SET_CODE_` AS `ORGN_SET_CODE_`,`ORGN_SET`.`ORGN_SET_NAME_` AS `ORGN_SET_NAME_`,`D`.`DUTY_ID_` AS `DUTY_ID_`,`D`.`DUTY_CODE_` AS `DUTY_CODE_`,`D`.`DUTY_NAME_` AS `DUTY_NAME_`,`D`.`DUTY_CATEGORY_` AS `DUTY_CATEGORY_`,`D`.`MEMO_` AS `MEMO_`,`D`.`DUTY_TAG_` AS `DUTY_TAG_`,`D`.`DUTY_EXT_ATTR_1_` AS `DUTY_EXT_ATTR_1_`,`D`.`DUTY_EXT_ATTR_2_` AS `DUTY_EXT_ATTR_2_`,`D`.`DUTY_EXT_ATTR_3_` AS `DUTY_EXT_ATTR_3_`,`D`.`DUTY_EXT_ATTR_4_` AS `DUTY_EXT_ATTR_4_`,`D`.`DUTY_EXT_ATTR_5_` AS `DUTY_EXT_ATTR_5_`,`D`.`DUTY_EXT_ATTR_6_` AS `DUTY_EXT_ATTR_6_`,`D`.`DUTY_EXT_ATTR_7_` AS `DUTY_EXT_ATTR_7_`,`D`.`DUTY_EXT_ATTR_8_` AS `DUTY_EXT_ATTR_8_`,`D`.`ORDER_` AS `ORDER_`,`D`.`DUTY_STATUS_` AS `DUTY_STATUS_`,`D`.`CREATION_DATE_` AS `CREATION_DATE_`,`D`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`D`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`D`.`OPERATOR_NAME_` AS `OPERATOR_NAME_` from (`OM_DUTY` `D` join `OM_ORGN_SET` `ORGN_SET` on((`ORGN_SET`.`ORGN_SET_ID_` = `D`.`ORGN_SET_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_EMP`
--

/*!50001 DROP VIEW IF EXISTS `OMV_EMP`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_EMP` AS select `ORGN_SET`.`ORGN_SET_ID_` AS `ORGN_SET_ID_`,`ORGN_SET`.`ORGN_SET_CODE_` AS `ORGN_SET_CODE_`,`ORGN_SET`.`ORGN_SET_NAME_` AS `ORGN_SET_NAME_`,`E`.`EMP_ID_` AS `EMP_ID_`,`E`.`EMP_CODE_` AS `EMP_CODE_`,`E`.`EMP_NAME_` AS `EMP_NAME_`,`E`.`PASSWORD_RESET_REQ_` AS `PASSWORD_RESET_REQ_`,`E`.`PARTY_` AS `PARTY_`,`E`.`EMP_LEVEL_` AS `EMP_LEVEL_`,`E`.`GENDER_` AS `GENDER_`,`E`.`BIRTH_DATE_` AS `BIRTH_DATE_`,`E`.`TEL_` AS `TEL_`,`E`.`EMAIL_` AS `EMAIL_`,`E`.`IN_DATE_` AS `IN_DATE_`,`E`.`OUT_DATE_` AS `OUT_DATE_`,`E`.`EMP_CATEGORY_` AS `EMP_CATEGORY_`,`E`.`MEMO_` AS `MEMO_`,`E`.`EMP_TAG_` AS `EMP_TAG_`,`E`.`EMP_EXT_ATTR_1_` AS `EMP_EXT_ATTR_1_`,`E`.`EMP_EXT_ATTR_2_` AS `EMP_EXT_ATTR_2_`,`E`.`EMP_EXT_ATTR_3_` AS `EMP_EXT_ATTR_3_`,`E`.`EMP_EXT_ATTR_4_` AS `EMP_EXT_ATTR_4_`,`E`.`EMP_EXT_ATTR_5_` AS `EMP_EXT_ATTR_5_`,`E`.`EMP_EXT_ATTR_6_` AS `EMP_EXT_ATTR_6_`,`E`.`EMP_EXT_ATTR_7_` AS `EMP_EXT_ATTR_7_`,`E`.`EMP_EXT_ATTR_8_` AS `EMP_EXT_ATTR_8_`,`E`.`ORDER_` AS `ORDER_`,`E`.`EMP_STATUS_` AS `EMP_STATUS_`,`E`.`CREATION_DATE_` AS `CREATION_DATE_`,`E`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`E`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`E`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`O1`.`ORG_ID_` AS `ORG_ID_`,`O1`.`PARENT_ORG_ID_` AS `PARENT_ORG_ID_`,`O1`.`ORG_CODE_` AS `ORG_CODE_`,`O1`.`ORG_NAME_` AS `ORG_NAME_`,`O1`.`ORG_ABBR_NAME_` AS `ORG_ABBR_NAME_`,`O1`.`ORG_TYPE_` AS `ORG_TYPE_`,`O1`.`ORG_CATEGORY_` AS `ORG_CATEGORY_`,`O1`.`ORG_TAG_` AS `ORG_TAG_`,`O1`.`ORG_EXT_ATTR_1_` AS `ORG_EXT_ATTR_1_`,`O1`.`ORG_EXT_ATTR_2_` AS `ORG_EXT_ATTR_2_`,`O1`.`ORG_EXT_ATTR_3_` AS `ORG_EXT_ATTR_3_`,`O1`.`ORG_EXT_ATTR_4_` AS `ORG_EXT_ATTR_4_`,`O1`.`ORG_EXT_ATTR_5_` AS `ORG_EXT_ATTR_5_`,`O1`.`ORG_EXT_ATTR_6_` AS `ORG_EXT_ATTR_6_`,`O1`.`ORG_EXT_ATTR_7_` AS `ORG_EXT_ATTR_7_`,`O1`.`ORG_EXT_ATTR_8_` AS `ORG_EXT_ATTR_8_`,`O1`.`ORG_STATUS_` AS `ORG_STATUS_`,`O2`.`ORG_CODE_` AS `PARENT_ORG_CODE_`,`O2`.`ORG_NAME_` AS `PARENT_ORG_NAME_` from (((`OM_EMP` `E` join `OM_ORGN_SET` `ORGN_SET` on((`ORGN_SET`.`ORGN_SET_ID_` = `E`.`ORGN_SET_ID_`))) left join `OM_ORG` `O1` on(((`O1`.`ORGN_SET_ID_` = `E`.`ORGN_SET_ID_`) and (`O1`.`ORG_ID_` = `E`.`ORG_ID_`)))) left join `OM_ORG` `O2` on(((`O2`.`ORGN_SET_ID_` = `O1`.`ORGN_SET_ID_`) and (`O2`.`ORG_ID_` = `O1`.`PARENT_ORG_ID_`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_EMP_RELATION`
--

/*!50001 DROP VIEW IF EXISTS `OMV_EMP_RELATION`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_EMP_RELATION` AS select `ORGN_SET`.`ORGN_SET_ID_` AS `ORGN_SET_ID_`,`ORGN_SET`.`ORGN_SET_CODE_` AS `ORGN_SET_CODE_`,`ORGN_SET`.`ORGN_SET_NAME_` AS `ORGN_SET_NAME_`,`ER`.`EMP_RELATION_ID_` AS `EMP_RELATION_ID_`,`ER`.`EMP_RELATION_` AS `EMP_RELATION_`,`ER`.`EMP_RELATION_CATEGORY_` AS `EMP_RELATION_CATEGORY_`,`ER`.`MEMO_` AS `MEMO_`,`ER`.`EMP_RELATION_TAG_` AS `EMP_RELATION_TAG_`,`ER`.`EMP_RELATION_EXT_ATTR_1_` AS `EMP_RELATION_EXT_ATTR_1_`,`ER`.`EMP_RELATION_EXT_ATTR_2_` AS `EMP_RELATION_EXT_ATTR_2_`,`ER`.`EMP_RELATION_EXT_ATTR_3_` AS `EMP_RELATION_EXT_ATTR_3_`,`ER`.`EMP_RELATION_EXT_ATTR_4_` AS `EMP_RELATION_EXT_ATTR_4_`,`ER`.`EMP_RELATION_EXT_ATTR_5_` AS `EMP_RELATION_EXT_ATTR_5_`,`ER`.`EMP_RELATION_EXT_ATTR_6_` AS `EMP_RELATION_EXT_ATTR_6_`,`ER`.`EMP_RELATION_EXT_ATTR_7_` AS `EMP_RELATION_EXT_ATTR_7_`,`ER`.`EMP_RELATION_EXT_ATTR_8_` AS `EMP_RELATION_EXT_ATTR_8_`,`ER`.`ORDER_` AS `ORDER_`,`ER`.`EMP_RELATION_STATUS_` AS `EMP_RELATION_STATUS_`,`ER`.`CREATION_DATE_` AS `CREATION_DATE_`,`ER`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`ER`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`ER`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`UE`.`EMP_ID_` AS `UPPER_EMP_ID_`,`UE`.`EMP_CODE_` AS `UPPER_EMP_CODE_`,`UE`.`EMP_NAME_` AS `UPPER_EMP_NAME_`,`UE`.`PASSWORD_RESET_REQ_` AS `UPPER_PASSWORD_RESET_REQ_`,`UE`.`PARTY_` AS `UPPER_PARTY_`,`UE`.`EMP_LEVEL_` AS `UPPER_EMP_LEVEL_`,`UE`.`GENDER_` AS `UPPER_GENDER_`,`UE`.`BIRTH_DATE_` AS `UPPER_BIRTH_DATE_`,`UE`.`TEL_` AS `UPPER_TEL_`,`UE`.`EMAIL_` AS `UPPER_EMAIL_`,`UE`.`IN_DATE_` AS `UPPER_IN_DATE_`,`UE`.`OUT_DATE_` AS `UPPER_OUT_DATE_`,`UE`.`EMP_CATEGORY_` AS `UPPER_EMP_CATEGORY_`,`UE`.`EMP_TAG_` AS `UPPER_EMP_TAG_`,`UE`.`EMP_EXT_ATTR_1_` AS `UPPER_EMP_EXT_ATTR_1_`,`UE`.`EMP_EXT_ATTR_2_` AS `UPPER_EMP_EXT_ATTR_2_`,`UE`.`EMP_EXT_ATTR_3_` AS `UPPER_EMP_EXT_ATTR_3_`,`UE`.`EMP_EXT_ATTR_4_` AS `UPPER_EMP_EXT_ATTR_4_`,`UE`.`EMP_EXT_ATTR_5_` AS `UPPER_EMP_EXT_ATTR_5_`,`UE`.`EMP_EXT_ATTR_6_` AS `UPPER_EMP_EXT_ATTR_6_`,`UE`.`EMP_EXT_ATTR_7_` AS `UPPER_EMP_EXT_ATTR_7_`,`UE`.`EMP_EXT_ATTR_8_` AS `UPPER_EMP_EXT_ATTR_8_`,`UE`.`EMP_STATUS_` AS `UPPER_EMP_STATUS_`,`UO1`.`ORG_ID_` AS `UPPER_ORG_ID_`,`UO1`.`PARENT_ORG_ID_` AS `UPPER_PARENT_ORG_ID_`,`UO1`.`ORG_CODE_` AS `UPPER_ORG_CODE_`,`UO1`.`ORG_NAME_` AS `UPPER_ORG_NAME_`,`UO1`.`ORG_ABBR_NAME_` AS `UPPER_ORG_ABBR_NAME_`,`UO1`.`ORG_TYPE_` AS `UPPER_ORG_TYPE_`,`UO1`.`ORG_CATEGORY_` AS `UPPER_ORG_CATEGORY_`,`UO1`.`ORG_TAG_` AS `UPPER_ORG_TAG_`,`UO1`.`ORG_EXT_ATTR_1_` AS `UPPER_ORG_EXT_ATTR_1_`,`UO1`.`ORG_EXT_ATTR_2_` AS `UPPER_ORG_EXT_ATTR_2_`,`UO1`.`ORG_EXT_ATTR_3_` AS `UPPER_ORG_EXT_ATTR_3_`,`UO1`.`ORG_EXT_ATTR_4_` AS `UPPER_ORG_EXT_ATTR_4_`,`UO1`.`ORG_EXT_ATTR_5_` AS `UPPER_ORG_EXT_ATTR_5_`,`UO1`.`ORG_EXT_ATTR_6_` AS `UPPER_ORG_EXT_ATTR_6_`,`UO1`.`ORG_EXT_ATTR_7_` AS `UPPER_ORG_EXT_ATTR_7_`,`UO1`.`ORG_EXT_ATTR_8_` AS `UPPER_ORG_EXT_ATTR_8_`,`UO1`.`ORG_STATUS_` AS `UPPER_ORG_STATUS_`,`UO2`.`ORG_CODE_` AS `UPPER_PARENT_ORG_CODE_`,`UO2`.`ORG_NAME_` AS `UPPER_PARENT_ORG_NAME_`,`LE`.`EMP_ID_` AS `LOWER_EMP_ID_`,`LE`.`EMP_CODE_` AS `LOWER_EMP_CODE_`,`LE`.`EMP_NAME_` AS `LOWER_EMP_NAME_`,`LE`.`PASSWORD_RESET_REQ_` AS `LOWER_PASSWORD_RESET_REQ_`,`LE`.`PARTY_` AS `LOWER_PARTY_`,`LE`.`EMP_LEVEL_` AS `LOWER_EMP_LEVEL_`,`LE`.`GENDER_` AS `LOWER_GENDER_`,`LE`.`BIRTH_DATE_` AS `LOWER_BIRTH_DATE_`,`LE`.`TEL_` AS `LOWER_TEL_`,`LE`.`EMAIL_` AS `LOWER_EMAIL_`,`LE`.`IN_DATE_` AS `LOWER_IN_DATE_`,`LE`.`OUT_DATE_` AS `LOWER_OUT_DATE_`,`LE`.`EMP_CATEGORY_` AS `LOWER_EMP_CATEGORY_`,`LE`.`EMP_TAG_` AS `LOWER_EMP_TAG_`,`LE`.`EMP_EXT_ATTR_1_` AS `LOWER_EMP_EXT_ATTR_1_`,`LE`.`EMP_EXT_ATTR_2_` AS `LOWER_EMP_EXT_ATTR_2_`,`LE`.`EMP_EXT_ATTR_3_` AS `LOWER_EMP_EXT_ATTR_3_`,`LE`.`EMP_EXT_ATTR_4_` AS `LOWER_EMP_EXT_ATTR_4_`,`LE`.`EMP_EXT_ATTR_5_` AS `LOWER_EMP_EXT_ATTR_5_`,`LE`.`EMP_EXT_ATTR_6_` AS `LOWER_EMP_EXT_ATTR_6_`,`LE`.`EMP_EXT_ATTR_7_` AS `LOWER_EMP_EXT_ATTR_7_`,`LE`.`EMP_EXT_ATTR_8_` AS `LOWER_EMP_EXT_ATTR_8_`,`LE`.`EMP_STATUS_` AS `LOWER_EMP_STATUS_`,`LO1`.`ORG_ID_` AS `LOWER_ORG_ID_`,`LO1`.`PARENT_ORG_ID_` AS `LOWER_PARENT_ORG_ID_`,`LO1`.`ORG_CODE_` AS `LOWER_ORG_CODE_`,`LO1`.`ORG_NAME_` AS `LOWER_ORG_NAME_`,`LO1`.`ORG_ABBR_NAME_` AS `LOWER_ORG_ABBR_NAME_`,`LO1`.`ORG_TYPE_` AS `LOWER_ORG_TYPE_`,`LO1`.`ORG_CATEGORY_` AS `LOWER_ORG_CATEGORY_`,`LO1`.`ORG_TAG_` AS `LOWER_ORG_TAG_`,`LO1`.`ORG_EXT_ATTR_1_` AS `LOWER_ORG_EXT_ATTR_1_`,`LO1`.`ORG_EXT_ATTR_2_` AS `LOWER_ORG_EXT_ATTR_2_`,`LO1`.`ORG_EXT_ATTR_3_` AS `LOWER_ORG_EXT_ATTR_3_`,`LO1`.`ORG_EXT_ATTR_4_` AS `LOWER_ORG_EXT_ATTR_4_`,`LO1`.`ORG_EXT_ATTR_5_` AS `LOWER_ORG_EXT_ATTR_5_`,`LO1`.`ORG_EXT_ATTR_6_` AS `LOWER_ORG_EXT_ATTR_6_`,`LO1`.`ORG_EXT_ATTR_7_` AS `LOWER_ORG_EXT_ATTR_7_`,`LO1`.`ORG_EXT_ATTR_8_` AS `LOWER_ORG_EXT_ATTR_8_`,`LO1`.`ORG_STATUS_` AS `LOWER_ORG_STATUS_`,`LO2`.`ORG_CODE_` AS `LOWER_PARENT_ORG_CODE_`,`LO2`.`ORG_NAME_` AS `LOWER_PARENT_ORG_NAME_` from (((((((`OM_EMP_RELATION` `ER` join `OM_ORGN_SET` `ORGN_SET` on((`ORGN_SET`.`ORGN_SET_ID_` = `ER`.`ORGN_SET_ID_`))) join `OM_EMP` `UE` on(((`UE`.`ORGN_SET_ID_` = `ER`.`ORGN_SET_ID_`) and (`UE`.`EMP_ID_` = `ER`.`UPPER_EMP_ID_`)))) join `OM_ORG` `UO1` on(((`UO1`.`ORGN_SET_ID_` = `UE`.`ORGN_SET_ID_`) and (`UO1`.`ORG_ID_` = `UE`.`ORG_ID_`)))) left join `OM_ORG` `UO2` on(((`UO2`.`ORGN_SET_ID_` = `UO1`.`ORGN_SET_ID_`) and (`UO2`.`ORG_ID_` = `UO1`.`PARENT_ORG_ID_`)))) join `OM_EMP` `LE` on(((`LE`.`ORGN_SET_ID_` = `ER`.`ORGN_SET_ID_`) and (`LE`.`EMP_ID_` = `ER`.`LOWER_EMP_ID_`)))) join `OM_ORG` `LO1` on(((`LO1`.`ORGN_SET_ID_` = `LE`.`ORGN_SET_ID_`) and (`LO1`.`ORG_ID_` = `LE`.`ORG_ID_`)))) left join `OM_ORG` `LO2` on(((`LO2`.`ORGN_SET_ID_` = `LO1`.`ORGN_SET_ID_`) and (`LO2`.`ORG_ID_` = `LO1`.`PARENT_ORG_ID_`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_LOG`
--

/*!50001 DROP VIEW IF EXISTS `OMV_LOG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_LOG` AS select `OM_LOG`.`LOG_ID_` AS `LOG_ID_`,`OM_LOG`.`CATEGORY_` AS `CATEGORY_`,`OM_LOG`.`IP_` AS `IP_`,`OM_LOG`.`USER_AGENT_` AS `USER_AGENT_`,`OM_LOG`.`URL_` AS `URL_`,`OM_LOG`.`ACTION_` AS `ACTION_`,`OM_LOG`.`PARAMETER_MAP_` AS `PARAMETER_MAP_`,`OM_LOG`.`BUSINESS_KEY_` AS `BUSINESS_KEY_`,`OM_LOG`.`ERROR_` AS `ERROR_`,`OM_LOG`.`MESSAGE_` AS `MESSAGE_`,`OM_LOG`.`ORG_ID_` AS `ORG_ID_`,`OM_LOG`.`ORG_NAME_` AS `ORG_NAME_`,`OM_LOG`.`POSI_ID_` AS `POSI_ID_`,`OM_LOG`.`POSI_NAME_` AS `POSI_NAME_`,`OM_LOG`.`EMP_ID_` AS `EMP_ID_`,`OM_LOG`.`EMP_NAME_` AS `EMP_NAME_`,`OM_LOG`.`CREATION_DATE_` AS `CREATION_DATE_` from `OM_LOG` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_MAIN_SERVER`
--

/*!50001 DROP VIEW IF EXISTS `OMV_MAIN_SERVER`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_MAIN_SERVER` AS select `MS`.`MAIN_SERVER_ID_` AS `MAIN_SERVER_ID_`,`MS`.`MAIN_SERVER_NAME_` AS `MAIN_SERVER_NAME_`,`MS`.`DRIVER_CLASS_NAME_` AS `DRIVER_CLASS_NAME_`,`MS`.`URL_` AS `URL_`,`MS`.`USERNAME_` AS `USERNAME_`,`MS`.`PASSWORD_` AS `PASSWORD_`,`MS`.`MEMO_` AS `MEMO_`,`MS`.`LAST_SYNC_DATE_` AS `LAST_SYNC_DATE_`,`MS`.`ORDER_` AS `ORDER_`,`MS`.`MAIN_SERVER_STATUS_` AS `MAIN_SERVER_STATUS_`,`MS`.`CREATION_DATE_` AS `CREATION_DATE_`,`MS`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`MS`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`MS`.`OPERATOR_NAME_` AS `OPERATOR_NAME_` from `OM_MAIN_SERVER` `MS` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_MIRROR_SERVER`
--

/*!50001 DROP VIEW IF EXISTS `OMV_MIRROR_SERVER`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_MIRROR_SERVER` AS select `MS`.`MIRROR_SERVER_ID_` AS `MIRROR_SERVER_ID_`,`MS`.`MIRROR_SERVER_NAME_` AS `MIRROR_SERVER_NAME_`,`MS`.`DRIVER_CLASS_NAME_` AS `DRIVER_CLASS_NAME_`,`MS`.`URL_` AS `URL_`,`MS`.`USERNAME_` AS `USERNAME_`,`MS`.`PASSWORD_` AS `PASSWORD_`,`MS`.`MEMO_` AS `MEMO_`,`MS`.`LAST_SYNC_DATE_` AS `LAST_SYNC_DATE_`,`MS`.`ORDER_` AS `ORDER_`,`MS`.`MIRROR_SERVER_STATUS_` AS `MIRROR_SERVER_STATUS_`,`MS`.`CREATION_DATE_` AS `CREATION_DATE_`,`MS`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`MS`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`MS`.`OPERATOR_NAME_` AS `OPERATOR_NAME_` from `OM_MIRROR_SERVER` `MS` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_ORG`
--

/*!50001 DROP VIEW IF EXISTS `OMV_ORG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_ORG` AS select `ORGN_SET`.`ORGN_SET_ID_` AS `ORGN_SET_ID_`,`ORGN_SET`.`ORGN_SET_CODE_` AS `ORGN_SET_CODE_`,`ORGN_SET`.`ORGN_SET_NAME_` AS `ORGN_SET_NAME_`,`O1`.`ORG_ID_` AS `ORG_ID_`,`O1`.`PARENT_ORG_ID_` AS `PARENT_ORG_ID_`,`O1`.`ORG_CODE_` AS `ORG_CODE_`,`O1`.`ORG_NAME_` AS `ORG_NAME_`,`O1`.`ORG_ABBR_NAME_` AS `ORG_ABBR_NAME_`,`O1`.`ORG_TYPE_` AS `ORG_TYPE_`,`O1`.`ORG_CATEGORY_` AS `ORG_CATEGORY_`,`O1`.`MEMO_` AS `MEMO_`,`O1`.`ORG_TAG_` AS `ORG_TAG_`,`O1`.`ORG_EXT_ATTR_1_` AS `ORG_EXT_ATTR_1_`,`O1`.`ORG_EXT_ATTR_2_` AS `ORG_EXT_ATTR_2_`,`O1`.`ORG_EXT_ATTR_3_` AS `ORG_EXT_ATTR_3_`,`O1`.`ORG_EXT_ATTR_4_` AS `ORG_EXT_ATTR_4_`,`O1`.`ORG_EXT_ATTR_5_` AS `ORG_EXT_ATTR_5_`,`O1`.`ORG_EXT_ATTR_6_` AS `ORG_EXT_ATTR_6_`,`O1`.`ORG_EXT_ATTR_7_` AS `ORG_EXT_ATTR_7_`,`O1`.`ORG_EXT_ATTR_8_` AS `ORG_EXT_ATTR_8_`,`O1`.`ORDER_` AS `ORDER_`,`O1`.`ORG_STATUS_` AS `ORG_STATUS_`,`O1`.`CREATION_DATE_` AS `CREATION_DATE_`,`O1`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`O1`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`O1`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`O2`.`ORG_CODE_` AS `PARENT_ORG_CODE_`,`O2`.`ORG_NAME_` AS `PARENT_ORG_NAME_` from ((`OM_ORG` `O1` join `OM_ORGN_SET` `ORGN_SET` on((`ORGN_SET`.`ORGN_SET_ID_` = `O1`.`ORGN_SET_ID_`))) left join `OM_ORG` `O2` on(((`O2`.`ORGN_SET_ID_` = `O1`.`ORGN_SET_ID_`) and (`O2`.`ORG_ID_` = `O1`.`PARENT_ORG_ID_`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_ORGN_SET`
--

/*!50001 DROP VIEW IF EXISTS `OMV_ORGN_SET`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_ORGN_SET` AS select `OS1`.`ORGN_SET_ID_` AS `ORGN_SET_ID_`,`OS1`.`PARENT_ORGN_SET_ID_` AS `PARENT_ORGN_SET_ID_`,`OS1`.`ORGN_SET_CODE_` AS `ORGN_SET_CODE_`,`OS1`.`ORGN_SET_NAME_` AS `ORGN_SET_NAME_`,`OS1`.`ALLOW_SYNC_` AS `ALLOW_SYNC_`,`OS1`.`MEMO_` AS `MEMO_`,`OS1`.`ORDER_` AS `ORDER_`,`OS1`.`ORGN_SET_STATUS_` AS `ORGN_SET_STATUS_`,`OS1`.`CREATION_DATE_` AS `CREATION_DATE_`,`OS1`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`OS1`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`OS1`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`OS2`.`ORGN_SET_CODE_` AS `PARENT_ORGN_SET_CODE_`,`OS2`.`ORGN_SET_NAME_` AS `PARENT_ORGN_SET_NAME_` from (`OM_ORGN_SET` `OS1` left join `OM_ORGN_SET` `OS2` on((`OS2`.`ORGN_SET_ID_` = `OS1`.`PARENT_ORGN_SET_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_POSI`
--

/*!50001 DROP VIEW IF EXISTS `OMV_POSI`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_POSI` AS select `ORGN_SET`.`ORGN_SET_ID_` AS `ORGN_SET_ID_`,`ORGN_SET`.`ORGN_SET_CODE_` AS `ORGN_SET_CODE_`,`ORGN_SET`.`ORGN_SET_NAME_` AS `ORGN_SET_NAME_`,`P`.`POSI_ID_` AS `POSI_ID_`,`P`.`POSI_CODE_` AS `POSI_CODE_`,`P`.`POSI_NAME_` AS `POSI_NAME_`,`P`.`ORG_LEADER_TYPE_` AS `ORG_LEADER_TYPE_`,`P`.`POSI_CATEGORY_` AS `POSI_CATEGORY_`,`P`.`MEMO_` AS `MEMO_`,`P`.`POSI_TAG_` AS `POSI_TAG_`,`P`.`POSI_EXT_ATTR_1_` AS `POSI_EXT_ATTR_1_`,`P`.`POSI_EXT_ATTR_2_` AS `POSI_EXT_ATTR_2_`,`P`.`POSI_EXT_ATTR_3_` AS `POSI_EXT_ATTR_3_`,`P`.`POSI_EXT_ATTR_4_` AS `POSI_EXT_ATTR_4_`,`P`.`POSI_EXT_ATTR_5_` AS `POSI_EXT_ATTR_5_`,`P`.`POSI_EXT_ATTR_6_` AS `POSI_EXT_ATTR_6_`,`P`.`POSI_EXT_ATTR_7_` AS `POSI_EXT_ATTR_7_`,`P`.`POSI_EXT_ATTR_8_` AS `POSI_EXT_ATTR_8_`,`P`.`ORDER_` AS `ORDER_`,`P`.`POSI_STATUS_` AS `POSI_STATUS_`,`P`.`CREATION_DATE_` AS `CREATION_DATE_`,`P`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`P`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`P`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`D`.`DUTY_ID_` AS `DUTY_ID_`,`D`.`DUTY_CODE_` AS `DUTY_CODE_`,`D`.`DUTY_NAME_` AS `DUTY_NAME_`,`D`.`DUTY_CATEGORY_` AS `DUTY_CATEGORY_`,`D`.`DUTY_TAG_` AS `DUTY_TAG_`,`D`.`DUTY_EXT_ATTR_1_` AS `DUTY_EXT_ATTR_1_`,`D`.`DUTY_EXT_ATTR_2_` AS `DUTY_EXT_ATTR_2_`,`D`.`DUTY_EXT_ATTR_3_` AS `DUTY_EXT_ATTR_3_`,`D`.`DUTY_EXT_ATTR_4_` AS `DUTY_EXT_ATTR_4_`,`D`.`DUTY_EXT_ATTR_5_` AS `DUTY_EXT_ATTR_5_`,`D`.`DUTY_EXT_ATTR_6_` AS `DUTY_EXT_ATTR_6_`,`D`.`DUTY_EXT_ATTR_7_` AS `DUTY_EXT_ATTR_7_`,`D`.`DUTY_EXT_ATTR_8_` AS `DUTY_EXT_ATTR_8_`,`D`.`DUTY_STATUS_` AS `DUTY_STATUS_`,`O1`.`ORG_ID_` AS `ORG_ID_`,`O1`.`PARENT_ORG_ID_` AS `PARENT_ORG_ID_`,`O1`.`ORG_CODE_` AS `ORG_CODE_`,`O1`.`ORG_NAME_` AS `ORG_NAME_`,`O1`.`ORG_ABBR_NAME_` AS `ORG_ABBR_NAME_`,`O1`.`ORG_TYPE_` AS `ORG_TYPE_`,`O1`.`ORG_CATEGORY_` AS `ORG_CATEGORY_`,`O1`.`ORG_TAG_` AS `ORG_TAG_`,`O1`.`ORG_EXT_ATTR_1_` AS `ORG_EXT_ATTR_1_`,`O1`.`ORG_EXT_ATTR_2_` AS `ORG_EXT_ATTR_2_`,`O1`.`ORG_EXT_ATTR_3_` AS `ORG_EXT_ATTR_3_`,`O1`.`ORG_EXT_ATTR_4_` AS `ORG_EXT_ATTR_4_`,`O1`.`ORG_EXT_ATTR_5_` AS `ORG_EXT_ATTR_5_`,`O1`.`ORG_EXT_ATTR_6_` AS `ORG_EXT_ATTR_6_`,`O1`.`ORG_EXT_ATTR_7_` AS `ORG_EXT_ATTR_7_`,`O1`.`ORG_EXT_ATTR_8_` AS `ORG_EXT_ATTR_8_`,`O1`.`ORG_STATUS_` AS `ORG_STATUS_`,`O2`.`ORG_CODE_` AS `PARENT_ORG_CODE_`,`O2`.`ORG_NAME_` AS `PARENT_ORG_NAME_` from ((((`OM_POSI` `P` join `OM_ORGN_SET` `ORGN_SET` on((`ORGN_SET`.`ORGN_SET_ID_` = `P`.`ORGN_SET_ID_`))) left join `OM_DUTY` `D` on(((`D`.`ORGN_SET_ID_` = `P`.`ORGN_SET_ID_`) and (`D`.`DUTY_ID_` = `P`.`DUTY_ID_`)))) join `OM_ORG` `O1` on(((`O1`.`ORGN_SET_ID_` = `P`.`ORGN_SET_ID_`) and (`O1`.`ORG_ID_` = `P`.`ORG_ID_`)))) left join `OM_ORG` `O2` on(((`O2`.`ORGN_SET_ID_` = `O1`.`ORGN_SET_ID_`) and (`O2`.`ORG_ID_` = `O1`.`PARENT_ORG_ID_`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_POSI_EMP`
--

/*!50001 DROP VIEW IF EXISTS `OMV_POSI_EMP`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_POSI_EMP` AS select `ORGN_SET`.`ORGN_SET_ID_` AS `ORGN_SET_ID_`,`ORGN_SET`.`ORGN_SET_CODE_` AS `ORGN_SET_CODE_`,`ORGN_SET`.`ORGN_SET_NAME_` AS `ORGN_SET_NAME_`,`PE`.`POSI_EMP_ID_` AS `POSI_EMP_ID_`,`PE`.`MAIN_` AS `MAIN_`,`PE`.`POSI_EMP_CATEGORY_` AS `POSI_EMP_CATEGORY_`,`PE`.`MEMO_` AS `MEMO_`,`PE`.`POSI_EMP_TAG_` AS `POSI_EMP_TAG_`,`PE`.`POSI_EMP_EXT_ATTR_1_` AS `POSI_EMP_EXT_ATTR_1_`,`PE`.`POSI_EMP_EXT_ATTR_2_` AS `POSI_EMP_EXT_ATTR_2_`,`PE`.`POSI_EMP_EXT_ATTR_3_` AS `POSI_EMP_EXT_ATTR_3_`,`PE`.`POSI_EMP_EXT_ATTR_4_` AS `POSI_EMP_EXT_ATTR_4_`,`PE`.`POSI_EMP_EXT_ATTR_5_` AS `POSI_EMP_EXT_ATTR_5_`,`PE`.`POSI_EMP_EXT_ATTR_6_` AS `POSI_EMP_EXT_ATTR_6_`,`PE`.`POSI_EMP_EXT_ATTR_7_` AS `POSI_EMP_EXT_ATTR_7_`,`PE`.`POSI_EMP_EXT_ATTR_8_` AS `POSI_EMP_EXT_ATTR_8_`,`PE`.`ORDER_` AS `ORDER_`,`PE`.`POSI_EMP_STATUS_` AS `POSI_EMP_STATUS_`,`PE`.`CREATION_DATE_` AS `CREATION_DATE_`,`PE`.`UPDATE_DATE_` AS `UPDATE_DATE_`,`PE`.`OPERATOR_ID_` AS `OPERATOR_ID_`,`PE`.`OPERATOR_NAME_` AS `OPERATOR_NAME_`,`E`.`EMP_ID_` AS `EMP_ID_`,`E`.`EMP_CODE_` AS `EMP_CODE_`,`E`.`EMP_NAME_` AS `EMP_NAME_`,`E`.`PASSWORD_RESET_REQ_` AS `PASSWORD_RESET_REQ_`,`E`.`PARTY_` AS `PARTY_`,`E`.`EMP_LEVEL_` AS `EMP_LEVEL_`,`E`.`GENDER_` AS `GENDER_`,`E`.`BIRTH_DATE_` AS `BIRTH_DATE_`,`E`.`TEL_` AS `TEL_`,`E`.`EMAIL_` AS `EMAIL_`,`E`.`IN_DATE_` AS `IN_DATE_`,`E`.`OUT_DATE_` AS `OUT_DATE_`,`E`.`EMP_CATEGORY_` AS `EMP_CATEGORY_`,`E`.`EMP_TAG_` AS `EMP_TAG_`,`E`.`EMP_EXT_ATTR_1_` AS `EMP_EXT_ATTR_1_`,`E`.`EMP_EXT_ATTR_2_` AS `EMP_EXT_ATTR_2_`,`E`.`EMP_EXT_ATTR_3_` AS `EMP_EXT_ATTR_3_`,`E`.`EMP_EXT_ATTR_4_` AS `EMP_EXT_ATTR_4_`,`E`.`EMP_EXT_ATTR_5_` AS `EMP_EXT_ATTR_5_`,`E`.`EMP_EXT_ATTR_6_` AS `EMP_EXT_ATTR_6_`,`E`.`EMP_EXT_ATTR_7_` AS `EMP_EXT_ATTR_7_`,`E`.`EMP_EXT_ATTR_8_` AS `EMP_EXT_ATTR_8_`,`E`.`EMP_STATUS_` AS `EMP_STATUS_`,`P`.`POSI_ID_` AS `POSI_ID_`,`P`.`POSI_CODE_` AS `POSI_CODE_`,`P`.`POSI_NAME_` AS `POSI_NAME_`,`P`.`ORG_LEADER_TYPE_` AS `ORG_LEADER_TYPE_`,`P`.`POSI_CATEGORY_` AS `POSI_CATEGORY_`,`P`.`POSI_TAG_` AS `POSI_TAG_`,`P`.`POSI_EXT_ATTR_1_` AS `POSI_EXT_ATTR_1_`,`P`.`POSI_EXT_ATTR_2_` AS `POSI_EXT_ATTR_2_`,`P`.`POSI_EXT_ATTR_3_` AS `POSI_EXT_ATTR_3_`,`P`.`POSI_EXT_ATTR_4_` AS `POSI_EXT_ATTR_4_`,`P`.`POSI_EXT_ATTR_5_` AS `POSI_EXT_ATTR_5_`,`P`.`POSI_EXT_ATTR_6_` AS `POSI_EXT_ATTR_6_`,`P`.`POSI_EXT_ATTR_7_` AS `POSI_EXT_ATTR_7_`,`P`.`POSI_EXT_ATTR_8_` AS `POSI_EXT_ATTR_8_`,`P`.`POSI_STATUS_` AS `POSI_STATUS_`,`D`.`DUTY_ID_` AS `DUTY_ID_`,`D`.`DUTY_CODE_` AS `DUTY_CODE_`,`D`.`DUTY_NAME_` AS `DUTY_NAME_`,`D`.`DUTY_CATEGORY_` AS `DUTY_CATEGORY_`,`D`.`DUTY_TAG_` AS `DUTY_TAG_`,`D`.`DUTY_EXT_ATTR_1_` AS `DUTY_EXT_ATTR_1_`,`D`.`DUTY_EXT_ATTR_2_` AS `DUTY_EXT_ATTR_2_`,`D`.`DUTY_EXT_ATTR_3_` AS `DUTY_EXT_ATTR_3_`,`D`.`DUTY_EXT_ATTR_4_` AS `DUTY_EXT_ATTR_4_`,`D`.`DUTY_EXT_ATTR_5_` AS `DUTY_EXT_ATTR_5_`,`D`.`DUTY_EXT_ATTR_6_` AS `DUTY_EXT_ATTR_6_`,`D`.`DUTY_EXT_ATTR_7_` AS `DUTY_EXT_ATTR_7_`,`D`.`DUTY_EXT_ATTR_8_` AS `DUTY_EXT_ATTR_8_`,`D`.`DUTY_STATUS_` AS `DUTY_STATUS_`,`O1`.`ORG_ID_` AS `ORG_ID_`,`O1`.`PARENT_ORG_ID_` AS `PARENT_ORG_ID_`,`O1`.`ORG_CODE_` AS `ORG_CODE_`,`O1`.`ORG_NAME_` AS `ORG_NAME_`,`O1`.`ORG_ABBR_NAME_` AS `ORG_ABBR_NAME_`,`O1`.`ORG_TYPE_` AS `ORG_TYPE_`,`O1`.`ORG_CATEGORY_` AS `ORG_CATEGORY_`,`O1`.`ORG_TAG_` AS `ORG_TAG_`,`O1`.`ORG_EXT_ATTR_1_` AS `ORG_EXT_ATTR_1_`,`O1`.`ORG_EXT_ATTR_2_` AS `ORG_EXT_ATTR_2_`,`O1`.`ORG_EXT_ATTR_3_` AS `ORG_EXT_ATTR_3_`,`O1`.`ORG_EXT_ATTR_4_` AS `ORG_EXT_ATTR_4_`,`O1`.`ORG_EXT_ATTR_5_` AS `ORG_EXT_ATTR_5_`,`O1`.`ORG_EXT_ATTR_6_` AS `ORG_EXT_ATTR_6_`,`O1`.`ORG_EXT_ATTR_7_` AS `ORG_EXT_ATTR_7_`,`O1`.`ORG_EXT_ATTR_8_` AS `ORG_EXT_ATTR_8_`,`O1`.`ORG_STATUS_` AS `ORG_STATUS_`,`O2`.`ORG_CODE_` AS `PARENT_ORG_CODE_`,`O2`.`ORG_NAME_` AS `PARENT_ORG_NAME_` from ((((((`OM_POSI_EMP` `PE` join `OM_ORGN_SET` `ORGN_SET` on((`ORGN_SET`.`ORGN_SET_ID_` = `PE`.`ORGN_SET_ID_`))) join `OM_EMP` `E` on(((`E`.`ORGN_SET_ID_` = `PE`.`ORGN_SET_ID_`) and (`E`.`EMP_ID_` = `PE`.`EMP_ID_`)))) join `OM_POSI` `P` on(((`P`.`ORGN_SET_ID_` = `PE`.`ORGN_SET_ID_`) and (`P`.`POSI_ID_` = `PE`.`POSI_ID_`)))) left join `OM_DUTY` `D` on(((`D`.`ORGN_SET_ID_` = `P`.`ORGN_SET_ID_`) and (`D`.`DUTY_ID_` = `P`.`DUTY_ID_`)))) join `OM_ORG` `O1` on(((`O1`.`ORGN_SET_ID_` = `P`.`ORGN_SET_ID_`) and (`O1`.`ORG_ID_` = `P`.`ORG_ID_`)))) left join `OM_ORG` `O2` on(((`O2`.`ORGN_SET_ID_` = `O1`.`ORGN_SET_ID_`) and (`O2`.`ORG_ID_` = `O1`.`PARENT_ORG_ID_`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OMV_TAG`
--

/*!50001 DROP VIEW IF EXISTS `OMV_TAG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `OMV_TAG` AS select `T`.`ORGN_SET_ID_` AS `ORGN_SET_ID_`,`T`.`TAG_ID_` AS `TAG_ID_`,`T`.`OBJ_ID_` AS `OBJ_ID_`,`T`.`OBJ_TYPE_` AS `OBJ_TYPE_`,`T`.`TAG_` AS `TAG_`,`ORGN_SET`.`ORGN_SET_CODE_` AS `ORGN_SET_CODE_`,`ORGN_SET`.`ORGN_SET_NAME_` AS `ORGN_SET_NAME_` from (`OM_TAG` `T` join `OM_ORGN_SET` `ORGN_SET` on((`ORGN_SET`.`ORGN_SET_ID_` = `T`.`ORGN_SET_ID_`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-31 10:11:53
