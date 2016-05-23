function timeoutEventFunc( hTimer, eventData )
% Function to raise timeout flag
        global timeoutFlag;
        timeoutFlag = true;        
end

