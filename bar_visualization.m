function []=bar_visualization(s1new,s2new,old1,old2,config)

path=[s1new(:,end)';s2new(:,end)'];
%%
s1old_phase=old1;
for i=1:9 % make phases
    if i==8
        continue
    end
    if i==7
    ind1=min(find(s1old_phase(:,end)==i));
    ind2=min(find(s1old_phase(:,end)==i+2));
    s1old_phase(ind1:ind2-1,end)=i;   
    end
    ind1=min(find(s1old_phase(:,end)==i));
    ind2=min(find(s1old_phase(:,end)==i+1));
    s1old_phase(ind1:ind2-1,end)=i;
end

s2old_phase=old2;
for i=1:9 % make phases
    if i==8
        continue
    end
    if i==7
    ind1=min(find(s2old_phase(:,end)==i));
    ind2=min(find(s2old_phase(:,end)==i+2));
    s2old_phase(ind1:ind2-1,end)=i;   
    end
    ind1=min(find(s2old_phase(:,end)==i));
    ind2=min(find(s2old_phase(:,end)==i+1));
    s2old_phase(ind1:ind2-1,end)=i;
end

 if length(s1old_phase) < length(s2old_phase)
    extra_rows=length(s2old_phase)-length(s1old_phase);
    s1old_phase=[s1old_phase; zeros(extra_rows,size(s1old_phase,2))];
    s1old_phase(end-extra_rows+1:end,end)=9;
 else
    extra_rows=length(s1old_phase)-length(s2old_phase);
    s2old_phase=[s2old_phase; zeros(extra_rows,size(s2old_phase,2))];
    s1old_phase(end-extra_rows+1:end,end)=9;
 end

path_old=[s1old_phase(:,end)';s2old_phase(:,end)'];
%%
figure,% subplot(2,1,1)
bar_path=imagesc(path);
hold on;
x=1:length(s1new);
y=1.5;
line([x(1) x(end)],[y y],'LineWidth',3,'Color',[0 0 0])
% Mouth - z-line - start retro = insertion (1&2)
% Start retro - pylorus insight = retroflexion + inspection (3&4)
% Pylorus in sight - Intubation = intubation (5&6)
% Retraction duodenum - mouth = retraction (7&9)

% blue 001, green 010, gray 0.50.50.5 red 100 orange 10.40 yellow 110
% pink 101 white 111 black 000
cmap1=[0,0,1;0,0,1;0,1,0;0,1,0;0.5,0.5,0.5;0.5,0.5,0.5;1,0,0;1,0,0];
colormap(gca,cmap1);
colorbar('Ticks',[2;4;6;8],'TickLabels',{'Insertion','Retroflexion + inspection'...
   'Intubation','Retraction'},'Location','southoutside');
title(config);
%%
% subplot(2,1,2)
figure,
bar_path_old=imagesc(path_old);
hold on;
x=1:length(s1new);
y=1.5;
line([x(1) x(end)],[y y],'LineWidth',3,'Color',[0 0 0])
cmap2=[0,0,1;0,0,1;0,1,0;0,1,0;0.5,0.5,0.5;0.5,0.5,0.5;1,0,0;1,0,0;1,0,0;1,1,1];
colormap(gca,cmap2);

% hold on
% txt={sprintf('%d',dist),sprintf('%d',accuracy)};
% text(1,1,txt);% sprintf('%d',dist))

end

