1 OPEN "I",1,"CLRSCRN"
2 INPUT#1,A:M9$=CHR$(A)
3 CLOSE 1
10  REM (C) 1981 TAYLORWARE
30  GOSUB 50090: PRINT TAB(6);: GOSUB 50100: PRINT "<<A TEST OF SEXUAL ATTITUDES>>": GOSUB 50110: PRINT
40  PRINT "INTRODUCTION:  THIS TEST GIVES THE TAKER": PRINT "AN OPPORTUNITY TO TAKE A GOOD LOOK AT"
50  PRINT "HIS OR HER THINKING.  THESE DAYS, MANY": PRINT "PEOPLE CLAIM TO BE SEXUALLY LIBERATED."
60  PRINT "BUT ARE THEY?  WHAT DOES IT MEAN TO BE": PRINT "SEXUALLY LIBERAL?  DO PEOPLE GENERALLY"
70  PRINT "FIND THAT THEY ARE EITHER ALL LIBERAL OR": PRINT "ALL CONSERVATIVE?  GENERALLY, THE"
80  PRINT "ANSWER TO THAT QUESTION IS, 'NO.'  FOR": PRINT "EXAMPLE, MANY PEOPLE WHO ARE AGAINST"
90  PRINT "ABORTION MAY OTHERWISE BE VERY LIBERAL.": PRINT "IT IS IMPORTANT, THEREFORE, TO IDENTIFY"
100  PRINT "YOUR PATTERN OF ATTITUDES.  WHERE DO YOU": PRINT "WANT CHANGE, AND WHERE ARE YOU MOST"
110  PRINT "AGAINST CHANGE?": PRINT : PRINT TAB(6); "SECONDLY, THIS TEST SHOULD HELP"
120  PRINT "BREACH SOME COMMUNICATION GAPS.  WHEN": PRINT "YOU UNDERSTAND YOUR POSITION, YOU SHOULD"
130  PRINT "BE ABLE TO SEE WHERE YOU ARE MOST LIKELY": PRINT: GOSUB 50100: PRINT "<< PRESS RETURN TO CONTINUE >>";: INPUT A$: GOSUB 50090: PRINT TAB(6); "<<A TEST OF SEXUAL ATTITUDES>>": GOSUB 50110: PRINT
140  PRINT "TO BOTH SHARE AND CLASH WITH OTHERS.": PRINT : PRINT TAB(6); "FINALLY, SELECTING AN ANSWER FORCES"
150  PRINT "YOU TO DECIDE HOW YOU REALLY FEEL.  DO": PRINT "YOU REALLY FEEL THAT PREMARITAL"
160  PRINT "EXPERIENCE IS ACCEPTABLE?  IF SO, IS IT": PRINT "EQUALLY ACCEPTABLE FOR MEN AND WOMEN?"
170  PRINT "HOW OPEN SHOULD BE SEXUAL DISCUSSION": PRINT "BETWEEN THE SEXES?  THIS TEST WILL"
180  PRINT "REFLECT YOUR ATTITUDES ON THESE AND": PRINT "MANY OTHER VITAL QUESTIONS."
190  PRINT : PRINT "DIRECTIONS:  THIS TEST IS DESIGNED TO": PRINT "MEASURE EACH INDIVIDUALS'S SEXUAL"
200  PRINT "ATTITUDES ALONG A CONTINUUM FROM VERY": PRINT "CONSERVATIVE TO VERY LIBERAL.  THE TEST"
210  PRINT "IS SIMPLE TO TAKE.  IT CONSISTS OF 40": PRINT "QUESTIONS.  FOR EACH QUESTION, YOU NEED"
220  PRINT "MERELY SELECT THE ANSWER THAT IS MOST": PRINT "REPRESENTATIVE OF YOUR ATTITUDE."
230  PRINT: GOSUB 50100: PRINT "<< PRESS RETURN TO CONTINUE >>";: INPUT A$: GOSUB 50090: PRINT TAB(6); "<<A TEST OF SEXUAL ATTITUDES>>": GOSUB 50110: PRINT
240  PRINT "YOUR SCORE WILL BE DISPLAYED AT THE END": PRINT "OF THE TEST.": PRINT: GOSUB 50100: PRINT "<< PRESS RETURN TO CONTINUE >>";: INPUT A$: GOSUB 50090: PRINT TAB(6); "<<A TEST OF SEXUAL ATTITUDES>>": GOSUB 50110: PRINT
250 A = 0:B = 0:C = 0:D = 0
260  PRINT "1.  IF A MAN HAD A CHOICE, HE WOULD": PRINT TAB(5); "PREFER TO MARRY A WOMAN WHO:": PRINT : PRINT TAB(5); "A.  HAD NO PREMARITAL EXPERIENCE.": PRINT : PRINT TAB(5); "B.  HAD SLIGHT SEXUAL EXPERIENCE."
270  PRINT : PRINT TAB(5); "C.  HAD A FEW PREMARITAL AFFAIRS.": PRINT : PRINT TAB(5); "D.  HAD A NUMBER OF PREMARITAL": PRINT TAB(9); "AFFAIRS.": GOSUB 50000
280  PRINT "2.  I BELIEVE THAT PREMARITAL EXPERIENCE": PRINT TAB(5); "FOR WOMEN IS:": PRINT : PRINT TAB(5); "A.  VERY DAMAGING.": PRINT : PRINT TAB(5); "B.  DOES NOT PRODUCE ANY CHANGE.": PRINT : PRINT TAB(5);
290  PRINT "C.  IS HELPFUL FOR FUTURE MARITAL": PRINT TAB(9); "SUCCESS.": PRINT : PRINT TAB(5); "D.  IS HIGHLY DESIRABLE.": GOSUB 50000
300  PRINT "3.  KNOWLEDGE ABOUT SEX IS:": PRINT : PRINT TAB(5); "A.  NOT DESIRABLE FOR WOMEN.": PRINT : PRINT TAB(5); "B.  NOT IMPORTANT FOR WOMEN.": PRINT : PRINT TAB(5);
310  PRINT "C.  VERY IMPORTANT FOR WOMEN.": PRINT : PRINT TAB(5); "D.  EXCEEDINGLY IMPORTANT FOR WOMEN.": GOSUB 50000
320  PRINT "4.  A WOMAN'S SEX DRIVE GENERALLY IS:": PRINT : PRINT TAB(5); "A.  NOT AS STRONG AS A MAN'S.": PRINT : PRINT TAB(5); "B.  UNKNOWN AS FAR AS INTENSITY.": PRINT : PRINT TAB(5);
330  PRINT "C.  NEARLY AS STRONG AS A MAN'S.": PRINT : PRINT TAB(5); "D.  AT LEAST AS STRONG AS A MAN'S.": GOSUB 50000
340  PRINT "5.  KNOWLEDGE ABOUT SEX GENERALLY IS:": PRINT : PRINT TAB(5); "A.  NOT NECESSARY FOR A MAN.": PRINT : PRINT TAB(5); "B.  SLIGHTLY DESIRABLE FOR A MAN.": PRINT : PRINT TAB(5);
350  PRINT "C.  IMPORTANT FOR A MAN.": PRINT : PRINT TAB(5); "D.  EXTREMELY IMPORTANT FOR A MAN.": GOSUB 50000
360  PRINT "6.  A WOMAN SHOULD:": PRINT : PRINT TAB(5); "A.  TELL HER FIANCE ABOUT HER SEXUAL": PRINT TAB(9); "EXPERIENCES.": PRINT : PRINT TAB(5); "B.  ADMIT ONLY WHAT SHE HAS TO.": PRINT : PRINT TAB(5);
370  PRINT "C.  NOT TELL HER FIANCE ANYTHING": PRINT TAB(9); "OF HER PAST.": PRINT : PRINT TAB(5); "D.  SHARE WITH HER FIANCE HER": PRINT TAB(9); "EXPERIENCES.": GOSUB 50000
380  PRINT "7.  A MAN SHOULD:": PRINT : PRINT TAB(5); "A.  TELL HIS FIANCE ABOUT HIS SEXUAL": PRINT TAB(9); "EXPERIENCES.": PRINT : PRINT TAB(5); "B.  ADMIT ONLY WHAT HE HAS TO.": PRINT : PRINT TAB(5);
390  PRINT "C.  NOT DISCUSS HIS PREMARITAL": PRINT TAB(9); "EXPERIENCE.": PRINT : PRINT TAB(5); "D.  SHARE WITH HIS FIANCE HIS": PRINT TAB(9); "EXPERIENCES.": GOSUB 50000
400  PRINT "8.  CURIOSITY ABOUT SEX:": PRINT : PRINT TAB(5); "A.  EXISTS PREDOMINANTLY FOR MEN.": PRINT : PRINT TAB(5); "B.  EXISTS SLIGHTLY MORE FOR MEN.": PRINT : PRINT TAB(5);
410  PRINT "C.  IS ABOUT EQUAL FOR BOTH MEN AND": PRINT TAB(9); "WOMEN.": PRINT : PRINT TAB(5); "D.  IS EQUAL FOR BOTH SEXES.": GOSUB 50000
420  PRINT "9.  DIRECT REQUESTS FOR SEXUAL ACTIVITY:": PRINT : PRINT TAB(5); "A.  ARE THE OPTION FOR MEN.": PRINT : PRINT TAB(5); "B.  SELDOM ARE ALLOWABLE FOR WOMEN.": PRINT : PRINT TAB(5);
430  PRINT "C.  ARE EQUALLY ACCEPTABLE FOR BOTH": PRINT TAB(9); "SEXES.": PRINT : PRINT TAB(5); "D.  ARE NEEDED EQUALLY FROM BOTH": PRINT TAB(9); "SEXES.": GOSUB 50000
440  PRINT "10.  SEXUAL DESIRES:": PRINT : PRINT TAB(6); "A.  SHOULD NOT BE DISCUSSED": PRINT TAB(10); "OPENLY.": PRINT : PRINT TAB(6); "B.  CAN BE ALLUDED TO.": PRINT : PRINT TAB(6);
450  PRINT "C.  SHOULD BE DISCUSSED OPENLY.": PRINT : PRINT TAB(6); "D.  MUST BE DISCUSSED OPENLY.": GOSUB 50000
460  PRINT "11.  SEXUAL ACTIVITY IS ACCEPTABLE:": PRINT : PRINT TAB(6); "A.  ONLY DURING MARRIED LIFE.": PRINT : PRINT TAB(6); "B.  WHEN THERE IS A FORMAL": PRINT TAB(10); "COMMITMENT.": PRINT : PRINT TAB(6);
470  PRINT "C.  WHEN TWO PEOPLE SHARE A MUTUAL": PRINT TAB(10); "DESIRE.": PRINT : PRINT TAB(6); "D.  WHEN TWO RESPONSIBLE PEOPLE": PRINT TAB(10); "FEEL THEY WANT IT.": GOSUB 50000
480  PRINT "12.  SEX FOR FUN:": PRINT : PRINT TAB(6); "A.  IS NOT ACCEPTABLE.": PRINT : PRINT TAB(6); "B.  SELDOM IS ALLOWABLE.": PRINT : PRINT TAB(6);
490  PRINT "C.  IS ONLY EXCUSABLE IN MARRIAGE.": PRINT : PRINT TAB(6); "D.  SHOULD BE A PART OF ALL SEXUAL": PRINT TAB(10); "RELATIONSHIPS.": GOSUB 50000
500  PRINT "13.  SEXUAL EXPERIMENTATION AND": PRINT TAB(6); "EXPLORATION:": PRINT : PRINT TAB(6); "A.  IS NOT EVER ACCEPTABLE.": PRINT : PRINT TAB(6); "B.  RARELY IS ACCEPTABLE.": PRINT : PRINT TAB(6);
510  PRINT "C.  IS HEALTHY.": PRINT : PRINT TAB(6); "D.  SHOULD BE A PART OF ALL SEXUAL": PRINT TAB(10); "RELATIONSHIPS.": GOSUB 50000
520  PRINT "14.  MEN ARE ATTRACTED BY NUDITY AND": PRINT TAB(6); "THAT IS:": PRINT : PRINT TAB(6); "A.  UNHEALTHY.": PRINT : PRINT TAB(6); "B.  NORMAL BUT VERY DANGEROUS.": PRINT : PRINT TAB(6);
530  PRINT "C.  NORMAL.": PRINT : PRINT TAB(6); "D.  DESIRABLE.": GOSUB 50000
540  PRINT "15.  WOMEN'S ATTRACTION TO NUDE MALES:": PRINT : PRINT TAB(6); "A.  IS MOST RARE.": PRINT : PRINT TAB(6); "B.  HAPPENS AND MAY NOT BE HARMFUL.": PRINT : PRINT TAB(6);
550  PRINT "C.  IS VERY DESIRABLE AND HEALTHY.": PRINT : PRINT TAB(6); "D.  IS AS HEALTHY AND DESIRABLE AS": PRINT TAB(10); "A MAN'S ATTRACTION TO NUDE": PRINT TAB(10); "WOMEN.": GOSUB 50000
560  PRINT "16.  MOVIES WHICH ARE X-RATED:": PRINT : PRINT TAB(6); "A.  SHOULD BE BANNED FOR ALL.": PRINT : PRINT TAB(6); "B.  SHOULD BE MORE CAREFULLY": PRINT TAB(10); "CENSORED.": PRINT : PRINT TAB(6);
570  PRINT "C.  ARE BAD BUT NEED NOT BE": PRINT TAB(10); "RESTRICTED.": PRINT : PRINT TAB(6); "D.  MAY BE STIMULATING TO A HUSBAND": PRINT TAB(10); "AND WIFE.": GOSUB 50000
580  PRINT "17.  SEDUCTIVE CLOTHES:": PRINT : PRINT TAB(6); "A.  SHOULD BE AVOIDED BY WOMEN.": PRINT : PRINT TAB(6); "B.  ARE DANGEROUS.": PRINT : PRINT TAB(6);
590  PRINT "C.  MAY BE ACCEPTABLE UNDER A FEW": PRINT TAB(10); "CIRCUMSTANCES.": PRINT : PRINT TAB(6); "D.  HELP BOTH MEN AND WOMEN FEEL": PRINT TAB(10); "GOOD.": GOSUB 50000
600  PRINT "18.  IF A PERSON FEELS SEXUALLY": PRINT TAB(6); "UNFULFILLED HE OR SHE SHOULD:": PRINT : PRINT TAB(6); "A.  NOT MENTION IT TO ANYONE.": PRINT : PRINT TAB(6); "B.  READ BOOKS TO FIND OUT WHAT IS": PRINT TAB(10); "WRONG.": PRINT : PRINT TAB(6);
610  PRINT "C.  DISCUSS IT OPENLY WITH HIS OR": PRINT TAB(10); "HER LOVER.": PRINT : PRINT TAB(6); "D.  DISCUSS IT AND EXPLORE TO FIND": PRINT TAB(10); "THAT WHICH FEELS FULFILLING.": GOSUB 50000
620  PRINT "19.  'PLAYGIRL' MAGAZINE:": PRINT : PRINT TAB(6); "A.  SHOULD NOT BE SOLD.": PRINT : PRINT TAB(6); "B.  IS DANGEROUS.": PRINT : PRINT TAB(6);
630  PRINT "C.  MAY NOT, AFTER ALL, BE TOO": PRINT TAB(10); "DAMAGING.": PRINT : PRINT TAB(6); "D.  IS GOOD BECAUSE IT ALLOWS": PRINT TAB(10); "WOMEN THE SAME OPPORTUNITIES": PRINT TAB(10); "THAT MEN HAVE.": GOSUB 50000
640  PRINT "20.  MALE MASTURBATION:": PRINT : PRINT TAB(6); "A.  IS VERY DESTRUCTIVE.": PRINT : PRINT TAB(6); "B.  NEVER SHOULD BE DISCUSSED.": PRINT : PRINT TAB(6);
650  PRINT "C.  IS ACCCEPTABLE.": PRINT : PRINT TAB(6); "D.  MAY SERVE AS A HEALTHY OUTLET.": GOSUB 50000
660  PRINT "21.  FEMALE MASTURBATION:": PRINT : PRINT TAB(6); "A.  IS VERY DISRUPTIVE FOR": PRINT TAB(10); "EMOTIONAL GROWTH.": PRINT : PRINT TAB(6); "B.  SHOULD NOT BE DISCUSSED.": PRINT : PRINT TAB(6);
670  PRINT "C.  MAY NOT BE HARMFUL.": PRINT : PRINT TAB(6); "D.  MAY PROVIDE USEFUL BENEFITS.": GOSUB 50000
680  PRINT "22.  MALE ADULTERY:": PRINT : PRINT TAB(6); "A.  IS A TERRIBLE THING.": PRINT : PRINT TAB(6); "B.  SELDOM HAPPENS BUT IS OVERLY": PRINT TAB(10); "TALKED ABOUT.": PRINT : PRINT TAB(6);
690  PRINT "C.  HAPPENS FREQUENTLY.": PRINT : PRINT TAB(6); "D.  MAY TAKE PLACE FOR A WIDE": PRINT TAB(10); "VARIETY OF REASONS.": GOSUB 50000
700  PRINT "23.  FEMALE ADULTERY:": PRINT : PRINT TAB(6); "A.  IS A TERRIBLE THING.": PRINT : PRINT TAB(6); "B.  SELDOM HAPPENS BUT IS MORE": PRINT TAB(10); "OFTEN TALKED ABOUT.": PRINT : PRINT TAB(6);
710  PRINT "C.  PROBABLY HAPPENS MORE AND MORE": PRINT TAB(10); "FREQUENTLY.": PRINT : PRINT TAB(6); "D.  MAY WELL INVOLVE NUMEROUS": PRINT TAB(10); "DIFFERENT MOTIVES.": GOSUB 50000
720  PRINT "24.  IF ADULTERY TAKES PLACE:": PRINT : PRINT TAB(6); "A.  A CRIME HAS BEEN COMMITTED.": PRINT : PRINT TAB(6); "B.  A MARRIAGE IS OVER.": PRINT : PRINT TAB(6);
730  PRINT "C.  IT WILL PUT A STRAIN ON ANY": PRINT TAB(10); "MARRIAGE.": PRINT : PRINT TAB(6); "D.  THE COUPLE SHOULD TRY TO": PRINT TAB(10); "UNDERSTAND WHAT CAUSED THE": PRINT TAB(10); "AFFAIR.": GOSUB 50000
740  PRINT "25.  ORAL SEX:": PRINT : PRINT TAB(6); "A.  IS NOT A DESIRABLE ACT.": PRINT : PRINT TAB(6); "B.  NEVER SHOULD BE DISCUSSED IN": PRINT TAB(10); "MIXED COMPANY.": PRINT : PRINT TAB(6);
750  PRINT "C.  IS NO BIG DEAL.": PRINT : PRINT TAB(6); "D.  IS FINE IF BOTH PARTNERS ENJOY": PRINT TAB(10); "IT.": GOSUB 50000
760  PRINT "26.  SEX GUIDES:": PRINT : PRINT TAB(6); "A.  NEVER SHOULD BE WRITTEN BECAUSE": PRINT TAB(10); "SEX ALREADY IS OVERLY": PRINT TAB(10); "EMPHASIZED.": PRINT : PRINT TAB(6); "B.  ARE NOT REALLY NEEDED.": PRINT : PRINT TAB(6);
770  PRINT "C.  ARE FINE FOR A FEW WHO ARE": PRINT TAB(10); "TROUBLED.": PRINT : PRINT TAB(6); "D.  MAY HELP MANY COUPLES PUT": PRINT TAB(10); "VARIETY INTO THEIR LOVE-MAKING.": GOSUB 50000
780  PRINT "27.  PETTING AND FOREPLAY:": PRINT : PRINT TAB(6); "A.  ARE NECESSARY SOMETIMES BEFORE": PRINT TAB(10); "INTERCOURSE.": PRINT : PRINT TAB(6); "B.  ARE HELPFUL FOR INTERCOURSE.": PRINT : PRINT TAB(6);
790  PRINT "C.  ARE FUN.": PRINT : PRINT TAB(6); "D.  SHOULD NOT HAVE A CLEAR ENDING": PRINT TAB(10); "SINCE ALL OF LOVE-MAKING SHOULD": PRINT TAB(10); "BE PLAY.": GOSUB 50000
800  PRINT "28.  ABORTION:": PRINT : PRINT TAB(6); "A.  SHOULD BE ILLEGAL.": PRINT : PRINT TAB(6); "B.  NEVER IS MORALLY ACCEPTABLE.": PRINT : PRINT TAB(6);
810  PRINT "C.  IS ACCEPTABLE ONLY IN RAPE": PRINT TAB(10); "CASES.": PRINT : PRINT TAB(6); "D.  SHOULD BE A PERSONAL ISSUE.": GOSUB 50000
820  PRINT "29.  A WOMAN'S SEXUAL FANTASIES:": PRINT : PRINT TAB(6); "A.  SHOULD NOT BE DISCUSSED OPENLY.": PRINT : PRINT TAB(6); "B.  ARE GREATLY OVERPLAYED.": PRINT : PRINT TAB(6);
830  PRINT "C.  ARE NOT WELL UNDERSTOOD.": PRINT : PRINT TAB(6); "D.  MAY WELL BE AS ACTIVE AS A": PRINT TAB(10); "MAN'S.": GOSUB 50000
840  PRINT "30.  A WOMAN'S SEXUAL FANTASIES:": PRINT : PRINT TAB(6); "A.  SHOULD NOT BE A PART OF HER": PRINT TAB(10); "LOVE-MAKING.": PRINT : PRINT TAB(6); "B.  MAY NOT HARM HER LOVE-MAKING.": PRINT : PRINT TAB(6);
850  PRINT "C.  MAY WELL ENHANCE HER": PRINT TAB(10); "LOVE-MAKING.": PRINT : PRINT TAB(6); "D.  PROBABLY ARE ESSENTIAL TO THE": PRINT TAB(10); "MOST PASSIONATE OF LOVE-MAKING.": GOSUB 50000
860  PRINT "31.  THE SEXUAL LIBERATION OF WOMEN IS:": PRINT : PRINT TAB(6); "A.  DAMAGING TO THE RELATIONSHIPS": PRINT TAB(10); "BETWEEN THE SEXES.": PRINT : PRINT TAB(6); "B.  PROBABLY INEVITABLE.": PRINT : PRINT TAB(6);
870  PRINT "C.  DESIRABLE.": PRINT : PRINT TAB(6); "D.  ONLY FAIR SINCE SOCIETY HAS": PRINT TAB(10); "LONG ALLOWED GREATER FREEDOM": PRINT TAB(10); "TO MEN.": GOSUB 50000
880  PRINT "32.  THE SO-CALLED 'DOUBLE CODE OF": PRINT TAB(6); "MORALITY' OR DIFFERENT RULES FOR": PRINT TAB(6); "MEN AND WOMEN, IS:"
881  PRINT : PRINT TAB(6); "A. A VERY WORKABLE MORAL CODE.": PRINT : PRINT TAB(6); "B.  ACCEPTABLE THOUGH IT HAS SOME": PRINT TAB(10); "WEAKNESSES"
890  PRINT : PRINT TAB(6); "C.  IS NOT FAIR TO WOMEN.": PRINT : PRINT TAB(6); "D.  IS NOT FAIR TO EITHER SEX SINCE": PRINT TAB(10); "IT MAKES IT DIFFICULT FOR MEN": PRINT TAB(10); "AND WOMEN TO RELATE.": GOSUB 50000
900  PRINT "33.  SEXUAL GADGETS ARE:": PRINT : PRINT TAB(6); "A.  SOMETHING THAT NEVER SHOULD BE": PRINT TAB(10); "MANUFACTURED.": PRINT : PRINT TAB(6); "B.  DISGUSTING.": PRINT : PRINT TAB(6);
910  PRINT "C.  NOT NEEDED.": PRINT : PRINT TAB(6); "D.  FINE FOR THOSE WHO ENJOY THEM.": GOSUB 50000
920  PRINT "34.  BIRTH CONTROL INFORMATION:": PRINT : PRINT TAB(6); "A.  IS IMMORAL.": PRINT : PRINT TAB(6); "B.  SHOULD NOT BE PUBLICIZED.": PRINT : PRINT TAB(6);
930  PRINT "C.  SOMETIMES IS BENEFICIAL.": PRINT : PRINT TAB(6); "D.  SHOULD BE PROVIDED FOR EVERYONE": PRINT TAB(10); "WHO WISHES IT.": GOSUB 50000
940  PRINT "35.  SEXUAL BEHAVIOR SHOULD:": PRINT : PRINT TAB(6); "A.  BE GOVERNED BY SOCIETY.": PRINT : PRINT TAB(6); "B.  BE CONTROLLED BY RELIGIOUS": PRINT TAB(10); "LEADERS.": PRINT : PRINT TAB(6);
950  PRINT "C.  HAVE ESTABLISHED GUIDELINES SET": PRINT TAB(10); "BY OUR RELIGIOUS GROUPS.": PRINT : PRINT TAB(6); "D.  BE AN INDIVIDUAL CHOICE AS LONG": PRINT TAB(10); "AS CONSENTING ADULTS ARE": PRINT TAB(10); "INVOLVED.": GOSUB 50000
960  PRINT "36.  IF YOU MEET SOMEONE WITH A SEXUAL": PRINT TAB(6); "CODE VERY DIFFERENT FROM YOUR OWN": PRINT TAB(6); "YOU SHOULD:": PRINT : PRINT TAB(6); "A.  AVOID THAT PERSON.": PRINT : PRINT TAB(6); "B.  TOLERATE THAT PERSON.": PRINT : PRINT TAB(6);
970  PRINT "C.  NOT BE DISTURBED BY IT.": PRINT : PRINT TAB(6); "D.  ACCEPT THIS BEHAVIOR AS RIGHT": PRINT TAB(10); "FOR HIM OR HER.": GOSUB 50000
980  PRINT "37.  IF YOU LEARNED THAT YOUR SPOUSE HAD": PRINT TAB(6); "A HOMOSEXUAL EXPERIENCE IN HIS OR": PRINT TAB(6);
981  PRINT "HER YOUTH YOU WOULD:": PRINT : PRINT TAB(6); "A.  NATURALLY BE TERRIBLY HURT.": PRINT : PRINT TAB(6); "B.  TRY TO BE UNDERSTANDING.": PRINT : PRINT TAB(6);
990  PRINT "C.  NOT BE CONCERNED.": PRINT : PRINT TAB(6); "D.  RECOGNIZE IT AS NOT AT ALL": PRINT TAB(10); "ABNORMAL.": GOSUB 50000
1000  PRINT "38.  IF SOMEONE MAKES A PASS AT YOUR": PRINT TAB(6); "MATE, YOU WOULD:": PRINT : PRINT TAB(6); "A.  HIT THE OFFENDING PERSON.": PRINT : PRINT TAB(6); "B.  BE ANGRY AT YOUR MATE.": PRINT : PRINT TAB(6);
1010  PRINT "C.  LET THE SITUATION DETERMINE": PRINT TAB(10); "YOUR REACTION.": PRINT : PRINT TAB(6); "D.  HAVE FAITH THAT YOUR MATE CAN": PRINT TAB(10); "HANDLE IT.": GOSUB 50000
1020  PRINT "39.  FRANK, OPEN SEXUAL TALK:": PRINT : PRINT TAB(6); "A.  IS TOO PREVALENT IN OUR": PRINT TAB(10); "SOCIETY.": PRINT : PRINT TAB(6); "B.  SHOULD NOT TAKE PLACE IN MIXED": PRINT TAB(10); "COMPANY.": PRINT : PRINT TAB(6);
1030  PRINT "C.  IS NOT ALWAYS DESTRUCTIVE.": PRINT : PRINT TAB(6); "D.  SHOULD TAKE PLACE BETWEEN THE": PRINT TAB(10); "SEXES.": GOSUB 50000
1040  PRINT "40.  A SEXUAL CLIMAX IS:": PRINT : PRINT TAB(6); "A.  VITAL FOR A MAN'S WELL BEING.": PRINT : PRINT TAB(6); "B.  MORE LIKELY FOR MEN THAN FOR": PRINT TAB(10); "WOMEN.": PRINT : PRINT TAB(6);
1050  PRINT "C.  DESIRABLE FOR BOTH SEXES.": PRINT : PRINT TAB(6); "D.  EQUALLY NEEDED FOR BOTH MEN AND": PRINT TAB(10); "WOMEN IN A MEANINGFUL": PRINT TAB(10); "RELATIONSHIP.": GOSUB 50000
1060  PRINT TAB(6); "THIS TEST COUNTED THE NUMBER OF": PRINT "TIMES YOU HAVE SELECTED EACH ANSWER."
1070  PRINT "ANSWER 'A' INDICATES THE MOST ULTRA-": PRINT "CONSERVATIVE INDIVIDUAL, THE ONE WHO"
1080  PRINT "USUALLY DOES NOT WANT CHANGE OR OPEN": PRINT "DISCUSSION.  ANSWER 'B' SHOWS A LESS"
1090  PRINT "CONSERVATIVE PERSON, ONE WHO MAY AT": PRINT "TIMES ALLOW OPENNESS.  ANSWER 'C'"
1100  PRINT "INDIVIDUALS ARE MODERATELY LIBERAL AND": PRINT "THEY ALLOW GREATER CHANGE AND OPENNESS."
1110  PRINT "THE ANSWER 'D' PERSON IS THE ULTRA-": PRINT "LIBERAL WHO WANTS CHANGES AND FREEDOM.": PRINT : PRINT TAB(6);
1120  GOSUB 50100: PRINT "YOUR SCORES ARE:": GOSUB 50110: PRINT 
1130  PRINT "ULTRA CONSERVATIVE........"A
1140  PRINT "MODERATE CONSERVATIVE....."B
1150  PRINT "MODERATE LIBERAL.........."C
1160  PRINT "ULTRA LIBERAL............."D
1170  PRINT: GOSUB 50100: PRINT "<< PRESS RETURN TO CONTINUE >>";: INPUT A$: GOSUB 50090: PRINT TAB(6); "<<A TEST OF SEXUAL ATTITUDES>>": GOSUB 50110: PRINT
1180  PRINT "CONCLUSION:  NOW THAT YOU SEE WHERE YOU": PRINT "STAND ON SOME IMPORTANT ISSUES, MAYBE"
1190  PRINT "YOU CAN UNDERSTAND HOW YOU INTERACT WITH": PRINT "OTHERS.  DO YOU CLASH, FOR EXAMPLE, WITH"
1200  PRINT "PEOPLE WHO RESIST CHANGE OR WITH PEOPLE": PRINT "WHO WANT CHANGE?  SHOULD YOU SHARE YOUR"
1210  PRINT "TEST ANSWERS WITH YOUR LOVER?  MIGHT": PRINT "THIS NOT OPEN UP SOME IMPORTANT AREAS OF"
1220  PRINT "COMMUNICATION?  IF PROPERLY USED, THIS": PRINT "TEST MAY HELP YOU EXAMINE SOME OF YOUR"
1230  PRINT "ATTITUDES, PREJUDICES AND BIASES.  IT": PRINT "ALSO MAY HELP BRING YOU CLOSER TO A"
1240  PRINT "LOVED ONE.  AT LEAST, YOU MAY BOTH BE": PRINT "ABLE TO GAIN RESPECT FOR THE VIEWS OF"
1250  PRINT "ONE ANOTHER.  WHO KNOWS, AT SOME POINT": PRINT "YOU MAY EVEN BE ABLE TO EXAMINE THE": PRINT "REASONS BEHIND YOUR ATTITUDES."
1260 PRINT:PRINT "<< PRESS RETURN FOR MENU >>";:INPUT A$:GOTO 50120
50000 PRINT:PRINT "    PLEASE ENTER YOUR ANSWER: ";:INPUT AN$
50010  IF AN$ <  > "A" AND AN$ <  > "B" AND AN$ <  > "C" AND AN$ <  > "D" THEN  PRINT  CHR$ (7): GOTO 50000
50020  IF AN$ = "A" THEN A = A + 1
50030  IF AN$ = "B" THEN B = B + 1
50040  IF AN$ = "C" THEN C = C + 1
50050  IF AN$ = "D" THEN D = D + 1
50060  GOSUB 50090: GOSUB 50100: PRINT TAB(6); "<<A TEST OF SEXUAL ATTITUDES>>": GOSUB 50110: PRINT
50070  RETURN 
50080  REM  ***THE FOLLOWING ROUTINES MUST BE CHANGED WHEN CONVERTING TO OTHER MACHINES***
50090  PRINT M9$: RETURN 
50100   RETURN 
50110   RETURN 
50120 RUN "STARTUP"
HANGED WHEN CONVERTING TO OTHER MACHINES***