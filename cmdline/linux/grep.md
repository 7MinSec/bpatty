# grep
A tool for finding words/lines matching a pattern. Some handy examples below:

Searching a file for an *exact* match:

    grep -w "some exact string you want to find" name-of-file-you-are-searching

Searching the current dir and all sub-dirs for something, like 

    grep word-you-are-searching-for -r *

If you want to see what line a given string appears on in a file, do something like:

    grep -n brianjohnson /usr/share/wordlists/rockyou.txt