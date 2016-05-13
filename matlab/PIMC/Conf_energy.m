function [ out ] = Conf_energy(spin_conf, HParams, PT)
    
    % Number of spins/config
    n = length(spin_conf);
    [h, Jzz, Jxx, Jzzz, Jxxx] = deal(HParams{:});
    
    h_tot = 0;
    Jzz_tot = 0
    Jxx_tot = 0
    Jzzz_tot = 0
    Jxxx_tot = 0
    
    % Find h energy terms
    for i = 1:length(h)
        h_tot = h_tot + h(i)*spin_conf(i)
    end
    
    % Find Jzz en terms
    for i = 1:length(Jzz)
        for j = i:length(Jzz)
            Jzz_tot = Jzz_tot + Jzz(i,j)*spin_conf(i)*spin_conf(j)
        end
    end
    
    % Find Jxx en terms
    for i = 1:length(Jxx)
        for j = i:length(Jxx)
            Jxx_tot = Jxx_tot + Jxx(i,j)*spin_conf(i)*spin_conf(j)
        end
    end
    
    % Find Jzzz en terms
    for i = 1:length(Jzzz)
        for j = i:length(Jzzz)
            for k = j:length(Jzzz)
                Jzzz_tot = Jzzz_tot + Jzzz(i,j,k)*spin_conf(i)*spin_conf(j)*spin_conf(k)
            end
        end
    end
    
    % Find Jxxx en terms
    for i = 1:length(Jxxx)
        for j = i:length(Jxxx)
            for k = j:length(Jxxx)
                Jxxx_tot = Jxxx_tot + Jxxx(i,j,k)*spin_conf(i)*spin_conf(j)*spin_conf(k)
            end
        end
    end
    
    out = h_tot + Jzz_tot + Jxx_tot + Jzzz_tot + Jxxx_tot
        
        
        
    
    
