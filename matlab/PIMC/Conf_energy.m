function [ out ] = Conf_energy(spin_conf, HParams)
    global timeoutFlag
    if timeoutFlag
        msgID = 'Timeout';
        msg = 'Timeout.';
        baseException = MException(msgID,msg);
        throw(baseException)
    end
    % Number of spins/config
    n = length(spin_conf);
    [h, Jzz, Jxx, Jzzz, Jxxx] = deal(HParams{:});
    
    h_tot = 0;
    Jzz_tot = 0;
    Jxx_tot = 0;
    Jzzz_tot = 0;
    Jxxx_tot = 0;
    
%     % Find h energy terms
%     for i = 1:length(h)
%         
%     end
%     
%     % Find Jzz en terms
%     for i = 1:length(Jzz)
%         for j = i+1:length(Jzz)
%             
%         end
%     end
%     
%     % Find Jxx en terms
%     for i = 1:length(Jxx)
%         for j = i+1:length(Jxx)
%             
%         end
%     end

    % Find Jzzz en terms
    for i = 1:n;
        if length(h) > 1 
            if h(i) ~= 0
                h_tot = h_tot + h(i)*spin_conf(i);
            end
        end
        for j = i+1:n;
            if length(Jzz) > 1 
                if Jzz(i,j) ~= 0;
                    Jzz_tot = Jzz_tot + Jzz(i,j)*spin_conf(i)*spin_conf(j);
                end
            end           
            if length(Jxx) > 1
                if Jxx(i,j) ~= 0
                    Jxx_tot = Jxx_tot + Jxx(i,j)*spin_conf(i)*spin_conf(j);
                end
            end
            for k = j+1:n;
                if length(Jzzz) > 1
                    if Jzzz(i,j,k) ~= 0
                        Jzzz_tot = Jzzz_tot + Jzzz(i,j,k)*spin_conf(i)*spin_conf(j)*spin_conf(k);
                    end
                end
                if length(Jxxx) > 1 
                    if Jxxx(i,j,k) ~= 0
                        Jxxx_tot = Jxxx_tot + Jxxx(i,j,k)*spin_conf(i)*spin_conf(j)*spin_conf(k);
                    end
                
                end
            end
        end
    end
    
 
    
    out = h_tot + Jzz_tot + Jxx_tot + Jzzz_tot + Jxxx_tot;
        
        
        
    
    
