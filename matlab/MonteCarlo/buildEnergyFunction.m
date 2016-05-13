function energyFunction = buildEnergyFunction( h, Jzz, Jzzz)
%BUILD ENERGY FUNCTION builds an energy function given an array of 
%local fields, a matrix of 2 local couplings and a tensor or 
%3 local couplings

%USAGE: call energyFunction = buildEnergyFunction(h,Jzz,Jzzz)
%Then to calculate the energy of an array of spins=[1,-1,...] just do
%energy = energyFunction(spins)

    localFields = '';
    couplingsZZ = '';
    couplingsZZZ = '';
    
    if ~isempty(h)
        for i=1:length(h)
            if h(i)~=0
               formatSpec = '%f*spinConfig(%u)+';
               localFields = CStrCatStr(localFields,{sprintf(formatSpec,h(i),i)});
               %localFields = strcat(localFields,sprintf(formatSpec,h(i),i));
               %localFields = strcat(localFields,strcat(num2str(h(i)),...
               %     strcat('*',strcat('spinConfig(',strcat(int2str(i),')+')))));
            end
        end
    end
    
    if ~isempty(Jzz)
        for i = 1:length(Jzz)
            for j = (i+1):length(Jzz)
                if Jzz(i,j)~=0
                    formatSpec = '%f*spinConfig(%u)*spinConfig(%u)+';
                    couplingsZZ = CStrCatStr(couplingsZZ,{sprintf(formatSpec,Jzz(i,j),i,j)});
                    %couplingsZZ = strcat(couplingsZZ,sprintf(formatSpec,Jzz(i,j),i,j));
                    %couplingsZZ = strcat(couplingsZZ,strcat(...
                    %    num2str(Jzz(i,j)),strcat('*spinConfig(',strcat(...
                    %    int2str(i),strcat(')*spinConfig(',strcat(int2str(j),')+'))))));
                end
            end    
        end
    end

    if ~isempty(Jzzz)
        for i = 1:length(Jzzz)
            for j = (i+1):length(Jzzz)
                for k = (j+1):length(Jzzz)
                    if Jzzz(i,j,k)~=0
                        %disp('here');
                        formatSpec = '%f*spinConfig(%u)*spinConfig(%u)*spinConfig(%u)+';
                        couplingsZZZ = CStrCatStr(couplingsZZZ,{sprintf(formatSpec,Jzzz(i,j,k),...
                            i,j,k)});
                        %disp(couplingsZZZ);
                        %couplingsZZZ = strcat(couplingsZZZ,sprintf(formatSpec,Jzzz(i,j,k),...
                        %    i,j,k));
                        %couplingsZZZ = strcat(couplingsZZZ,strcat(...
                        %    num2str(Jzzz(i,j,k)),strcat('*spinConfig(',strcat(...
                        %    int2str(i),strcat(')*spinConfig(',strcat(...
                        %    int2str(j),strcat(')*spinConfig(',strcat(...
                        %    int2str(k),')+'))))))));
                    end
                end
            end
        end
    end
    %couplingsZZZ = couplingsZZZ(1:end-1);
    %disp(localFields{1});
    disp(couplingsZZ);
    %disp(isempty(couplingsZZZ));
    %disp(couplingsZZZ);
    hamString = strcat(localFields,strcat(couplingsZZ,couplingsZZZ)); 
    hamString = hamString{1};
    hamString = hamString(1:end-1);
    %disp(hamString);
    function energy = metaFunction(spinConfig)
        energy = eval(hamString);
    end
    energyFunction = @metaFunction;
end

