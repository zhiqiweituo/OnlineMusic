/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.5.24 : Database - db_online_music
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_online_music` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_online_music`;

/*Table structure for table `favorite_user_song` */

DROP TABLE IF EXISTS `favorite_user_song`;

CREATE TABLE `favorite_user_song` (
  `user_no` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  KEY `FK_5j2r6rsss4pl8362ibr32xwso` (`song_id`),
  KEY `FK_rhr65peq16cqxj1rwnjj8ativ` (`user_no`),
  CONSTRAINT `FK_5j2r6rsss4pl8362ibr32xwso` FOREIGN KEY (`song_id`) REFERENCES `t_user` (`user_no`),
  CONSTRAINT `FK_rhr65peq16cqxj1rwnjj8ativ` FOREIGN KEY (`user_no`) REFERENCES `t_song` (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `favorite_user_song` */

/*Table structure for table `sys_data_dic` */

DROP TABLE IF EXISTS `sys_data_dic`;

CREATE TABLE `sys_data_dic` (
  `dd_id` int(11) NOT NULL AUTO_INCREMENT,
  `dd_desc` varchar(50) DEFAULT NULL,
  `dd_value` varchar(20) DEFAULT NULL,
  `dd_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`dd_id`),
  KEY `FK_tcmyxhs8mqm4x79nmuhe1wnd5` (`dd_type_id`),
  CONSTRAINT `FK_tcmyxhs8mqm4x79nmuhe1wnd5` FOREIGN KEY (`dd_type_id`) REFERENCES `sys_data_dic_type` (`dd_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `sys_data_dic` */

insert  into `sys_data_dic`(`dd_id`,`dd_desc`,`dd_value`,`dd_type_id`) values (1,NULL,'大陆',2),(2,NULL,'欧美',2),(3,'','日本',2),(4,'','韩国',2),(5,'','华语',3),(6,'','欧美',3),(7,'','粤语',3),(8,'','日语',3),(9,'','韩语',3),(10,'','流行',4),(11,'','摇滚',4),(12,'','民谣',4),(13,'','爵士',4),(14,'','古典',4),(15,'','乡村',4),(16,'','说唱',4);

/*Table structure for table `sys_data_dic_type` */

DROP TABLE IF EXISTS `sys_data_dic_type`;

CREATE TABLE `sys_data_dic_type` (
  `dd_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `dd_type_desc` varchar(50) DEFAULT NULL,
  `dd_type_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`dd_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `sys_data_dic_type` */

insert  into `sys_data_dic_type`(`dd_type_id`,`dd_type_desc`,`dd_type_name`) values (2,'歌手所属地区','所属地区'),(3,'华语 欧美 粤语 日语\r\n韩语 等...','语种'),(4,'流行 摇滚 民谣 爵士古典 乡村 说唱 等...','风格');

/*Table structure for table `t_admin` */

DROP TABLE IF EXISTS `t_admin`;

CREATE TABLE `t_admin` (
  `admin_no` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(30) DEFAULT NULL,
  `admin_state` bit(1) DEFAULT NULL,
  `gender` bit(1) DEFAULT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `note` varchar(100) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `real_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`admin_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_admin` */

insert  into `t_admin`(`admin_no`,`admin_name`,`admin_state`,`gender`,`mobile_no`,`note`,`password`,`real_name`) values (1,'admin','\0','','111',NULL,'admin','超级管理员'),(2,'www',NULL,NULL,NULL,NULL,'111','测试用户');

/*Table structure for table `t_singer` */

DROP TABLE IF EXISTS `t_singer`;

CREATE TABLE `t_singer` (
  `singer_id` int(11) NOT NULL AUTO_INCREMENT,
  `region` varchar(30) DEFAULT NULL,
  `singer_name` varchar(30) DEFAULT NULL,
  `sex` bit(1) DEFAULT NULL,
  PRIMARY KEY (`singer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `t_singer` */

insert  into `t_singer`(`singer_id`,`region`,`singer_name`,`sex`) values (1,'日本','坂本真綾',NULL),(2,'大陆','冯提莫',NULL),(3,'大陆','胡彦斌',''),(4,'大陆','林俊杰',''),(5,'大陆','林志颖',''),(6,'大陆','刘珂矣',NULL),(7,'大陆','刘涛',NULL),(8,'大陆','许嵩',''),(9,'大陆','薛之谦',''),(17,'大陆','蔡依林','\0'),(20,'欧美','M2M','\0'),(21,'韩国','鸟叔','');

/*Table structure for table `t_song` */

DROP TABLE IF EXISTS `t_song`;

CREATE TABLE `t_song` (
  `song_id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(100) DEFAULT NULL,
  `song_name` varchar(30) DEFAULT NULL,
  `singer_id` int(11) DEFAULT NULL,
  `song_language` varchar(30) DEFAULT NULL,
  `song_style` varchar(30) DEFAULT NULL,
  `admin_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`song_id`),
  KEY `FK_cv0o1k0graik3cmscejh469l7` (`singer_id`),
  KEY `FK_dvwa56701f1kncni8j3yih8uu` (`admin_no`),
  CONSTRAINT `FK_cv0o1k0graik3cmscejh469l7` FOREIGN KEY (`singer_id`) REFERENCES `t_singer` (`singer_id`),
  CONSTRAINT `FK_dvwa56701f1kncni8j3yih8uu` FOREIGN KEY (`admin_no`) REFERENCES `t_admin` (`admin_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_song` */

insert  into `t_song`(`song_id`,`location`,`song_name`,`singer_id`,`song_language`,`song_style`,`admin_no`) values (1,'胡彦斌 - 还魂门.mp3','还魂门',3,'华语','流行',NULL),(2,'冯提莫 - 再见前任.mp3','再见前任',2,'华语','流行',NULL),(3,'薛之谦 - 丑八怪.mp3','丑八怪',9,'华语','流行',NULL);

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `user_no` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) DEFAULT NULL,
  `gender` bit(1) DEFAULT NULL,
  `head_img` varchar(60) DEFAULT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `user_name` varchar(30) DEFAULT NULL,
  `user_state` bit(1) DEFAULT NULL,
  `user_type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`user_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`user_no`,`email`,`gender`,`head_img`,`mobile_no`,`note`,`password`,`user_name`,`user_state`,`user_type`) values (1,'0999','\0','user/04d73b10bcc74ecd94ce2e5a36b9d172.jpg','0999','艾伦是好人','123','allen','','A'),(2,'0876','','user/04b75bb347bf49698dc74f4f9eabce47.jpg','0876','0876','1','martin','','B'),(6,'677','','user/325bc4b6e29c4df8b01e146b7310706e.jpg','677','ford是个小领导','1','ford','','A'),(7,'111','\0','user/91d740115da3411e99054fbbc3a8dcc3.jpg','111','哼','1','测试用户','','A');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
