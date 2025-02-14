function [scrsz,scrOffSet_x,scrOffSet_y] = subScreenSizeCalc(scrszIn,subScreenId)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%preset scrsz -> overwrite specific values based on case
scrsz = scrszIn;

switch subScreenId
    case 'full'
        scrOffSet_x = 0;
        scrOffSet_y = 0;
    %half
    case 'left'
        scrsz(3) = floor(scrszIn(3)./2); % width/2
        scrOffSet_x = 0;
        scrOffSet_y = 0;
    case 'right'
        scrsz(3) = floor(scrszIn(3)./2); % width/2
        scrOffSet_x = floor(scrszIn(3)./2); % width/2
        scrOffSet_y = 0;
    case 'top'
        scrsz(4) = floor(scrszIn(4)./2); % height/2
        scrOffSet_x = 0;
        scrOffSet_y = floor(scrszIn(4)./2); % height/2
    case 'bottom'
        scrsz(4) = floor(scrszIn(4)./2); % height/2
        scrOffSet_x = 0;
        scrOffSet_y = 0;
    %quarter
    case 'topleft'
        scrsz(3:4) = floor(scrszIn(3:4)./2); % width/2 & height/2
        scrOffSet_x = 0;
        scrOffSet_y = floor(scrszIn(4)./2); % height/2
    case 'topright'        
        scrsz(3:4) = floor(scrszIn(3:4)./2); % width/2 & height/2
        scrOffSet_x = floor(scrszIn(3)./2); % width/2
        scrOffSet_y = floor(scrszIn(4)./2); % height/2
    case 'bottomleft'
        scrsz(3:4) = floor(scrszIn(3:4)./2); % width/2 & height/2
        scrOffSet_x = 0;
        scrOffSet_y = 0;
    case 'bottomright'
        scrsz(3:4) = floor(scrszIn(3:4)./2); % width/2 & height/2
        scrOffSet_x = floor(scrszIn(3)./2); % width/2
        scrOffSet_y = 0;
    %third (vertical)
    case 'lthird'
        scrsz(3) = floor(scrszIn(3)./3); % width/3
        scrOffSet_x = 0;
        scrOffSet_y = 0;
    case 'mthird'
        scrsz(3) = floor(scrszIn(3)./3); % width/3
        scrOffSet_x = floor(scrszIn(3)./3); % width/3 
        scrOffSet_y = 0;
    case 'rthird'
        scrsz(3) = floor(scrszIn(3)./3); % width/3
        scrOffSet_x = 2*floor(scrszIn(3)./3); % 2x width/3 
        scrOffSet_y = 0;
    %quart (vertical)
    case 'llquart'
        scrsz(3) = floor(scrszIn(3)./4); % width/4
        scrOffSet_x = 0;
        scrOffSet_y = 0;
    case 'lquart'
        scrsz(3) = floor(scrszIn(3)./4); % width/4
        scrOffSet_x = floor(scrszIn(3)./4); % width/4
        scrOffSet_y = 0;
    case 'rquart'
        scrsz(3) = floor(scrszIn(3)./4); % width/4
        scrOffSet_x = 2*floor(scrszIn(3)./4); % 2x width/4
        scrOffSet_y = 0;
    case 'rrquart'
        scrsz(3) = floor(scrszIn(3)./4); % width/4
        scrOffSet_x = 3*floor(scrszIn(3)./4); % 3x width/4
        scrOffSet_y = 0;
end

end