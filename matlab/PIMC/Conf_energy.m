function [ out ] = Conf_energy(spin_conf, HParams)
    
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
        if length(h) > 1;
            h_tot = h_tot + h(i)*spin_conf(i);
        end
        for j = i+1:n;
            if length(Jzz) > 1;
                Jzz_tot = Jzz_tot + Jzz(i,j)*spin_conf(i)*spin_conf(j);
            end           
            if length(Jxx) > 1;
                Jxx_tot = Jxx_tot + Jxx(i,j)*spin_conf(i)*spin_conf(j);
            end
            for k = j+1:n;
                if length(Jzzz) > 1;
                    Jzzz_tot = Jzzz_tot + Jzzz(i,j,k)*spin_conf(i)*spin_conf(j)*spin_conf(k);
                end
                if length(Jxxx) > 1;
                    Jxxx_tot = Jxxx_tot + Jxxx(i,j,k)*spin_conf(i)*spin_conf(j)*spin_conf(k);
                end
            end
        end
    end
    
    
 
    
    out = h_tot + Jzz_tot + Jxx_tot + Jzzz_tot + Jxxx_tot;
        
        
        
    
    
