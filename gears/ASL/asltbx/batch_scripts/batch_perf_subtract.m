% Toolbox for batch processing ASL perfusion based fMRI data.
% All rights reserved.
% Ze Wang @ TRC, CFN, Upenn 2004
%
% Batch calculation for the perfusion signals.

function batch_perf_subtract(PAR)
    for sb = 1:PAR.nsubs % for each subject

        sprintf('Calculate perfusion and CBF signals for subject #%g ... %g subjects left...',sb,length(PAR.subjects)-sb)
        for c=1:PAR.ncond

            P=[];
            %ptmp=spm_get('files', PAR.condirs{s,1}, [PAR.subjects{s} '*' PAR.confilters{1} '*img']);
            %P=ptmp(1,:);
            % creating a mask image for removing background
            maskimg = spm_select('FPList', PAR.condirs{sb,c},    ['^brainmask_nat\w*\.nii$']);
            Filename =  spm_select('ExtFPList', PAR.condirs{sb,c}, ['^sASLflt.*\.nii'], 1:1000 );
            %        spm_perf_subtract(Filename,FirstimageType, SubtractionType,...
            %           SubtractionOrder,Flag,Timeshift,AslType,MagType,Labeltime,Delaytime,Slicetime,M0img,M0seg,maskimg)
            M0imgcustom = spm_select('FPList', PAR.condirs{sb,c}, ['M0.nii$']);
            asl_perf_subtract(Filename,0, 0, ...
                1,      [0 1 1 0 0 1 0 1 1], 0.5,     1,      0.85, 1,...
                1.517, PAR.delaytime, 0, PAR.TE, M0imgcustom,[],[]);
            % labeling time=1.517s, post labeling delay=2 s, slice time=0
            % msec, TE=36.48 msec, yes explicit M0 image, no mask for extracting M0
            % value (like M0 white matter etc) provided.
        end
    end
end
