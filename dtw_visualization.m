function DTWVisualization(ix,iy,seq1,seq2,type)
%% visualization
DTW_seq1=seq1;
% DTW_seq1=DTW_seq1(min(find(DTW_seq1(:,end)==1)):max(find(DTW_seq1(:,end)==2)),:);
DTW_seq2=seq2;
% DTW_seq2=DTW_seq2(min(find(DTW_seq2(:,end)==1)):max(find(DTW_seq2(:,end)==2)),:);

switch type
    case 'Xsens_Pos'
% Xsens Position
        t_1=[1:length(ix)]; % why longer than longest ori matrix?
        t_2=[1:length(iy)];

        % add translation in x, y or z direction
        tform=[4 0 0]; % add translation in x direction
        % add translatrion to right forearm (column 10-12)
        DTW_seq2(:,10:12)=DTW_seq2(:,10:12)+repmat(tform,length(DTW_seq2),1);
    
        figure, 
%         scatter3(DTW_seq1(:,1), DTW_seq1(:,2), ...
%             DTW_seq1(:,3),30,t_1,'filled');
%         hold on
%         scatter3(DTW_seq2(:,1), DTW_seq2(:,2), ...
%             DTW_seq2(:,3),30,t_2,'filled');
        plot3(DTW_seq1(:,10), DTW_seq1(:,11),...
            DTW_seq1(:,12),'LineWidth',3);
        hold on
        plot3(DTW_seq2(:,10), DTW_seq2(:,11),...
            DTW_seq2(:,12),'LineWidth',3);
        hold on
        for i=1:20:(length(DTW_seq1)/4) % lines between match points
        line([DTW_seq1(i,10) DTW_seq2(i,10)],[DTW_seq1(i,11)...
            DTW_seq2(i,11)],[DTW_seq1(i,12) DTW_seq2(i,12)]);
        end
        xlabel('X'); ylabel('Y'); zlabel('Z');
%         cb = colorbar;
%         cb.Label.String = 'Time';
        title('Segment: right forarm');

        figure, 
        plot(ix(100:120),iy(100:120),'o-',[ix(100) ix(120)],[iy(100) iy(120)])
        
    case 'Aurora_Pos'
% Aurora Position
        t_1=[1:length(ix)];
        t_2=[1:length(iy)];

        % add translation in x, y or z direction
        tform=[4 0 0]; % add translation in x direction
        % add translatrion to first sensor
        DTW_seq2(:,1:3)=DTW_seq2(:,1:3)+repmat(tform,length(DTW_seq2),1);

        figure, 
        plot3(DTW_seq1(:,1), DTW_seq1(:,2),...
            DTW_seq1(:,3),'LineWidth',3);
        hold on
        plot3(DTW_seq2(:,1), DTW_seq2(:,2),...
            DTW_seq2(:,3),'LineWidth',3);
        hold on
        for i=1:5:(length(DTW_seq1)) % lines between match points
        line([DTW_seq1(i,1) DTW_seq2(i,1)],[DTW_seq1(i,2)...
            DTW_seq2(i,2)],[DTW_seq1(i,3) DTW_seq2(i,3)]);
        end
        
        figure, 
        plot(ix(100:120),iy(100:120),'o-',[ix(100) ix(120)],[iy(100) iy(120)])
end
        
