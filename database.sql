CREATE DATABASE  IF NOT EXISTS `tabling` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tabling`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tabling
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_settings`
--

DROP TABLE IF EXISTS `calendar_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_settings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `value` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_settings`
--

LOCK TABLES `calendar_settings` WRITE;
/*!40000 ALTER TABLE `calendar_settings` DISABLE KEYS */;
INSERT INTO `calendar_settings` VALUES (1,'termdate1','2017-09-11'),(2,'termdate2','2018-01-22');
/*!40000 ALTER TABLE `calendar_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changes`
--

DROP TABLE IF EXISTS `changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `changes` (
  `ID` varchar(45) NOT NULL,
  `StartTime` datetime DEFAULT NULL,
  `FinishTime` datetime DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `Submitted` int(11) DEFAULT NULL,
  `Approved` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changes`
--

LOCK TABLES `changes` WRITE;
/*!40000 ALTER TABLE `changes` DISABLE KEYS */;
INSERT INTO `changes` VALUES ('COMP100100100010','2017-09-16 12:00:00','2017-09-16 12:50:00',1,1,1),('COMP1001001000210','2017-09-15 11:00:00','2017-09-15 11:50:00',1,0,0),('COMP1001001000515','2017-09-12 13:00:00','2017-09-12 13:50:00',1,1,1),('COMP1002001000320','2017-09-14 10:00:00','2017-09-14 10:50:00',1,1,1),('COMP1007001001284','2017-09-16 13:00:00','2017-09-16 13:50:00',1,1,1),('COMP2004001000725','2017-09-12 10:00:00','2017-09-12 10:50:00',1,1,1),('COMP20190010015108','2017-09-14 11:00:00','2017-09-14 11:50:00',1,1,1);
/*!40000 ALTER TABLE `changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `CRN` int(11) NOT NULL AUTO_INCREMENT,
  `Offering` varchar(45) DEFAULT NULL,
  `Semester` varchar(45) DEFAULT NULL,
  `Module Name` varchar(45) DEFAULT NULL,
  `Module Code` varchar(45) DEFAULT NULL,
  `CoordinatorID` int(11) DEFAULT NULL,
  `Enrolled` int(11) DEFAULT NULL,
  PRIMARY KEY (`CRN`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'VA1','1','Introduction to Programming I','COMP10010',1,20),(2,'VQ1','1','Introduction to Programming II','COMP10020',1,65),(3,'VA1','1','Computer Science in Practice','COMP10130',5,55),(4,'VQ1','1','Intro to Comp Architecture','COMP20040',1,45),(5,'VA1','1','Data Structures & Algorithms I','COMP20010',5,55),(6,'VA1','1','Web Design','COMP20030',1,50),(7,'VQ1','1','Intro. to Cognitive Science','COMP20090',1,50),(8,'VA1','1','Algorithmic Problem Solving','COMP10030',5,50),(9,'VQ1','1','Formal Foundations','COMP10070',1,50),(10,'VA1','1','Computer Science in Practice','COMP10130',5,50),(11,'VA1','1','Intro to Operating Systems','COMP20180',1,50),(12,'VQ1','1','Intro to Functional Progring','COMP20190',1,50),(13,'VA1','1','UNIX Programming','COMP20200',5,50),(14,'VQ1','1','Programming II (Conv)','COMP20220',1,50),(15,'VA1','1','Rel DB & Info Sys (Conv)','COMP20240',5,50),(16,'VA1','1','Software Engineering Project 1','COMP10050',2,50),(17,'VQ1','1','Computer Sci for Engineers','COMP10060',2,50),(18,'VQ1','1','Foundations of Computing','COMP30010',2,50),(19,'VQ1','1','Computer Graphics I','COMP30020',2,50);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-02-03 01:05:32.494681'),(2,'auth','0001_initial','2020-02-03 01:05:32.643284'),(3,'admin','0001_initial','2020-02-03 01:05:33.053187'),(4,'admin','0002_logentry_remove_auto_add','2020-02-03 01:05:33.156910'),(5,'admin','0003_logentry_add_action_flag_choices','2020-02-03 01:05:33.165886'),(6,'contenttypes','0002_remove_content_type_name','2020-02-03 01:05:33.263623'),(7,'auth','0002_alter_permission_name_max_length','2020-02-03 01:05:33.338423'),(8,'auth','0003_alter_user_email_max_length','2020-02-03 01:05:33.369341'),(9,'auth','0004_alter_user_username_opts','2020-02-03 01:05:33.379315'),(10,'auth','0005_alter_user_last_login_null','2020-02-03 01:05:33.424197'),(11,'auth','0006_require_contenttypes_0002','2020-02-03 01:05:33.428184'),(12,'auth','0007_alter_validators_add_error_messages','2020-02-03 01:05:33.437160'),(13,'auth','0008_alter_user_username_max_length','2020-02-03 01:05:33.495006'),(14,'auth','0009_alter_user_last_name_max_length','2020-02-03 01:05:33.548861'),(15,'auth','0010_alter_group_name_max_length','2020-02-03 01:05:33.569804'),(16,'auth','0011_update_proxy_permissions','2020-02-03 01:05:33.579778'),(17,'sessions','0001_initial','2020-02-03 01:05:33.601720');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0nlr6ezj7n3e9fz2ms7z3bei21tnywti','NjA1ODExNDIzMmRhMTY1NDk3ZGYxNzBmYzQ4NTJkZjk2Nzg3ZDYyZDp7InVpZCI6IjEifQ==','2020-04-01 17:02:21.226748'),('bmbdz3z25ns04gepukesd3z10n0gau3g','MTg5YTY3YmQ3MjNlZTgzMTY5ZDA4YzUzMzZiZGMzYTRkOGZhY2I4Yzp7ImV2IjpbXX0=','2020-02-17 02:09:51.247864'),('lle9l1r02dte7foxqn30yohpldn9rgzk','NjA1ODExNDIzMmRhMTY1NDk3ZGYxNzBmYzQ4NTJkZjk2Nzg3ZDYyZDp7InVpZCI6IjEifQ==','2020-05-07 22:21:14.452954'),('pj6a22qfv2j76wqt0mhrr0fvua2shhi3','NjA1ODExNDIzMmRhMTY1NDk3ZGYxNzBmYzQ4NTJkZjk2Nzg3ZDYyZDp7InVpZCI6IjEifQ==','2020-03-17 03:37:17.403356'),('sqduioyz7lhy4ryvgrtli2z3b30mfl3i','NjA1ODExNDIzMmRhMTY1NDk3ZGYxNzBmYzQ4NTJkZjk2Nzg3ZDYyZDp7InVpZCI6IjEifQ==','2020-04-22 10:49:09.831632'),('tixjkdlyn5qqlxyzpag3aqjfr79vscmz','NjA1ODExNDIzMmRhMTY1NDk3ZGYxNzBmYzQ4NTJkZjk2Nzg3ZDYyZDp7InVpZCI6IjEifQ==','2020-05-27 23:25:50.980677'),('v6pkqdi8qyimaahcmgvoewac8cwv3hm2','MjgzOTEwMWYzODE1OWUzYzM3MWEzMGVmN2U1NGI3MjcxYTBiODg0Yzp7ImV2IjpbeyJpZCI6IkNPTVAxMDAxMDAxMDAwMTAiLCJzdGFydF9kYXRlIjoiVHVlIFNlcCAxMiAyMDE3IDEwOjAwOjAwIEdNVCswMTAwIChCcml0aXNoIFN1bW1lciBUaW1lKSIsImVuZF9kYXRlIjoiVHVlIFNlcCAxMiAyMDE3IDEwOjUwOjAwIEdNVCswMTAwIChCcml0aXNoIFN1bW1lciBUaW1lKSIsInRleHQiOiJDT01QMTAwMTBcbkludHJvZHVjdGlvbiB0byBQcm9ncmFtbWluZyBJIiwiZGV0YWlscyI6IlRFc3QiLCJfdGltZWQiOiJ0cnVlIiwiX3NkYXkiOiIxIiwiX2lubmVyIjoiZmFsc2UiLCJfc29yZGVyIjoiMCIsIl9jb3VudCI6IjEifV19','2020-02-17 01:46:20.984181');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `RoomID` int(11) NOT NULL AUTO_INCREMENT,
  `Location` varchar(45) DEFAULT NULL,
  `Capacity` int(11) NOT NULL,
  `Projector` int(11) NOT NULL,
  `WhiteBoard` int(11) NOT NULL,
  `PowerSockets` int(11) NOT NULL,
  `WiredNetwork` int(11) NOT NULL,
  PRIMARY KEY (`RoomID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,'B003 CSI',50,1,1,0,0),(2,'B002 CSI',50,1,1,1,1),(3,'B004 CSI',100,1,1,1,1),(4,'B106 CSI',70,1,1,1,0),(5,'B108 CSI',50,1,1,1,0),(6,'B109 CSI',50,1,1,1,0);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_preferences`
--

DROP TABLE IF EXISTS `room_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_preferences` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `roomid` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_preferences`
--

LOCK TABLES `room_preferences` WRITE;
/*!40000 ALTER TABLE `room_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taught`
--

DROP TABLE IF EXISTS `taught`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taught` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(45) DEFAULT NULL,
  `Day` varchar(45) DEFAULT NULL,
  `Weeks` varchar(45) DEFAULT NULL,
  `StartTime` int(11) DEFAULT NULL,
  `FinishTime` int(11) DEFAULT NULL,
  `RoomID` varchar(45) DEFAULT NULL,
  `CRN` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taught`
--

LOCK TABLES `taught` WRITE;
/*!40000 ALTER TABLE `taught` DISABLE KEYS */;
INSERT INTO `taught` VALUES (1,'LEC','5','1,2,3,4,5,6,7,8,9,10',1200,1250,'1','1'),(2,'LEC','4','1,2,3,4,5,6,7,8,9,10',1100,1150,'1','1'),(4,'LEC','1','1,2,3,4,5,6,7,8,9,10',1600,1750,'1','1'),(5,'LEC','1','1,2,3,4,5,6,7,8,9,10',1300,1350,'1','1'),(6,'LEC','5','1,2,3,4,5,6,7,8,9,10',900,950,'3','3'),(7,'LEC','1','1,2,3,4,5,6,7,8,9,10',1000,1050,'3','4'),(8,'LEC','1','1,2,3,4,5,6,7,8,9,10,11,12',900,950,'3','5'),(9,'LEC','2','1,2,3,4,5,6,7,8,9,10,11,12',1200,1250,'3','6'),(10,'LEC','3','1,2,3,4,5,6,7,8,9,10,11,12',1200,1250,'3','7'),(11,'LEC','4','1,2,3,4,5,6,7,8,9,10,11,12',1300,1450,'4','8'),(12,'LEC','5','1,2,3,4,5,6,7,8,9,10,11,12',1300,1350,'3','9'),(13,'LEC','1','1,2,3,4,5,6,7,8,9,10,11,12',900,950,'4','10'),(14,'LEC','2','1,2,3,4,5,6,7,8,9,10,11,12',900,950,'3','11'),(15,'LEC','3','1,2,3,4,5,6,7,8,9,10,11,12',1100,1150,'3','12'),(16,'LEC','4','1,2,3,4,5,6,7,8,9,10,11,12',1600,1750,'4','13'),(17,'LEC','5','1,2,3,4,5,6,7,8,9,10,11,12',1400,1450,'3','14'),(18,'LEC','1','1,2,3,4,5,6,7,8,9,10,11,12',1100,1150,'3','15'),(19,'LEC','2','1,2,3,4,5,6,7,8,9,10,11,12',1000,1050,'3','14'),(20,'LEC','3','1,2,3,4,5,6,7,8,9,10,11,12',900,950,'3','13'),(21,'LEC','4','1,2,3,4,5,6,7,8,9,10,11,12',900,950,'4','12'),(22,'LEC','5','1,2,3,4,5,6,7,8,9,10,11,12',900,950,'4','11'),(23,'LEC','1','1,2,3,4,5,6,7,8,9,10,11,12',1500,1550,'3','10'),(24,'LEC','2','1,2,3,4,5,6,7,8,9,10,11,12',1500,1550,'3','9'),(25,'LEC','3','1,2,3,4,5,6,7,8,9,10,11,12',1500,1550,'3','8'),(26,'LEC','4','1,2,3,4,5,6,7,8,9,10,11,12',1500,1550,'4','7'),(27,'LEC','5','1,2,3,4,5,6,7,8,9,10,11,12',1500,1550,'3','6'),(28,'LEC','1','1,2,3,4,5,6,7,8,9,10,11,12',900,950,'1','18'),(29,'LEC','2','1,2,3,4,5,6,7,8,9,10,11,12',1100,1150,'3','19'),(30,'LEC','3','1,2,3,4,5,6,7,8,9,10,11,12',1100,1150,'3','18'),(31,'LEC','4','1,2,3,4,5,6,7,8,9,10,11,12',1100,1150,'4','19'),(32,'LEC','5','1,2,3,4,5,6,7,8,9,10,11,12',1100,1150,'3','18'),(33,'LEC','1','1,2,3,4,5,6,7,8,9,10,11,12',1100,1150,'4','18'),(34,'LEC','2','1,2,3,4,5,6,7,8,9,10,11,12',1000,1050,'4','19'),(35,'LEC','3','1,2,3,4,5,6,7,8,9,10,11,12',900,950,'3','18'),(36,'LEC','4','1,2,3,4,5,6,7,8,9,10,11,12',900,950,'4','19'),(37,'LEC','5','1,2,3,4,5,6,7,8,9,10,11,12',900,950,'5','18'),(38,'LEC','1','1,2,3,4,5,6,7,8,9,10,11,12',1500,1550,'4','19'),(39,'LEC','2','1,2,3,4,5,6,7,8,9,10,11,12',1500,1550,'4','18'),(40,'LEC','3','1,2,3,4,5,6,7,8,9,10,11,12',1500,1550,'3','19'),(41,'LEC','4','1,2,3,4,5,6,7,8,9,10,11,12',1500,1550,'4','18'),(42,'LEC','5','1,2,3,4,5,6,7,8,9,10,11,12',1500,1550,'4','19');
/*!40000 ALTER TABLE `taught` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_preferences`
--

DROP TABLE IF EXISTS `time_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_preferences` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `Time` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_preferences`
--

LOCK TABLES `time_preferences` WRITE;
/*!40000 ALTER TABLE `time_preferences` DISABLE KEYS */;
INSERT INTO `time_preferences` VALUES (5,1,109);
/*!40000 ALTER TABLE `time_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(45) DEFAULT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Type` int(11) DEFAULT NULL,
  `Password` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Finnlay.Mellor@ucd.ie','Finnlay Mellor',1,'c4ca4238a0b923820dcc509a6f75849b'),(2,'Aria.Frey@ucd.ie','Aria Frey',2,'c4ca4238a0b923820dcc509a6f75849b'),(3,'Devin.Andrews@ucd.ie','Devin Andrews',2,'c4ca4238a0b923820dcc509a6f75849b'),(4,'Duncan.Gordon@ucd.ie','Duncan Gordon',2,'c4ca4238a0b923820dcc509a6f75849b'),(5,'Jenny.Lane@ucd.ie','Jenny Lane',2,'c4ca4238a0b923820dcc509a6f75849b');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-21  1:07:36
