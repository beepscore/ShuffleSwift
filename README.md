# Purpose
Given three strings, write a method to test if shuffledString is a valid "shuffle" of string0 and string1.  
This app started as Java "ShuffleAndroid".
Then ported to Objective-C "Shuffle.app".
Now port to Swift as ShuffleSwift.app".

# References
Java ShuffleAndroid by Steve Baker Beepscore LLC  
<https://github.com/beepscore/ShuffleAndroid>

Objective C Shuffle by Steve Baker Beepscore LLC  
<https://github.com/beepscore/Shuffle>

TreeTraverser by Steve Baker Beepscore LLC  
<https://github.com/beepscore/TreeTraverser>

XorLinkedList by Steve Baker Beepscore LLC (unpublished) 

Tree Traversal  
<https://en.wikipedia.org/wiki/Tree_traversal>

Backtracking - used in depth first traverse
<https://en.wikipedia.org/wiki/Backtracking>

Backtracking by David Matuszek
<http://www.cis.upenn.edu/~matuszek/cit594-2012/Pages/backtracking.html>

# Results

## Original problem statement
We are given 3 strings: str1, str2, and str3.  

str3 is said to be a shuffle of str1 and str2 if it can be formed by interleaving 
the characters of str1 and str2 in a way that maintains the left to right ordering 
of the characters from each string.
For example, given  

    str1 == "abc"
    str2 == "def"

str3 == "dabecf" is a valid shuffle since it preserves the character ordering of the two strings.

So, given these 3 strings write a function that detects whether str3 is a valid shuffle of str1 and str2.

## Background
Can write algorithm recursively or iteratively.  
Recursive algorithm may be simpler to write, but has risk of call stack overflow.  
Iterative algorithm may have less risk of data structure stack overflow.  
Can traverse breadth first or depth first, or can even do a mix.  
Algorithmically traversing a solution tree depth first and then backing up is called "backtracking".  

## Nomenclature
    Let string0 length == m
    Let string1 length == n
    Let shuffledString length == m + n

## Assumptions - could ask problem specifier to confirm
Any argument may be null or empty string.  
In general case, string0 and string1 may have repeated letters and duplicate letters.  
For example  

    string0 == "aba"
    string1 == "abza"
    shuffledString == "abaabza"

## Possible approach - binary tree traversal
The possible solutions can be viewed as a binary tree.  
At each index in shuffledString can choose one of two-

    pop next letter from string0
    pop next letter from string1

## Possible alternative approach - delete letters from shuffledString
Delete letters in string0 from shuffledString, check if equals string1.  
Delete letters in string1 from shuffledString, check if equals string0.  
This is a potentially simple solution.  
I explored it, first implementation failed if string0 and string1 had letters in common.  

## Possible alternative approach - Iterate through shuffledString
At each letter, have two choices- can put it into string0 or string1.  
There are 2 ^ (m + n) possible deals.  
Big O complexity is exponential.  
Generate all possible candidates for string0, of any length 1 to (m + n).  
Then search candidates for one that equals the actual string0.  
This approach is very "brute force" and likely impractical.

## Tests
See tests for implemented behavior.
