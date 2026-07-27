/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.0.45-community-nt : Database - student_counselling
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`student_counselling` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `student_counselling`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL auto_increment,
  `username` varchar(50) default NULL,
  `password` varchar(50) default NULL,
  `department` varchar(50) default NULL,
  PRIMARY KEY  (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `counselling_request` */

DROP TABLE IF EXISTS `counselling_request`;

CREATE TABLE `counselling_request` (
  `request_id` int(11) NOT NULL auto_increment,
  `student_roll` varchar(20) default NULL,
  `issue` text,
  `request_date` date default NULL,
  `status` varchar(50) default NULL,
  `remarks` varchar(250) default NULL,
  `escalated_to_hod` varchar(10) default 'No',
  `escalation_reason` text,
  `escalated_by` varchar(100) default NULL,
  `escalated_date` datetime default NULL,
  `hod_remarks` text,
  `resolved_by` varchar(50) default NULL,
  PRIMARY KEY  (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=latin1;

/*Table structure for table `counselling_sessions` */

DROP TABLE IF EXISTS `counselling_sessions`;

CREATE TABLE `counselling_sessions` (
  `session_id` int(11) NOT NULL auto_increment,
  `student_roll` varchar(20) default NULL,
  `staff_id` varchar(250) default NULL,
  `session_date` date default NULL,
  `session_time` varchar(20) default NULL,
  `venue` varchar(255) default NULL,
  `problem` text,
  `counselling_notes` text,
  `status` varchar(50) default NULL,
  `request_id` int(11) default NULL,
  `hod_remarks` text,
  `resolved_by_hod` varchar(100) default NULL,
  `resolved_at` datetime default NULL,
  `final_status` varchar(50) default 'Pending',
  PRIMARY KEY  (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;

/*Table structure for table `department` */

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL auto_increment,
  `dept_name` varchar(100) default NULL,
  PRIMARY KEY  (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL auto_increment,
  `student_roll` varchar(20) default NULL,
  `staff_id` int(11) default NULL,
  `feedback` text,
  `rating` int(11) default NULL,
  `feedback_date` date default NULL,
  PRIMARY KEY  (`feedback_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `hod` */

DROP TABLE IF EXISTS `hod`;

CREATE TABLE `hod` (
  `hod_id` int(11) NOT NULL auto_increment,
  `name` varchar(100) default NULL,
  `department` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `phone` varchar(15) default NULL,
  `password` varchar(50) default NULL,
  PRIMARY KEY  (`hod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Table structure for table `password_log` */

DROP TABLE IF EXISTS `password_log`;

CREATE TABLE `password_log` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(100) default NULL,
  `role` varchar(50) default NULL,
  `change_date` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `staff` */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL auto_increment,
  `name` varchar(100) default NULL,
  `department` varchar(100) default NULL,
  `designation` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `phone` varchar(15) default NULL,
  `password` varchar(50) default NULL,
  PRIMARY KEY  (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Table structure for table `staff_activity` */

DROP TABLE IF EXISTS `staff_activity`;

CREATE TABLE `staff_activity` (
  `staff_id` varchar(10) default NULL,
  `staff_name` varchar(200) default NULL,
  `activity` varchar(100) default NULL,
  `student_name` varchar(100) default NULL,
  `date` varchar(20) default NULL,
  `status` varchar(50) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `staff_assignment` */

DROP TABLE IF EXISTS `staff_assignment`;

CREATE TABLE `staff_assignment` (
  `assignment_id` int(11) NOT NULL auto_increment,
  `staff_id` varchar(250) default NULL,
  `department` varchar(100) default NULL,
  `roll_start` varchar(20) default NULL,
  `roll_end` varchar(20) default NULL,
  `assigned_by` varchar(100) default NULL,
  `assigned_date` date default NULL,
  PRIMARY KEY  (`assignment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL auto_increment,
  `name` varchar(100) default NULL,
  `rollno` varchar(20) default NULL,
  `department` varchar(100) default NULL,
  `year` varchar(20) default NULL,
  `email` varchar(100) default NULL,
  `phone` varchar(15) default NULL,
  `password` varchar(50) default NULL,
  `assigned_staff` varchar(250) default NULL,
  PRIMARY KEY  (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
