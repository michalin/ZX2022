1?R?o ?                                                      CP/M Version 3.0COPYRIGHT 1982, DIGITAL RESEARCH130982    6543210123456789ABCDEF
ERROR:  $Reading file:  $Writing file:  $Directory full$Reading file: $Writing file:  $Invalid drive.$) ? $) ? $) ? $Bad character, re-enter $?   
 $
 Disk read error:  $File cannot fit into GENCPM buffer:  $Unable to open:  $BDOS3   BIOS3   
Setting up directory hash tables:
$ Enable hashing for drive $: $Unable to allocate space for hash table.$
Setting up Allocation vector for drive $
Setting up Checksum vector for drive $
*** Bank 1 and Common are not included ***
*** in the memory segment table.       ***

$Number of memory segments $
CP/M 3 Base,size,bank ($)
$
Enter memory segment table:
$ Base,size,bank $Zero length segment not allowed.$Bank one not allowed.$Memory conflict - segment trimmed.$Memory conflict - cannot trim segment.$Memory conflict - segment trimmed.$Memory conflict - segment trimmed.$ CP/M 3 Sys   $ Memseg No. $  Bank $
Accept new memory segment table entries $Default entries are shown in (parens).
Default base is Hex, precede entry with # for decimal
$
Use GENCPM.DAT for defaults $Create a new GENCPM.DAT file $Display Load Map at Cold Boot $Number of console columns $Number of lines in console page $Backspace echoes erased character $Rubout echoes erased character $Initial default drive ($:) ? $Top page of memory $Bank switched memory $Common memory base page $Long error messages $Accept new system definition $

CP/M 3.0 System Generation
Copyright (C) 1982, Digital Research

$
 BNKBIOS3 SPR$BIOS3    SPR$BNKBIOS3 SPR$BDOS3    SPR$RESBDOS3 SPR$BNKBDOS3 SPR$
 64K TPA
Copyright (C) 1982, Digital Research

*** CP/M 3.0 SYSTEM GENERATION DONE ***$   ? ?!?Sq:?S?*?S& ?? ?!?Sp+q:?S?*?S?	? ?!?Sp+q*?S#6 :?S?8:?S?8?*?S?
? *?S#N ! 	?*?S6 ???
???!?Sr+s+q+??q?!?S6???*?SDM?:?S?zS??T:?SҚ??:?S/!?S?ҳ!] 6 !m 6 ? ?!?Sp+q *?S	6   *?S	6 *?S?? ?!?Sp+q*?S?? ?!?Sp+q*?S?? ?!?Sp+q*?S?? ? ?	????_?!?Sp+q*?S?? ? ?5	????_?!?Sp+q*?S?? ???U	??? ?_  *?S	6 ?!?Sp+q*?S?? ?!?Sp+q*?S?!? ? ʎ	????_?!?Sp+q*?S?"? ? ʮ	????_?!?Sp+q*?S?$? ?!;Ur+s+p+q+??q?:7U? ??	?*7U?*8UDM*:U??
-??	?!>Us+p+q:>U? ?
*<U?*>UM!<U??Q??!?Uq:?U? ?
>?:?U?a?/?>z!?U??/?H??<
:?U?_2?U:?U?!@Uq:@U? ?/?>!@U??/?H??^
>?? ?? ?_> ?!BUp+q(??*AU~??
Y??Í
N????lS?:mS? ¢
?*nSM?
?Y??*AUw?!CUq:CU??O !?	N??:CU?O !?	N???!EUp+q ??*DU|Oͳ
*DU}Oͳ
H???!FUq*FU&  ??QDM??
?!HUp+q!MU6 !KU60!'"IU> GU?+R??>*KUM??à!LU6 >!LU?ڠIUGU?R?u!MU6?:KU<2KUIUGU?R?+s#r?L:MU҈*KUM??!KU60*IU?!
 ͥQ?"IU:LU<2LU?C?!OUs+q(??:OU?
??#??*NU& DM???*NUMͳ
???!TUs+p+q+??p+q???:mS? ???T?*RU6 :WU<2WUO !lS	N?
2VU?ʾ:VU?,?-*RU#"RU*RU6 !UU6û:VU?#?=!UU6
û:VU?02VU:UU????>	!VU???H??u>!VU??p:VU?2VU?u!VU6?!UU:VU?Ҟ*RU^ *UU& ??Q?*VU& ?	?*RU?qû!VU6 *RU6  ? ?_??*RU6 ???T?*PUDM?*PU~? ?7(??*RUNͳ
!WU6>!WU??&*RU#"RU:WU????:?O/?H??*RU6 ?,??*RUNͳ
:WU<2WU??*RU++"RU??B*RUN*TU?͡!UU6!WU6lS??!ZUr+s+q:?O/?f> ?!\U6???#q#p![U6:?O![U??k *[U& ??Q?O	 	?YU?R?a:XU?? *[U& ??Q?O	 	~? ?? *[U& ???Q?O	 	?]U?R??H??:[U2\U *[U& ??Q?O	 	^#V?"]U?a *[U& ??Q?O	 	~? ??? *[U& ???Q?O	 	?]U?R??H??a:[U2\U *[U& ??Q?O	 	^#V?"]U:[U<2[U?w:\U?!?T6 !?S6?͕"?:#?? ??> ?S?+R?ʟ? *?S|2?Sê? *?S|2?S!?S:?O?2cS? *?S|!?S?O:?O?2gS? *?S|O:gS?2fS?S?R?m??:?O/?!?T>?O:cS?2dS? *?S|O:cS?!?T?2eS?(:cS=2dS? *?S|O:cS?2eSͯ҇͡:?O?t*U?*?S?*5U?	? |!?S?O:?O?2gS? *?S|O:gS?2fS?m2?S?G?y!?S6 :?T/҄?v?):?S2hS:cS2\S?R?E:?Oһ=?*cS&  ??QDM*?S?͓??J?*cS&  ??QDM*?S?͓:?O/??:?S2?T! "?T*?TM?T?;:?T2?S!?S6 ?t? *?S|!?S?2?T? *?S|!?S?o& )##"?TW?*gS&  ??QDM*?T?͓*?TM?T?;:?T2?S:?S2?T! "?T>?jS?+R?+s#r*?TM?T?;:?T2?S? *?S|!?T?2hS:eS2\S?S?R?m?R?E? *?T& ??QjS?.R?+s#r? *?S|!?T?2?T:?O/??d?*eS&  ??QDM*?T?͓??q?*eS&  ??QDM*?T?͓*?TM?T?;:?T!?S?w:?O?{!hS6?:fS2\S?S?R?m?R?E? *?S|2?T? *?S|!?S?o& )?*?T"?T~?*fS&  ??QDM*?T?͓*?TM?T?;:?T!?S?w:?O/ҋ:?T?2?T?*?T& ?S	??Ϳ	:eS??2eS*eS& ?!
 ͥQ!0 ?*?T& ?S	?q*eS& ?!
 ͥQ0 ?*?T& ?S	?q:?T?2?T *cS& ??Q"?S$??S?Ϳ	!5S6 #6 #6 :?O2?S:?O2?S?zSSͿ	??SSͿ	?S?_	S͏	!5S6BT?_	S͏	S??:?P҈!?P6 :?T2?O:?O/2?O?zS9SͿ	??SASͿ	;J!?S6????!bUr+s+p+q*_U6 *_U#6 *aU|??O !?	?*_U##?
w*aU|?O !?	 ?*_U	?w*aU}??O !?	 ?*_U	?w*aU}?O !?	 ?*_U	?w?!eS:dS?O `i??Q?V	? "dU *dU	:?Ow *dU	:?Ow *dU	:?Ow. *dU	:?Ow*dU	:?Ow?X *dU	? Ϳ	:?O/҉W *dU	>?*dU	w^ *dU	:?Ow?!?V"fU*fUN#F!?V	"hU*hU"fU*fU???9R???!?T6??!?T6 *fU????#R??*fU?V͏Q?!????͕"?T!?T6????T?#R??l!jU6 >!jU??S*jU& )?*?T> ?6R??I*jU& )?*?T?V͏Q"?T *?T	???9R??I!?T6 :jU<2jU?:?O/!?T??g!?T6?l!?T6 ??kU?VͿ	?V*kU"kU*kU~??> ?>???!qUs+p+q+??p+q?%?*mUDM? ??*oUDM??
 ??*qUM??
:?O?D?*?T& ?S	?*mUDMͿ	:?T?2?T*?T& ?S	DM*oU?͔:?T?2?T*?T& ?S	?*qU&  ??Q??͔:?T?2?T?*?T& ?S	?)Ϳ	:?T?2?T?!sUp+q*rU"?R?VM? ?d??,?_*rUDM???!wUr+s+p+q*vU^#V?"]S*vU##^#V?"_S *vU	^#V?"aS?*tU#DMzSͿ	?	 *tUDM?SͿ	? *]S??Q?S?.R??????_*]S+??Q}<2yU!xU6 !yU:xU??"? *xU& ??Q?V	"jSDM?_	*tUDM??:xU<2xU????*jSDM?NͿ	?V*]S"jS?!|Ur+s+q:zU? ???zSSͿ	??SSͿ	*{Un}25S*{U#~26SS͏	?VjS?#R} ?R}jS͋Q?+s#r*zU& )+?!~Us+6 :~U!}U???>?jS?+R?+s#rBK?_	S?	:}U<2}U¤Sͯ	?*{U?5SͿ	?:?O/???RwͿ	??RͿ	?!?R"U!?S"?U?5!?R"U!?S"?U?5!?R"U!?S"?U?5??*U#DMzSͿ	?	 *UDM?SͿ	*UDMʹ???n??e?_?V?_	*UDM??*?U?*?V??s#r*?U##?*?V??s#r *?U	?*?V??s#r*UDM???!?U6 ???T?#R???> ?!?U6 >!?U??r*?U& )?*?T> ?6R??h*?U& )?*?T?V͏Q"?T *?T	???9R??? *?T	????9R????H? *?T	????9R????H? *?T	????9R????H? *?T	????9R????H??h!?U6?:?U<2?U??:?U?!?U6 !?U6?!?U6 >!?U??*?U& )?*?T?V͏Q"?T*?U& )?*?T> ?6R??u *?T	????#R??!?U6  *?T	???9R??u:?U/??!?U6???:?U?O !?P	~2?S *?T	?V͏Q"?T *?T	N#F`i))"?U??:?U?AO????*?U& ?O	DM?l
?T*?U& ?O	~/?g *?T	??q#p?u:?O/ҕ!?U6 *?U& ?T)	?*?U??s#r*?U?*?T"?T?u*?U??S2?U??²*?U??S2?U:?U???? ?? ?_?u *?U& ??Q?O	 	 ?*?T	?
w *?U& ??Q?O	N `i??Q ?*?U& ??Q?O	 	N `i??Q ?*?U& ??Q?O	 	??9R?	 ?*?T	?q#p *?U& ??Q?O	 	??U?R ?*?U& ??Q?O	 	?q#p:?U<2?U:?O/!?U?Ҡ!?T6:dS<<2dS:eS<<2eS?!?U6 >!?U???*?U& ?T)	> w#6 *?U& U)	> w#6 :?U<2?U¦!  "U!  "5U!?U6 +6 >!?U??<*?U& )?*?T> ?6R??2*?U& )?*?T?V͏Q"?T *?T	?V͏Q"?T *?T	???9R???:?U?AO??:??!?U6? *?T	^#V! ͥQ*?U& ?T)	s#r*?U& )	ÙQ?+s#r *?T	???9R??2?:?U?AO??:??!?U6? *?T	 ?͜Q ??R??? *?T	 ?q#p *?T	> w#6 ?2 *?T	>͌Q?! ͥQ*?U& U)	s#r*?U& )	5ÙQ?+s#r*?U& U)	 ?*?T	?N#F?q#p:?U<2?U??:?U?F?T?:fS2?O!fS:?O?2?O!  "?O!?O6 !?U6 F?:?P2?S??
?O????*?OMͳ
,??*?OMͳ
,??*?OMͳ
??:?U/҉ ??!?U6:?O!?U?ڥ!?U6 :?U/қ:?U?=O !?P	~2?S?? *?U& ??Q?O	DM?? *?U& ??Q?O	 	N `i??Q ?*?U& ??Q?O	 	?q#p *?U& ??Q?O	 	~? ?[ ? ?_Ø *?U& ??Q?O	 	~? ?. ?_Ø *?U& ??Q?O	~2?U*?U&  ?*?U& ??Q?O	 	N ?	"?U*?U|? ???*?U?}O:?O???H??& ?D ?_!?U:?O? *?U& ???Q?O	 	?Hq!?U:?O?O `i??Q ?*?U& ??Q?O	 	?q#pØ*?U}2?U!?U6 !?U6?!?U:?U??#?Ҙ *?U& ??Q?O	~2?U *?U& ??Q?O	 	:?U?2?U *?U& ??Q?O	 	 ?*?U& ??Q?O	 	?
?!?U:?U??/+?~!?U??/?H?+?~!?U??/+?~!?U??/?H??H??? ?g ?_!?U6 Î:?U!?U??+?~!?U???H??  ?? ?_ *?U& ??Q?O	:?Uw!?U6 Î:?U!?U??+?~!?U???H?Ҏ ?? ?_!?U:?U? *?U& ???Q?O	 	?Hq!?U:?U?O `i??Q ?*?U& ??Q?O	 	?q#p!?U6 :?U<2?U?7??:?U<2?U½?T!?U6 :?O!?U??p :?U? ????????:?U=Oͳ
 *?U& ??Q?O	N??
 *?U& ??Q?O	 	N??
:?O?c ?? *?U& ??Q?O	 	Nͳ
 *?U& ??Q?O	 	~???? *?U& ???Q?O	 	~? ????H??c !?S6??T:?U<2?U­!?S6 !?U6????U?l
ê?T?#?8Sʹ2?U???? ?zS9SͿ	??SASͿ	??!?U6??U?l
?T:?U?? ?vE8S???? !?S6?+6 ?!?U6 ͍ :?U/Ҁ":}Q2?S?T???P?l
:?P2?S?T?T???O?l
?T?T:?P2?S:?O<2?O??
?O??:?O=2?O:?P2?S:?O<2?O??
?O??:?O=2?O:?P2?S??O?l
?T:?P2?S>??O?l
?T?T:?P2?S^?:?O?AO??v?lS?:mS? ??!*nSM?
?A2?U*?UM?@
/??!ß!:?U2?O?T?T:?P2?S|??O??*?O& ??Q "?S:?P2?S???O?l
?T:?O/2iS:?O?\":?P2?S???O???T:?P2?S???O?l
?T?a"!?O6 !?S6 !?U6??T???U?l
?T?? :?O2?T:?O<2?O:?O/2?O???S??S?6	!4S6 !?U6 >!?U???"*?U& ?S	6 :?U<2?U±"!?U6?>?!?U???"*?U& ?S	6$:?U<2?U??"!?T6??*?T& ?S	?:Ϳ	!?T6??zSSͿ	??SSͿ	?V?_	S?	S?	??V ?#R#??Q"?S!?U6 >!?U??t#*?U& ?T)	> w#6 :?U<2?U?Q#!  "?T:] ?A°#!?S6?#6 !?U6 >?!?U?ڭ#*?U& ?P	6 :?U<2?U#ø#!?S6 #6?:m ?D??#!?S6?!?S6 ?
     Available space in 256 byte pages:
     $TPA =$, Bank 0 =$, Other banks =$Unable to allocate Dir deblocking buffer space.$Unable to allocate Data deblocking buffer space.$Unable to allocate Data deblocking buffer space.$Drive specified has not been defined. $0FFFFH is an invalid value in the
DPH directory BCB address field.$
Setting up Blocking/Deblocking buffers:
$
The physical record size is$:
$     *** Directory buffer required  ***
     *** and allocated for drive $: ***
$               Overlay Directory buffer for drive $: $               Number of directory buffers for drive $: $Minumum number of buffers is 1. $               Number of directory buffers for drive $: $
*** Maximum number of directory buffers ***
*** for the current drive is$.     ***
*** Number of directory buffers reduced ***
*** accordingly.                        ***
$               Share buffer(s) with which drive ($:) ? $     *** Data buffer required and ***
     *** allocated for drive $:   ***
$               Overlay Data buffer for drive $: $               Number of data buffers for drive $: $Minumum number of buffers is 1. $               Number of data buffers for drive $: $               Share buffer(s) with which drive ($:) ? $               Allocate buffers outside bank zero $
Accept new buffer definitions $!?U6 >!?U?ڪ)*?U& )?*?T?V͏Q"?T> ?
R?ʣ) *?T	???9R??? *?T	????9R????H?҇) *?T	?V͏Q"?T *?T	^? ??	?*?U& ??QAP	?q#p *?T	???9R?£)???$ ?_!?U4?)!?U6 >!?U?ګ*!  "?U}2?U>!?U??**?U& ??QAP	??U? R?? 	?~? ???H??**?U& ??QAP	^#V?"?U!?U4??)*?U& ))V	?*?U??s#r*?U& ))	 	> w#6 !?U6 >!?U?ڤ**?U& ??QAP	?U? R????> ?+R?????H?ҝ**?U& ))V	 	?*?U? ??	???Q?+s#r*?U& ??QAP	 	6?!?U4?7*!?U4¯)!?U6 >!?U???**?U& ??QAP	 	6 !?U4°*!?U6 >!?U??-+ *?U& ??Q?O	 	?*?U& ?U)	?N#F?q#p *?U& ??Q?O	 	?*?U& ?U	?
w!?U4??*:?O?<+!V6?A+!V6:V=2
V!	V6 !?U6 :?U??2!  "V}2?U!?U6?*eS& ??Q?*?T?R"V:?Oږ+UV?R?*5U?R"V!?U6 >!?U???+*?U& ?U)	 ?*?U& ??Q?O	 	?N#F?q#p!?U4+!?U6 !?U6?#6?!?U6 n& ))V	 	^#V?"?U*?U& ))V	> ?6R?????:?U???H???2:?U?+,%?!?U6?F%?*?U& ))V	N#F??
d%?!?U6 >?U͘Q>?
R?????:?U???H?Ҁ,!?U??Q?+s#r!?U4?M,!?U??Q?+s#r:?U?ʺ2*?U& )?*?T?V͏Q"?T 	?V͏Q"?T 	>͌Q??Q" V *?T	 ?͜Q> ?
R???,!?U6???,!?U6  *?T	???9R??N/?HA*?U& ??QAP	 	>?w:?O??-:?U?O-!?U6 *?U& ??QAP	 	6h%?:?U?AO???%???-:?U?{O !?P	~2?S?%?:?U?AO???%?*?U& ??QAP	 	DM?l
?T*?U& ??QAP	 	~ڶ-*?U& ??QAP	 	6??-*?U& ??QAP	 	6 ?_.:?U?;O !?P	~2?S?%?:?U?AO??'&?*?U& ??QAP	 	DM
??:?U?_.!?U6 *?U& ??QAP	 	~? ?_. ?*& ?_K&?:?U?AO???&?*?U& ??QAP	 	DM
???.*?U& ??QAP	 	~ V?+RҤ.?&?* VDM??
?&?*?U& ??QAP	 	?* V??s*?U& ??QAP	 	~? ?=/:?U?[O !?P	~2?S6'?*?U& ??QAP	 	~?AO??h'?lS?:mS? ?7/*nSM?
?A2?U*?UM?@
?/??.*?UMͺD?#/??.*?U& ??QAP	 	:?Uw?T?N/*?UM?B? ?N/??2 *?T	???9R??Y2!?U6 *?U& ??QAP	>??6R?/ *?T	??q#p*?U& ??QAP	 	6 ?Y2?HA*?U& ??QAP	 	>?w:?Oږ0:?U??0:?U??/!?U6!?U6?*?U& ??QAP	 	6n'?:?U?AO???'??0:?U?0!?U6!?U6 :?U??ʓ0:?UƋO !?P	~2?S?'?:?U?AO???'?*?U& ??QAP		 	DM?l
?T*?U& ??QAP		 	~?|0*?U& ??QAP	 	6 Ó0*?U& ??QAP	 	6!?U6?>1:?U?KO !?P	~2?S?'?:?U?AO??(?*?U& ??QAP	 	DM
??*?U& ??QAP	 	>?w:?U?>1!?U6 *?U& ??QAP	 	~? ?>1 ?"( ?_C(?:?U?AO??t(?*?U& ??QAP	 	DM
????0*?U& ??QAP	 	~? ?2:?U?w1!?U6 *?U& ??QAP	 	:?Uw??1:?U?kO !?P	~2?Sw(?*?U& ??QAP	 	~?AO???(?lS?:mS? ??1*nSM?
?A2?U*?UM?@
??1Ç1*?UMͺD??1Ç1*?U& ??QAP	 	:?Uw?T*?U& ??QAP	 	:?U?w?Y2:?S!?S??H2:?U?+O !?P	~2?S?(?*?U& ??QAP	 	DM?l
?T*?UM?B? ?Y2??2!?U6 *?U? ??	V??Q?+s#r!?U4>?U͘Q>?
R?????:?U???H?Ҫ2!?U??Q?+s#r!?U4?w2!?U??Q?+s#rÍ,!?U4n& ))V	 	^#V?"?U??+!?S6 !?U6?:?U??2?HA?(??U?l
?T?R+!?U6 #6 !  "?U}2?U>!?U??Y4*?U& ??QAP	 	~? ?R4*?U& ??QAP	 ?	~? ???? 	?>?????H?Ң3:?O?f3!?U4Ë3*?U& ??QAP	???! ^ ?N#F??Q?*?U"?U*?U& ??QAP	 	:?U?2?U*?U& ??QAP	 ?	~? ???? 	?>?????H??R4:?O?4!?U4*?U& ??QAP	 	~?4*?U& ??QAP	???! ^ ?N#F??Q?*?U"?U?;4*?U& ??QAP	???! ^ ?N#F??Q?*?U"?U*?U& ??QAP	 	:?U?2?U!?U4?3*V& ?*?U& ??Q?*?U& )?	"?U:?O??8?V*?S"V*?U?*?S?*?U?	??*?T?	?*5U?	?*U?	? |O:?O?O:cS?2?SO:cS?2cS:eS?2eS:dS?2dS??|2?S!cS?2?O?V?"jS*cS& ??Q?*?S?	"?U?*?U?	"?U*]S"V*V?V	?!jS?9R?)5*V?V	6 *V#"V?5!?U6 n& ))V	 	^#V?"?U*?U& ))V	> ?6R?????:?U???H???7!?U6 >?U͘Q>?
R?????:?U???H?Ҝ5!?U??Q?+s#r!?U4?i5!?U??Q?+s#r:?U???7*?U& )?*?T?V͏Q"?T*?U& ??QAP	 	>??6*?U& ??QAP	 	~? ?N6*V6?
 *V	?*?U??s#r*?U& ??QAP	?ÙQ?+s#r *?T	?*?U??s#r:V?U͋Q?+s#r:VV͋Q?+s#rÑ6*?T"?U*?U& ??QAP	 	n& )?*?T?V͏Q"?T 	^#V?"?U*?U"?T	?*?U??s#r*?U& ??QAP	 	>??7*?U& ??QAP	 	~? ?7*V6?
 *V	?*?U??s#r*?U& ??QAP	?ÙQ?+s#r *?T	?*?U??s#r:V?U͋Q?+s#r:VV͋Q?+s#rÉ7*?T"?U*?U& ??QAP?	 	>?o& )?*?T?V͏Q"?T?!AP	 	>?? ?h7 *?T	^#V?"?U?v7 *?T	^#V?"?U*?U"?T 	?*?U??s#r!?U4>?U͘Q>?
R?????:?U???H???7!?U??Q?+s#r!?U4Í7!?U??Q?+s#ré5!?U4n& ))V	 	^#V?"?U?B5!?U6 >!?U??I8*?U& ?T)	> ?6R??B8*?U& )?*?T?V͏Q"?T 	?*?U??s#r*?U& ?T)	?ÙQ?+s#r!?U4??7!?U6 >!?U???8*?U& )?*?T?V͏Q"?T*?U& ?T)	> ?6R?ʣ8 *?T	?*?U??s#r*?U& ?T)	?ÙQ?+s#r*?U& U)	> ?6R???8 *?T	?*?U??s#r*?U& U)	?ÙQ?+s#r!?U4?N8?GA!?U6 >!?U?? 9*?U& ?U)	 ?*?U& ??Q?O	 	?N#F?q#p!?U4??8*5U?*?U?*U?	"?U> ?S?+R????S??R????H??m9*?U?*?S? |O:?O?O:cS?2?SÇ9*?U?*?S? |O:?O?O:cS?2?S!?S:cS?2cS:eS?2eS:dS?2dS:?O?2?O*?S} ?R}?S͋Q?S?.R"V> ?S?+R????S??R????H??(:? *?U|O:?O?2gS*?S}?R}?S͋Q?V"?U*gS& ??Q"?U*cS& ??Q?*?S?	"?U?m:*?U?*V? |O:?O?2gS?V*?S"?UO `i??Q?*V?	"?U*cS& ??Q?*?S?	"?U*?U?*?U"jS? *?S|O:gS?2fS*?U& )?*?U"V*?U"?U?VjS?#R"?S*]S"V*V?V	?!jS?9R??:*V?V	6 *V#"Vï:!?U6?!?U6 !?U6:?O!?U??9; *?U& ??Q?O?	 ?	?
?2?U?!?O	 	~? ???:?U!?U???H??2;:?U2?U:?U2?U!?U4??::fS2?O!fS:?O?2?O:?U????; *?U& ??Q?O	 ?	?
?O:fS???; *?U& ??Q?O?	 ?	N `i??Q??! ??9R"V?!?O	?:fS?? 	w *?U& ??Q?O	 ?	N `i??Q?*V?R??! ?q#p!?U6 n& ))V	 	^#V?"?U*?U& ))V	> ?6R?????:?U???H??y@!?U6 >?U͘Q>?
R?????:?U???H??N<!?U??Q?+s#r!?U4?<!?U??Q?+s#r:?U??^@*?U& )?*?T?V͏Q"?T*?U& ??QAP	 	>???>*?U& ??QAP	 	~? ??<*?T"?U*?U& ??QAP	 	n& )?*?T?V͏Q"?T 	^#V?"?U*?U"?T	?*?U??s#r?>*?U?*?U??s#r *?T	?*?U??s#r*?U##"?U*?U##"?U!?U6*?U& ??QAP	 	~!?U???=*?U& ??QAP	^#V?S2?U*V6? *?U& ??Q?O	?N `i??Q??! N `i??Q?! ??9R?	
 ?*V	?q#p *V	6  *?U& ??Q?O	 	?*?U& ??QAP	?? R?+s#r:V?U͋Q?+s#r *V	s#r:VV͋Q?+s#r!?U4?=:VV?+R?+s#r! > w#6 :VV͋Q?+s#r*?U& ??QAP	 	>???@*?U& ??QAP	 	~? >*?T"?U*?U& ??QAP	 	n& )?*?T?V͏Q"?T 	^#V?"?U*?U"?T	?*?U??s#r?@*?U?*?U??s#r *?T	?*?U??s#r*?U##"?U*?U##"?U!?U6*?U& ??QAP	 	~!?U????*?U& ??QAP	 	~ҏ?*?U& ??QAP	^#V?S2?U*V6? *?U& ??Q?O	?N `i??Q??! N `i??Q?! ??9R?	
 ?*V	?q#p *?U& ??Q?O	 	 ?*V	?
w *?U& ??Q?O	 	?*?U& ??QAP	?? R?+s#r???*V6?
 *V	?*?U??s#r*?U& ??QAP	?ÙQ?+s#r *V	6 :V?U͋Q?+s#r *V	s#r:VV͋Q?+s#r!?U4»>:VV?+R?+s#r! > w#6 :VV͋Q?+s#r!?U4>?U͘Q>?
R?????:?U???H??N@!?U??Q?+s#r!?U4?@!?U??Q?+s#r?[<!?U4n& ))V	 	^#V?"?U??;!?U6 >!?U?ڮ@*?U& ?U	 ?*?U& ??Q?O	 	?
w!?U4?~@!?U6 >!?U??GA*?U& )?*?T?V͏Q"?T*?U& ?T)	> ?6R??A *?T	?*?U??s#r*?U& ?T)	?ÙQ?+s#r*?U& U)	> ?6R??@A *?T	?*?U??s#r*?U& U)	?ÙQ?+s#r!?U4³@?!  "MV"OV!QV6:?O!QV???A *QV& ??Q?O	 	~? A *QV& ??Q?O	 	??Q?*MV"MVüA *QV& ??Q?O	 	??Q?*OV"OV!QV4?VA?#??#?!V??QDM??
:?O?
B$?*MVDM??
:?S!?S??
B$?*OVDM??
?T?T?!SVs+q*RV& ??QAP	^#V?"]V:?O?HB:V]V͋QV?.R?+s#r÷D!
V55:SV??fC*RV& ??QAP	 	~2TV!UV6:TV!UV??cC!V:
V??C!
V6?+4!WV6?!YV6 !VV6:?O!VV???B *VV& ??Q?O?	 ?	?
?2XV?!?O	 	~? ???:YV!XV???H???B:VV2WV:XV2YV!VV4B *WV& ??Q?O	 	? ?#R?+s#r?C!V:
V?2
V*]V??S2ZV???=C ?$ ?_> ??\C *ZV& ??Q?O	 	?]V?R?+s#r!UV4?nB÷D*RV& ??QAP	 	~2TV!UV6:TV!UV?ڷD!V:
V??"D!
V6?+4!WV6?!YV6 !VV6:?O!VV?? D *VV& ??Q?O?	 ?	?
?2XV?!?O	 	~? ???:YV!XV???H???C:VV2WV:XV2YV!VV4©C *WV& ??Q?O	 	? ?#R?+s#r?,D!V:
V?2
V*RV& ??QAP	 	~?oD]VV?R?+s#r??Q?:?O?R?lD ?M$ ?_> ?ðD*]V??S2ZV??D ?~$ ?_> ?ðD *ZV& ??Q?O	 	?]V?R?+s#r!UV4?C>??!_Vq*_V? ??	V͝Q> ?
R???D> ? ??$ ?_>??ERROR:  $ at line $Missing parameter variable$Equals (=) delimiter missing$Invalid drive ignored$Invalid character$Invalid parameter variable$! "kV?V?_	!hV6!jV6 :jVڼEͭF:jVڹE?;J2iV:iV??ʱE??GùE[E ͽEÌE?!oVr+s+q:?S2pV!?S6??D?*nVDM??D?*kVDM?:mV??E???T:pV2?S?:hV??"F!hV6 8S? ? ?F!jV6??&F!hV4?? F*hV& ?V	~2qV:qV? ???:qV?	???H??:qV?
???H??}F:qV?
?jF*kV#"kV? F*hV& ?V	~2qV?7F:qV?a?/?>z!qV??/?H?ҜF:qV?_2qV:qV?©F!jV6?:qV?!tV6 :tV/?:jV/?H???G!rV6 >!rV???F*rV& `V	6 !rV4??F?'F2sV!rV6 :rV???:sV?=????H??:sV?????H??:jV/?H??1G*rV& `V	:sVw?'F2sV!rV4??F:sV?=????:sV?????H??:jV/?H??ZG?'F2sV?1G:jV??G:sV?=???> !rV???H?ҀG!tV6???G:sV?=G?D ͽEãG:rV? ʣGE ͽE:sV?????:jV/?H???G?'F2sVãGòF??'F2wV!vV6 !lS:vV???:wV?????H??:jV/?H??H*vV& nS	:wVw!vV4~`i+w?'F2wV??G:wV?????:jV/?H??+H?'F2wV?H!{V6 #6> !vV??:J *iV& ??Q?N?	 	^#V?"xV?!?N		 	~2uV?? ??H:uV?? ʀH:gV?A2{VìH:gV?0?/?>9!gV??/?H?ҢH:gV?02{VìH:gV?A?
2{V *iV& ??Q?N	 	^ *{V& ??Q?*xV"xV*|V& lS	~???I *iV& ??Q?N	
 	:{V?O !?P	6?!?S6?!|V4!mS5> !mS??:J:uV?? ?ZI*|V& lS	~?A?/?>P??/?H??OI*|V& lS	~?A*xVw?WI3E ͽE?:J:uV?? ?zI*|V& lS	~?Y??*xVw?:J!zV6*xV6 !vV6 :mS=!vV??:J:|V!vV?O !lS	~2wV?,¼I*xV#"xV6 !zV6?3J:wV?#??I!zV6
?3J:wV?02wV:zV????>	!wV???H??J>!wV???I:wV?2wV?J!wV6?!zV:wV??+J*xV^ ?*zV& ??Q?*wV& ?	??s?3JIE ͽE!vV4I?!V6 !}V6 :}V???:V/?H?үJ!~V6 :~V?? *}V& ???Q?N	?*~V& ?	?*~V& `V	?
????H?ҘJ!~V4?\J:~V?¨J!V6?ìJ!}V4?EJ:VڹJ>??:}V???V?_	8S??8S?6	!?V6?!?V6 >!?V???L!?V6 #n&  ??Q?N		 	~2?V!?V6 :?V???:?V/?H?ҽL!?V6 >!?V??QK??L *?V& ??Q?N	?*?V& ?	?*?V& ?V	?
w!?V4?K:?V?? ?cK!?V6?êK:?V?? ?K:?V?A*?V& ?V	wêK:?V?
ҙK:?V?0*?V& ?V	wêK:?V?A?
*?V& ?V	w??L*?V& ?V	6 ??L*?V& ?V	6=??L*?V& ?V	6  *?V& ??Q?N	 ?	??! ^ *?V& ??Q?͐Q"?V:?V?? ? L??L*?V~?A*?V& ?V	wÚL:?V?? ?QL??L*?V~?CL*?V& ?V	6Y?NL*?V& ?V	6NÚL*?VN?M:?V??L??L*?V& ?V	6,*?V#"?V*?VN?M??L*?V& ?V	6,*?V#"?V*?VN?M??L*?V& ?V	6??L*?V& ?V	6
!?V4?K!?V4??J>!?V???L8S?	8S???:?V??M8S?	!?V6 >!?V??M*?V& ?V	6!?V4??L!?V6 ?M!?V4?!?Vq??L:?V??O !?	?*?V& ?V	?w??L:?V?O !?	?*?V& ?V	?w??N? *]SDM}?o?{M??*?R?? ????9N] !?N>?2?N?V?:\Sgx??3N{։?½M?:?N?¹M??*?R?? ??!?N??9N~#?o}o?/N?<??M:cS?-N<??M:dS?Ɯ??-N<??M:eS?-N<??M:fS?-N<??M:dS?-N:hSg:iS??N??'N>?:dS?-N:gSo??'N??-N:\Sg??ÏM?!  |??!??|?                                                                                                                                 PRTMSG   ?OPAGWID  ?OPAGLEN  ?OBACKSPC ?ORUBOUT  ?OBOOTDRV ?OMEMTOP  ?OBNKSWT  ?OCOMBAS  ?OLERROR  	?ONUMSEGS 
?OMEMSEG00?OHASHDRVA?OALTBNKSA
+DPNDIRRECA
;EPNDTARECA
KFPODIRDRVA
[GPODTADRVA
kHPOVLYDIRA
{IPOVLYDTAA
?JPCRDATAF ??P????? O ?????????????????      ?    ?   ?   ?   ?   ?   ?   ?   ?	   ?
   ?   ?   ?   ?   ?   ?        ??      ??      ??      ??      ??      ??      ??      ??      ??      ??      ??      ??      ??      ??      ??      ??                                                                                                                                                             i`N#F?o?g??_ ??o?g??_ ??o?g?DM!  >?)??)덑o|?gҾQ	?=¬Q?^#V?)?))?	?DM!  >)?)???Q	=??Q??_ ??o?g?^#V?)??Q?^#V?|?g}o??Q?_ {?oz?g?O {?oz?g?i`N#F?o?g?o& ?o?g?_ {?_z#?W??                                                                                                       BNKBIOS3SPR                         RESBDOS3SPR                         BNKBDOS3SPR                         CPM3    SYS                         GENCPM  DAT                                                             .   $