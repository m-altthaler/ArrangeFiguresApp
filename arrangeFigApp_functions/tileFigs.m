function tileFigs(xlen, ylen, colOffSet, rowOffSet, xborder, yborder, subScreenId)
%Tiles the screen with all open figures in the spcified size (if they fit)
%   Based on the screen size - reduced by a safe space (colOffSet & rowOffSet) -
%   up to a maximum number of figures that can fit the screen, the figures
%   are resized to the dimension (xlen, ylen) and placed with spacing
%   (xoffSet, yoffSet). 
%
%   xlen        width of the figures in px (default 560)
%   ylen        height of the figures in px (default 420)
%   colOffSet   horizontal offset between the figures in px (default 0)
%   rowOffSet   vertical offset between the figures in px (default 0)
%   xborder     border in px on the left & right edge of the frame (default 25)
%   yborder     border in px on the top & bottom edge of the frame (default 25)
%
%   Note: all values are given in pixels (px). 

% Markus Altthaler, Oct. 2023


arguments
    xlen        {mustBeNumeric,mustBePositive}=560
    ylen        {mustBeNumeric,mustBePositive}=420
    colOffSet   {mustBeNumeric,mustBeNonnegative}=0
    rowOffSet   {mustBeNumeric,mustBeNonnegative}=0
    xborder     {mustBeNumeric,mustBeNonnegative}=25
    yborder     {mustBeNumeric,mustBeNonnegative}=25
    subScreenId {mustBeText} = 'full'
end

%figure head save space
yFigHead = 80;
taksBar_bottom_save = 50;

%screen size & max number of figures 
set(0,'units','pixels') % set unit to pixels (in case it was changed before)
scrsz  = get (0,'screensize'); % determine terminal size in pixels

%calculate size and offset of sub-screen 
[scrsz, scrOffSet_x,scrOffset_y]  = subScreenSizeCalc(scrsz,subScreenId); 

%claculate number of rows and cols:
maxRow = floor((scrsz(4)-2*yborder-taksBar_bottom_save-ylen-yFigHead)./(ylen+rowOffSet+yFigHead))+1; 
maxCol = floor((scrsz(3)-2*xborder-xlen)./(xlen+colOffSet))+1; 
maxNumFigs = maxRow*maxCol; 

%open figures & check maxNumFigs
hands   = get (0,'Children');   % locate all open figure handles
numfigs = size(hands,1);        % number of open figures

if (numfigs>maxNumFigs)         % check if actual number of figures exceed the limit
        msg = sprintf(" Error: More than %s figures open! \n Close %s figures or specify a reduced figure size.", num2str(maxNumFigs),num2str(numfigs-maxNumFigs));
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