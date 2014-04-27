-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2014 at 09:58 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `a8567911_cpoint`
--

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_components`
--
DROP TABLE IF EXISTS `knowledge_components`;
CREATE TABLE IF NOT EXISTS `knowledge_components` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

DROP TABLE IF EXISTS `lessons`;
CREATE TABLE IF NOT EXISTS `lessons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `html` varchar(15000) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `html`) VALUES
(1, '<div class="lesson-div section-1">  <h1>Lesson 1</h1> <p><span class="highlight">Pointers</span> in the C programming language have been known to be a confusing topic amongst beginning programmers. In this lesson, we will introduce pointers and their syntax as well as some theory. </p> <p>More often than not, students struggle with pointers due to a lack of conceptual understanding of variables. Thus we will begin with some review.</p> <p>A variable in a C program is something that is assigned a name, the value of which can be changed. The compiler and linker then assign that variable a certain block in memory. The size of that block will depend on the range over which the variable is allowed to vary. For example, on 32 bit PC''s the size of an integer variable is 4 bytes. However, on older 16 bit PCs integers were 2 bytes.  In C the size of a variable type such as an integer need not be the same on all types of machines.  Adding upon that,  there are more than one type of integer variables in the C language (such as long, long long, and short integers). To keep things simple, this tutoring system will assume the use of a 32 bit computer system with 4 byte (32 bit) integers.</p> <p>When a variable is declared, we are telling the compiler two things. These two things are the name of the variable and the type of the variable (such as an int or char). For example, we declare a variable of type integer assigning it the name f with this instruction: </p>     <ol class="code"><li><code>int f;</code></li></ol>  <p>When the compiler sees the "int" in the above statement, it will reserve 4 bytes of memory to hold the value of the integer. It will also create a symbol table in which the symbol "f" (from the above example) to a relative address in memory where those 4 bytes were set aside. Thus, later if we write: </p>     <ol class="code"><li><code>f = 6;</code></li></ol> <p>we expect that, at run time when the above statement is executed, the value 6 will be placed in that memory location reserved for the storage of the value of f. This is the case. </p> <p>In essence there are two "values" associated with the object f. The first is the value of the integer stored there, which would be 6 in the example above. The other is the "value" of the memory location, in other words, the address of f. These two values can be refered with the nomenclature rvalue (right value, pronounced "are value") and lvalue (left value, pronounced "el value") respectively. </p> <p>In some languages, the lvalue is the value permitted on the left side of the assignment operator ''='' (i.e. the address where the result of evaluation of the right side ends up). The rvalue is that which is on the right side of the assignment statement, the 6 above. Rvalues cannot be used on the left side of the assignment statement. Thus: 6 = f; is illegal. </p> <p>Actually, the above definition of "lvalue" is somewhat modified for C. According to K&R II (page 197): [1] </p> <p>"An object is a named region of storage; an lvalue is an expression referring to an object." </p> <p>However, at this point, the definition originally cited above is sufficient. As we become more familiar with pointers we will go into more detail on this. </p> <p>Okay, now consider:</p>     <ol class="code"><li><code>int j, k;</code></li>      <li><code>k = 2;</code></li>     <li><code>j = 7;  // line 1</code></li>     <li><code>k = j;  // line 2</code></li> 	</ol> <p>In the above, the compiler interprets the j in line 1 as the address of the variable j (its lvalue) and creates code to copy the value 7 to that address. In line 2, however, the j is interpreted as its rvalue (since it is on the right hand side of the assignment operator ''=''). That is, here the j refers to the value stored at the memory location set aside for j, in this case 7. So, the 7 is copied to the address designated by the lvalue of k. </p> <p>In all of these examples, we are using 4 byte integers so all copying of rvalues from one storage location to the other is done by copying 4 bytes. Had we been using two byte integers, we would be copying 2 bytes. </p> <p>Now, what if you wanted to create a variable that was designed to hold an lvalue? A variable of this kind is called a pointer variable. In the C programming language, a pointer variable is defined similarly to a regular variable except an asterisk is placed before the variable name. In C when we define a pointer variable we do so by preceding its name with an asterisk. We must also remember to give the pointer variable a type. For example, consider the variable declaration: </p>    <ol class="code"><li><code>int *ptr;</code></li></ol> <p>ptr is the name of our variable (just as f was the name of our integer variable). The ''*'' informs the compiler that we want a pointer variable, i.e. to set aside however many bytes is required to store an address in memory. The int says that we intend to use our pointer variable to store the address of an integer. Such a pointer is said to "point to" an integer. However, note that when we wrote int k; we did not give f a value. If this definition is made outside of any function ANSI compliant compilers will initialize it to zero. Similarly, ptr has no value, that is we haven''t stored an address in it in the above declaration. In this case, again if the declaration is outside of any function, it is initialized to a value guaranteed in such a way that it is guaranteed to not point to any C object or function. A pointer initialized in this manner is called a "null" pointer. </p> <p>The actual bit pattern used for a null pointer may or may not evaluate to zero since it depends on the specific system on which the code is developed. To make the source code compatible between various compilers on various systems, a macro is used to represent a null pointer. That macro goes under the name NULL. Thus, setting the value of a pointer using the NULL macro, as with an assignment statement such as ptr = NULL, guarantees that the pointer has become a null pointer. Similarly, just as one can test for an integer value of zero, as in if(k == 0), we can test for a null pointer using if (ptr == NULL). </p>    <p> Before moving on, try declaring a pointer by yourself. Use the data type "char" and the name "charPtr".</p>  	<p><input type="text" id="section-1-answer" onkeyup="checkSectionAnswer(this, ''1'')"/>&nbsp;&nbsp;<span id="section-1-feedback">Enter Answer</span><span class="hidden" id="section-1-hash">f654a8ea7a6d0f62b348e382ea21a808</span></p></div>  	<div class="lesson-div section-2"><p>But, back to using our new variable ptr. Suppose now that we want to store in ptr the address of our integer variable k. To do this we use the unary & operator and write: </p> 		<ol class="code"><li><code>ptr = &k;</code></li></ol> 	<p>What the & operator does is retrieve the lvalue (address) of k, even though k is on the right hand side of the assignment operator ''='', and copies that to the contents of our pointer ptr. Now, ptr is said to "point to" k. Bear with us now, there is only one more operator we need to discuss. </p> 	<p>Once again, before moving on, using the char pointer do created before, assign it the address of a char variable named "anotherChar"</p> 		<p><input type="text" id="section-2-answer" onkeyup="checkSectionAnswer(this, ''2'')"/>&nbsp;&nbsp;<span id="section-2-feedback">Enter Answer</span><span class="hidden" id="section-2-hash">55fdbb46a45ee615cf311e8d57d4a777</span></p></div>  	<div class="lesson-div section-3"><p>The "dereferencing operator" is the asterisk and it is used as follows: </p> 		<ol class="code"><li><code>*ptr = 7;</code></li></ol> 		<p>will copy 7 to the address pointed to by ptr. Thus if ptr "points to" (contains the address of) k, the above statement will set the value of k to 7. That is, when we use the ''*'' this way we are referring to the value of that which ptr is pointing to, not the value of the pointer itself. </p> 		<p>Using the char pointer you created before, assign the character ''c'' to it by dereferencing it.  		<p><input type="text" id="section-3-answer" onkeyup="checkSectionAnswer(this, ''3'')"/>&nbsp;&nbsp;<span id="section-3-feedback">Enter Answer</span><span class="hidden" id="section-3-hash">dec1fd0d84c8a76bb9790d540e28bee6</span></p></div>  	<div class="lesson-div section-4"><p>Similarly, we could write: </p>  <ol class="code"><li><code>printf("%d\\n",*ptr);</code></li></ol>  <p>to print to the screen the integer value stored at the address pointed to by ptr;. </p> <p> 	In addition to regular pointers, lets say you wanted to create a pointer that pointed to the location of another pointer, how would you do this? This would be called a double pointer. It is done by using to asterisks ''**'', this indicated two levels of pointers. Look at the following line of code:</p> 	<ol class="code"><li><code>int ** doublePointer;</code></li></ol>	 	<p> 	This is how a double pointer (with an integer data type) is declared. Lets create another pointer (single pointer) and make our double pointer point to it:</p> 	<ol class="code"><li><code>int j, k;</code></li>      <li><code>int * singlePointer;</code></li>     <li><code>*singlePointer = 20; //point singlePointer to 20</code></li>     <li><code>doublePointer = &amp;singlePointer;</code></li> 	</ol>  	<p> 	This is a diagram of how it would look:<br><br> 	doublePointer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;singlePointer<br> 	 	| addr  |  20   |---------->| 20 |  addr to int   |---------->| 20 |<br><br> 	  	''addr'' is the address of the double pointer. 20 is the address of single pointer. Notice that the doublePointer stores the address of singlePtr. NOTE: I am using the address of 20 as an example, in reality it would not be such a small number.<br><br> 	Before moving on, go ahead and create a double char pointer named ''doubleCharPtr''		 	 	</p> 	<p><input type="text" id="section-4-answer" onkeyup="checkSectionAnswer(this, ''4'')"/>&nbsp;&nbsp;<span id="section-4-feedback">Enter Answer</span><span class="hidden" id="section-4-hash">2fa52fe1e7fb5debf623a8702151ccde</span></p> <div class="lesson-div section-5"><p> Good job! You have completed lesson 1. Before moving on to lesson 2, you will need to complete the lesson 1 assessment. It is a graded assessment, thus, feel free to review this page before moving on if you would like. </p> <form method="POST" action="select-task.php"><input class="button" type="submit" name="send" value="Next"></form> </div>');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kc` int(11) NOT NULL,
  `question` varchar(5000) COLLATE utf8_unicode_ci NOT NULL,
  `answer` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `answer_type` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `kc`, `question`, `answer`, `answer_type`) VALUES
(1, 0, '<form method="post" action="select-task.php"> <p>Declare a pointer of type integer with the pointer name "intptr"</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', 'int * intptr;', 'C'),
(2, 0, '<form method="post" action="select-task.php"> <p>Assign the address of an integer named "num" to a pointer named "numptr"</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', 'numptr = &amp;num;', 'C'),
(3, 0, '<form method="post" action="select-task.php"> <p>Suppose you have a char variable:</p> <p>char charData;</p> <p>Store the contents of this variable into the location that a char pointer named "charptr" points to.</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', '*charptr = charData;', 'C'),
(4, 0, '<form method="post" action="select-task.php"> <p>Consider the following code:</p> <ol class="code"> <li><code>int * intPointer1;</code></li> <li><code>int * intPointer2 = malloc(sizeof(int));</code></li> <li><code>*intPointer2 = 8;</code></li> <li><code>*intPointer2 = *intPointer2 + 1;</code></li> <li><code>intPointer1 = intPointer2;</code></li> <li><code>*intPointer2 = *intPointer2 + 3;</code></li> </ol> <p>What value will will intPointer1 be pointing to?</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', '9', 'T'),
(5, 0, '<form method="post" action="select-task.php"> <p>Declare a pointer of type char with the pointer name "charptr"</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', 'char * charptr;', 'C'),
(6, 0, '<form method="post" action="select-task.php"> <p>Declare a double pointer of type char with the pointer name "doubleCharPtr"</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', 'char ** doubleCharPtr;', 'C'),
(7, 2, '<form method="post" action="select-task.php"> <p>Consider the following code: <ol class="code"> <li><code>int * intPointer1 = malloc(sizeof(int));</code></li> <li><code>int * intPointer2 = malloc(sizeof(int));</code></li> <li><code>*intPointer2 = 8;</code></li> <li><code>*intPointer2 = *intPointer2 + 1;</code></li> <li><code>intPointer1 = intPointer2;</code></li> <li><code>*intPointer2 = *intPointer2 - 6;</code></li> </ol> <p>On which line is memory leaked?</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', '5', 'T'),
(8, 2, '<form method="post" action="select-task.php"> <p>Create an integer pointer named "intptr", allocate space for one integer and make your pointer point to it all in one line of code</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', 'int * intptr = malloc(sizeof(int));', 'C');

-- --------------------------------------------------------

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `reg_login_attempt`
--

INSERT INTO `reg_login_attempt` (`id`, `ip`, `email`, `login_success`, `ts`) VALUES
(1, '::1', 'cameronk313@cox.net', 1, '2014-04-27 03:18:05'),
(2, '::1', 'cameronk313@cox.net', 1, '2014-04-27 04:01:59'),
(3, '::1', 'cameronk313@cox.net', 1, '2014-04-27 04:20:13');

-- --------------------------------------------------------

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
  `current_task` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `reg_users`
--

INSERT INTO `reg_users` (`id`, `first_name`, `last_name`, `password`, `email`, `rank`, `registered`, `last_login`, `token`, `token_validity`, `reg_ip`, `user_stat`, `current_task`) VALUES
(1, 'Steven', 'Barney', 'acdd77bc283941db353f3936a5a9b847', 'srbarney@asu.edu', 3, '2014-03-13 05:10:12', '2014-04-05 15:03:44', '9dfb1c02b3a778c5132ee0d617fbdf293f85dc47', '2014-04-05 16:03:44', '0.0.0.0', 'A', 1),
(2, 'Cameron', 'Keith', 'c59b47fbcf66b482e2ed3db39ab05155', 'cameronk313@cox.net', 3, '2014-04-27 03:17:53', '2014-04-27 20:54:32', '0ac6c5f0eadd0487cecfa062ae81404df0fca6f0', '2014-04-27 21:54:32', '0.0.0.0', 'A', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `task_type` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `task_type`, `task_id`) VALUES
(1, 'L', 1),
(2, 'Q', 1),
(3, 'Q', 2),
(4, 'Q', 3),
(5, 'Q', 4),
(6, 'A', 1),
(7, 'Q', 5),
(8, 'Q', 6),
(9, 'Q', 7),
(10, 'Q', 8),
(11, 'A', 2);

-- --------------------------------------------------------

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
  `user_answer` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `correct` int(4) unsigned NOT NULL,
  `reviewed` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
