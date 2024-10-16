function y = s_MLP(MLP, X)

nm = size(X,1);
nc = length(MLP);
y = X;
for i1=1:nc
    %u = y*(MLP{i1}.W)';
    MLP{i1}.u = [y ones(nm,1)]*([MLP{i1}.W MLP{i1}.t])';
    y=eval([MLP{1}.fa,'(MLP{i1}.u,MLP{i1}.vp)']);
    MLP{i1}.y = y;
    MLP{i1}.dy = eval(['d', MLP{1}.fa,'(MLP{i1}.u,MLP{i1}.vp)']);
end