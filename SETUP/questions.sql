-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2014 at 01:11 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cpointer`
--

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
  `ID` int(11) NOT NULL,
  `KC` int(11) NOT NULL,
  `Question` text NOT NULL,
  `Answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`ID`, `KC`, `Question`, `Answer`) VALUES
(2, 0, '<form method="post">\r\nDeclare a pointer of type integer with the pointer name ''intptr'' <br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', 'int * intptr;'),
(3, 0, '<form method="post">\r\nassign the address of an integer named ''num'' to a pointer named ''numptr'' <br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', 'numptr = &num;'),
(4, 0, '<form method="post">\r\nSuppose you have a char variable:<br>\r\nchar charData;<br>\r\nStore the contents of this variable into the location that a char pointer named ''charptr'' points to.<br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', '*charptr = charData;'),
(5, 0, '<form method="post">\r\nConsider the following code:<br><br>\r\nint * intPointer1;<br>\r\nint * intPointer2 = malloc(sizeof(int));<br>\r\n*intPointer2 = 8;<br>\r\n*intPointer2 = *intPointer2 + 1;<br>\r\nintPointer1 = intPointer2;<br>\r\n*intPointer2 = *intPointer2 + 3;<br><br>\r\nWhat value will will intPointer1 be pointing to?<br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', '9'),
(6, 0, '<form method="post">\r\nDeclare a pointer of type char with the pointer name ''charptr'' <br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', 'char * charptr;'),
(7, 0, '<form method="post">\r\nDeclare a double pointer of type char with the pointer name ''doubleCharPtr'' <br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', 'char ** doubleCharPtr;'),
(8, 2, '<form method="post">\r\nConsider the following code:<br><br>\r\n1: int * intPointer1 = malloc(sizeof(int));<br>\r\n2: int * intPointer2 = malloc(sizeof(int));<br>\r\n3: *intPointer2 = 8;<br>\r\n4: *intPointer2 = *intPointer2 + 1;<br>\r\n5: intPointer1 = intPointer2;<br>\r\n6: *intPointer2 = *intPointer2 - 6;<br><br>\r\nOn which line is memory leaked?<br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', '5'),
(9, 2, '<form method="post">\r\nCreate an integer pointer named ''intptr'', allocate space for one integer<br>\r\nand make your pointer point to it all in one line of code<br>\r\nType your answer below: <br>\r\n<input type="text" name="answer">\r\n<br>\r\n<input type="submit" name="send" value="Submit">\r\n</form>', 'int * intptr = malloc(sizeof(int));');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
