function [poses]=poses_prep(seq)

seq=seq(:,3:end);
% interpolates for missing values
x=1:length(seq);
for i=1:size(seq,2)
    ind=~isnan(seq(:,i));
    seq(:,i)=interp1(x(ind),seq(ind,i),x)';
    i=i+1;
end
% replace NaNs on outside of matrix by 0
for i=1:length(seq)
    x=isnan(seq(i,:));
    seq(i,x)=0;

end
poses=seq;
end