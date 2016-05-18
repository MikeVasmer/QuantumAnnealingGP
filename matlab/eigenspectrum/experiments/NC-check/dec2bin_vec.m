function binVec=dec2bin_vec(dec1,vecLength)

nCheck=floor(log2(dec1))+1;
if exist('vecLength','var')
    if nCheck>vecLength
        warning('too few decimial places specifed, ''dec2bin_vec'' giving full binary instead: this may cause errors downstream');
        vecLength=nCheck;
    end
else
    vecLength=nCheck;
end

binVec=zeros(vecLength,1);

for ibin=1:nCheck
    m1=mod(dec1,2^ibin);
    if m1~=0
        binVec(ibin)=1;
        dec1=dec1-2^(ibin-1);
    end
end

%binVec=flipud(binVec);