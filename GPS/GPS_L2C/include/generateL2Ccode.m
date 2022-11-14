function L2Ccode = generateL2Ccode(PRN,flag,settings)
% generateL2Ccode.m generates one of the GPS satellite L2C codes.
%
% L2Ccode = generateL2Ccode(PRN,flag,settings)
%
%   Inputs:
%       PRN         - PRN number of the sequence.
%       flag        - 'CM' or 'cm' for L2c CMcode; 'CL' or 'cl' for L2c CLcode; 
%       settings    - receiver settings
%
%   Outputs:
%       L2Ccode      - a vector containing the desired L2C code sequence 
%                   (chips).  

%--------------------------------------------------------------------------
%                         CU Multi-GNSS SDR  
% (C) Written by Yafeng Li, Nagaraj C. Shivaramaiah and Dennis M. Akos
%--------------------------------------------------------------------------

%This program is free software; you can redistribute it and/or
%modify it under the terms of the GNU General Public License
%as published by the Free Software Foundation; either version 2
%of the License, or (at your option) any later version.
%
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with this program; if not, write to the Free Software
%Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
%USA.
%------------------------------------------------------------------------------------

%CVS record:
%$Id: generateL2Ccode.m,v 1.1.2.5 2016/08/23 22:00:00 dpl Exp $

%--- Initialize related parameters --------------------------------------------------
RegPos = [4 7 9 12 15 17 19 22 23 24 25];

%--- Initial-state table from pages 9--11 and pages 62--63 of IS-GPS-200H ---
% PRNs 64-158 do not exist for L2 CM-/L2 CL-code.
l2cm_init = [...
   ... PRNs 1-37 for GPS satellites
   742417664,   756014035,   002747144,   066265724,...
   601403471,   703232733,   124510070,   617316361,...
   047541621,   733031046,   713512145,   024437606,...
   021264003,   230655351,   001314400,   222021506,...
   540264026,   205521705,   064022144,   120161274,...
   044023533,   724744327,   045743577,   741201660,...
   700274134,   010247261,   713433445,   737324162,...
   311627434,   710452007,   722462133,   050172213,...
   500653703,   755077436,   136717361,   756675453,...
   435506112,...
   ...PRNs 38-63 are required per this Table if a manufacturer chooses to 
   ...include these PRNs in their receiver design
   771353753,   226107701,   022025110,   402466344,...
   752566114,   702011164,   041216771,   047457275,...
   266333164,   713167356,   060546335,   355173035,...
   617201036,   157465571,   767360553,   023127030,...
   431343777,   747317317,   045706125,   002744276,...
   060036467,   217744147,   603340174,   326616775,...
   063240065,   111460621,...
   ... PRN 159-210 are reserved for other GNSS applications.
   604055104,   157065232,   013305707,   603552017,...
   230461355,   603653437,   652346475,   743107103,...
   401521277,   167335110,   014013575,   362051132,...
   617753265,   216363634,   755561123,   365304033,...
   625025543,   054420334,   415473671,   662364360,...
   373446602,   417564100,   000526452,   226631300,...
   113752074,   706134401,   041352546,   664630154,...
   276524255,   714720530,   714051771,   044526647,...
   207164322,   262120161,   204244652,   202133131,...
   714351204,   657127260,   130567507,   670517677,...
   607275514,   045413633,   212645405,   613700455,...
   706202440,   705056276,   020373522,   746013617,...
   132720621,   434015513,   566721727,   140633660];

l2cl_init = [...
   ... PRNs 1-37 for GPS satellites
   624145772,   506610362,   220360016,   710406104,...
   001143345,   053023326,   652521276,   206124777,...
   015563374,   561522076,   023163525,   117776450,...
   606516355,   003037343,   046515565,   671511621,...
   605402220,   002576207,   525163451,   266527765,...
   006760703,   501474556,   743747443,   615534726,...
   763621420,   720727474,   700521043,   222567263,...
   132765304,   746332245,   102300466,   255231716,...
   437661701,   717047302,   222614207,   561123307,...
   240713073,...
   ...For PRNs 38-63
   101232630,   132525726,   315216367,   377046065,...
   655351360,   435776513,   744242321,   024346717,...
   562646415,   731455342,   723352536,   000013134,...
   011566642,   475432222,   463506741,   617127534,...
   026050332,   733774235,   751477772,   417631550,...
   052247456,   560404163,   417751005,   004302173,...
   715005045,   001154457,...
   ... For PRN 159-210
   605253024,   063314262,   066073422,   737276117,...
   737243704,   067557532,   227354537,   704765502,...
   044746712,   720535263,   733541364,   270060042,...
   737176640,   133776704,   005645427,   704321074,...
   137740372,   056375464,   704374004,   216320123,...
   011322115,   761050112,   725304036,   721320336,...
   443462103,   510466244,   745522652,   373417061,...
   225526762,   047614504,   034730440,   453073141,...
   533654510,   377016461,   235525312,   507056307,...
   221720061,   520470122,   603764120,   145604016,...
   051237167,   033326347,   534627074,   645230164,...
   000171400,   022715417,   135471311,   137422057,...
   714426456,   640724672,   501254540,   513322453];

if (PRN >= 1 && PRN <= 63)
    shiftPos = PRN;
elseif(PRN >= 159 && PRN <= 210)
    shiftPos = PRN - 95;
elseif ( PRN < 1 || PRN > 210 || (PRN >= 64 && PRN <= 158) )
    disp('  PRN does not exist! ');
    return;
end

% 
if ( strcmp(flag,'CM') || strcmp(flag,'cm'))
    CodeLength = settings.codeLength;
    code_init = l2cm_init(shiftPos);
elseif(strcmp(flag,'CL') || strcmp(flag, 'cl'))
    CodeLength = settings.CLCodeLength;
    code_init = l2cl_init(shiftPos);
else
    disp('  Code type flag error! ');
    return;    
end
      
reg = dec2bin(oct2dec(code_init)) - 48;
reg = [zeros(1,27-length(reg)) reg];

%--- Convert 0 to 1 and  1 to -1 ---
reg(find(reg)) = -1;  %#ok<*FNDSB>
reg(find(reg == 0)) = 1;

L2Ccode = zeros(1,CodeLength);
for index = 1:CodeLength
    L2Ccode(index) = reg(end);
    reg = circshift(reg',1)';
    reg(RegPos) = reg(RegPos) * L2Ccode(index); 
%     % for debug
%     if (index == CodeLength-1)
%         regDebug = reg;
%     end
end

% %% --- Following is for debug  ----------------------------------------------------
% % test vectors in IS-GPS-200H
% l2cm_end_state = [...
%   ... PRNs 1-37 for GPS satellites
%   552566002,  034445034,  723443711,  511222013,...
%   463055213,  667044524,  652322653,  505703344,...
%   520302775,  244205506,  236174002,  654305531,...
%   435070571,  630431251,  234043417,  535540745,...
%   043056734,  731304103,  412120105,  365636111,...
%   143324657,  110766462,  602405203,  177735650,...
%   630177560,  653467107,  406576630,  221777100,...
%   773266673,  100010710,  431037132,  624127475,...
%   154624012,  275636742,  644341556,  514260662,...
%   133501670,...
%   ...For PRNs 38-63
%   453413162,  637760505,  612775765,  136315217,...
%   264252240,  113027466,  774524245,  161633757,...
%   603442167,  213146546,  721323277,  207073253,...
%   130632332,  606370621,  330610170,  744312067,...
%   154235152,  525024652,  535207413,  655375733,...
%   316666241,  525453337,  114323414,  755234667,...
%   526032633,  602375063,...
%   ... For PRN 159-210
%   425373114,  427153064,  310366577,  623710414,...
%   252761705,  050174703,  050301454,  416652040,...
%   050301251,  744136527,  633772375,  007131446,...
%   142007172,  655543571,  031272346,  203260313,...
%   226613112,  736560607,  011741374,  765056120,...
%   262725266,  013051476,  144541215,  534125243,...
%   250001521,  276000566,  447447071,  000202044,...
%   751430577,  136741270,  257252440,  757666513,...
%   606512137,  734247645,  415505547,  705146647,...
%   006215430,  371216176,  645502771,  455175106,...
%   127161032,  470332401,  252026355,  113771472,...
%   754447142,  627405712,  325721745,  056714616,...
%   706035241,  173076740,  145721746,  465052527];
% 
% l2cl_end_state = [...
%   267724236,  167516066,  771756405,  047202624,...
%   052770433,  761743665,  133015726,  610611511,...
%   352150323,  051266046,  305611373,  504676773,...
%   272572634,  731320771,  631326563,  231516360,...
%   030367366,  713543613,  232674654,  641733155,...
%   730125345,  000316074,  171313614,  001523662,...
%   023457250,  330733254,  625055726,  476524061,...
%   602066031,  012412526,  705144501,  615373171,...
%   041637664,  100107264,  634251723,  257012032,...
%   703702423,...
%   463624741,  673421367,  703006075,  746566507,...
%   444022714,  136645570,  645752300,  656113341,...
%   015705106,  002757466,  100273370,  304463615,...
%   054341657,  333276704,  750231416,  541445326,...
%   316216573,  007360406,  112114774,  042303316,...
%   353150521,  044511154,  244410144,  562324657,...
%   027501534,  521240373,...
%   044547544,  707116115,  412264037,  223755032,...
%   403114174,  671505575,  606261015,  223023120,...
%   370035547,  516101304,  044115766,  704125517,...
%   406332330,  506446631,  743702511,  022623276,...
%   704221045,  372577721,  105175230,  760701311,...
%   737141001,  227627616,  245154134,  040015760,...
%   002154472,  301767766,  226475246,  733673015,...
%   602507667,  753362551,  746265601,  036253206,...
%   202512772,  701234023,  722043377,  240751052,...
%   375674043,  166677056,  123055362,  707017665,...
%   437503241,  275605155,  376333266,  467523556,...
%   144132537,  451024205,  722446427,  412376261,...
%   441570172,  063217710,  110320656,  113765506];
% 
% if ( strcmp(flag,'CM') || strcmp(flag,'cm'))
%     code_end = l2cm_end_state(shiftPos);
% elseif(strcmp(flag,'CL') || strcmp(flag, 'cl'))
%     code_end = l2cl_end_state(shiftPos);
% else
%     disp('  Code type flag error! ');
%     return;    
% end
%       
% reg_end = dec2bin(oct2dec(code_end)) - 48;
% reg_end = [zeros(1,27-length(reg_end)) reg_end];
% 
% %--- Convert 0 to 1 and  1 to -1 ---
% reg_end(find(reg_end)) = -1; %#ok<FNDSB>
% reg_end(find(reg_end == 0)) = 1; %#ok<FNDSB>
% 
% if (reg_end ~= regDebug )
%     fprintf('  %s Code for PRN %02d generating error! \n',flag, PRN);
% else
%     fprintf('  %s Code for PRN %02d generating right! \n',flag, PRN);
% end