function B2aPilotcode = generateB2aPilotCode(PRN,settings)
% This function generates one of the BDS-3 satellite B2a pilot codes.
%
% generateB2aPilotCode(PRN,settings)
%
%   Inputs:
%       PRN          - PRN number of the sequence.
%       settings     - receiver settings
%
%   Outputs:
%       B2aPilotcode - a vector containing the desired B2a pilot code 
%                      sequence (chips).

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
%--------------------------------------------------------------------------

%CVS record:
%$Id: generateL2Ccode.m,v 1.1.2.5 2017/01/16 23:00:00 dpl Exp $

% --- Initail parameters for pilot code generation ------------------------
% Initial values of the register No.2 
B2aData_reg2_ini = [ 1 0 0 0 0 0 0 1 0 0 1 0 1;... 
1 0 0 0 0 0 0 1 1 0 1 0 0;... 
1 0 0 0 0 1 0 1 0 1 1 0 1;... 
1 0 0 0 1 0 1 0 0 1 1 1 1;...
1 0 0 0 1 0 1 0 1 0 1 0 1;...
1 0 0 0 1 1 0 1 0 1 1 1 0;... 
1 0 0 0 1 1 1 1 0 1 1 1 0;... 
1 0 0 0 1 1 1 1 1 1 0 1 1;... 
1 0 0 1 1 0 0 1 0 1 0 0 1;... 
1 0 0 1 1 1 1 0 1 1 0 1 0;... 
1 0 1 0 0 0 0 1 1 0 1 0 1;... 
1 0 1 0 0 0 1 0 0 0 1 0 0;... 
1 0 1 0 0 0 1 0 1 0 1 0 1;... 
1 0 1 0 0 0 1 0 1 1 0 1 1;... 
1 0 1 0 0 0 1 0 1 1 1 0 0;... 
1 0 1 0 0 1 0 1 0 0 0 1 1;... 
1 0 1 0 0 1 1 1 1 0 1 1 1;... 
1 0 1 0 1 0 0 0 0 0 0 0 1;... 
1 0 1 0 1 0 0 1 1 1 1 1 0;... 
1 0 1 0 1 1 0 1 0 1 0 1 1;... 
1 0 1 0 1 1 0 1 1 0 0 0 1;... 
1 0 1 1 0 0 1 0 1 0 0 1 1;... 
1 0 1 1 0 0 1 1 0 0 0 1 0;... 
1 0 1 1 0 1 0 0 1 1 0 0 0;... 
1 0 1 1 0 1 0 1 1 0 1 1 0;... 
1 0 1 1 0 1 1 1 1 0 0 1 0;... 
1 0 1 1 0 1 1 1 1 1 1 1 1;... 
1 0 1 1 1 0 0 0 1 0 0 1 0;... 
1 0 1 1 1 0 0 1 1 1 1 0 0;... 
1 0 1 1 1 1 0 1 0 0 0 0 1;... 
1 0 1 1 1 1 1 0 0 1 0 0 0;... 
1 0 1 1 1 1 1 0 1 0 1 0 0;... 
1 0 1 1 1 1 1 1 0 1 0 1 1;... 
1 0 1 1 1 1 1 1 1 0 0 1 1;... 
1 1 0 0 0 0 1 0 1 0 0 0 1;... 
1 1 0 0 0 1 0 0 1 0 1 0 0;... 
1 1 0 0 0 1 0 1 1 0 1 1 1;... 
1 1 0 0 1 0 0 0 1 0 0 0 1;... 
1 1 0 0 1 0 0 0 1 1 0 0 1;... 
1 1 0 0 1 1 0 1 0 1 0 1 1;... 
1 1 0 0 1 1 0 1 1 0 0 0 1;... 
1 1 0 0 1 1 1 0 1 0 0 1 0;... 
1 1 0 1 0 0 1 0 1 0 1 0 1;...
1 1 0 1 0 0 1 1 1 0 1 0 0;... 
1 1 0 1 0 1 1 0 0 1 0 1 1;... 
1 1 0 1 1 0 1 0 1 0 1 1 1;... 
1 1 1 0 0 0 0 1 1 0 1 0 0;... 
1 1 1 0 0 1 0 0 0 0 0 1 1;... 
1 1 1 0 0 1 0 0 0 1 0 1 1;... 
1 1 1 0 0 1 0 1 0 0 0 1 1;... 
1 1 1 0 0 1 0 1 0 1 0 0 0;...
1 1 1 0 1 0 0 1 1 1 0 1 1;... 
1 1 1 0 1 1 0 0 1 0 1 1 1;... 
1 1 1 1 0 0 1 0 0 1 0 0 0;... 
1 1 1 1 0 1 0 0 1 0 1 0 0;... 
1 1 1 1 0 1 0 0 1 1 0 0 1;... 
1 1 1 1 0 1 1 0 1 1 0 1 0;... 
1 1 1 1 0 1 1 1 1 1 0 0 0;... 
1 1 1 1 0 1 1 1 1 1 1 1 1;... 
1 1 1 1 1 1 0 1 1 0 1 0 1;... 
1 0 1 0 0 1 0 0 0 0 1 1 0;... 
0 0 1 0 1 1 1 1 1 1 0 0 0;... 
0 0 0 1 1 0 1 0 1 0 1 0 1];

% Code length
CodeLength = settings.codeLength;

%--- Generate XA codes ----------------------------------------------------
% Feedback position of exclusive OR operation for XA codes
reg1_FeedbackPos = [3 6 7 13];
reg2_FeedbackPos = [1 5 7 8 12 13];

% Initial state of XA register: 1 for 0, and -1 for 1, to perform exclusive
% OR operation by multiply
register1 = ones(1,13) * -1;
register2  = 1- 2* B2aData_reg2_ini(PRN,:);

% XA codes output
B2aPilotcode = zeros(1,CodeLength);

% XA register will be reset to all 1 (here -1 represents 1)
reset_index = 8190;

%--- Generate the B2a pilot channel codes ---------------------------------
for ind = 1:CodeLength
    B2aPilotcode(ind) = register1(end) * register2(end);
    % Exclusive OR operation for feedback
    feedback1 = prod(register1(reg1_FeedbackPos));
    % shift the register to right by one element
    register1 = circshift(register1',1)';
    register1(1) = feedback1;
    % Exclusive OR operation for feedback
    feedback2 = prod(register2(reg2_FeedbackPos));
    % shift the register to right by one element
    register2 = circshift(register2',1)';
    register2(1) = feedback2;
    if ind == reset_index
        register1 = ones(1,13) * -1;
    end
end
