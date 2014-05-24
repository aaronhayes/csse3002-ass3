% CSSE3002 ASSIGNMENT 3 UNIT TESTS
:- consult(aaa3002).

:- begin_tests(lvl1ok).

% lvl1ok() TEST
% 12 lvl 1 test :- TRUE
test(a) :- lvl1ok([[csse1001,deco1400,infs1200,math1061,math1051,math1052,eltv1001,eltv1002,eltv1003,eltv1004,eltv1005,eltv1006],[],[],[],[],[],[]]).

% 1 fake course test :- TRUE
test(b) :- lvl1ok([[csse1001,deco1400,infs1200,math1061,math1051,math1052,eltv1001,eltv1002,eltv1003,eltv1004,eltv1005,eltv1006,fake1001],[],[],[],[],[],[]]).

% 13 lvl 1 test :- FALSE
test(c, [fail]) :- lvl1ok([[csse1001,deco1400,infs1200,math1061,math1051,math1052,eltv1001,eltv1002,eltv1003,eltv1004,eltv1005,eltv1006,eltv1007],[],[],[],[],[],[]]).

% 13 lvl 1 semester 10000 :- FALSE
test(d, [fail]) :- lvl1ok([[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[csse1001,deco1400,infs1200,math1061,math1051,math1052,eltv1001,eltv1002,eltv1003,eltv1004,eltv1005,eltv1006,eltv1007],[],[],[],[],[],[]]).

% 12 lvl 1 semester 1000 :- TRUE
test(e) :- lvl1ok([[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[deco1400,infs1200,math1061,math1051,math1052,eltv1001,eltv1002,eltv1003,eltv1004,eltv1005,eltv1006,eltv1007],[],[],[],[],[],[]]).

% 0 courses :- TRUE
test(f) :- lvl1ok([[],[],[],[],[],[]]).

% 13 lvl2 courses :- TRUE
test(g) :- lvl1ok([[eltv2001,eltv2002,eltv2003,eltv2004,eltv2005,eltv2006,eltv2007,eltv2008,csse2002,csse3002,deco2800,csse2010,deco2500],[],[],[]]).

% 12 lvl1 courses, heaps of others :- TRUE
test(h) :- lvl1ok([[csse1001,deco1400,infs1200,math1061,math1051,math1052,eltv1001,eltv1002,eltv1003,eltv1004,eltv1005,eltv1006],[eltv2001,eltv2002,eltv2003,eltv2004,eltv2005,eltv2006,eltv2007,eltv2008,csse2002,csse3002,deco2800,csse2010,deco2500],[],[],[]]).

% 13 lvl1 courses over semesters :- FALSE
test(i, [fail]) :- lvl1ok([[csse1001],[deco1400],[infs1200],[math1061],[math1051],[math1052],[eltv1001],[eltv1002],[eltv1003],[eltv1004],[eltv1005],[eltv1006],[eltv1007]]).

% 12 lvl1 courses over semesters :- TRUE
test(j) :- lvl1ok([[csse1001],[deco1400],[infs1200],[math1061],[math1051],[math1052],[eltv1001],[eltv1002],[eltv1003],[eltv1004],[eltv1005],[eltv1006]]).

:- end_tests(lvl1ok).


:- begin_tests(semestersok).

% semestersok() TEST
% prior test :- TRUE
test(prior) :- semestersok([[csse1001,csse2002,deco1400,infs1200],[],[],[],[]]).

% reverse test :- FALSE
test(reverse, [fail]) :- semestersok([[],[deco1400],[csse1001],[infs1200],[csse2002]]).

% okay test :- TRUE
test(okay) :- semestersok([[],[math1061],[deco1400],[csse1001],[infs1200],[csse2002]]).

% s1 (eltv1005) wrong :- FALSE
test(s1, [fail]) :- semestersok([[], [math1061, csse1001, csse2002], [deco1400, infs1200, eltv3008], [eltv1001, eltv1005], [eltv3007,eltv3006]]).

% s2 (eltv3001) wrong :- FALSE
test(s2, [fail]) :- semestersok([[], [math1061, csse1001, csse2002], [deco1400, infs1200, eltv3001], [eltv1001, eltv1003], [eltv3007,eltv3006]]).

% 0 courses :- TRUE
test(zero) :- semestersok([[],[],[]]).

test(empty) :- semestersok([[]]).
test(emptys1) :- semestersok([[],[]]).

:- end_tests(semestersok).


% preok() TEST

:- begin_tests(preok).

% zero test :- TRUE
test(zero_pre) :- preok([[],[],[]]).

% simple fail :- FALSE
test(simple_pre, [fail]) :- preok([[], [comp3506]]).

% simple(2) fail :- FALSE
test(simple_pre2, [fail]) :- preok([[], [csse2002], [comp3506]]).

% simple pass :- TRUE
test(simple_pre3) :- preok([[csse1001], [csse2002]]).

% simple(2) pass :- TRUE
test(simple_pre4) :- preok([[csse1001], [csse2002], [comp3506]]).
test(simple_pre5) :- preok([[], [csse1001], [], [csse2002], [comp3506]]).

% swapped :- FALSE
test(swap, [fail]) :- preok([[], [csse1001], [comp3506], [csse2002], []]).

% afterwards :- FALSE
test(after, [fail]) :- preok([[],[csse2002], [], [csse1001]]).

% same semesters :- FALSE
test(same_sem1, [fail]) :- preok([[], [csse2002, csse1001]]).
test(same_sem2, [fail]) :- preok([[], [csse1001, csse2002]]).

% deco3800 :- TRUE
test(deco3800a) :- preok([[deco2800], [deco3800]]).
test(deco3800b) :- preok([[csse1001, infs2200], [deco3800]]).
test(deco3800c) :- preok([[deco2800,csse1001,infs2200], [deco3800]]).
test(deco3800d) :- preok([[csse1001,deco2800,math1061],[infs1200],[],[infs2200],[deco3800]]).

% deco300 :- FALSE
test(deco3800e, [fail]) :- preok([[csse1001], [deco3800]]).
test(deco3800f, [fail]) :- preok([[infs2200], [deco3800], [csse1001]]).
test(deco3800g, [fail]) :- preok([[infs2200], [deco3800], [deco2800]]).

% csse2010 :- TRUE
test(csse2010a) :- preok([[csse1001,math1061],[csse2010]]).
test(csse2010b) :- preok([[], [csse1001], [], [math1061], [], [csse2010]]).

% csse2010 :- FALSE
test(csse2010c, [fail]) :- preok([[], [csse2010]]).
test(csse2010d, [fail]) :- preok([[csse1001], [csse2010]]).
test(csse2010e, [fail]) :- preok([[math1061], [], [], [csse2010]]).
test(csse2010f, [fail]) :- preok([[], [csse1001], [], [csse2010], [], [math1061]]).
test(csse2010g, [fail]) :- preok([[], [csse2010], [], [], [], [math1061, csse1001]]).

:- end_tests(preok).


:-begin_tests(binftech).
%% not valid binftech
test(nonvalid, [fail]) :- binftech([[],[csse1001,math1061],[deco1400,infs1200],[csse2002],[deco2800],[comp3506,deco3800],[csse3002,deco3801]]).

%% valid binftech
test(valid) :- binftech([
	[],
	[csse1001,math1061,eltv1001,math1051],
	[deco1400,infs1200,eltv1005,math1052],
	[csse2002,csse2010,eltv2001,eltv2002],
	[deco2800,csse2310,eltv2005,eltv2006],
	[comp3506,deco3800,eltv3001,eltv3002],
	[csse3002,deco3801,comp3702,infs3204]
]).

%% valid binftech
test(valida) :- binftech([
	[
	csse1001,math1061,eltv1001,math1051,deco1400,infs1200,eltv1005,math1052,
	csse2002,csse2010,eltv2001,eltv2002,deco2800,csse2310,eltv2005,eltv2006,
	comp3506,deco3800,eltv3001,eltv3002
	],
	[],[csse3002,deco3801,comp3702,infs3204]
]).



:-end_tests(binftech).

:- run_tests.