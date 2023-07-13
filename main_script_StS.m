clear all; clc; close all ; 

%% 2nd trial

% 00maayan 
file=readmatrix('maayan_all.xlsx');
x_wo = file(:,1); X_wo_1 = x_wo(92:118); X_wo_2 = x_wo(286:312); X_wo_3 = x_wo(429:455);
x_w = file(:,2); X_w_1 = x_w(129:155); X_w_2 = x_w(310:336);  X_w_3 = x_w(473:499);
y_wo = file(:,3); Y_wo_1 = y_wo(95:121); Y_wo_2 = y_wo(287:313); Y_wo_3 = y_wo(429:455); 
y_w = file(:,4); Y_w_1 = y_w(117:143); Y_w_2 = y_w(299:325); Y_w_3 = y_w(459:485);
[T_maayan] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'A');

% 00shani 
file=readmatrix('shani_all.xlsx');
x_wo = file(:,1); X_wo_1 = x_wo(121:151); X_wo_2 = x_wo(267:297); X_wo_3 = x_wo(402:432);
x_w = file(:,2); X_w_1 = x_w(81:111); X_w_2 = x_w(474:504); X_w_3 = x_w(662:692); %X_w_2 = x_w(277:303);
y_wo = file(:,3); Y_wo_1 = y_wo(81:111); Y_wo_2 = y_wo(225:255); Y_wo_3 = y_wo(364:394);
y_w = file(:,4); Y_w_1 = y_w(77:107); Y_w_2 = y_w(468:498); Y_w_3 = y_w(655:685); %Y_w_2 = y_w(265:291);
[T_shani] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'B');

% 00shahar 
% file=readmatrix('shahar_all.xlsx');
% x_wo = file(:,1); X_wo_1 = x_wo(100:141); X_wo_2 = x_wo(318:354); X_wo_3 = x_wo(558:597);
% x_w = file(:,2); X_w_1 = x_w(361:396); X_w_2 = x_w(638:674);  X_w_3 = x_w(833:864); %X_w_2 = x_w(277:303);
% y_wo = file(:,3); Y_wo_1 = y_wo(90:131); Y_wo_2 = y_wo(309:346); Y_wo_3 = y_wo(553:592);
% y_w = file(:,4); Y_w_1 = y_w(341:384); Y_w_2 = y_w(623:659); Y_w_3 = y_w(816:853); %Y_w_2 = y_w(265:291);
% time = file (:,5);
[T_shahar] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'C');
%% 1st trial

% 03edna 
file=readmatrix('03edna_all.xlsx');
x_wo = file(:,2); X_wo_1 = x_wo(87:117); X_wo_2 = x_wo(289:319); X_wo_3 = x_wo(462:492);
x_w = file(:,3); X_w_1 = x_w(295:325); X_w_2 = x_w(518:548); X_w_3 = x_w(735:765);
y_wo = file(:,4); Y_wo_1 = y_wo(81:111); Y_wo_2 = y_wo(283:313); Y_wo_3 = y_wo(459:489);
y_w = file(:,5); Y_w_1 = y_w(282:312); Y_w_2 = y_w(506:536); Y_w_3 = y_w(721:751);
[T_3] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'3');

% 04carmela
file=readmatrix('04carmela_all.xlsx');
x_wo = file(:,2); X_wo_1 = x_wo(96:126); X_wo_2 = x_wo(265:295); X_wo_3 = x_wo(436:466);
x_w = file(:,3); X_w_1 = x_w(112:142); X_w_2 = x_w(285:315); X_w_3 = x_w(480:510);
y_wo = file(:,4); Y_wo_1 = y_wo(35:65); Y_wo_2 = y_wo(204:234); Y_wo_3 = y_wo(373:403);
y_w = file(:,5); Y_w_1 = y_w(34:64); Y_w_2 = y_w(207:237); Y_w_3 = y_w(401:431);
[T_4] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'4');

% 11avi
file=readmatrix('11avi_all.xlsx');
x_wo = file(:,2); X_wo_1 = x_wo(90:120); X_wo_2 = x_wo(265:295); X_wo_3 = x_wo(441:471);
x_w = file(:,3); X_w_1 = x_w(280:310); X_w_2 = x_w(456:486); X_w_3 = x_w(642:672);
y_wo = file(:,4); Y_wo_1 = y_wo(260:290); Y_wo_2 = y_wo(434:464); Y_wo_3 = y_wo(632:662);
y_w = file(:,5); Y_w_1 = y_w(278:308); Y_w_2 = y_w(453:483); Y_w_3 = y_w(639:669);
[T_11] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'11');

% 12eli (there is 4 rep. I took 1, 3, 4)
file=readmatrix('12eli_all.xlsx');
x_wo = file(:,2); X_wo_1 = x_wo(83:113); X_wo_2 = x_wo(426:456); X_wo_3 = x_wo(595:625);
x_w = file(:,3); X_w_1 = x_w(231:261); X_w_2 = x_w(575:605); X_w_3 = x_w(736:766);
y_wo = file(:,4); Y_wo_1 = y_wo(82:112); Y_wo_2 = y_wo(425:455); Y_wo_3 = y_wo(594:624);
y_w = file(:,5); Y_w_1 = y_w(233:263); Y_w_2 = y_w(578:608); Y_w_3 = y_w(739:769);
[T_12] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'12');

% 13yafa
file=readmatrix('13yafa_all.xlsx');
x_wo = file(:,2); X_wo_1 = x_wo(73:103); X_wo_2 = x_wo(229:259); X_wo_3 = x_wo(401:431);
x_w = file(:,3); X_w_1 = x_w(241:271); X_w_2 = x_w(406:436); X_w_3 = x_w(585:615);
y_wo = file(:,4); Y_wo_1 = y_wo(69:99); Y_wo_2 = y_wo(226:256); Y_wo_3 = y_wo(397:427);
y_w = file(:,5); Y_w_1 = y_w(238:268); Y_w_2 = y_w(404:434); Y_w_3 = y_w(582:612);
[T_13] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'13');

% 16yakova (with sns 4 rep. I TOOK  2 3 4)
file=readmatrix('16yakova_all.xlsx');
x_wo = file(:,2); X_wo_1 = x_wo(76:106); X_wo_2 = x_wo(253:283); X_wo_3 = x_wo(410:440);
x_w = file(:,3); X_w_1 = x_w(436:466); X_w_2 = x_w(606:636); X_w_3 = x_w(789:819);
y_wo = file(:,4); Y_wo_1 = y_wo(73:103); Y_wo_2 = y_wo(251:281); Y_wo_3 = y_wo(407:437);
y_w = file(:,5); Y_w_1 = y_w(439:469); Y_w_2 = y_w(609:639); Y_w_3 = y_w(792:822);
[T_16] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'16');

% 24yakovt
file=readmatrix('24yakovt_all_1.xlsx');
x_wo = file(:,2); X_wo_1 = x_wo(78:108); X_wo_2 = x_wo(255:285); X_wo_3 = x_wo(445:475);
x_w = file(:,3); X_w_1 = x_w(72:102); X_w_2 = x_w(238:268); X_w_3 = x_w(419:449);
y_wo = file(:,4); Y_wo_1 = y_wo(110:140); Y_wo_2 = y_wo(287:317); Y_wo_3 = y_wo(475:505);
y_w = file(:,5); Y_w_1 = y_w(71:101); Y_w_2 = y_w(237:267); Y_w_3 = y_w(418:448);
[T_24] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'24');

% 26itzik 
file=readmatrix('26itzik_all.xlsx');
x_wo = file(:,2); X_wo_1 = x_wo(68:98); X_wo_2 = x_wo(231:261); X_wo_3 = x_wo(414:444);
x_w = file(:,3); X_w_1 = x_w(305:335); X_w_2 = x_w(467:497); X_w_3 = x_w(644:674);
y_wo = file(:,4); Y_wo_1 = y_wo(110:140);Y_wo_2 = y_wo(271:301); Y_wo_3 = y_wo(454:484);
y_w = file(:,5); Y_w_1 = y_w(286:316); Y_w_2 = y_w(447:477); Y_w_3 = y_w(623:653);
[T_26] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,'26');
