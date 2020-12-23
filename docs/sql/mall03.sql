/*
 Navicat MySQL Data Transfer

 Source Server         : wamp_mysql
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : mall03

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 23/12/2020 19:57:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('clusteredScheduler', 'TASK_14', 'DEFAULT', '0 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('clusteredScheduler', 'TASK_16', 'DEFAULT', '0 0/5 * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('clusteredScheduler', 'TASK_14', 'DEFAULT', NULL, 'com.ytrue.mall.quartz.config.QuartzJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720027636F6D2E79747275652E6D616C6C2E71756172747A2E6D6F64656C2E5363686564756C654A6F627EFB64EA8291AB0C0200084C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B78707400096F726465725461736B7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016B884153587874000B30202A202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000E74000B63616E63656C4F7264657274000074001BE58F96E6B688E8B685E697B6E69CAAE694AFE4BB98E8AEA2E58D95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);
INSERT INTO `qrtz_job_details` VALUES ('clusteredScheduler', 'TASK_16', 'DEFAULT', NULL, 'com.ytrue.mall.quartz.config.QuartzJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720027636F6D2E79747275652E6D616C6C2E71756172747A2E6D6F64656C2E5363686564756C654A6F627EFB64EA8291AB0C0200084C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B78707400096F726465725461736B7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016B88422E187874000D3020302F35202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000001074000C636F6E6669726D4F7264657274000074001EE7B3BBE7BB9FE887AAE58AA8E7A1AEE8AEA4E694B6E8B4A7E8AEA2E58D95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('clusteredScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('clusteredScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('clusteredScheduler', 'LAPTOP-NUDGSF0A1608713663829', 1608724628080, 10000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('clusteredScheduler', 'TASK_14', 'DEFAULT', 'TASK_14', 'DEFAULT', NULL, 1608724680000, 1608724620000, 5, 'WAITING', 'CRON', 1608646926000, 0, NULL, 1, '');
INSERT INTO `qrtz_triggers` VALUES ('clusteredScheduler', 'TASK_16', 'DEFAULT', 'TASK_16', 'DEFAULT', NULL, 1608724800000, 1608724500000, 5, 'WAITING', 'CRON', 1608646926000, 0, NULL, 1, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720027636F6D2E79747275652E6D616C6C2E71756172747A2E6D6F64656C2E5363686564756C654A6F627EFB64EA8291AB0C0200084C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B78707400096F726465725461736B7074000D3020302F35202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000001074000C636F6E6669726D4F7264657274000074001EE7B3BBE7BB9FE887AAE58AA8E7A1AEE8AEA4E694B6E8B4A7E8AEA2E58D95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0011000000007800);

-- ----------------------------
-- Table structure for tz_schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `tz_schedule_job`;
CREATE TABLE `tz_schedule_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tz_schedule_job
-- ----------------------------
INSERT INTO `tz_schedule_job` VALUES (14, 'orderTask', 'cancelOrder', '', '0 * * * * ?', 0, '取消超时未支付订单', '2019-06-24 14:51:51');
INSERT INTO `tz_schedule_job` VALUES (16, 'orderTask', 'confirmOrder', '', '0 0/5 * * * ?', 0, '系统自动确认收货订单', '2019-06-24 14:52:47');

-- ----------------------------
-- Table structure for tz_schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `tz_schedule_job_log`;
CREATE TABLE `tz_schedule_job_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `job_id`(`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 701 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tz_schedule_job_log
-- ----------------------------
INSERT INTO `tz_schedule_job_log` VALUES (650, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 16:56:00');
INSERT INTO `tz_schedule_job_log` VALUES (651, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 16:57:00');
INSERT INTO `tz_schedule_job_log` VALUES (652, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 16:58:00');
INSERT INTO `tz_schedule_job_log` VALUES (653, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 16:59:00');
INSERT INTO `tz_schedule_job_log` VALUES (654, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:00:00');
INSERT INTO `tz_schedule_job_log` VALUES (655, 16, 'orderTask', 'confirmOrder', '', 0, NULL, 0, '2020-12-23 17:00:00');
INSERT INTO `tz_schedule_job_log` VALUES (656, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:01:00');
INSERT INTO `tz_schedule_job_log` VALUES (657, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:02:00');
INSERT INTO `tz_schedule_job_log` VALUES (658, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:03:00');
INSERT INTO `tz_schedule_job_log` VALUES (659, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:04:00');
INSERT INTO `tz_schedule_job_log` VALUES (660, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:05:00');
INSERT INTO `tz_schedule_job_log` VALUES (661, 16, 'orderTask', 'confirmOrder', '', 0, NULL, 0, '2020-12-23 17:05:00');
INSERT INTO `tz_schedule_job_log` VALUES (662, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 2, '2020-12-23 17:06:00');
INSERT INTO `tz_schedule_job_log` VALUES (663, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:07:00');
INSERT INTO `tz_schedule_job_log` VALUES (664, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:08:00');
INSERT INTO `tz_schedule_job_log` VALUES (665, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:09:00');
INSERT INTO `tz_schedule_job_log` VALUES (666, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:10:00');
INSERT INTO `tz_schedule_job_log` VALUES (667, 16, 'orderTask', 'confirmOrder', '', 0, NULL, 0, '2020-12-23 17:10:00');
INSERT INTO `tz_schedule_job_log` VALUES (668, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:11:00');
INSERT INTO `tz_schedule_job_log` VALUES (669, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:12:00');
INSERT INTO `tz_schedule_job_log` VALUES (670, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:13:00');
INSERT INTO `tz_schedule_job_log` VALUES (671, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:14:00');
INSERT INTO `tz_schedule_job_log` VALUES (672, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:15:00');
INSERT INTO `tz_schedule_job_log` VALUES (673, 16, 'orderTask', 'confirmOrder', '', 0, NULL, 2, '2020-12-23 17:15:00');
INSERT INTO `tz_schedule_job_log` VALUES (674, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:16:00');
INSERT INTO `tz_schedule_job_log` VALUES (675, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:17:00');
INSERT INTO `tz_schedule_job_log` VALUES (676, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:18:00');
INSERT INTO `tz_schedule_job_log` VALUES (677, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 2, '2020-12-23 17:19:00');
INSERT INTO `tz_schedule_job_log` VALUES (678, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:20:00');
INSERT INTO `tz_schedule_job_log` VALUES (679, 16, 'orderTask', 'confirmOrder', '', 0, NULL, 0, '2020-12-23 17:20:00');
INSERT INTO `tz_schedule_job_log` VALUES (680, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:21:00');
INSERT INTO `tz_schedule_job_log` VALUES (681, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:22:00');
INSERT INTO `tz_schedule_job_log` VALUES (682, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:23:00');
INSERT INTO `tz_schedule_job_log` VALUES (683, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 2, '2020-12-23 17:24:00');
INSERT INTO `tz_schedule_job_log` VALUES (684, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:25:00');
INSERT INTO `tz_schedule_job_log` VALUES (685, 16, 'orderTask', 'confirmOrder', '', 0, NULL, 0, '2020-12-23 17:25:00');
INSERT INTO `tz_schedule_job_log` VALUES (686, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 17:26:00');
INSERT INTO `tz_schedule_job_log` VALUES (687, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 2, '2020-12-23 17:27:00');
INSERT INTO `tz_schedule_job_log` VALUES (688, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 1, '2020-12-23 19:49:43');
INSERT INTO `tz_schedule_job_log` VALUES (689, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 19:49:44');
INSERT INTO `tz_schedule_job_log` VALUES (690, 16, 'orderTask', 'confirmOrder', '', 0, NULL, 1, '2020-12-23 19:49:44');
INSERT INTO `tz_schedule_job_log` VALUES (691, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 19:50:00');
INSERT INTO `tz_schedule_job_log` VALUES (692, 16, 'orderTask', 'confirmOrder', '', 0, NULL, 0, '2020-12-23 19:50:00');
INSERT INTO `tz_schedule_job_log` VALUES (693, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 19:51:00');
INSERT INTO `tz_schedule_job_log` VALUES (694, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 19:52:00');
INSERT INTO `tz_schedule_job_log` VALUES (695, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 19:53:00');
INSERT INTO `tz_schedule_job_log` VALUES (696, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 19:54:00');
INSERT INTO `tz_schedule_job_log` VALUES (697, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 19:55:00');
INSERT INTO `tz_schedule_job_log` VALUES (698, 16, 'orderTask', 'confirmOrder', '', 0, NULL, 0, '2020-12-23 19:55:00');
INSERT INTO `tz_schedule_job_log` VALUES (699, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 19:56:00');
INSERT INTO `tz_schedule_job_log` VALUES (700, 14, 'orderTask', 'cancelOrder', '', 0, NULL, 0, '2020-12-23 19:57:00');

-- ----------------------------
-- Table structure for tz_sys_config
-- ----------------------------
DROP TABLE IF EXISTS `tz_sys_config`;
CREATE TABLE `tz_sys_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'value',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `key`(`param_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tz_sys_log
-- ----------------------------
DROP TABLE IF EXISTS `tz_sys_log`;
CREATE TABLE `tz_sys_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1006 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tz_sys_log
-- ----------------------------
INSERT INTO `tz_sys_log` VALUES (922, '临时用户名', '删除角色', 'com.ytrue.mall.sys.controller.SysRoleController.delete()', '[27]', 43, '127.0.0.1', '2020-12-19 10:09:56');
INSERT INTO `tz_sys_log` VALUES (923, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23430]', 6, '127.0.0.1', '2020-12-19 10:10:10');
INSERT INTO `tz_sys_log` VALUES (924, '临时用户名', '保存用户', 'com.ytrue.mall.sys.controller.SysUserController.save()', '{\"createTime\":1608459309012,\"email\":\"test@qq.com\",\"mobile\":\"17897657907\",\"password\":\"$2a$10$ufcT88mklmQKaE/.Zr0zIu/Dz4d8x5OSaDCY0odDULyPsAwCDDkZq\",\"roleIdList\":[],\"status\":1,\"userId\":23431,\"username\":\"test\"}', 268, '127.0.0.1', '2020-12-20 18:15:09');
INSERT INTO `tz_sys_log` VALUES (925, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23431]', 12, '127.0.0.1', '2020-12-20 21:39:49');
INSERT INTO `tz_sys_log` VALUES (926, '临时用户名', '保存用户', 'com.ytrue.mall.sys.controller.SysUserController.save()', '{\"createTime\":1608471623472,\"email\":\"11518232@qq.com\",\"mobile\":\"17656789675\",\"password\":\"$2a$10$JsnRmgw.kXZIKDlVuVcuX.xMDAqnSj/I/CHI3rGK7MiLMxuEeSqe6\",\"roleIdList\":[],\"status\":1,\"userId\":23432,\"username\":\"test\"}', 90, '127.0.0.1', '2020-12-20 21:40:23');
INSERT INTO `tz_sys_log` VALUES (927, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 21:44:30');
INSERT INTO `tz_sys_log` VALUES (928, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 21:44:35');
INSERT INTO `tz_sys_log` VALUES (929, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 2, '127.0.0.1', '2020-12-20 21:44:47');
INSERT INTO `tz_sys_log` VALUES (930, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 21:44:59');
INSERT INTO `tz_sys_log` VALUES (931, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 2, '127.0.0.1', '2020-12-20 21:46:08');
INSERT INTO `tz_sys_log` VALUES (932, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[1]', 0, '127.0.0.1', '2020-12-20 21:46:12');
INSERT INTO `tz_sys_log` VALUES (933, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 2, '127.0.0.1', '2020-12-20 21:47:39');
INSERT INTO `tz_sys_log` VALUES (934, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 21:47:53');
INSERT INTO `tz_sys_log` VALUES (935, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 1, '127.0.0.1', '2020-12-20 21:48:40');
INSERT INTO `tz_sys_log` VALUES (936, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 21:49:19');
INSERT INTO `tz_sys_log` VALUES (937, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 21:50:34');
INSERT INTO `tz_sys_log` VALUES (938, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 1, '127.0.0.1', '2020-12-20 21:51:23');
INSERT INTO `tz_sys_log` VALUES (939, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 21:52:05');
INSERT INTO `tz_sys_log` VALUES (940, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 21:53:21');
INSERT INTO `tz_sys_log` VALUES (941, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 21:53:26');
INSERT INTO `tz_sys_log` VALUES (942, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 21:58:51');
INSERT INTO `tz_sys_log` VALUES (943, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 22:00:14');
INSERT INTO `tz_sys_log` VALUES (944, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 2, '127.0.0.1', '2020-12-20 22:00:53');
INSERT INTO `tz_sys_log` VALUES (945, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 22:01:11');
INSERT INTO `tz_sys_log` VALUES (946, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 2, '127.0.0.1', '2020-12-20 22:03:00');
INSERT INTO `tz_sys_log` VALUES (947, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 1, '127.0.0.1', '2020-12-20 22:03:14');
INSERT INTO `tz_sys_log` VALUES (948, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 22:05:33');
INSERT INTO `tz_sys_log` VALUES (949, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 22:06:00');
INSERT INTO `tz_sys_log` VALUES (950, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 22:06:03');
INSERT INTO `tz_sys_log` VALUES (951, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 22:06:15');
INSERT INTO `tz_sys_log` VALUES (952, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23432]', 0, '127.0.0.1', '2020-12-20 22:07:18');
INSERT INTO `tz_sys_log` VALUES (953, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[1]', 0, '127.0.0.1', '2020-12-20 22:07:20');
INSERT INTO `tz_sys_log` VALUES (954, '临时用户名', '保存用户', 'com.ytrue.mall.sys.controller.SysUserController.save()', '{\"email\":\"\",\"mobile\":\"\",\"password\":\"\",\"roleIdList\":[],\"status\":1,\"username\":\"\"}', 0, '127.0.0.1', '2020-12-20 22:09:50');
INSERT INTO `tz_sys_log` VALUES (955, '临时用户名', '保存用户', 'com.ytrue.mall.sys.controller.SysUserController.save()', '{\"email\":\"\",\"mobile\":\"\",\"password\":\"\",\"roleIdList\":[],\"status\":1,\"username\":\"\"}', 0, '127.0.0.1', '2020-12-20 22:09:54');
INSERT INTO `tz_sys_log` VALUES (956, '临时用户名', '保存用户', 'com.ytrue.mall.sys.controller.SysUserController.save()', '{\"email\":\"\",\"mobile\":\"\",\"password\":\"\",\"roleIdList\":[],\"status\":1,\"username\":\"\"}', 0, '127.0.0.1', '2020-12-20 22:09:55');
INSERT INTO `tz_sys_log` VALUES (957, '临时用户名', '保存用户', 'com.ytrue.mall.sys.controller.SysUserController.save()', '{\"email\":\"\",\"mobile\":\"\",\"password\":\"\",\"roleIdList\":[],\"status\":1,\"username\":\"\"}', 0, '127.0.0.1', '2020-12-20 22:09:55');
INSERT INTO `tz_sys_log` VALUES (958, '临时用户名', '保存用户', 'com.ytrue.mall.sys.controller.SysUserController.save()', '{\"email\":\"\",\"mobile\":\"\",\"password\":\"\",\"roleIdList\":[],\"status\":1,\"username\":\"\"}', 0, '127.0.0.1', '2020-12-20 22:09:55');
INSERT INTO `tz_sys_log` VALUES (959, '临时用户名', '保存用户', 'com.ytrue.mall.sys.controller.SysUserController.save()', '{\"email\":\"\",\"mobile\":\"\",\"password\":\"\",\"roleIdList\":[],\"status\":1,\"username\":\"\"}', 0, '127.0.0.1', '2020-12-20 22:09:55');
INSERT INTO `tz_sys_log` VALUES (960, '临时用户名', '修改角色', 'com.ytrue.mall.sys.controller.SysRoleController.update()', '{\"menuIdList\":[317,-666666,1],\"remark\":\"测试\",\"roleId\":1,\"roleName\":\"测试角色\"}', 85, '127.0.0.1', '2020-12-21 13:03:12');
INSERT INTO `tz_sys_log` VALUES (961, '临时用户名', '修改用户', 'com.ytrue.mall.sys.controller.SysUserController.update()', '{\"email\":\"11518232@qq.com\",\"mobile\":\"17656789675\",\"roleIdList\":[1],\"status\":1,\"userId\":23432,\"username\":\"test\"}', 22, '127.0.0.1', '2020-12-21 13:03:20');
INSERT INTO `tz_sys_log` VALUES (962, '临时用户名', '修改角色', 'com.ytrue.mall.sys.controller.SysRoleController.update()', '{\"menuIdList\":[6,7,8,9,10,11,12,13,14,29,317,318,-666666,1],\"remark\":\"测试\",\"roleId\":1,\"roleName\":\"测试角色\"}', 9, '127.0.0.1', '2020-12-21 13:05:14');
INSERT INTO `tz_sys_log` VALUES (963, '临时用户名', '修改角色', 'com.ytrue.mall.sys.controller.SysRoleController.update()', '{\"menuIdList\":[317,318,-666666,1],\"remark\":\"测试\",\"roleId\":1,\"roleName\":\"测试角色\"}', 10, '127.0.0.1', '2020-12-21 13:05:55');
INSERT INTO `tz_sys_log` VALUES (964, '临时用户名', '保存菜单', 'com.ytrue.mall.sys.controller.SysMenuController.save()', '{\"icon\":\"123\",\"menuId\":319,\"name\":\"123\",\"orderNum\":0,\"parentId\":0,\"perms\":\"\",\"type\":0,\"url\":\"\"}', 23, '127.0.0.1', '2020-12-21 21:52:08');
INSERT INTO `tz_sys_log` VALUES (965, '临时用户名', '保存菜单', 'com.ytrue.mall.sys.controller.SysMenuController.save()', '{\"icon\":\"312321\",\"menuId\":320,\"name\":\"321312\",\"orderNum\":0,\"parentId\":319,\"perms\":\"312312\",\"type\":1,\"url\":\"312312\"}', 8, '127.0.0.1', '2020-12-21 21:52:38');
INSERT INTO `tz_sys_log` VALUES (966, '临时用户名', '保存菜单', 'com.ytrue.mall.sys.controller.SysMenuController.save()', '{\"icon\":\"\",\"menuId\":321,\"name\":\"214\",\"orderNum\":0,\"parentId\":318,\"perms\":\"423423\",\"type\":2,\"url\":\"\"}', 12, '127.0.0.1', '2020-12-21 22:16:59');
INSERT INTO `tz_sys_log` VALUES (967, '临时用户名', '保存菜单', 'com.ytrue.mall.sys.controller.SysMenuController.save()', '{\"icon\":\"23423\",\"menuId\":322,\"name\":\"2432423423\",\"orderNum\":0,\"parentId\":1,\"perms\":\"\",\"type\":0,\"url\":\"\"}', 6, '127.0.0.1', '2020-12-21 22:18:00');
INSERT INTO `tz_sys_log` VALUES (968, '临时用户名', '修改菜单', 'com.ytrue.mall.sys.controller.SysMenuController.update()', '{\"icon\":\"el-icon-setting\",\"menuId\":1,\"name\":\"系统管理1\",\"orderNum\":3,\"parentId\":0,\"perms\":\"\",\"type\":0,\"url\":\"\"}', 13, '127.0.0.1', '2020-12-21 22:32:53');
INSERT INTO `tz_sys_log` VALUES (969, '临时用户名', '修改菜单', 'com.ytrue.mall.sys.controller.SysMenuController.update()', '{\"icon\":\"el-icon-setting\",\"menuId\":1,\"name\":\"系统管理12\",\"orderNum\":3,\"parentId\":0,\"perms\":\"\",\"type\":0,\"url\":\"\"}', 3, '127.0.0.1', '2020-12-21 22:33:00');
INSERT INTO `tz_sys_log` VALUES (970, '临时用户名', '修改菜单', 'com.ytrue.mall.sys.controller.SysMenuController.update()', '{\"icon\":\"el-icon-setting\",\"menuId\":1,\"name\":\"系统管理\",\"orderNum\":3,\"parentId\":0,\"perms\":\"\",\"type\":0,\"url\":\"\"}', 6, '127.0.0.1', '2020-12-21 22:33:05');
INSERT INTO `tz_sys_log` VALUES (971, '临时用户名', '修改菜单', 'com.ytrue.mall.sys.controller.SysMenuController.update()', '{\"icon\":\"el-icon-setting\",\"menuId\":1,\"name\":\"系统管理\",\"orderNum\":0,\"parentId\":0,\"perms\":\"\",\"type\":0,\"url\":\"\"}', 6, '127.0.0.1', '2020-12-21 22:33:14');
INSERT INTO `tz_sys_log` VALUES (972, '临时用户名', '保存定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.save()', '{\"beanName\":\"orderTask\",\"createTime\":1608647759130,\"cronExpression\":\"0 * * * * ?\",\"jobId\":17,\"methodName\":\"test\",\"params\":\"\",\"remark\":\"测试方法\",\"status\":0}', 129, '127.0.0.1', '2020-12-22 22:35:59');
INSERT INTO `tz_sys_log` VALUES (973, '临时用户名', '修改定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.update()', '{\"beanName\":\"orderTask\",\"cronExpression\":\"0 * * * * ?\",\"jobId\":17,\"methodName\":\"test\",\"params\":\"\",\"remark\":\"测试方法\",\"status\":0}', 27, '127.0.0.1', '2020-12-22 22:40:20');
INSERT INTO `tz_sys_log` VALUES (974, '临时用户名', '修改定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.update()', '{\"beanName\":\"orderTask\",\"cronExpression\":\"0 * * * * ?\",\"jobId\":17,\"methodName\":\"test\",\"params\":\"\",\"remark\":\"测试方法\",\"status\":0}', 20, '127.0.0.1', '2020-12-22 22:40:56');
INSERT INTO `tz_sys_log` VALUES (975, '临时用户名', '删除定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.delete()', '[null]', 9, '127.0.0.1', '2020-12-22 22:41:57');
INSERT INTO `tz_sys_log` VALUES (976, '临时用户名', '删除定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.delete()', '[17]', 117, '127.0.0.1', '2020-12-22 22:42:18');
INSERT INTO `tz_sys_log` VALUES (977, '临时用户名', '修改定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.update()', '{\"beanName\":\"orderTask1\",\"cronExpression\":\"0 0/5 * * * ?\",\"jobId\":16,\"methodName\":\"confirmOrder\",\"params\":\"\",\"remark\":\"系统自动确认收货订单\",\"status\":0}', 15, '127.0.0.1', '2020-12-22 22:43:16');
INSERT INTO `tz_sys_log` VALUES (978, '临时用户名', '修改定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.update()', '{\"beanName\":\"orderTask\",\"cronExpression\":\"0 0/5 * * * ?\",\"jobId\":16,\"methodName\":\"confirmOrder\",\"params\":\"\",\"remark\":\"系统自动确认收货订单\",\"status\":0}', 10, '127.0.0.1', '2020-12-22 22:43:22');
INSERT INTO `tz_sys_log` VALUES (979, '临时用户名', '保存用户', 'com.ytrue.mall.sys.controller.SysUserController.save()', '{\"createTime\":1608648783357,\"email\":\"2131@qq.com\",\"mobile\":\"17657656789\",\"password\":\"$2a$10$lhoXhxBdStOjDH8uL2u3r.69plk00UfXfdxwpJvdyfe9S/Rm//jOu\",\"roleIdList\":[],\"status\":1,\"userId\":23433,\"username\":\"e\'q\'q\'we\"}', 185, '127.0.0.1', '2020-12-22 22:53:03');
INSERT INTO `tz_sys_log` VALUES (980, '临时用户名', '保存用户', 'com.ytrue.mall.sys.controller.SysUserController.save()', '{\"createTime\":1608648806606,\"email\":\"21321@Qq.com\",\"mobile\":\"17689076789\",\"password\":\"$2a$10$oUuEHmNY/L.no4maaoHoeuZSu30ZV6tmDW0tIz73JJO6tsbv99Bge\",\"roleIdList\":[],\"status\":1,\"userId\":23434,\"username\":\"234234\"}', 88, '127.0.0.1', '2020-12-22 22:53:27');
INSERT INTO `tz_sys_log` VALUES (981, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23434,23433]', 0, '127.0.0.1', '2020-12-22 22:54:13');
INSERT INTO `tz_sys_log` VALUES (982, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23434,23433]', 2, '127.0.0.1', '2020-12-22 22:54:32');
INSERT INTO `tz_sys_log` VALUES (983, '临时用户名', '删除用户', 'com.ytrue.mall.sys.controller.SysUserController.delete()', '[23434,23433]', 12, '127.0.0.1', '2020-12-22 22:55:23');
INSERT INTO `tz_sys_log` VALUES (984, '临时用户名', '暂停定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.pause()', '[null]', 16, '127.0.0.1', '2020-12-22 23:00:17');
INSERT INTO `tz_sys_log` VALUES (985, '临时用户名', '暂停定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.pause()', '[null]', 8, '127.0.0.1', '2020-12-22 23:02:03');
INSERT INTO `tz_sys_log` VALUES (986, '临时用户名', '暂停定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.pause()', '[16]', 20, '127.0.0.1', '2020-12-22 23:02:51');
INSERT INTO `tz_sys_log` VALUES (987, '临时用户名', '暂停定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.pause()', '[14]', 12, '127.0.0.1', '2020-12-22 23:03:21');
INSERT INTO `tz_sys_log` VALUES (988, '临时用户名', '恢复定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.resume()', '[16]', 9, '127.0.0.1', '2020-12-22 23:03:24');
INSERT INTO `tz_sys_log` VALUES (989, '临时用户名', '立即执行任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.run()', '[14]', 14, '127.0.0.1', '2020-12-22 23:09:53');
INSERT INTO `tz_sys_log` VALUES (990, '临时用户名', '立即执行任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.run()', '[16,14]', 14, '127.0.0.1', '2020-12-22 23:10:00');
INSERT INTO `tz_sys_log` VALUES (991, '临时用户名', '立即执行任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.run()', '[14]', 6, '127.0.0.1', '2020-12-22 23:10:16');
INSERT INTO `tz_sys_log` VALUES (992, '临时用户名', '恢复定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.resume()', '[14]', 29, '127.0.0.1', '2020-12-23 08:11:55');
INSERT INTO `tz_sys_log` VALUES (993, '临时用户名', '暂停定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.pause()', '[16]', 10, '127.0.0.1', '2020-12-23 08:20:47');
INSERT INTO `tz_sys_log` VALUES (994, '临时用户名', '恢复定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.resume()', '[16]', 10, '127.0.0.1', '2020-12-23 08:20:50');
INSERT INTO `tz_sys_log` VALUES (995, '临时用户名', '立即执行任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.run()', '[16]', 8, '127.0.0.1', '2020-12-23 08:20:53');
INSERT INTO `tz_sys_log` VALUES (996, '临时用户名', '暂停定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.pause()', '[16]', 10, '127.0.0.1', '2020-12-23 08:25:28');
INSERT INTO `tz_sys_log` VALUES (997, '临时用户名', '恢复定时任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.resume()', '[16]', 8, '127.0.0.1', '2020-12-23 08:25:33');
INSERT INTO `tz_sys_log` VALUES (998, '临时用户名', '保存菜单', 'com.ytrue.mall.sys.controller.SysMenuController.save()', '{\"icon\":\"\",\"menuId\":323,\"name\":\"123\",\"orderNum\":0,\"parentId\":2,\"perms\":\"123\",\"type\":2,\"url\":\"\"}', 14, '127.0.0.1', '2020-12-23 08:26:26');
INSERT INTO `tz_sys_log` VALUES (999, '临时用户名', '删除菜单', 'com.ytrue.mall.sys.controller.SysMenuController.delete()', '323', 11, '127.0.0.1', '2020-12-23 08:34:43');
INSERT INTO `tz_sys_log` VALUES (1000, '临时用户名', '立即执行任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.run()', '[16]', 19, '127.0.0.1', '2020-12-23 16:53:08');
INSERT INTO `tz_sys_log` VALUES (1001, '临时用户名', '立即执行任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.run()', '[16]', 29, '127.0.0.1', '2020-12-23 16:54:42');
INSERT INTO `tz_sys_log` VALUES (1002, '临时用户名', '立即执行任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.run()', '[16,14]', 14, '127.0.0.1', '2020-12-23 16:54:58');
INSERT INTO `tz_sys_log` VALUES (1003, '临时用户名', '立即执行任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.run()', '[16,14]', 12, '127.0.0.1', '2020-12-23 16:55:01');
INSERT INTO `tz_sys_log` VALUES (1004, '临时用户名', '立即执行任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.run()', '[16,14]', 12, '127.0.0.1', '2020-12-23 16:55:03');
INSERT INTO `tz_sys_log` VALUES (1005, '临时用户名', '立即执行任务', 'com.ytrue.mall.quartz.controller.ScheduleJobController.run()', '[16,14]', 10, '127.0.0.1', '2020-12-23 16:55:06');

-- ----------------------------
-- Table structure for tz_sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `tz_sys_menu`;
CREATE TABLE `tz_sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 324 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tz_sys_menu
-- ----------------------------
INSERT INTO `tz_sys_menu` VALUES (1, 0, '系统管理', '', '', 0, 'el-icon-setting', 0);
INSERT INTO `tz_sys_menu` VALUES (2, 1, '管理员', 'sys/user', '', 1, 'el-icon-s-custom', 1);
INSERT INTO `tz_sys_menu` VALUES (3, 1, '角色管理', 'sys/role', '', 1, 'tree', 2);
INSERT INTO `tz_sys_menu` VALUES (4, 1, '菜单管理', 'sys/menu', '', 1, 'el-icon-menu', 3);
INSERT INTO `tz_sys_menu` VALUES (6, 1, '定时任务', 'sys/schedule', '', 1, 'el-icon-alarm-clock', 5);
INSERT INTO `tz_sys_menu` VALUES (7, 6, '查看', NULL, 'sys:schedule:page,sys:schedule:info', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (8, 6, '新增', NULL, 'sys:schedule:save', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (9, 6, '修改', NULL, 'sys:schedule:update', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (10, 6, '删除', NULL, 'sys:schedule:delete', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (11, 6, '暂停', NULL, 'sys:schedule:pause', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (12, 6, '恢复', NULL, 'sys:schedule:resume', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (13, 6, '立即执行', NULL, 'sys:schedule:run', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (14, 6, '日志列表', NULL, 'sys:schedule:log', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (15, 2, '查看', NULL, 'sys:user:page,sys:user:info', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (16, 2, '新增', '', 'sys:user:save,sys:role:list', 2, '', 1);
INSERT INTO `tz_sys_menu` VALUES (17, 2, '修改', '', 'sys:user:update,sys:role:list', 2, '', 2);
INSERT INTO `tz_sys_menu` VALUES (18, 2, '删除', '', 'sys:user:delete', 2, '', 3);
INSERT INTO `tz_sys_menu` VALUES (19, 3, '查看', NULL, 'sys:role:page,sys:role:info', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (20, 3, '新增', NULL, 'sys:role:save,sys:menu:list', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (21, 3, '修改', NULL, 'sys:role:update,sys:menu:list', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (22, 3, '删除', NULL, 'sys:role:delete', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (23, 4, '查看', NULL, 'sys:menu:list,sys:menu:info', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (24, 4, '新增', NULL, 'sys:menu:save,sys:menu:select', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (25, 4, '修改', NULL, 'sys:menu:update,sys:menu:select', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (26, 4, '删除', NULL, 'sys:menu:delete', 2, NULL, 0);
INSERT INTO `tz_sys_menu` VALUES (29, 1, '操作日志', 'sys/log', 'sys:log:page', 1, 'el-icon-tickets', 7);
INSERT INTO `tz_sys_menu` VALUES (317, 1, '系统监控', 'sys/monitor', 'sys:monito:page', 1, 'el-icon-s-platform', 8);
INSERT INTO `tz_sys_menu` VALUES (318, 1, '应用监控', 'sys/application', NULL, 1, 'el-icon-s-grid', 9);

-- ----------------------------
-- Table structure for tz_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `tz_sys_role`;
CREATE TABLE `tz_sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tz_sys_role
-- ----------------------------
INSERT INTO `tz_sys_role` VALUES (1, '测试角色', '测试', NULL, '2019-07-03 08:39:49');

-- ----------------------------
-- Table structure for tz_sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `tz_sys_role_menu`;
CREATE TABLE `tz_sys_role_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 235 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色与菜单对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tz_sys_role_menu
-- ----------------------------
INSERT INTO `tz_sys_role_menu` VALUES (231, 1, 317);
INSERT INTO `tz_sys_role_menu` VALUES (232, 1, 318);
INSERT INTO `tz_sys_role_menu` VALUES (233, 1, -666666);
INSERT INTO `tz_sys_role_menu` VALUES (234, 1, 1);

-- ----------------------------
-- Table structure for tz_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `tz_sys_user`;
CREATE TABLE `tz_sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23435 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tz_sys_user
-- ----------------------------
INSERT INTO `tz_sys_user` VALUES (1, 'admin', '$2a$10$ufcT88mklmQKaE/.Zr0zIu/Dz4d8x5OSaDCY0odDULyPsAwCDDkZq', 'root@123.com', '13612345678', 1, 1, '2016-11-11 11:11:11');
INSERT INTO `tz_sys_user` VALUES (23432, 'test', '$2a$10$JsnRmgw.kXZIKDlVuVcuX.xMDAqnSj/I/CHI3rGK7MiLMxuEeSqe6', '11518232@qq.com', '17656789675', 1, NULL, '2020-12-20 21:40:23');

-- ----------------------------
-- Table structure for tz_sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tz_sys_user_role`;
CREATE TABLE `tz_sys_user_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与角色对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tz_sys_user_role
-- ----------------------------
INSERT INTO `tz_sys_user_role` VALUES (1, 4, 1);
INSERT INTO `tz_sys_user_role` VALUES (2, 23425, 1);
INSERT INTO `tz_sys_user_role` VALUES (9, 1, 1);
INSERT INTO `tz_sys_user_role` VALUES (10, 23432, 1);

SET FOREIGN_KEY_CHECKS = 1;
