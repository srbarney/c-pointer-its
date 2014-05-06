-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2014 at 06:33 AM
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
(3, '<div class="lesson-div section-1">  <h1>Lesson 3 - Passing Pointers to Functions</h1> <p><span class="highlight">The</span> ability to pass pointers to functions is very powerful, and pretty easy to master with enough practice. If we were to make a program that takes a number and adds five to it using a function, we might write something like the following:</p>     <ol class="code">     <li><code>void addFive(int num){</code></li>     <li><code>num = num + 5;</code></li>     <li><code>}</code></li>     <li><code></code></li>     <li><code></code></li>     <li><code>void main(){</code></li>     <li><code>int myNum = 18;</code></li>     <li><code></code></li>     <li><code>printf("My original number is %d\\n", myNum);</code></li> 	<li><code>addFive(myNum);</code></li>     <li><code>printf("My new number is %d\\n", myNum);</code></li>     <li><code></code></li>     <li><code>}</code></li> 	</ol>  <p>However, the problem with this is that the Number referred to in AddFive is a copy of the variable myNum passed to the function, not the variable itself. Therefore, the line num = num + 5 adds five to the copy of the variable, leaving the original variable in main() unaffected. You can try running the program to prove this. </p> <p> To get around this problem, we can pass a pointer to where the number is kept in memory to the function, but we''ll have to alter the function so that it expects a pointer to a number, not a number. To do this, we change void addFive(int num) to void addFive(int * num), adding the asterisk. Here is the program again, with the changes made. Notice that we have to make sure we pass the address of myNum instead of the number itself? This is done by adding the & (ampersand) sign, which (as you will recall) is read as "the address of."</p>     <ol class="code">     <li><code>void addFive(int * num){ //notice: ''*''</code></li>     <li><code>num = num + 5;</code></li>     <li><code>}</code></li>     <li><code></code></li>     <li><code></code></li>     <li><code>void main(){</code></li>     <li><code>int myNum = 18;</code></li>     <li><code></code></li>     <li><code>printf("My original number is %d\\n", myNum);</code></li> 	<li><code>addFive(&myNum); //notice: ''&''</code></li>     <li><code>printf("My new number is %d\\n", myNum);</code></li>     <li><code></code></li>     <li><code>}</code></li> 	</ol>      <p> It''s that simple. That is all there is to this lesson. However, before moving on, we would like to let you try it yourself. Go ahead and declare a void function named ''ptrFunct'' that accepts one integer pointer named ''ptrArg''. NOTE: assume the opening bracket of the function will be placed on the next line - so no need to include it in this text field.</p>  	<p><input type="text" id="section-1-answer" onkeyup="checkSectionAnswer(this, ''1'')"/>&nbsp;&nbsp;<span id="section-1-feedback">Enter Answer</span><span class="hidden" id="section-1-hash">d10001e47cee7e1de385f027c74ff8f6</span></p></div>  	<div class="lesson-div section-2"><p>Excellent! Now let''s say we are back in the main() function and we want to pass an integer named ''intToPass'' to the function you just created (so that it can modify the variable directly). Type the function call and pass the pointer properly to the function.</p>  		<p><input type="text" id="section-2-answer" onkeyup="checkSectionAnswer(this, ''2'')"/>&nbsp;&nbsp;<span id="section-2-feedback">Enter Answer</span><span class="hidden" id="section-2-hash">ebeffe61ffda95314c37ac99745b081f</span></p></div>   <div class="lesson-div section-3"><p> Well done! You correctly passed a pointer to a function. While this was a short lesson, many students still struggle on this area, so before proceeding to the next assessment, make sure you really understand what is going on here.  </p> <form method="POST" action="select-task.php"><input class="button" type="submit" name="send" value="Next"></form> </div>'),
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=33 ;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `kc`, `lesson_tag`, `question`, `answer`, `hint`, `answer_type`) VALUES
(1, 0, 1, '<p>Declare a pointer of type integer with the pointer name "intptr"</p> ', 'int * intptr;', 'What special character do you use to declare a pointer?', 'C'),
(2, 0, 1, '<p>Assign the address of an integer named "num" to a pointer named "numptr"</p> ', 'numptr = &amp;num;', 'Recall, a special characher ''&'' must be used.', 'C'),
(3, 0, 1, '<p>Suppose you have a char variable:</p> <p>char charData;</p> <p>Store the contents of this variable into the location that a char pointer named "charptr" points to.</p> ', '*charptr = charData;', 'Which special character do you use to access the value of the memory location "charptr" points to?', 'C'),
(4, 0, 1, '<p>Consider the following code:</p> <ol class="code"> <li><code>int * intPointer1;</code></li> <li><code>int * intPointer2 = malloc(sizeof(int));</code></li> <li><code>*intPointer2 = 8;</code></li> <li><code>*intPointer2 = *intPointer2 + 1;</code></li> <li><code>intPointer1 = intPointer2;</code></li> <li><code>*intPointer2 = *intPointer2 + 3;</code></li> </ol> <p>What value will will intPointer1 be pointing to?</p> ', '9', 'Pay close attention to what is assigned on each line.', 'T'),
(5, 0, 1, '<p>Declare a pointer of type char with the pointer name "charptr"</p> ', 'char * charptr;', 'What special character do you use to declare a pointer?', 'C'),
(6, 0, 1, '<p>Declare a double pointer of type char with the pointer name "doubleCharPtr"</p> ', 'char ** doubleCharPtr;', 'You must use a two asterisks to declare a double pointer.', 'C'),
(7, 2, 2, '<p>Consider the following code: <ol class="code"> <li><code>int * intPointer1 = malloc(sizeof(int));</code></li> <li><code>int * intPointer2 = malloc(sizeof(int));</code></li> <li><code>*intPointer2 = 8;</code></li> <li><code>*intPointer2 = *intPointer2 + 1;</code></li> <li><code>intPointer1 = intPointer2;</code></li> <li><code>*intPointer2 = *intPointer2 - 6;</code></li> </ol> <p>On which line is memory leaked?</p> ', '5', 'Look for the line where a pointer is overwritten.', 'T'),
(8, 2, 2, '<p>Create an integer pointer named "intptr", allocate space for one integer and make your pointer point to it all in one line of code</p> ', 'int * intptr = malloc(sizeof(int));', 'You must use malloc() and sizeof().', 'C'),
(9, 1, 1, '<p>Declare a pointer of type "double" and set it equal to NULL. Name the pointer nullPtr;</p>', 'double * nullPtr = NULL;', 'Don''t overthink this one. NULL just means "nothing" and is typed exactly how you see it. ', 'C'),
(10, 1, 1, '<p>Lets say you want to create a pointer to a pointer named "iPoint" of type int. Is the code below the proper way to do this?</p><ol class="code"><li><code>iPoint ** int;</code></li></ol><p>Type "yes" or "no" (in lowercase).</p>', 'no', 'Think about the first thing you need to let the compiler know about the pointer.', 'T'),
(11, 1, 1, '<p>Is this the proper way to dereference a pointer named "dereferenceMe"?</p><ol class="code"><li><code>int newData = &dereferenceMe;</code></li></ol><p>Type "yes" or "no" (in lowercase).</p>', 'no', 'Think about what character you need to use to dereference, does that one look right?', 'T'),
(12, 2, 2, '<p>Create a dynamic integer array by creating a pointer named myArray and allocating enough space for a size of "n".</p>', 'int * myArray = malloc(n * sizeof(int));', 'You will need to use malloc() as well as sizeof().', 'C'),
(13, 2, 2, '<p>Create a char pointer and allocate enough space for just one char. Name it  "oneChar".</p>', 'char * oneChar = malloc(sizeof(char));', 'Recall the functions malloc() and sizeof()', 'C'),
(14, 2, 2, '<p>Suppose you have a dynamic array defined as seen on line 1 in the code below. Lets say you want to create a for loop to populate the array at index content with the index. For instance, the content at index 2 will be 2, and the content at index 3 will be 3. Write the line of code in the text box that would accomplish this.</p><ol class="code"><li><code>int * dynamicArray = malloc(5 * sizeof(int));</code></li><li><code></code></li><li><code>int i;</code></li><li><code>for(i = 0; i < 5; i++)</code></li><li><code>{</code></li><li><code>//your code will go here</code></li><li><code>}</code></li></ol>', 'dynamicArray[i] = i;', 'Once you have created a dynamic array, you can access just like you would a non dynamic array.', 'C'),
(15, 2, 2, '<p>Is this the proper way to release memory that was allocated to the pointer "temp" in C?</p><ol class="code"><li><code>destroy(temp);</code></li></ol><p>Type "yes" or "no" (in lower case)</p>', 'no', 'No hint available for this question. ', 'T'),
(16, 2, 2, '<p>Suppose you have a pointer "tempPoint", that has memory allocated to it. How would you properly release this memory?</p>', 'free(tempPoint);', 'This requires one function call with the pointer as an argument.', 'C'),
(17, 2, 2, '<p>Is it okay to assign a pointer that has already been allocated memory a new address?</p><p>Type "yes" or "no" (all lower case)</p>', 'no', 'Think about what actually happens behind the scenes when you do this. ', 'T'),
(18, 2, 2, '<p>Given the following code:</p><ol class="code"><li><code>int * p1 = malloc(sizeof(int));</code></li><li><code>*p1 = 8;</code></li><li><code>int * p2 = malloc(sizeof(int));</code></li><li><code>p1 = p2;</code></li><li><code>*p2 = 20;</code></li></ol><p></p><p>Is there a problem with this code? If not, type "no". If there is, input the line number where the problem occurs.</p>', '4', 'In order to decide if there is a problem in this code, think about what is happening in memory with all instructions.', 'T'),
(19, 3, 3, '<p>You are wanting to pass a pointer to a function. The function will have only one argument. Refer to the code below:</p><ol class="code"><li><code></code></li><li><code>//You want to pass an integer pointer to the function</code></li><li><code>void myFunction(/*what goes here?*/)</code></li><li><code>{</code></li><li><code>//code for function</code></li><li><code>}</code></li><li><code></code></li></ol><p></p><p>If the argument is an integer and the name of the argument is "arg", what would you replace the "/*what goes here?*/" comment with in the code above?</p>', 'int * arg', 'You must tell the function exactly what it is recieving.', 'C'),
(20, 3, 3, '<p>You are calling a function named "foo" which recieves one char pointer as an argument. You are passing a variable named "fooVar". Write the line that would accomplish this function call.</p>', 'foo(&fooVar);', 'Remember you must pass an address', 'C'),
(21, 3, 3, '<p>Create a void function named foo that accepts two char pointers named: arg1 and arg2. Make sure arg1 comes before arg2. NOTE: assume the the opening bracket of the function will be placed on the next line, thus, do not include it in the line of code.</p>', 'void foo(char * arg1, char * arg2)', 'Declare the function the way you regularly would, but think about what needs to change with declaring the arguments.', 'C'),
(22, 3, 3, '<p>Create a void function named ''myFunction'' that accepts one float pointers named: p_float. NOTE: assume the the opening bracket of the function will be placed on the next line, thus, do not include it in the line of code.</p>', 'void myFunction(float * p_float)', 'Declare the function the way you regularly would, but think about what needs to change with declaring the arguments.', 'C'),
(23, 3, 3, '<p>You have two integers that you want to be modified directly by a function. These are named: ''int1'' and ''int2''. The function looks like this:</p><ol class="code"><li><code>void modifyIntegers(int * int1, int * int2)</code></li><li><code>{</code></li><li><code>//modifies the integers in here</code></li><li><code>}</code></li></ol><p></p><p>Correctly pass the integers to the function properly. Note, when passing the arguments, make sure int1 comes before int2.</p>', 'modifyIntegers(&int1, &int2);', 'You need to send the address of the integers to the function.', 'C'),
(24, 3, 3, '<p>You have a float variable that you want to be modified directly by a function. It is named: ''float1''. The function looks like this:</p><ol class="code"><li><code>void changeFloat(float * float1)</code></li><li><code>{</code></li><li><code>//modifies the float in here</code></li><li><code>}</code></li></ol><p></p><p>Correctly pass the float variable to the function properly. Note, when passing the arguments, make sure int1 comes before int2.</p>', 'changeFloat(&float1);', 'You need to send the address of the float to the function.', 'C'),
(25, 4, 4, '<p>Suppose you have a struct defined as such:</p><ol class="code"><li><code>typedef struct person{</code></li><li><code>int age;</code></li><li><code>char gender;</code></li><li><code>}Person;</code></li></ol><p></p><p>Now say you have a pointer to the struct named "personPtr". Using the arrow operator, set the age to 42.</p>', 'personPtr->age = 42;', 'The arrow operator is used for pointers in the same way the dot operator is used for non pointers.', 'C'),
(26, 4, 4, '<p>Suppose you have a struct defined as such:</p><ol class="code"><li><code>typedef struct person{</code></li><li><code>int age;</code></li><li><code>char gender;</code></li><li><code>}Person;</code></li></ol><p></p><p>Now say you have a pointer to the struct named "personPtr". Using the arrow operator, set the gender to ''F''.</p>', 'personPtr->gender = ''F'';', 'The arrow operator is used for pointers in the same way the dot operator is used for non pointers.', 'C'),
(27, 4, 4, '<p>Suppose you have a struct defined as such:</p><ol class="code"><li><code>typedef struct car{</code></li><li><code>int year;</code></li><li><code>int VIN;</code></li><li><code>}Car;</code></li></ol><p></p><p>Now say you have a pointer to the struct named "carPtr". Using the DOT operator, set the year to 1996. NOTE: This problem might be a little trickier for you, think about it before submitting.</p>', '(*carPtr).year = 1996;', 'Remember, if you want to use the dot operator, the pointer must be dereferenced.', 'C'),
(28, 4, 4, '<p>Suppose you have a struct defined as such:</p><ol class="code"><li><code>typedef struct car{</code></li><li><code>int year;</code></li><li><code>int VIN;</code></li><li><code>}Car;</code></li></ol><p></p><p>Now say you have a pointer to the struct named "carPtr". Using the arrow operator, set the year to 2014.</p>', 'carPtr->year = 2014;', 'When using pointers to structs, the arrow operator is used in the same way as the dot operator.', 'C'),
(29, 4, 4, '<p>Suppose you have a dynamic array defined using the struct as such:</p><ol class="code"><li><code>typedef struct car{</code></li><li><code>int year;</code></li><li><code>int VIN;</code></li><li><code>}Car;</code></li><li><code></code></li><li><code>void main()</code></li><li><code>{</code></li><li><code></code></li><li><code>Car * carArr = malloc(10 * sizeof(Car));</code></li><li><code></code></li><li><code>}</code></li></ol><p></p><p>Using the arrow operator, set the year of the 5th (index 4) car element in the array to 2003.</p>', 'carArr[4]->year = 2003;', 'Dynamic can be accessed in the same way as non dynamic arrays.', 'C'),
(30, 4, 4, '<p>Suppose you have a dynamic array defined using the struct as such:</p><ol class="code"><li><code>typedef struct person{</code></li><li><code>int age;</code></li><li><code>char gender;</code></li><li><code>}Person;</code></li><li><code></code></li><li><code>void main()</code></li><li><code>{</code></li><li><code></code></li><li><code>Person * personArr = malloc(25 * sizeof(Person));</code></li><li><code></code></li><li><code>}</code></li></ol><p></p><p>Using the arrow operator, set the age of the 1st (index 0) car element in the array to 21.</p>', 'personArr[0]->age = 21;', 'Dynamic can be accessed in the same way as non dynamic arrays.', 'C'),
(31, 4, 4, '<p>Suppose you have a struct defined using the struct as such:</p><ol class="code"><li><code>typedef struct person{</code></li><li><code>int age;</code></li><li><code>char gender;</code></li><li><code>}Person;</code></li></ol><p></p><p>Create a pointer to this struct named ''newPerson''. Allocate it room for 1 person. NOTE: use the alias defined by the typedef: (Person).</p>', 'Person * newPerson = malloc(sizeof(Person));', 'The struct is used in the same way regular types are. Use malloc() and free();', 'C'),
(32, 4, 4, '<p>Suppose you have a struct defined using the struct as such:</p><ol class="code"><li><code>typedef struct person{</code></li><li><code>int age;</code></li><li><code>char gender;</code></li><li><code>}Person;</code></li></ol><p></p><p>Create a pointer to this struct named ''newPerson''. Allocate it room for 10 people. NOTE: use the alias defined by the typedef: (Person).</p>', 'Person * newPerson = malloc(10* sizeof(Person));', 'The struct is used in the same way regular types are. Use malloc() and free(). Remember, you are making room for 10 times the size of the struct Person.', 'C');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17 ;

--
-- Dumping data for table `reg_login_attempt`
--

INSERT INTO `reg_login_attempt` (`id`, `ip`, `email`, `login_success`, `ts`) VALUES
(1, '::1', 'cameronk313@cox.net', 1, '2014-04-27 03:18:05'),
(2, '::1', 'cameronk313@cox.net', 1, '2014-04-27 04:01:59'),
(3, '::1', 'cameronk313@cox.net', 1, '2014-04-27 04:20:13'),
(4, '::1', 'cameronk313@cox.net', 1, '2014-04-29 03:05:19'),
(5, '::1', 'cameronk313@cox.net', 1, '2014-04-29 03:06:29'),
(6, '::1', 'cameronk313@cox.net', 1, '2014-04-29 05:19:03'),
(7, '::1', 'cameronk313@cox.net', 1, '2014-05-02 07:50:02'),
(8, '::1', 'cameronk313@cox.net', 1, '2014-05-04 02:13:48'),
(9, '::1', 'cameronk313@cox.net', 1, '2014-05-04 02:20:24'),
(10, '::1', 'cameronk313@cox.net', 1, '2014-05-04 04:17:06'),
(11, '::1', 'cameronk313@cox.net', 1, '2014-05-05 04:27:16'),
(12, '::1', 'student@asu.edu', 1, '2014-05-06 01:29:53'),
(13, '::1', 'instructor@asu.edu', 1, '2014-05-06 02:08:21'),
(14, '::1', 'srbarney@asu.edu', 1, '2014-05-06 04:26:18'),
(15, '::1', 'student@asu.edu', 1, '2014-05-06 04:32:17'),
(16, '::1', 'instructor@asu.edu', 1, '2014-05-06 04:32:36');

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
  `current_task` int(6) unsigned NOT NULL DEFAULT '1',
  `highest_lesson` int(6) unsigned NOT NULL DEFAULT '0',
  `task_list` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `reg_users`
--

INSERT INTO `reg_users` (`id`, `first_name`, `last_name`, `password`, `email`, `rank`, `registered`, `last_login`, `token`, `token_validity`, `reg_ip`, `user_stat`, `current_task`, `highest_lesson`, `task_list`) VALUES
(1, 'Steven', 'Barney', 'acdd77bc283941db353f3936a5a9b847', 'srbarney@asu.edu', 3, '2014-03-13 05:10:12', '2014-05-06 13:26:18', '073a6769c46d088c2a39caf0aa91ae90a8c09474', '2014-05-06 14:26:18', '0.0.0.0', 'A', 2, 0, '{"task1": {"id": 1,"type": "L","taskid": 1},"task2": {"id": 2,"type": "Q","taskid": 9},"task3": {"id": 3,"type": "Q","taskid": 10},"task4": {"id": 4,"type": "Q","taskid": 6},"task5": {"id": 5,"type": "Q","taskid": 5},"task6": {"id": 6,"type": "A","taskid": 1},"task7": {"id": 7,"type": "Q","taskid": 11},"task8": {"id": 8,"type": "Q","taskid": 10},"task9": {"id": 9,"type": "Q","taskid": 3},"task10": {"id": 10,"type": "Q","taskid": 5},"task11": {"id": 11,"type": "A","taskid": 2},"task12": {"id": 12,"type": "L","taskid": 2},"task13": {"id": 13,"type": "Q","taskid": 17},"task14": {"id": 14,"type": "Q","taskid": 15},"task15": {"id": 15,"type": "Q","taskid": 16},"task16": {"id": 16,"type": "Q","taskid": 7},"task17": {"id": 17,"type": "A","taskid": 3},"task18": {"id": 18,"type": "Q","taskid": 16},"task19": {"id": 19,"type": "Q","taskid": 15},"task20": {"id": 20,"type": "Q","taskid": 4},"task21": {"id": 21,"type": "Q","taskid": 11},"task22": {"id": 22,"type": "A","taskid": 4},"task23": {"id": 23,"type": "L","taskid": 3},"task24": {"id": 24,"type": "Q","taskid": 22},"task25": {"id": 25,"type": "Q","taskid": 23},"task26": {"id": 26,"type": "Q","taskid": 20},"task27": {"id": 27,"type": "Q","taskid": 19},"task28": {"id": 28,"type": "A","taskid": 5},"task29": {"id": 29,"type": "Q","taskid": 2},"task30": {"id": 30,"type": "Q","taskid": 3},"task31": {"id": 31,"type": "Q","taskid": 8},"task32": {"id": 32,"type": "Q","taskid": 16},"task33": {"id": 33,"type": "A","taskid": 6},"task34": {"id": 34,"type": "L","taskid": 4},"task35": {"id": 35,"type": "Q","taskid": 30},"task36": {"id": 36,"type": "Q","taskid": 28},"task37": {"id": 37,"type": "Q","taskid": 25},"task38": {"id": 38,"type": "Q","taskid": 32},"task39": {"id": 39,"type": "A","taskid": 7},"task40": {"id": 40,"type": "Q","taskid": 1},"task41": {"id": 41,"type": "Q","taskid": 4},"task42": {"id": 42,"type": "Q","taskid": 24},"task43": {"id": 43,"type": "Q","taskid": 9},"task44": {"id": 44,"type": "A","taskid": 8}}'),
(2, 'Cameron', 'Keith', 'c59b47fbcf66b482e2ed3db39ab05155', 'cameronk313@cox.net', 3, '2014-04-27 03:17:53', '2014-05-05 04:27:16', '4017bbeccc09d262c073e23b8acde77b61ce67d1', '2014-05-05 05:27:16', '0.0.0.0', 'A', 7, 0, ''),
(3, 'Lydia', 'Fox', 'cd73502828457d15655bbd7a63fb0bc8', 'student@asu.edu', 1, '2014-03-13 05:10:12', '2014-05-06 13:32:17', '1c072e1fce335cbc9c00daf05e52f4b570a395ec', '2014-05-06 14:32:17', '0.0.0.0', 'A', 12, 0, '{"task1": {"id": 1,"type": "L","taskid": 1},"task2": {"id": 2,"type": "Q","taskid": 2},"task3": {"id": 3,"type": "Q","taskid": 3},"task4": {"id": 4,"type": "Q","taskid": 4},"task5": {"id": 5,"type": "Q","taskid": 6},"task6": {"id": 6,"type": "A","taskid": 1},"task7": {"id": 7,"type": "Q","taskid": 9},"task8": {"id": 8,"type": "Q","taskid": 11},"task9": {"id": 9,"type": "Q","taskid": 5},"task10": {"id": 10,"type": "Q","taskid": 6},"task11": {"id": 11,"type": "A","taskid": 2},"task12": {"id": 12,"type": "L","taskid": 2},"task13": {"id": 13,"type": "Q","taskid": 7},"task14": {"id": 14,"type": "Q","taskid": 14},"task15": {"id": 15,"type": "Q","taskid": 18},"task16": {"id": 16,"type": "Q","taskid": 17},"task17": {"id": 17,"type": "A","taskid": 3},"task18": {"id": 18,"type": "Q","taskid": 2},"task19": {"id": 19,"type": "Q","taskid": 3},"task20": {"id": 20,"type": "Q","taskid": 18},"task21": {"id": 21,"type": "Q","taskid": 8},"task22": {"id": 22,"type": "A","taskid": 4},"task23": {"id": 23,"type": "L","taskid": 3},"task24": {"id": 24,"type": "Q","taskid": 20},"task25": {"id": 25,"type": "Q","taskid": 22},"task26": {"id": 26,"type": "Q","taskid": 23},"task27": {"id": 27,"type": "Q","taskid": 21},"task28": {"id": 28,"type": "A","taskid": 5},"task29": {"id": 29,"type": "Q","taskid": 21},"task30": {"id": 30,"type": "Q","taskid": 24},"task31": {"id": 31,"type": "Q","taskid": 8},"task32": {"id": 32,"type": "Q","taskid": 9},"task33": {"id": 33,"type": "A","taskid": 6},"task34": {"id": 34,"type": "L","taskid": 4},"task35": {"id": 35,"type": "Q","taskid": 30},"task36": {"id": 36,"type": "Q","taskid": 32},"task37": {"id": 37,"type": "Q","taskid": 25},"task38": {"id": 38,"type": "Q","taskid": 26},"task39": {"id": 39,"type": "A","taskid": 7},"task40": {"id": 40,"type": "Q","taskid": 18},"task41": {"id": 41,"type": "Q","taskid": 30},"task42": {"id": 42,"type": "Q","taskid": 22},"task43": {"id": 43,"type": "Q","taskid": 9},"task44": {"id": 44,"type": "A","taskid": 8}}'),
(4, 'Bill', 'Farmer', '175cca0310b93021a7d3cfb3e4877ab6', 'instructor@asu.edu', 2, '2014-03-13 05:10:12', '2014-05-06 13:32:36', 'dca2f3765744fe18b4aa27eec67cc8f391e0cdf4', '2014-05-06 14:32:36', '0.0.0.0', 'A', 23, 0, '{"task1": {"id": 1,"type": "L","taskid": 1},"task2": {"id": 2,"type": "Q","taskid": 4},"task3": {"id": 3,"type": "Q","taskid": 6},"task4": {"id": 4,"type": "Q","taskid": 9},"task5": {"id": 5,"type": "Q","taskid": 5},"task6": {"id": 6,"type": "A","taskid": 1},"task7": {"id": 7,"type": "Q","taskid": 3},"task8": {"id": 8,"type": "Q","taskid": 9},"task9": {"id": 9,"type": "Q","taskid": 1},"task10": {"id": 10,"type": "Q","taskid": 6},"task11": {"id": 11,"type": "A","taskid": 2},"task12": {"id": 12,"type": "L","taskid": 2},"task13": {"id": 13,"type": "Q","taskid": 17},"task14": {"id": 14,"type": "Q","taskid": 13},"task15": {"id": 15,"type": "Q","taskid": 15},"task16": {"id": 16,"type": "Q","taskid": 18},"task17": {"id": 17,"type": "A","taskid": 3},"task18": {"id": 18,"type": "Q","taskid": 4},"task19": {"id": 19,"type": "Q","taskid": 15},"task20": {"id": 20,"type": "Q","taskid": 16},"task21": {"id": 21,"type": "Q","taskid": 7},"task22": {"id": 22,"type": "A","taskid": 4},"task23": {"id": 23,"type": "L","taskid": 3},"task24": {"id": 24,"type": "Q","taskid": 22},"task25": {"id": 25,"type": "Q","taskid": 20},"task26": {"id": 26,"type": "Q","taskid": 24},"task27": {"id": 27,"type": "Q","taskid": 21},"task28": {"id": 28,"type": "A","taskid": 5},"task29": {"id": 29,"type": "Q","taskid": 11},"task30": {"id": 30,"type": "Q","taskid": 12},"task31": {"id": 31,"type": "Q","taskid": 6},"task32": {"id": 32,"type": "Q","taskid": 2},"task33": {"id": 33,"type": "A","taskid": 6},"task34": {"id": 34,"type": "L","taskid": 4},"task35": {"id": 35,"type": "Q","taskid": 26},"task36": {"id": 36,"type": "Q","taskid": 25},"task37": {"id": 37,"type": "Q","taskid": 29},"task38": {"id": 38,"type": "Q","taskid": 27},"task39": {"id": 39,"type": "A","taskid": 7},"task40": {"id": 40,"type": "Q","taskid": 29},"task41": {"id": 41,"type": "Q","taskid": 4},"task42": {"id": 42,"type": "Q","taskid": 27},"task43": {"id": 43,"type": "Q","taskid": 24},"task44": {"id": 44,"type": "A","taskid": 8}}');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17 ;

--
-- Dumping data for table `task_attempts`
--

INSERT INTO `task_attempts` (`id`, `question_id`, `student_id`, `tstamp`, `time_spent`, `hint_level_used`, `user_answer`, `correct`, `reviewed`) VALUES
(1, 1, 2, '2014-04-29 03:17:19', '00:00:00', 0, 'int * intptr;', 1, 1),
(2, 2, 2, '2014-04-29 03:17:52', '00:00:00', 0, 'numptr = &amp;num;', 1, 1),
(3, 3, 2, '2014-04-29 03:18:35', '00:00:00', 0, '*charptr = charData;', 1, 1),
(4, 4, 2, '2014-04-29 03:18:50', '00:00:00', 0, '9', 1, 1),
(5, 2, 2, '2014-05-04 04:17:47', '00:00:00', 0, 'numptr = &amp;num;', 1, 1),
(6, 1, 2, '2014-05-04 04:18:08', '00:00:00', 0, 'int * intptr;', 1, 1),
(7, 5, 2, '2014-05-04 04:18:26', '00:00:00', 0, 'char * charptr;', 1, 1),
(8, 6, 2, '2014-05-04 04:21:04', '00:00:00', 0, 'char ** doubleCharPtr;', 1, 1),
(9, 2, 3, '2014-05-06 01:32:11', '00:00:00', 0, 'numptr = &amp;num;', 1, 1),
(10, 3, 3, '2014-05-06 01:32:22', '00:00:00', 0, '*charptr = charData;', 1, 1),
(11, 4, 3, '2014-05-06 01:32:41', '00:00:00', 0, '9', 1, 1),
(12, 6, 3, '2014-05-06 01:32:49', '00:00:00', 0, 'char **doubleCharPtr;', 1, 1),
(13, 9, 3, '2014-05-06 01:36:14', '00:00:00', 0, 'double *nullPtr = NULL;', 1, 1),
(14, 11, 3, '2014-05-06 01:36:36', '00:00:00', 0, 'no', 1, 1),
(15, 5, 3, '2014-05-06 01:36:43', '00:00:00', 0, 'char *charptr;', 1, 1),
(16, 6, 3, '2014-05-06 01:36:52', '00:00:00', 0, 'char **doubleCharPtr;', 1, 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `user_profile`
--

INSERT INTO `user_profile` (`id`, `user_id`, `KC1correct`, `KC1attempts`, `KC2correct`, `KC2attempts`, `KC3correct`, `KC3attempts`, `KC4correct`, `KC4attempts`) VALUES
(1, 1, 8, 8, 8, 8, 8, 8, 8, 8),
(2, 2, 8, 8, 8, 8, 8, 8, 8, 8),
(3, 3, 13, 14, 7, 10, 3, 8, 1, 8),
(4, 4, 7, 8, 0, 0, 0, 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
