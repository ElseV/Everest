%% check if data in struct is similar
rawdata=data0724;
expertNames = fieldnames(rawdata);

  for i = 1:numel(expertNames)
      
      expertName = expertNames(i);
      sequences = rawdata.(expertNames{i});
      sequenceNames = fieldnames(sequences);
      
      for j = 1:numel(sequenceNames)
          sequenceName = sequenceNames(j);
          data = sequences.(sequenceNames{j});  
          dataNames = fieldnames(data);
          
          for k = 1:4%numel(dataNames)
              for m=1:4
                  chck{k,m}=isequal(rawdata.(expertNames{i}).(sequenceNames{j}).(dataNames{k}),...
                  rawdata.(expertNames{i}).(sequenceNames{j}).(dataNames{m}));
              end
%               chck1=struct('data1',{},'data2',{},'data3',{},'data4',{});
%               chck1(k).data=chck;
          end
          chck2{j}=chck;
%           chck2=struct('seq1',{},'seq2',{},'seq3',{},'seq4',{},'seq5',{});
%           chck2(j)=chck1;
      end
      chck3{i}=chck2;
%       chck3=struct('exp1',{},'exp2',{},'exp3',{},'exp4',{});
%       chck3(i)=chck2;
  end
  

%%
% run first part create struct
A=whos;
for j=1:75
    for i=1:75
        chck(j,i)=isequal(eval(A(j).name),eval(A(i).name));
    end
end