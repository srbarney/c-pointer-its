-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 15, 2014 at 03:58 AM
-- Server version: 5.5.32
-- PHP Version: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `a8567911_cpoint`
--
CREATE DATABASE IF NOT EXISTS `a8567911_cpoint` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `a8567911_cpoint`;

--
-- Table structure for table `knowledge_components`
--

DROP TABLE IF EXISTS `knowledge_components`;
CREATE TABLE IF NOT EXISTS `knowledge_components` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Table structure for table `lesson`
--

DROP TABLE IF EXISTS `lessons`;
CREATE TABLE IF NOT EXISTS `lessons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `html` varchar(5000) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `html`) VALUES
(1, '<form method="post" action="select-task.php"><h1>Lesson 1</h1><input type="submit" name="send" value="Submit"></form>');

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kc` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `kc`, `question`, `answer`) VALUES
(1, 0, '<form method="post" action="select-task.php">\r\nDeclare a pointer of type integer with the pointer name ''intptr'' <br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', 'int * intptr;'),
(2, 0, '<form method="post" action="select-task.php">\r\nassign the address of an integer named ''num'' to a pointer named ''numptr'' <br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', 'numptr = &num;'),
(3, 0, '<form method="post" action="select-task.php">\r\nSuppose you have a char variable:<br>\r\nchar charData;<br>\r\nStore the contents of this variable into the location that a char pointer named ''charptr'' points to.<br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', '*charptr = charData;'),
(4, 0, '<form method="post" action="select-task.php">\r\nConsider the following code:<br><br>\r\nint * intPointer1;<br>\r\nint * intPointer2 = malloc(sizeof(int));<br>\r\n*intPointer2 = 8;<br>\r\n*intPointer2 = *intPointer2 + 1;<br>\r\nintPointer1 = intPointer2;<br>\r\n*intPointer2 = *intPointer2 + 3;<br><br>\r\nWhat value will will intPointer1 be pointing to?<br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', '9'),
(5, 0, '<form method="post" action="select-task.php">\r\nDeclare a pointer of type char with the pointer name ''charptr'' <br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', 'char * charptr;'),
(6, 0, '<form method="post" action="select-task.php">\r\nDeclare a double pointer of type char with the pointer name ''doubleCharPtr'' <br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', 'char ** doubleCharPtr;'),
(7, 2, '<form method="post" action="select-task.php">\r\nConsider the following code:<br><br>\r\n1: int * intPointer1 = malloc(sizeof(int));<br>\r\n2: int * intPointer2 = malloc(sizeof(int));<br>\r\n3: *intPointer2 = 8;<br>\r\n4: *intPointer2 = *intPointer2 + 1;<br>\r\n5: intPointer1 = intPointer2;<br>\r\n6: *intPointer2 = *intPointer2 - 6;<br><br>\r\nOn which line is memory leaked?<br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', '5'),
(8, 2, '<form method="post" action="select-task.php">\r\nCreate an integer pointer named ''intptr'', allocate space for one integer<br>\r\nand make your pointer point to it all in one line of code<br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', 'int * intptr = malloc(sizeof(int));');


--
-- Table structure for table `reg_login_attempt`
--
DROP TABLE IF EXISTS `reg_login_attempt`;
CREATE TABLE IF NOT EXISTS `reg_login_attempt` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `login_success` tinyint(1) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Table structure for table `reg_users`
--

DROP TABLE IF EXISTS `reg_users`;
CREATE TABLE IF NOT EXISTS `reg_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `rank` tinyint(2) unsigned NOT NULL,
  `registered` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `token` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `token_validity` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reg_ip` varchar(45) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0',
  `user_stat` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'U',
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `reg_users`
--

INSERT INTO `reg_users` (`id`, `first_name`, `last_name`, `password`, `email`, `rank`, `registered`, `last_login`, `token`, `token_validity`, `reg_ip`, `user_stat`) VALUES
(1, 'Steven', 'Barney', 'acdd77bc283941db353f3936a5a9b847', 'srbarney@asu.edu', 3, '2014-03-13 05:10:12', '2014-04-05 15:03:44', '9dfb1c02b3a778c5132ee0d617fbdf293f85dc47', '2014-04-05 16:03:44', '0.0.0.0', 'A');

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `task_type` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `task_type`, `task_id`) VALUES
(1, 'L', 1),
(2, 'Q', 1),
(3, 'Q', 2),
(4, 'Q', 3),
(5, 'Q', 4),
(6, 'Q', 5),
(7, 'Q', 6),
(8, 'Q', 7),
(9, 'Q', 8);

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE IF NOT EXISTS `user_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `KC1correct` double NOT NULL,
  `KC1attempts` int(11) NOT NULL,
  `KC2correct` double NOT NULL,
  `KC2attempts` int(11) NOT NULL,
  `KC3correct` double NOT NULL,
  `KC3attempts` int(11) NOT NULL,
  `KC4correct` double NOT NULL,
  `KC4attempts` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Table structure for table `task_attempts`
--

--
-- CREATE TABLE IF NOT EXISTS `task_attempts` (
--  `id` int(11) NOT NULL AUTO_INCREMENT,
--  `question_id` int(11) NOT NULL,
--  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
--  `time_spent` time NOT NULL,
--  `hint_level_used` int(5) NOT NULL,
--  `student_id` int(11) NOT NULL,
--  PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
--

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
