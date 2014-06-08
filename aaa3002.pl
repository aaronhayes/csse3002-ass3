
%% aaa for csse3002
%% author: Paul Bailes 7 May 2014
%% assignment by Aaron Hayes 2014

%% INSERT ASSIGNMENT 3 SOLUTION CODE AT THIS POINT

%% INSERT lvl1ok AT THIS POINT

%% lvl1ok([Prior,S1,...,Sn]):- study plan with semesters S1 ... Sn and
%% prior study Prior meets level 1 requirements (12 courses at most)
lvl1ok(SP) :-
	findall(Crs, spHasLvl1(SP,Crs), Lvl1s),
	length(Lvl1s,N1s),
	N1s =< 12.


%% INSERT ANY RELATIONS REQUIRED BY lvl1ok AT THIS POINT

%%	 spHasLvl1(SP, Crs) :- if Crs is found in SP and Crs is level 1
spHasLvl1(SP,Crs) :-
       lvl1(Crs),
       courses(SP,Crss),
       member(Crs,Crss).





%% INSERT semestersok AT THIS POINT

%%	semestersok([Prior,S1,...,Sn]) :- study plan with semesters S1
%%	... Sn and prior meets timetable requirements
semestersok(SP) :-
	%% Remove prior courses and split into two study plans
	%% (semester 1 and semester 2 study plans).
	removePrior(SP, SPnew),
	splitSP(SPnew,SPs2,SPs1),

	%% Check if SPs1 contains only s1 courses
	(SPs1 == [] -> true;
	courses(SPs1,Crss1),
	spHasS1Only(Crss1)),

	%% Check is SPs2 contains only s2 courses.
	(SPs2 == [] -> true;
	courses(SPs2,Crss2),
	spHasS2Only(Crss2)), !.

%% semestersok([]) :- null input case
semestersok([]).

%% INSERT ANY RELATIONS REQUIRED BY semestersok AT THIS POINT

%%	 removePrior Remove the prior courses from a study plan
removePrior([_|SP], SP).

%%	splitSP(SP,SPs2,SPs1) :- Split Study Plan (SP) into study plans
%%	for semesters 1 (SPs1) and 2 (SPs2)
splitSP(SP, SPs2, SPs1) :-
    % First position is SPs1
    getS1(SP, SPs2, SPs1).

%%	getS1([Head|Tail], SPs2, [Head|SPs1]) :- Handle the semester 1
%%	position, then the semester 2 position
getS1([Head|Tail], SPs2, [Head|SPs1]) :-
    getS2(Tail, SPs2, SPs1).
getS1([], [], []).

%%	getS2([Head|Tail], [Head|SPs2], SPs1) :- Handle the
%	semester 2 position, then the semester 1 position
getS2([Head|Tail], [Head|SPs2], SPs1) :-
    getS1(Tail, SPs2, SPs1).
getS2([], [], []).

%%	spHasS1Only([Course|SPs1]) :- check if Study Plan for
%%	Semester 1 courses SPs1 only has semester 1 courses included
spHasS1Only([Course|SPs1]) :-
	s1(Course),
	spHasS1Only(SPs1).

%%	spHasS1Only([]) :- true.
spHasS1Only([]).

%%	spHasS2Only([Course|SPs2]) :- check if Study Plan for
%%	Semester 2 courses SPs2 only has semester 2 courses included
spHasS2Only([Course|SPs2]) :-
	s2(Course),
	spHasS2Only(SPs2).

%%	spHasS2Only([]) :-  true.
spHasS2Only([]).




%% INSERT preok AT THIS POINT

%%	preok([Prior,S1,...,Sn]) :- study plan with semesters S1 ... Sn
%%	and prior meets prerequsite requirements
preok(SP) :-
	reverse(SP, SPrev),
	spHasPre(SPrev), !.


%% INSERT ANY RELATIONS REQUIRED BY preok AT THIS POINT

%%	sublist :- check if list X is in Y
sublist([], _ ).
sublist([Head|Tail], L) :-
	member(Head, L),
	subset(Tail, L).


%%	 reverse :- reverse list L
reverse(L, Rev) :- accRev(L, [], Rev).
accRev([Head|Tail], Accu, Rev) :- accRev(Tail, [Head|Accu], Rev).
accRev([], Accu, Accu).

%%	 spHasPre([]) :- true.
spHasPre([]).

%%	spHasPre ([Load|SP]) :- Check if the Study Plan has
%%	all required prerequiste complete. Course Load (Load) = one
%%	semester
spHasPre([Load|SP]) :-
	% Check if course load has pres
	semHasPre(Load, SP),
	spHasPre(SP).


%%	semHasPre([Course|Sem], SP) :- if Course|Sem or SP is empty
semHasPre([], _).
semHasPre(_, []).

%%	semHasPre([Course|Sem], SP) :- Check if each indivdual course in
%%	the semester has prequireisite requirements complete.
semHasPre([Course|Sem], SP) :-
	findall(Crs,courseHasPre(Course, SP, Crs), Pres),
	length(Pres, NPres),
	NPres >= 1,
	semHasPre(Sem, SP).


%%	courseHasPre(Course, SP, Crs) :- find pres of each course,
%%	return courses that have been complete inacordance to
%%	prequiresite requirements.
courseHasPre(Course, SP, Crs) :-
	pre(Course, Crs),
	courses(SP, Crss),
	sublist(Crs, Crss).


%% MODIFY binftech AT THIS POINT
%% binftech([Prior,S1,...,Sn]):- study plan with semesters S1 ... Sn and prior study Prior qualifies for BInfTech
binftech(SP) :- partAok(SP), partBok(SP), partBCok(SP), lvl3ok(SP), lvl1ok(SP), semestersok(SP), preok(SP), !.

%% partAok([Prior,S1,...,Sn]):- study plan with semesters S1 ... Sn and prior study Prior meets Part A requirements
partAok(SP) :-
	courses(SP,Crss),
	member(comp3506,Crss),
	member(csse1001,Crss),
	member(csse2002,Crss),
	member(csse3002,Crss),
	member(infs1200,Crss),
	member(deco1400,Crss),
	member(deco2800,Crss),
	member(deco3800,Crss),
	member(deco3801,Crss),
	member(math1061,Crss).

%% partBok([Prior,S1,...,Sn]):- study plan with semesters S1 ... Sn and prior study Prior meets Part B requirements
partBok(SP) :-
	findall(Crs, spHasPartB(SP,Crs), PartBs),
	length(PartBs, NBs),
	NBs >= 6.

%%	spHasPartB(SP,Crs) :- if Crs is found in SP and Crs is in part B
spHasPartB(SP,Crs) :-
	partB(Crs),
	courses(SP,Crss),
	member(Crs, Crss).

%% partBCok([Prior,S1,...,Sn]):- study plan with semesters S1 ... Sn and prior study Prior meets combined Part B & C requirements
partBCok(SP) :-
	findall(Crs, spHasPartBC(SP, Crs), PartBCs),
	length(PartBCs, NBCs),
	NBCs =:= 14.

%%	spHasPartBC(SP,Crs) :- if Crs is found in SP and Crs is in part B or part C
spHasPartBC(SP,Crs) :-
	partBC(Crs),
	courses(SP,Crss),
	member(Crs, Crss).

%% lvl3ok([Prior,S1,...,Sn]):- study plan with semesters S1 ... Sn and prior study Prior meets level 3 requirements
lvl3ok(SP) :-
	findall(Crs, spHasLvl3AB(SP, Crs), Lvl3s),
	length(Lvl3s,N3s),
	N3s >= 6.

%%	spHasLvl3AB(SP,Crs) :- if Crs is found in SP and Crs is level 3 and Crs is in part A or part B
spHasLvl3AB(SP,Crs) :-
	lvl3(Crs),
	partAB(Crs),
	courses(SP,Crss),
	member(Crs, Crss).

%% courses(SP,Cs) :- Cs is list of courses in SP
courses([Sm],Sm).
courses([Sm|SP],Cs) :- courses(SP,CSP), append(Sm,CSP,Cs).

%% properties of each course

%% part A

partA(comp3506).
lvl3(comp3506).
s1(comp3506).
pre(comp3506,[csse2002]).

partA(csse1001).
lvl1(csse1001).
s1(csse1001).
pre(csse1001,[]).

partA(csse2002).
s1(csse2002).
pre(csse2002,[csse1001]).

partA(csse3002).
s2(csse3002).
lvl3(csse3002).
pre(csse3002,[deco2800]).

partA(deco1400).
lvl1(deco1400).
s2(deco1400).
pre(deco1400,[]).

partA(deco2800).
s2(deco2800).
pre(deco2800,[csse2002]).

partA(deco3800).
s1(deco3800).
lvl3(deco3800).
pre(deco3800,[deco2800]).
pre(deco3800,[csse1001,infs2200]).

partA(deco3801).
s2(deco3801).
lvl3(deco3801).
pre(deco3801, [deco3800]).

partA(infs1200).
s2(infs1200).
lvl1(infs1200).
pre(infs1200,[math1061]).

partA(math1061).
s1(math1061).
lvl1(math1061).
pre(math1061,[]).

%% part B

partB(comp3301).
s1(comp3301).
lvl3(comp3301).
pre(comp3301,[csse2310]).

partB(comp3702).
s2(comp3702).
lvl3(comp3702).
pre(comp3702,[comp3506]).

partB(csse2010).
s1(csse2010).
lvl2(csse2010).
pre(csse2010,[csse1001,math1061]).


partB(csse2310).
s2(csse2310).
lvl2(csse2310).
pre(csse2310,[csse2010]).

partB(deco2500).
s2(deco2500).
lvl2(deco2500).
pre(deco2500,[csse1001,deco1400]).

partB(infs2200).
s1(infs2200).
lvl2(infs2200).
pre(infs2200,[infs1200]).

partB(infs3200).
s1(infs3200).
lvl3(infs3200).
pre(infs3200,[infs2200]).

partB(infs3204).
s2(infs3204).
lvl3(infs3204).
pre(infs3204,[infs1200,csse2002]).

partB(math1051).
s1(math1051).
lvl1(math1051).
pre(math1051,[]).

partB(math1052).
s2(math1052).
lvl1(math1052).
pre(math1052,[math1051]).

%% part C (free electives)

%% level 1 electives
partC(eltv1001).
s1(eltv1001).
lvl1(eltv1001).
pre(eltv1001,[]).
partC(eltv1002).
s1(eltv1002).
lvl1(eltv1002).
pre(eltv1002,[]).
partC(eltv1003).
s1(eltv1003).
lvl1(eltv1003).
pre(eltv1003,[]).
partC(eltv1004).
s1(eltv1004).
lvl1(eltv1004).
pre(eltv1004,[]).
partC(eltv1005).
s2(eltv1005).
lvl1(eltv1005).
pre(eltv1005,[]).
partC(eltv1006).
s2(eltv1006).
lvl1(eltv1006).
pre(eltv1006,[]).
partC(eltv1007).
s2(eltv1007).
lvl1(eltv1007).
pre(eltv1007,[]).
partC(eltv1008).
s2(eltv1008).
lvl1(eltv1008).
pre(eltv1008,[]).

%% level 2 electives
partC(eltv2001).
s1(eltv2001).
lvl2(eltv2001).
pre(eltv2001,[]).
partC(eltv2002).
s1(eltv2002).
lvl2(eltv2002).
pre(eltv2002,[]).
partC(eltv2003).
s1(eltv2003).
lvl2(eltv2003).
pre(eltv2003,[]).
partC(eltv2004).
s1(eltv2004).
lvl2(eltv2004).
pre(eltv2004,[]).
partC(eltv2005).
s2(eltv2005).
lvl2(eltv2005).
pre(eltv2005,[]).
partC(eltv2006).
s2(eltv2006).
lvl2(eltv2006).
pre(eltv2006,[]).
partC(eltv2007).
s2(eltv2007).
lvl2(eltv2007).
pre(eltv2007,[]).
partC(eltv2008).
s2(eltv2008).
lvl2(eltv2008).
pre(eltv2008,[]).

%% level 3 electives
partC(eltv3001).
s1(eltv3001).
lvl3(eltv3001).
pre(eltv3001,[]).
partC(eltv3002).
s1(eltv3002).
lvl3(eltv3002).
pre(eltv3002,[]).
partC(eltv3003).
s1(eltv3003).
lvl3(eltv3003).
pre(eltv3003,[]).
partC(eltv3004).
s1(eltv3004).
lvl3(eltv3004).
pre(eltv3004,[]).
partC(eltv3005).
s2(eltv3005).
lvl3(eltv3005).
pre(eltv3005,[]).
partC(eltv3006).
s2(eltv3006).
lvl3(eltv3006).
pre(eltv3006,[]).
partC(eltv3007).
s2(eltv3007).
lvl3(eltv3007).
pre(eltv3007,[]).
partC(eltv3008).
s2(eltv3008).
lvl3(eltv3008).
pre(eltv3008,[]).

%% Crs belongs to part A or part B
partAB(Crs) :- partA(Crs); partB(Crs).

%% Crs belongs to part B or part C
partBC(Crs) :- partB(Crs); partC(Crs).


%% examples of test harnesses - students should develop their own as required; and markers will use their own for grading
%% testX(SP),binftech(SP) :- test that the plan defined n testX is valid BInfTech

%% not valid binftech
test1([[],[csse1001,math1061],[deco1400,infs1200],[csse2002],[deco2800],[comp3506,deco3800],[csse3002,deco3801]]).

%% valid binftech
test2([
	[],
	[csse1001,math1061,eltv1001,math1051],
	[deco1400,infs1200,eltv1005,math1052],
	[csse2002,csse2010,eltv2001,eltv2002],
	[deco2800,csse2310,eltv2005,eltv2006],
	[comp3506,deco3800,eltv3001,eltv3002],
	[csse3002,deco3801,comp3702,infs3204]
]).

%% valid binftech
testa([
	[
	csse1001,math1061,eltv1001,math1051,deco1400,infs1200,eltv1005,math1052,
	csse2002,csse2010,eltv2001,eltv2002,deco2800,csse2310,eltv2005,eltv2006,
	comp3506,deco3800,eltv3001,eltv3002
	],
	[],[csse3002,deco3801,comp3702,infs3204]
]).

