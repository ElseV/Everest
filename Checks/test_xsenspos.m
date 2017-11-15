function [dist,ix,iy,sync_error,accuracy,sym_error]=test_xsenspos(seq1,seq2)

        position_xs1=pos_xsens(seq1.xsenspos,1,length(seq1));
        position_xs2=pos_xsens(seq2.xsenspos,1,length(seq2));
        [dist,ix,iy]=dtw(position_xs1',position_xs2');
        
        DTW_position_xs1= position_xs1(ix,:);
        DTW_position_xs2= position_xs2(iy,:);
        
        [sync_error,accuracy,sym_error]=errors(ix,iy,position_xs1,position_xs2,seq1.events,seq2.events);
 end