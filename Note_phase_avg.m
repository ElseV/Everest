N1=1; 
N2=7; % amount of experts
nn=1;

for i = 1:7
n=1;  
name=string("AVG_Seq_all.seq%d"); % data list
A1=i;
part1=char(sprintf(name,A1));
seq_ref=eval(part1);

position_xs_ref=pos_xsens_avg(seq_ref); % avg or normal?
Reference = position_xs_ref;

    for ii=1:26
        name2=("data_list.seq%d");
        B1=ii;
        part2=char(sprintf(name2,B1));
        seq_measure=eval(part2);

        position_xs_measure=pos_xsens(seq_measure); % avg or normal?
        Measurement = note_phase(position_xs_measure);

        [~,ix,iy]=dtw(Reference',Measurement(:,1:end-2)');
        DTWref= Reference(ix,:);
        DTWmeasure= Measurement(iy,:);
        
        %phase?
        
    end
    % majority vote for phases?
end