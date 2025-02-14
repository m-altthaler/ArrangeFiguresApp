function [gridFigs_preset, tileFigs_preset, offStackFigs_preset] = presetCalc_screenSize(subScreenId)
%Calculate presets for figure arrangement on screen
%   Calculates useful presets based on the given screen size
arguments
    subScreenId {mustBeText} = 'full'
end

%screen size
set(0,'units','pixels') % set unit to pixels (in case it was changed before)
scrsz  = get (0,'screensize'); % determine terminal size in pixels
%calculate size and offset of sub-screen 
[scrsz,~,~]  = subScreenSizeCalc(scrsz,subScreenId); 


%for gridFigs

% set borders very small and no gaps between figures
gridFigs_preset.colOffSet = 0;
gridFigs_preset.rowOffSet = 0;
gridFigs_preset.xborder = 5;
gridFigs_preset.yborder = 5;
% set grid variables as:   
switch subScreenId
    case {'full','topleft','topright','bottomleft','bottomright'}
        %min 3x2 or nCol x nRow
        gridFigs_preset.nCol = max(3,floor((scrsz(3)-2*gridFigs_preset.xborder)./560));
        gridFigs_preset.nRow = max(2,floor((scrsz(4)-2*gridFigs_preset.yborder-125)./(480+80)));
    case {'left','right'}
        %min 2x3 or nCol x nRow
        gridFigs_preset.nCol = max(2,floor((scrsz(3)-2*gridFigs_preset.xborder)./560));
        gridFigs_preset.nRow = max(3,floor((scrsz(4)-2*gridFigs_preset.yborder-125)./(480+80)));
    case {'top', 'bottom'}
        %min 3x1 or nCol x nRow
        gridFigs_preset.nCol = max(3,floor((scrsz(3)-2*gridFigs_preset.xborder)./560));
        gridFigs_preset.nRow = max(1,floor((scrsz(4)-2*gridFigs_preset.yborder-125)./(480+80)));
    case {'lthird','mthird','rthird','llquart','lquart','rquart','rrquart'}
        %min 1x3 or nCol x nRow
        gridFigs_preset.nCol = max(1,floor((scrsz(3)-2*gridFigs_preset.xborder)./560));
        gridFigs_preset.nRow = max(3,floor((scrsz(4)-2*gridFigs_preset.yborder-125)./(480+80)));
end 



%for tileFigs

% set borders very small and no gaps between figures
tileFigs_preset.colOffSet = 0;
tileFigs_preset.rowOffSet = 0;
tileFigs_preset.xborder = 5;
tileFigs_preset.yborder = 5;

switch subScreenId
    case {'full','topleft','topright','bottomleft','bottomright'}
        %min 3x2
        tileFigs_preset.xlen = min(560,floor((scrsz(3)-(2*tileFigs_preset.xborder))./3));
        tileFigs_preset.ylen = min(480,floor((scrsz(4)-(2*tileFigs_preset.yborder)-125-(2*80))./2));
    case {'left','right'}
        %min 2x3
        tileFigs_preset.xlen = min(560,floor((scrsz(3)-(2*tileFigs_preset.xborder))./2));
        tileFigs_preset.ylen = min(480,floor((scrsz(4)-(2*tileFigs_preset.yborder)-125-(3*80))./3));
    case {'top', 'bottom'}
        %min 3x1
        tileFigs_preset.xlen = min(560,floor((scrsz(3)-(2*tileFigs_preset.xborder))./3));
        tileFigs_preset.ylen = min(480,floor((scrsz(4)-(2*tileFigs_preset.yborder)-125-80)./1));
    case {'lthird','mthird','rthird','llquart','lquart','rquart','rrquart'}
        %min 1x3
        tileFigs_preset.xlen = min(560,floor((scrsz(3)-(2*tileFigs_preset.xborder))./1));
        tileFigs_preset.ylen = min(480,floor((scrsz(4)-(2*tileFigs_preset.yborder)-125-3*80)./3));
end        


%for offStackFigs

%default case for 560x420px stacked figs
offStackFigs_preset.xOffSet = 0;
offStackFigs_preset.yOffSet = 25;
offStackFigs_preset.xborder = 5;
offStackFigs_preset.yborder = 5;
offStackFigs_preset.colOffSet = 0;

%check if at least 1 figure can be placed - or reduce size
if scrsz(3)<560+10+1
    offStackFigs_preset.xlen = scrsz(3)-2*offStackFigs_preset.xborder;
else
    offStackFigs_preset.xlen = 560;
end

if scrsz(4)<420+10+125+1
    offStackFigs_preset.ylen = scrsz(4)-2*offStackFigs_preset.yborder-125;
else
    offStackFigs_preset.ylen = 420;
end

%function end
end