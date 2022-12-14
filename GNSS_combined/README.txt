This is not as complete of a product as I wished to have by the end of this final project. 

Unfortunately, it still exists in a state that requires each constellation's SDR to be run separately, the workspaces saved, and then 
the trackResults combined to produce a position solution. Many hacks and work-around are currently in place to make this work.

I don't think it would take me a lot of work to make this combined solution work closer to the paradigm of the other constellations' SDRs, 
but I didn't complete a position solution in time for that to work. 


Ultimately, to start to get a combined solution, you have to do the following: 

%   1. Run GPS L5 code with desired parameters, save the entire workspace under
%   savedVar\L5_soln.mat
%   2. Run GAL E5a code with the SAME parameters (as close as possible),
%   save the entire workspace under savedVar\E5a_results.mat
%   3. Run comboSoln_check.m within the GNSS_combined folder.

I've zipped the data as well as the saved variables required to run this code, so ultimately you only have to do step 3. 