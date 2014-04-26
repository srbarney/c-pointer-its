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
-- Table structure for table `lessons`
--

DROP TABLE IF EXISTS `lessons`;
CREATE TABLE IF NOT EXISTS `lessons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `html` varchar(10000) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `html`) VALUES
(1, '<div class="lesson-div section-1"><p><span class="highlight">Bacon</span> ipsum dolor sit amet venison beef ball tip, filet mignon bacon landjaeger t-bone shank ham chicken pork belly. Ribeye leberkas ball tip flank jerky capicola fatback pork loin t-bone shank bacon. Ball tip ribeye venison brisket pig pancetta filet mignon pork spare ribs. Fatback spare ribs bresaola, strip steak capicola leberkas beef prosciutto frankfurter pancetta. Strip steak bresaola ham beef kevin, tail beef ribs ribeye turkey ball tip andouille. Pork loin tenderloin sausage short ribs short loin jowl venison strip steak kielbasa flank. Pork loin shankle porchetta turkey tongue frankfurter tenderloin venison spare ribs rump prosciutto short ribs ground round.</p><ol class="code"><li><code>Sample Code</code></li><li><code>Testing</code></li><li><code>Testing</code></li><li><code>Testing</code></li><li><code>Testing</code></li></ol><p><input type="text" id="section-1-answer" onkeyup="checkSectionAnswer(this, ''1'')"/>&nbsp;&nbsp;<span id="section-1-feedback">Enter Answer</span><span class="hidden" id="section-1-hash">b46170535240d2c507556a050d79908b</span></p></div><div class="lesson-div section-2"><p>Pork kevin rump, salami pastrami doner shoulder. Ham hock prosciutto frankfurter cow, beef ribs tail doner ground round flank chuck pastrami ribeye. Jerky ball tip pork belly salami strip steak corned beef, andouille tenderloin tail. Shoulder meatloaf pork chop ribeye. Ribeye prosciutto kevin pork chop doner, rump beef biltong pancetta ground round tri-tip. Landjaeger tenderloin filet mignon, pork loin venison leberkas chuck bacon ham. Drumstick rump andouille, beef ribs bresaola ground round frankfurter leberkas pork chop turducken tri-tip chuck tenderloin.</p><p><input type="text" id="section-2-answer" onkeyup="checkSectionAnswer(this, ''2'')"/>&nbsp;&nbsp;<span id="section-2-feedback">Enter Answer</span><span class="hidden" id="section-2-hash">b46170535240d2c507556a050d79908b</span></p></div><div class="lesson-div section-3"><p>Landjaeger shoulder hamburger, jerky tail leberkas boudin capicola fatback chicken spare ribs ground round. Sausage prosciutto cow filet mignon porchetta corned beef hamburger short ribs biltong jowl meatball fatback salami jerky. Shank shoulder meatloaf tenderloin, ball tip turducken beef beef ribs. T-bone spare ribs pig, ball tip biltong <span class="highlight">frankfurter</span> bacon filet mignon. Tail shoulder kielbasa shank ground round fatback meatball chicken bacon pig leberkas. Ball tip chuck turducken, flank shoulder drumstick jerky t-bone hamburger porchetta ham brisket sausage.</p><p><input type="text" id="section-3-answer" onkeyup="checkSectionAnswer(this, ''3'')"/>&nbsp;&nbsp;<span id="section-3-feedback">Enter Answer</span><span class="hidden" id="section-3-hash">b46170535240d2c507556a050d79908b</span></p></div><div class="lesson-div section-4"><p>Pork chop boudin sirloin fatback. Biltong landjaeger turducken pork chop doner, drumstick leberkas pastrami shankle. Short loin cow bresaola shank ball tip, pancetta shankle pig. Ham tenderloin corned beef, filet mignon bresaola short loin landjaeger beef chuck tail ribeye pork loin ham hock kielbasa turducken. Prosciutto meatball bresaola, strip steak pig cow pork belly hamburger biltong.</p><p><input type="text" id="section-4-answer" onkeyup="checkSectionAnswer(this, ''4'')"/>&nbsp;&nbsp;<span id="section-4-feedback">Enter Answer</span><span class="hidden" id="section-4-hash">b46170535240d2c507556a050d79908b</span></p></div><div class="lesson-div section-5"><p>Ham sausage corned beef pastrami spare ribs. Meatloaf ham chuck strip steak short loin pig shoulder jowl corned beef cow ribeye landjaeger hamburger. Shank sirloin frankfurter prosciutto rump ham. Brisket andouille ball tip pancetta meatloaf salami strip steak rump venison sausage leberkas. Landjaeger pancetta pork chop jerky corned beef prosciutto cow, turkey chicken <span class="highlight">salami</span> shoulder andouille. Pork ball tip short loin pork loin pork belly turkey tail fatback, brisket andouille t-bone beef ribs bresaola tenderloin.</p><form method="POST" action="select-task.php"><input class="button" type="submit" name="send" value="Next"></form></div>');

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kc` int(11) NOT NULL,
  `question` varchar(5000) NOT NULL,
  `answer` varchar(250) NOT NULL,
  `answer_type` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `kc`, `question`, `answer`, `answer_type`) VALUES
(1, 0, '<form method="post" action="select-task.php"> <p>Declare a pointer of type integer with the pointer name "intptr"</p> <p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></form>', 'int * intptr;', 'C'),
(2, 0, '<form method="post" action="select-task.php"> <p>Assign the address of an integer named "num" to a pointer named "numptr"</p> <p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></form>', 'numptr = &num;', 'C'),
(3, 0, '<form method="post" action="select-task.php"> <p>Suppose you have a char variable:</p> <p>char charData;</p> <p>Store the contents of this variable into the location that a char pointer named "charptr" points to.</p> <p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></form>', '*charptr = charData;', 'C'),
(4, 0, '<form method="post" action="select-task.php"> <p>Consider the following code:</p> <ol class="code"> <li><code>int * intPointer1;</code></li> <li><code>int * intPointer2 = malloc(sizeof(int));</code></li> <li><code>*intPointer2 = 8;</code></li> <li><code>*intPointer2 = *intPointer2 + 1;</code></li> <li><code>intPointer1 = intPointer2;</code></li> <li><code>*intPointer2 = *intPointer2 + 3;</code></li> </ol> <p>What value will will intPointer1 be pointing to?</p> <p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></form>', '9', 'T'),
(5, 0, '<form method="post" action="select-task.php"> <p>Declare a pointer of type char with the pointer name "charptr"</p> <p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></form>', 'char * charptr;', 'C'),
(6, 0, '<form method="post" action="select-task.php"> <p>Declare a double pointer of type char with the pointer name "doubleCharPtr"<p> <p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></form>', 'char ** doubleCharPtr;', 'C'),
(7, 2, '<form method="post" action="select-task.php"> <p>Consider the following code: <ol class="code"> <li><code>int * intPointer1 = malloc(sizeof(int));</code></li> <li><code>int * intPointer2 = malloc(sizeof(int));</code></li> <li><code>*intPointer2 = 8;</code></li> <li><code>*intPointer2 = *intPointer2 + 1;</code></li> <li><code>intPointer1 = intPointer2;</code></li> <li><code>*intPointer2 = *intPointer2 - 6;</code></li> </ol> <p>On which line is memory leaked?</p> <p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></form>', '5', 'T'),
(8, 2, '<form method="post" action="select-task.php"> <p>Create an integer pointer named "intptr", allocate space for one integer and make your pointer point to it all in one line of code</p> <p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></form>', 'int * intptr = malloc(sizeof(int));', 'C');


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
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
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
  `current_task` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `reg_users`
--

INSERT INTO `reg_users` (`id`, `first_name`, `last_name`, `password`, `email`, `rank`, `registered`, `last_login`, `token`, `token_validity`, `reg_ip`, `user_stat`, `current_task`) VALUES
(1, 'Steven', 'Barney', 'acdd77bc283941db353f3936a5a9b847', 'srbarney@asu.edu', 3, '2014-03-13 05:10:12', '2014-04-05 15:03:44', '9dfb1c02b3a778c5132ee0d617fbdf293f85dc47', '2014-04-05 16:03:44', '0.0.0.0', 'A', 1);

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
(6, 'A', 0),
(7, 'Q', 5),
(8, 'Q', 6),
(9, 'Q', 7),
(10, 'Q', 8),
(11, 'A', 0);

--
-- Table structure for table `task_attempts`
--

DROP TABLE IF EXISTS `task_attempts`;
CREATE TABLE IF NOT EXISTS `task_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` int(11) unsigned NOT NULL,
  `student_id` int(11) unsigned NOT NULL,
  `tstamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_spent` time NOT NULL DEFAULT '00:00:00',
  `hint_level_used` int(5) NOT NULL DEFAULT '0',
  `user_answer` varchar(250) NOT NULL,
  `correct` int(4) unsigned NOT NULL,
  `reviewed` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
