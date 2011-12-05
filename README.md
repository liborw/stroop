# stroop: Stroop effect test

Matlab implementation of [Stroop test][stroop-link]. A test subject is shown word (red, green, blue and magenta) printed in colour. The word can, but not always do, match the colour in which is printed. A test subject is asked to press key according to colour of the type ```r``` for red, ```g``` for green, ```b``` for blue and ```m``` for magenta as fast as possible.

The experiment should demonstrate that the response time for stimuli where the word does not match the colour of the type is longer than for stimuli where the two match.

## Usage

In Matlab:

  	$ help stroop
  	STROOP The Stroop test

 	SYNOPSIS
   		trials = stroop();
   		trials = stroop(num);
   		trials = stroop(num, lang);

 	INPUT
   		num     Number of trials {100}
   		lang    Language of experiment {en} | cs
   	
   	$ stroop(100, 'cs')


## Acknowledgement
This project is part of [x33ksy: Cognitive Systems][x33ksy-link] course at [Faculty of Electrical Engineering][fee-link] of [Czech Technical University][ctu-link].

[fee-link]: http://www.fel.cvut.cz/
[ctu-link]: http://www.cvut.cz/en?set_language=en
[stroop-link]: http://en.wikipedia.org/wiki/Stroop_effect
[x33ksy-link]: http://www.fel.cvut.cz/education/bk.en/predmety/11/53/p11532804.html
