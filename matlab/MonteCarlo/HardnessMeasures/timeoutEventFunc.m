function timeoutEventFunc( hTimer, eventData )
% Function to raise timeout flag
        global timeoutFlag;
        timeoutFlag = true;     
        error('Warning: Woooo BROOO!! Time out brooo!');
end

