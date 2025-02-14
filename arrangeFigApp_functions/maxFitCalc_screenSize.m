function [gridFigs_preset, tileFigs_preset, offStackFigs_preset] = maxFitCalc_screenSize(subScreenId)
%Calculate presets for figure arrangement on screen for max fit
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
    %maximizes the grid to fit 125x100 pixel images 
    gridFigs_preset.colOffSet = 0;
    gridFigs_preset.rowOffSet = 0;
    gridFigs_preset.xborder = 0;
    gridFigs_preset.yborder = 0;
    gridFigs_preset.nCol = floor((scrsz(3)-2*gridFigs_preset.xborder)./125);
    gridFigs_preset.nRow = floor((scrsz(4)-2*gridFigs_preset.yborder-125)./(100+80));

%for tileFigs
    % 125x100 px images preset as min useful
    tileFigs_preset.xlen = 125;
    tileFigs_preset.ylen = 100;
    tileFigs_preset.colOffSet = 0;
    tileFigs_preset.rowOffSet = 0;
    tileFigs_preset.xborder = 0;
    tileFigs_preset.yborder = 0;
    
%for offStackFigs
    % 125x1 px as min image size to tile
    offStackFigs_preset.xlen = 125;
    offStackFigs_preset.ylen = 1;
    offStackFigs_preset.xOffSet = 0;
    offStackFigs_preset.yOffSet = 25;
    offStackFigs_preset.xborder = 0;
    offStackFigs_preset.yborder = 0;
    offStackFigs_preset.colOffSet = 0;

end