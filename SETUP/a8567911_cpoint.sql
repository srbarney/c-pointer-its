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

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_components`
--

CREATE TABLE IF NOT EXISTS `knowledge_components` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `question_multiple_choice`
--

CREATE TABLE IF NOT EXISTS `question_multiple_choice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `option_01` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `option_02` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `option_03` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `option_04` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `kc_id_01` int(11) NOT NULL,
  `kc_id_02` int(11) NOT NULL,
  `kc_id_03` int(11) NOT NULL,
  `difficulty` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `reg_login_attempt`
--

CREATE TABLE IF NOT EXISTS `reg_login_attempt` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `login_success` tinyint(1) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=37 ;

-- --------------------------------------------------------

--
-- Table structure for table `reg_users`
--

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `reg_users`
--

INSERT INTO `reg_users` (`id`, `first_name`, `last_name`, `password`, `email`, `rank`, `registered`, `last_login`, `token`, `token_validity`, `reg_ip`, `user_stat`) VALUES
(1, 'Steven', 'Barney', 'acdd77bc283941db353f3936a5a9b847', 'srbarney@asu.edu', 3, '2014-03-13 05:10:12', '2014-04-05 15:03:44', '9dfb1c02b3a778c5132ee0d617fbdf293f85dc47', '2014-04-05 16:03:44', '0.0.0.0', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `task_attempts`
--

CREATE TABLE IF NOT EXISTS `task_attempts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_spent` time NOT NULL,
  `hint_level_used` int(5) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
