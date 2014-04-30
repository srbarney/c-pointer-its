-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2014 at 10:25 PM
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `html`) VALUES
(1, '<div class="lesson-div section-1">  <h1>Lesson 1</h1> <p><span class="highlight">Pointers</span> in the C programming language have been known to be a confusing topic amongst beginning programmers. In this lesson, we will introduce pointers and their syntax as well as some theory. </p> <p>More often than not, students struggle with pointers due to a lack of conceptual understanding of variables. Thus we will begin with some review.</p> <p>A variable in a C program is something that is assigned a name, the value of which can be changed. The compiler and linker then assign that variable a certain block in memory. The size of that block will depend on the range over which the variable is allowed to vary. For example, on 32 bit PC''s the size of an integer variable is 4 bytes. However, on older 16 bit PCs integers were 2 bytes.  In C the size of a variable type such as an integer need not be the same on all types of machines.  Adding upon that,  there are more than one type of integer variables in the C language (such as long, long long, and short integers). To keep things simple, this tutoring system will assume the use of a 32 bit computer system with 4 byte (32 bit) integers.</p> <p>When a variable is declared, we are telling the compiler two things. These two things are the name of the variable and the type of the variable (such as an int or char). For example, we declare a variable of type integer assigning it the name f with this instruction: </p>     <ol class="code"><li><code>int f;</code></li></ol>  <p>When the compiler sees the "int" in the above statement, it will reserve 4 bytes of memory to hold the value of the integer. It will also create a symbol table in which the symbol "f" (from the above example) to a relative address in memory where those 4 bytes were set aside. Thus, later if we write: </p>     <ol class="code"><li><code>f = 6;</code></li></ol> <p>we expect that, at run time when the above statement is executed, the value 6 will be placed in that memory location reserved for the storage of the value of f. This is the case. </p> <p>In essence there are two "values" associated with the object f. The first is the value of the integer stored there, which would be 6 in the example above. The other is the "value" of the memory location, in other words, the address of f. These two values can be refered with the nomenclature rvalue (right value, pronounced "are value") and lvalue (left value, pronounced "el value") respectively. </p> <p>In some languages, the lvalue is the value permitted on the left side of the assignment operator ''='' (i.e. the address where the result of evaluation of the right side ends up). The rvalue is that which is on the right side of the assignment statement, the 6 above. Rvalues cannot be used on the left side of the assignment statement. Thus: 6 = f; is illegal. </p> <p>Actually, the above definition of "lvalue" is somewhat modified for C. According to K&R II (page 197): [1] </p> <p>"An object is a named region of storage; an lvalue is an expression referring to an object." </p> <p>However, at this point, the definition originally cited above is sufficient. As we become more familiar with pointers we will go into more detail on this. </p> <p>Okay, now consider:</p>     <ol class="code"><li><code>int j, k;</code></li>      <li><code>k = 2;</code></li>     <li><code>j = 7;  // line 1</code></li>     <li><code>k = j;  // line 2</code></li> 	</ol> <p>In the above, the compiler interprets the j in line 1 as the address of the variable j (its lvalue) and creates code to copy the value 7 to that address. In line 2, however, the j is interpreted as its rvalue (since it is on the right hand side of the assignment operator ''=''). That is, here the j refers to the value stored at the memory location set aside for j, in this case 7. So, the 7 is copied to the address designated by the lvalue of k. </p> <p>In all of these examples, we are using 4 byte integers so all copying of rvalues from one storage location to the other is done by copying 4 bytes. Had we been using two byte integers, we would be copying 2 bytes. </p> <p>Now, what if you wanted to create a variable that was designed to hold an lvalue? A variable of this kind is called a pointer variable. In the C programming language, a pointer variable is defined similarly to a regular variable except an asterisk is placed before the variable name. In C when we define a pointer variable we do so by preceding its name with an asterisk. We must also remember to give the pointer variable a type. For example, consider the variable declaration: </p>    <ol class="code"><li><code>int *ptr;</code></li></ol> <p>ptr is the name of our variable (just as f was the name of our integer variable). The ''*'' informs the compiler that we want a pointer variable, i.e. to set aside however many bytes is required to store an address in memory. The int says that we intend to use our pointer variable to store the address of an integer. Such a pointer is said to "point to" an integer. However, note that when we wrote int k; we did not give f a value. If this definition is made outside of any function ANSI compliant compilers will initialize it to zero. Similarly, ptr has no value, that is we haven''t stored an address in it in the above declaration. In this case, again if the declaration is outside of any function, it is initialized to a value guaranteed in such a way that it is guaranteed to not point to any C object or function. A pointer initialized in this manner is called a "null" pointer. </p> <p>The actual bit pattern used for a null pointer may or may not evaluate to zero since it depends on the specific system on which the code is developed. To make the source code compatible between various compilers on various systems, a macro is used to represent a null pointer. That macro goes under the name NULL. Thus, setting the value of a pointer using the NULL macro, as with an assignment statement such as ptr = NULL, guarantees that the pointer has become a null pointer. Similarly, just as one can test for an integer value of zero, as in if(k == 0), we can test for a null pointer using if (ptr == NULL). </p>    <p> Before moving on, try declaring a pointer by yourself. Use the data type "char" and the name "charPtr".</p>  	<p><input type="text" id="section-1-answer" onkeyup="checkSectionAnswer(this, ''1'')"/>&nbsp;&nbsp;<span id="section-1-feedback">Enter Answer</span><span class="hidden" id="section-1-hash">f654a8ea7a6d0f62b348e382ea21a808</span></p></div>  	<div class="lesson-div section-2"><p>But, back to using our new variable ptr. Suppose now that we want to store in ptr the address of our integer variable k. To do this we use the unary & operator and write: </p> 		<ol class="code"><li><code>ptr = &k;</code></li></ol> 	<p>What the & operator does is retrieve the lvalue (address) of k, even though k is on the right hand side of the assignment operator ''='', and copies that to the contents of our pointer ptr. Now, ptr is said to "point to" k. Bear with us now, there is only one more operator we need to discuss. </p> 	<p>Once again, before moving on, using the char pointer do created before, assign it the address of a char variable named "anotherChar"</p> 		<p><input type="text" id="section-2-answer" onkeyup="checkSectionAnswer(this, ''2'')"/>&nbsp;&nbsp;<span id="section-2-feedback">Enter Answer</span><span class="hidden" id="section-2-hash">55fdbb46a45ee615cf311e8d57d4a777</span></p></div>  	<div class="lesson-div section-3"><p>The "dereferencing operator" is the asterisk and it is used as follows: </p> 		<ol class="code"><li><code>*ptr = 7;</code></li></ol> 		<p>will copy 7 to the address pointed to by ptr. Thus if ptr "points to" (contains the address of) k, the above statement will set the value of k to 7. That is, when we use the ''*'' this way we are referring to the value of that which ptr is pointing to, not the value of the pointer itself. </p> 		<p>Using the char pointer you created before, assign the character ''c'' to it by dereferencing it.  		<p><input type="text" id="section-3-answer" onkeyup="checkSectionAnswer(this, ''3'')"/>&nbsp;&nbsp;<span id="section-3-feedback">Enter Answer</span><span class="hidden" id="section-3-hash">dec1fd0d84c8a76bb9790d540e28bee6</span></p></div>  	<div class="lesson-div section-4"><p>Similarly, we could write: </p>  <ol class="code"><li><code>printf("%d\\n",*ptr);</code></li></ol>  <p>to print to the screen the integer value stored at the address pointed to by ptr;. </p> <p> 	In addition to regular pointers, lets say you wanted to create a pointer that pointed to the location of another pointer, how would you do this? This would be called a double pointer. It is done by using to asterisks ''**'', this indicated two levels of pointers. Look at the following line of code:</p> 	<ol class="code"><li><code>int ** doublePointer;</code></li></ol>	 	<p> 	This is how a double pointer (with an integer data type) is declared. Lets create another pointer (single pointer) and make our double pointer point to it:</p> 	<ol class="code"><li><code>int j, k;</code></li>      <li><code>int * singlePointer;</code></li>     <li><code>*singlePointer = 20; //point singlePointer to 20</code></li>     <li><code>doublePointer = &amp;singlePointer;</code></li> 	</ol>  	<p> 	This is a diagram of how it would look:<br><br> 	doublePointer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;singlePointer<br> 	 	| addr  |  20   |---------->| 20 |  addr to int   |---------->| 20 |<br><br> 	  	''addr'' is the address of the double pointer. 20 is the address of single pointer. Notice that the doublePointer stores the address of singlePtr. NOTE: I am using the address of 20 as an example, in reality it would not be such a small number.<br><br> 	Before moving on, go ahead and create a double char pointer named ''doubleCharPtr''		 	 	</p> 	<p><input type="text" id="section-4-answer" onkeyup="checkSectionAnswer(this, ''4'')"/>&nbsp;&nbsp;<span id="section-4-feedback">Enter Answer</span><span class="hidden" id="section-4-hash">2fa52fe1e7fb5debf623a8702151ccde</span></p> <div class="lesson-div section-5"><p> Good job! You have completed lesson 1. Before moving on to lesson 2, you will need to complete the lesson 1 assessment. It is a graded assessment, thus, feel free to review this page before moving on if you would like. </p> <form method="POST" action="select-task.php"><input class="button" type="submit" name="send" value="Next"></form> </div>'),
(2, '<div class="lesson-div section-1">  <h1>Lesson 2 - Dynamic Memory Allocation</h1> <p><span class="highlight">Let''s</span> say that once we have defined a pointer, we would like to set aside a piece of memory that this pointer will be designated to point to. How would we do this? This is where the function ''malloc'' comes into play. is a function that you use to request memory from the system. You tell it how many bytes you want, and it''ll return a pointer to a newly allocated block of memory. Here''s an example of how you can use it:</p>     <ol class="code"><li><code>int * intPtr = malloc(1500);</code></li></ol>  <p>Of course, simply allocating 1500 doesn''t make much sense at all. Since we are using an integer pointer, we can ask malloc to give us exactly enough memory to put a single integer into it. Here''s how you would do that:</p>     <ol class="code"><li><code>int * intPtr = malloc(sizeof(int));</code></li></ol>     <p> Before moving on, try creating a char pointer and allocating space for one char using malloc(). Use the data type "char" and the name "charPtr".</p>  	<p><input type="text" id="section-1-answer" onkeyup="checkSectionAnswer(this, ''1'')"/>&nbsp;&nbsp;<span id="section-1-feedback">Enter Answer</span><span class="hidden" id="section-1-hash">aeda4195e3e32ec96940b2335e3f170d</span></p></div>  	<div class="lesson-div section-2"><p>The memory you allocate using malloc() is always accessible. No matter what function you are in, the memory will never be destroyed. Unless you explicitly tell the system to get rid of your block of memory, of course. You would do this using the free() function. This is an example of how you would do that.</p> 		<ol class="code"><li><code>free(intPtr);</code></li></ol> 	<p>You should always free() pointers you receive from malloc(). If you don''t, and keep requesting memory from the system, your application will use more and more memory (they say your application has a "memory leak" or a "memleak"). Eventually, your application will have taken up all the memory on your system: you''ll start getting strange errors, apps will start crashing randomly, your computer will lock up, etc. So, always free the memory you allocated as soon as you don''t need it anymore. It is also good practice to always check and make sure that malloc did not return NULL. For example, it may return NULL if it does not have the requested memory available.</p> 	<p>Once again, before moving on, using the char pointer you created before, free the memory by using the function you just learned about.</p> 		<p><input type="text" id="section-2-answer" onkeyup="checkSectionAnswer(this, ''2'')"/>&nbsp;&nbsp;<span id="section-2-feedback">Enter Answer</span><span class="hidden" id="section-2-hash">267854d4e8c999cf873684a97d57b581</span></p></div>  	<div class="lesson-div section-3"><p>One common application of dynamic memory allocation with pointers is creating a dynamic array. When creating a dynamic array, you must create a pointer and allocate it to point to n times the size of the data you wish to hold, n being the size of the dynamic array. Let me provide an example. Let''s say you would like to create a dynamic integer array of size 10. Here is how you would do this:</p> 		<ol class="code"><li><code>int * dynIntArr = malloc(10 * sizeof(int));</code></li></ol> 		<p>Did you catch what happened there? all we did was multiply the result returned from sizeof() with the size of the dynamic array we wanted to create. Once you have created the dynamic array, you can actually use it just like a regular array! For example, if we wanted to set the first element of the dynamic array that we just created to 7, all we would do is: </p> 		<ol class="code"><li><code>dynIntArr[0] = 7;</code></li></ol> 		<p>Before moving on, go ahead and create a dynamic char array of size''n'', assume that n has been previously defined and set to a particular value. Name the dynamic char array ''dynCharArr''.</p>  		<p><input type="text" id="section-3-answer" onkeyup="checkSectionAnswer(this, ''3'')"/>&nbsp;&nbsp;<span id="section-3-feedback">Enter Answer</span><span class="hidden" id="section-3-hash">3a2e9795c15e0976792e523d2e1ea568</span></p></div>  	<div class="lesson-div section-4"> <p> 	Good job! Now, we had previously discussed that there is one thing you should always do when allocating memory dynamically. Without looking back, do that ''one thing'' to the dynamic array that you just created.  		 	 	</p> 	<p><input type="text" id="section-4-answer" onkeyup="checkSectionAnswer(this, ''4'')"/>&nbsp;&nbsp;<span id="section-4-feedback">Enter Answer</span><span class="hidden" id="section-4-hash">2e5b38bf21fc56b9bb998365ece44052</span></p> <div class="lesson-div section-5"><p> Well done! You have completed lesson 2. Before moving on to lesson 3, you will need to complete the lesson 2 assessment. Once again, it is a graded assessment, thus, feel free to review this page as much as you need to before moving on. </p> <form method="POST" action="select-task.php"><input class="button" type="submit" name="send" value="Next"></form> </div>'),
(3, '<div class="lesson-div section-1">  <h1>Lesson 3 - Passing Pointers to Functions</h1> <p><span class="highlight">The</span> ability to pass pointers to functions is very powerful, and pretty easy to master with enough practice. If we were to make a program that takes a number and adds five to it using a function, we might write something like the following:</p>     <ol class="code">     <li><code>void addFive(int num){</code></li>     <li><code>num = num + 5;</code></li>     <li><code>}</code></li>     <li><code></code></li>     <li><code></code></li>     <li><code>void main(){</code></li>     <li><code>int myNum = 18;</code></li>     <li><code></code></li>     <li><code>printf("My original number is %d\\n", myNum);</code></li> 	<li><code>addFive(myNum);</code></li>     <li><code>printf("My new number is %d\\n", myNum);</code></li>     <li><code></code></li>     <li><code>}</code></li> 	</ol>  <p>However, the problem with this is that the Number referred to in AddFive is a copy of the variable myNum passed to the function, not the variable itself. Therefore, the line num = num + 5 adds five to the copy of the variable, leaving the original variable in main() unaffected. You can try running the program to prove this. </p> <p> To get around this problem, we can pass a pointer to where the number is kept in memory to the function, but we''ll have to alter the function so that it expects a pointer to a number, not a number. To do this, we change void addFive(int num) to void addFive(int * num), adding the asterisk. Here is the program again, with the changes made. Notice that we have to make sure we pass the address of myNum instead of the number itself? This is done by adding the & (ampersand) sign, which (as you will recall) is read as "the address of."</p>     <ol class="code">     <li><code>void addFive(int * num){ //notice: ''*''</code></li>     <li><code>num = num + 5;</code></li>     <li><code>}</code></li>     <li><code></code></li>     <li><code></code></li>     <li><code>void main(){</code></li>     <li><code>int myNum = 18;</code></li>     <li><code></code></li>     <li><code>printf("My original number is %d\\n", myNum);</code></li> 	<li><code>addFive(&myNum); //notice: ''&''</code></li>     <li><code>printf("My new number is %d\\n", myNum);</code></li>     <li><code></code></li>     <li><code>}</code></li> 	</ol>      <p> It''s that simple. That is all there is to this lesson. However, before moving on, we would like to let you try it yourself. Go ahead and declare a void function named ''ptrFunct'' that accepts one integer pointer named ''ptrArg''. NOTE: assume the opening bracket of the function will be placed on the next line - so no need to include it in this text field.</p>  	<p><input type="text" id="section-1-answer" onkeyup="checkSectionAnswer(this, ''1'')"/>&nbsp;&nbsp;<span id="section-1-feedback">Enter Answer</span><span class="hidden" id="section-1-hash">d10001e47cee7e1de385f027c74ff8f6</span></p></div>  	<div class="lesson-div section-2"><p>Excellent! Now let''s say we are back in the main() function and we want to pass an integer pointer named ''intToPass'' to the function you just created. Type the function call and pass the pointer properly to the function.</p>  		<p><input type="text" id="section-2-answer" onkeyup="checkSectionAnswer(this, ''2'')"/>&nbsp;&nbsp;<span id="section-2-feedback">Enter Answer</span><span class="hidden" id="section-2-hash">ebeffe61ffda95314c37ac99745b081f</span></p></div>   <div class="lesson-div section-3"><p> Well done! You correctly passed a pointer to a function. While this was a short lesson, many students still struggle on this area, so before proceeding to the next assessment, make sure you really understand what is going on here.  </p> <form method="POST" action="select-task.php"><input class="button" type="submit" name="send" value="Next"></form> </div>'),
(4, '<div class="lesson-div section-1">  <h1>Lesson 4 - Struct Pointers and the ''->'' Operator</h1> <p><span class="highlight">Often</span> times in C you find that you would like to create a pointer to a struct. This is useful, for instance, if you would like to pass the struct to a pointer. Struct pointers are used very often in C, thus this is worthy of its own lesson. Let''s begin this lesson by creating a struct like so: </p>     <ol class="code">     	<li><code>typedef struct person{</code></li>     	<li><code>int age;</code></li>     	<li><code>char gender;</code></li>     	<li><code>}Person;</code></li>    	</ol>  <p>Note: this struct uses typedef for ease of use later on. For the purposes of this lesson, we will assume you understand how typedef works.</p>     <p>We would normally create a struct variable like so: </p> <ol class="code"><li><code>Person p1;</code></li></ol>   <p>Do you recall how you would usually access a data member inside of a struct? In order to access a data member in a struct, we would use the ''.'' operator (Dot). For example, to set the age to ''22'', we would do so like: </p>  <ol class="code"><li><code>p1.age = 22;</code></li></ol>  <p>However, in this case we want to create a pointer to a variable, and accessing data elements when you have a struct pointer is slightly different. Let''s create a struct pointer and allocate memory for it first:</p>  <ol class="code"><li><code>Person * p2 = malloc(sizeof(Person));</code></li></ol> <p>Now how would we access the data member ''age''? When we have a pointer to a struct, we use the ''->'' (arrow) operator to access data elements. For example, if we wanted to set the data element ''age'' to 18, we would do this:</p>  <ol class="code"><li><code>p2->age = 18;</code></li></ol>  <p>This arrow operator dereferences the pointer p2 and sets its data element ''age'' to 18. You might wonder if we would still, somehow, use the dot operator to accomplish the same thing, and you would be right. You can use the dot operator on a struct pointer BUT first you must dereference it. For example, this next line of code accomplishes the exact same thing that the previous line of code does:</p> <ol class="code"><li><code>(*p2).age = 18;</code></li></ol>     <p> Before concluding this lesson, go ahead and try it yourself. Set the ''gender'' data element of the struct pointer p2 defined above to "M" using the arrow operator:</p>  	<p><input type="text" id="section-1-answer" onkeyup="checkSectionAnswer(this, ''1'')"/>&nbsp;&nbsp;<span id="section-1-feedback">Enter Answer</span><span class="hidden" id="section-1-hash">9ca79b3ee1ed9412f2462291d0489927</span></p></div>  	<div class="lesson-div section-2"><p> Now create a char pointer called ''p2_gender'' and assign it the gender by accessing the same struct pointer you used in the last problem. However instead of using the arrow operator, do this by dereferencing and using the dot operator.</p> 		<p><input type="text" id="section-2-answer" onkeyup="checkSectionAnswer(this, ''2'')"/>&nbsp;&nbsp;<span id="section-2-feedback">Enter Answer</span><span class="hidden" id="section-2-hash">ca30c81606d8d202536fafbb37adf62f</span></p></div>  <div class="lesson-div section-3"><p> Good job! You have completed lesson 4. Please continue on to the next assessment. It is a graded assessment, thus, feel free to review this page before moving on if you would like. </p> <form method="POST" action="select-task.php"><input class="button" type="submit" name="send" value="Next"></form> </div>');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kc` int(11) NOT NULL,
   `lesson_tag` int(11) NOT NULL,
  `question` varchar(5000) COLLATE utf8_unicode_ci NOT NULL,
  `answer` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `hint` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `answer_type` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `kc`, `lesson_tag`, `question`, `answer`, `hint`, `answer_type`) VALUES
(1, 0, 1, '<form method="post" action="select-task.php"> <p>Declare a pointer of type integer with the pointer name "intptr"</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', 'int * intptr;', 'EDIT ME', 'C'),
(2, 0, 1, '<form method="post" action="select-task.php"> <p>Assign the address of an integer named "num" to a pointer named "numptr"</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', 'numptr = &amp;num;', 'EDIT ME', 'C'),
(3, 0, 1, '<form method="post" action="select-task.php"> <p>Suppose you have a char variable:</p> <p>char charData;</p> <p>Store the contents of this variable into the location that a char pointer named "charptr" points to.</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', '*charptr = charData;', 'EDIT ME', 'C'),
(4, 0, 1, '<form method="post" action="select-task.php"> <p>Consider the following code:</p> <ol class="code"> <li><code>int * intPointer1;</code></li> <li><code>int * intPointer2 = malloc(sizeof(int));</code></li> <li><code>*intPointer2 = 8;</code></li> <li><code>*intPointer2 = *intPointer2 + 1;</code></li> <li><code>intPointer1 = intPointer2;</code></li> <li><code>*intPointer2 = *intPointer2 + 3;</code></li> </ol> <p>What value will will intPointer1 be pointing to?</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', '9', 'EDIT ME', 'T'),
(5, 0, 1, '<form method="post" action="select-task.php"> <p>Declare a pointer of type char with the pointer name "charptr"</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', 'char * charptr;', 'EDIT ME', 'C'),
(6, 0, 1, '<form method="post" action="select-task.php"> <p>Declare a double pointer of type char with the pointer name "doubleCharPtr"</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', 'char ** doubleCharPtr;', 'EDIT ME', 'C'),
(7, 2, 2, '<form method="post" action="select-task.php"> <p>Consider the following code: <ol class="code"> <li><code>int * intPointer1 = malloc(sizeof(int));</code></li> <li><code>int * intPointer2 = malloc(sizeof(int));</code></li> <li><code>*intPointer2 = 8;</code></li> <li><code>*intPointer2 = *intPointer2 + 1;</code></li> <li><code>intPointer1 = intPointer2;</code></li> <li><code>*intPointer2 = *intPointer2 - 6;</code></li> </ol> <p>On which line is memory leaked?</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', '5', 'EDIT ME', 'T'),
(8, 2, 1, '<form method="post" action="select-task.php"> <p>Create an integer pointer named "intptr", allocate space for one integer and make your pointer point to it all in one line of code</p> <span class="answer-area"><p>Type your answer below:</p> <p><input type="text" name="answer">&nbsp;&nbsp;<input class="button" type="submit" name="send" value="Submit"></p></span></form>', 'int * intptr = malloc(sizeof(int));', 'EDIT ME', 'C');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `reg_login_attempt`
--

INSERT INTO `reg_login_attempt` (`id`, `ip`, `email`, `login_success`, `ts`) VALUES
(1, '::1', 'cameronk313@cox.net', 1, '2014-04-27 03:18:05'),
(2, '::1', 'cameronk313@cox.net', 1, '2014-04-27 04:01:59'),
(3, '::1', 'cameronk313@cox.net', 1, '2014-04-27 04:20:13'),
(4, '::1', 'cameronk313@cox.net', 1, '2014-04-29 03:05:19'),
(5, '::1', 'cameronk313@cox.net', 1, '2014-04-29 03:06:29'),
(6, '::1', 'cameronk313@cox.net', 1, '2014-04-29 05:19:03');

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
  `task_list` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `reg_users`
--

INSERT INTO `reg_users` (`id`, `first_name`, `last_name`, `password`, `email`, `rank`, `registered`, `last_login`, `token`, `token_validity`, `reg_ip`, `user_stat`, `current_task`) VALUES
(1, 'Steven', 'Barney', 'acdd77bc283941db353f3936a5a9b847', 'srbarney@asu.edu', 3, '2014-03-13 05:10:12', '2014-04-05 15:03:44', '9dfb1c02b3a778c5132ee0d617fbdf293f85dc47', '2014-04-05 16:03:44', '0.0.0.0', 'A', 1),
(2, 'Cameron', 'Keith', 'c59b47fbcf66b482e2ed3db39ab05155', 'cameronk313@cox.net', 3, '2014-04-27 03:17:53', '2014-04-29 05:19:03', 'f6d7bcd792a2dc3d6f6d79c45b9877572fef4475', '2014-04-29 06:19:03', '0.0.0.0', 'A', 6);

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
(11, 'A', 2),
(12, 'L', 2),
(13, 'L', 3),
(14, 'L', 4);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `task_attempts`
--

INSERT INTO `task_attempts` (`id`, `question_id`, `student_id`, `tstamp`, `time_spent`, `hint_level_used`, `user_answer`, `correct`, `reviewed`) VALUES
(1, 1, 2, '2014-04-29 03:17:19', '00:00:00', 0, 'int * intptr;', 1, 0),
(2, 2, 2, '2014-04-29 03:17:52', '00:00:00', 0, 'numptr = &amp;num;', 1, 0),
(3, 3, 2, '2014-04-29 03:18:35', '00:00:00', 0, '*charptr = charData;', 1, 0),
(4, 4, 2, '2014-04-29 03:18:50', '00:00:00', 0, '9', 1, 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user_profile`
--

INSERT INTO `user_profile` (`id`, `user_id`, `KC1correct`, `KC1attempts`, `KC2correct`, `KC2attempts`, `KC3correct`, `KC3attempts`, `KC4correct`, `KC4attempts`) VALUES
(1, 2, 4, 4, 0, 0, 0, 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
