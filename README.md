ParseyParser
===========

Changes this:

```
1 Need  _ VERB  VB  _ 0 ROOT  _ _  
2 examples  _ NOUN  NNS _ 1 dobj  _ _  
3 to  _ PRT TO  _ 4 aux _ _
4 implement _ VERB  VB  _ 1 xcomp _ _
5 sophos  _ NOUN  NNS _ 6 nn  _ _  
6 antivirus _ NOUN  NN  _ 4 dobj  _ _  
7 api _ . . _ 1 punct _ _
```

into this:

```
need (VERB) -> examples (NOUN)
need (VERB) -> implement (VERB) -> to (PRT)
need (VERB) -> implement (VERB) -> antivirus (NOUN) -> sophos (NOUN)
need (VERB) -> api (.)
```

(example from [a now-deleted Stack Overflow question title](http://stackoverflow.com/q/37661408/1849664)) 
