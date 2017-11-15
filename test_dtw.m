function [dist,ix,iy,sync_error,sync_error_per,...
    accuracy,s1new_events,s2new_events,old1,old2]=test_dtw(exp,seq1,seq2)
maxsamp=10;
 switch exp
     case 'Xsens_Pos'
        position_xs1=pos_xsens(seq1);
        old1=position_xs1;
        position_xs2=pos_xsens(seq2);
        old2=position_xs2;
        [dist,ix,iy]=dtw(position_xs1(:,1:end-2)',position_xs2(:,1:end-2)');
%         [d]=dtw_alt(position_xs1,position_xs2);
        
        DTWseq1= position_xs1(ix,:);
        DTWseq2= position_xs2(iy,:);
        
        [sync_error,sync_error_per,...
        accuracy,s1new_events,s2new_events]=errors(DTWseq1,DTWseq2);
        
     case 'Xsens_Ori'
        orientation_xs1=ori_xsens(seq1);
        old1=orientation_xs1;
        orientation_xs2=ori_xsens(seq2);
        old2=orientation_xs2;
        [dist,ix,iy]=dtw(orientation_xs1(:,1:end-2)',orientation_xs2(:,1:end-2)');
        
        DTWseq1= orientation_xs1(ix,:);
        DTWseq2= orientation_xs2(iy,:);
        
        [sync_error,sync_error_per,...
        accuracy,s1new_events,s2new_events]=errors(DTWseq1,DTWseq2);


     case 'Xsens_P&O'
        position_xs1=pos_xsens(seq1);
        position_xs2=pos_xsens(seq2);
        orientation_xs1=ori_xsens(seq1);
        orientation_xs2=ori_xsens(seq2);
        xs1=[position_xs1(:,1:end-2) orientation_xs1];
        old1=xs1;
        xs2=[position_xs2(:,1:end-2) orientation_xs2];
        old2=xs2;
        [dist,ix,iy]=dtw(xs1(:,1:end-2)',xs2(:,1:end-2)');
        
        DTWseq1= xs1(ix,:);
        DTWseq2= xs2(iy,:);

        [sync_error,sync_error_per,...
        accuracy,s1new_events,s2new_events]=errors(DTWseq1,DTWseq2);
        
     case 'Aurora_Pos'
        position_au1=pos_aurora(seq1,1,9);
        old1=position_au1;
        position_au2=pos_aurora(seq2,1,9);
        old2=position_au2;
        [dist,ix,iy]=dtw(position_au1(:,1:end-2)',position_au2(:,1:end-2)');
   
        DTWseq1= position_au1(ix,:);
        DTWseq2= position_au2(iy,:);
       
        [sync_error,sync_error_per,...
        accuracy,s1new_events,s2new_events]=errors(DTWseq1,DTWseq2);
 
     case 'Aurora_Ori'
        orientation_au1=ori_aurora(seq1,1,12);
        old1=orientation_au1;
        orientation_au2=ori_aurora(seq2,1,12);
        old2=orientation_au2;
        [dist,ix,iy]=dtw(orientation_au1(:,1:end-2)',orientation_au2(:,1:end-2)');
        
        DTWseq1= orientation_au1(ix,:);
        DTWseq2= orientation_au2(iy,:);
        
        [sync_error,sync_error_per,...
        accuracy,s1new_events,s2new_events]=errors(DTWseq1,DTWseq2);
        
    case 'Aurora_P&O'
        position_au1=pos_aurora(seq1,1,9);
        position_au2=pos_aurora(seq2,1,9);
        orientation_au1=ori_aurora(seq1,1,12);
        orientation_au2=ori_aurora(seq2,1,12);
        au1=[position_au1(:,1:end-2) orientation_au1];
        old1=au1;
        au2=[position_au2(:,1:end-2) orientation_au2];
        old2=au2;
        
        [dist,ix,iy]=dtw(au1(:,1:end-2)',au2(:,1:end-2)');
        
        DTWseq1= au1(ix,:);
        DTWseq2= au2(iy,:);
        
        [sync_error,sync_error_per,...
        accuracy,s1new_events,s2new_events]=errors(DTWseq1,DTWseq2);

    case 'Position'
        position_xs1=pos_xsens(seq1);
        position_xs2=pos_xsens(seq2);
        position_au1=pos_aurora(seq1,1,9);
        position_au2=pos_aurora(seq2,1,9);
        % make xsens same length as aurora
        if length(position_xs1) <= length(position_au1)
            position_au1=position_au1(~all(position_xs1==0,2),:);
        else
            position_xs1=position_xs1(~all(position_au1==0,2),:);
        end
        
        if length(position_xs2) <= length(position_au2)
            position_au2=position_au2(~all(position_xs2==0,2),:);
        else
            position_xs2=position_xs2(~all(position_au2==0,2),:);
        end
        
        pos1=[position_xs1(:,1:end-2) position_au1];
        old1=pos1;
        pos2=[position_xs2(:,1:end-2) position_au2];
        old2=pos2;
        
        [dist,ix,iy]=dtw(pos1(:,1:end-2)',pos2(:,1:end-2)');
        
        DTWseq1= pos1(ix,:);
        DTWseq2= pos2(iy,:);
        
        [sync_error,sync_error_per,...
        accuracy,s1new_events,s2new_events]=errors(DTWseq1,DTWseq2);
 
    case 'Orientation'
        orientation_xs1=ori_xsens(seq1);
        orientation_xs2=ori_xsens(seq2);
        orientation_au1=ori_aurora(seq1,1,9);
        orientation_au2=ori_aurora(seq2,1,9);
        % make xsens same length as aurora
        if length(orientation_xs1) <= length(orientation_au1)
            orientation_au1=orientation_au1(~all(orientation_xs1==0,2),:);
        else
            orientation_xs1=orientation_xs1(~all(orientation_au1==0,2),:);
        end
        
        if length(orientation_xs2) <= length(orientation_au2)
            orientation_au2=orientation_au2(~all(orientation_xs2==0,2),:);
        else
            orientation_xs2=orientation_xs2(~all(orientation_au2==0,2),:);
        end
        
        ori1=[orientation_xs1(:,1:end-2) orientation_au1];
        old1=ori1;
        ori2=[orientation_xs2(:,1:end-2) orientation_au2];
        old2=ori2;
        
        [dist,ix,iy]=dtw(ori1(:,1:end-2)',ori2(:,1:end-2)');
        
        DTWseq1= ori1(ix,:);
        DTWseq2= ori2(iy,:);
        
        [sync_error,sync_error_per,...
        accuracy,s1new_events,s2new_events]=errors(DTWseq1,DTWseq2);
        
    case 'P&O'
        position_xs1=pos_xsens(seq1);
        position_xs2=pos_xsens(seq2);
        [position_au1]=pos_aurora(seq1,1,9);
        [position_au2]=pos_aurora(seq2,1,9);
        orientation_xs1=ori_xsens(seq1);
        orientation_xs2=ori_xsens(seq2);
        [orientation_au1]=ori_aurora(seq1,1,9);
        [orientation_au2]=ori_aurora(seq2,1,9);
        % make xsens same length as aurora
        if length(position_xs1) <= length(position_au1)
            position_au1=position_au1(~all(position_xs1==0,2),:);
        else
            position_xs1=position_xs1(~all(position_au1==0,2),:);
        end
        
        if length(position_xs2) <= length(position_au2)
            position_au2=position_au2(~all(position_xs2==0,2),:);
        else
            position_xs2=position_xs2(~all(position_au2==0,2),:);
        end
        if length(orientation_xs1) <= length(orientation_au1)
            orientation_au1=orientation_au1(~all(orientation_xs1==0,2),:);
        else
            orientation_xs1=orientation_xs1(~all(orientation_au1==0,2),:);
        end
        
        if length(orientation_xs2) <= length(orientation_au2)
            orientation_au2=orientation_au2(~all(orientation_xs2==0,2),:);
        else
            orientation_xs2=orientation_xs2(~all(orientation_au2==0,2),:);
        end

        pos_ori1=[position_xs1(:,1:end-2) position_au1(:,1:end-2) orientation_xs1(:,1:end-2) orientation_au1];
        old1=pos_ori1;
        pos_ori2=[position_xs2(:,1:end-2) position_au2(:,1:end-2) orientation_xs2(:,1:end-2) orientation_au2];
        old2=pos_ori2;

        [dist,ix,iy]=dtw(pos_ori1(:,1:end-2)',pos_ori2(:,1:end-2)');

        DTWseq1= pos_ori1(ix,:);
        DTWseq2= pos_ori2(iy,:);

        [sync_error,sync_error_per,...
        accuracy,s1new_events,s2new_events]=errors(DTWseq1,DTWseq2);
end