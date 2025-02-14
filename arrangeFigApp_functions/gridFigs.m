function gridFigs(nCol, nRow, colOffSet, rowOffSet, xborder, yborder, subScreenId)
%Arranges all open figures in the spcified grid (nRow,nCol) [if they fit]
%   Based on the screen size - reduced by a safe space (xborder & yborder) -
%   up to nRow*nCol figures are resized to fit the grid, with (colOffSet, 
%   rowOffSet) as space in between figures.  
%
%   nCol        number of cols for the grid (default 3)
%   nRow        number of rows for the grid (defualt 2)
%   xoffSet     horizontal shift of the figures in px (default 0)
%   yoffSet     vertical shift of the figures in px (default 0)
%   xborder     border in px on the left & right edge of the frame (default 25)
%   yborder     border in px on the top & bottom edge of the frame (default 25)
%
%   Note: all values are given in pixels (px). 

% Markus Altthaler, Oct. 2023


arguments
    nCol        {mustBeNumeric,mustBePositive}=3
    nRow        {mustBeNumeric,mustBePositive}=2
    colOffSet   {mustBeNumeric,mustBeNonnegative}=0
    rowOffSet   {mustBeNumeric,mustBeNonnegative}=0
    xborder     {mustBeNumeric,mustBeNonnegative}=25
    yborder     {mustBeNumeric,mustBeNonnegative}=25
    subScreenId {mustBeText} = 'full'
end

%figure head save space
yFigHead = 80;
taksBar_bottom_save = 130;

%screen size & max number of figures 
set(0,'units','pixels') % set unit to pixels (in case it was changed before)
scrsz  = get (0,'screensize'); % determine terminal size in pixels

%calculate size and offset of sub-screen 
[scrsz, scrOffSet_x,scrOffset_y]  = subScreenSizeCalc(scrsz,subScreenId); 

%number of rows and cols: 
maxRow = round(nRow);
maxCol = round(nCol);
maxNumFigs = maxRow*maxCol; 

%calculate xlen and ylen base dof screen size
xlen = floor((scrsz(3)-2*xborder-(maxCol-1)*colOffSet)./maxCol);
ylen = floor((scrsz(4)-2*yborder-taksBar_bottom_save-(maxRow-1)*(rowOffSet+yFigHead))./maxRow);

%open figures & check maxNumFigs
hands   = get (0,'Children');   % locate all open figure handles
numfigs = size(hands,1);        % number of open figures

if (numfigs>maxNumFigs)         % check if actual number of figures exceed the limit
        msg = sprintf(" Error: More than %s figures open! \n Close %s figures or specify a larger grid.", num2str(maxNumFigs),num2str(numfigs-maxNumFigs));
        f = msgbox(msg,"Error","error");
        return
end

%place figures
for n = 1:numfigs
    xpos = scrsz(1) + scrOffSet_x + xborder + mod(n-1,maxCol)*(xlen+colOffSet);
    ypos = scrsz(2) + scrOffset_y + scrsz(4)-yborder-ylen-yFigHead-floor((n-1)./maxCol)*(ylen+rowOffSet+yFigHead);
    set(hands(numfigs+1-n),'Position',[ xpos ypos xlen ylen ]); % move figure
end

end