function offStackFigs(xlen, ylen, xOffSet, yOffSet, xborder, yborder, colOffSet, subScreenId)
%Resizes and stacks all open figures in vertical columns on the screen
%   Based on the screen size - reduced by a safe space (xborder & yborder) -
%   up to a maximum number of figures that can fit the screen are placed in
%   vertical columns, so the figure name can be read. The accessible area for 
%   stacking and the relative offset as well as the figure size can be 
%   modified via the optional input parameters listed below: 
%
%   xlen        width of the figures in px (default 560)
%   ylen        height of the figures in px (default 420)
%   xOffSet     horizontal shift of the figures in px (default 0)
%   yOffSet     vertical shift of the figures in px (default 25)
%   xborder     border in px on the left & right edge of the frame (default 25)
%   yborder     border in px on the top & bottom edge of the frame (default 25)
%   coloffSet   determines the distance in px between colums (default 25)
%
%   Note: all values are given in pixels (px). 

% Markus Altthaler, Oct. 2023


arguments
    xlen        {mustBeNumeric,mustBePositive}=560
    ylen        {mustBeNumeric,mustBePositive}=420
    xOffSet     {mustBeNumeric,mustBeNonnegative}=0
    yOffSet     {mustBeNumeric,mustBePositive}=25
    xborder     {mustBeNumeric,mustBeNonnegative}=25
    yborder     {mustBeNumeric,mustBeNonnegative}=25
    colOffSet   {mustBeNumeric,mustBeNonnegative}=25
    subScreenId {mustBeText} = 'full'
end

%figure head save space
yFigHead = 80;
taksBar_bottom_save = 130;

%determine the offset of neighboring columns:
colOffSet = xlen+colOffSet;

%screen size & max number of figures 
set(0,'units','pixels') % set unit to pixels (in case it was changed before)
scrsz  = get (0,'screensize'); % determine terminal size in pixels

%calculate size and offset of sub-screen 
[scrsz, scrOffSet_x,scrOffset_y]  = subScreenSizeCalc(scrsz,subScreenId); 

%calculate number of fig per col
rowNumber = floor((scrsz(4)-2*yborder-taksBar_bottom_save-ylen)./yOffSet)+1;  

%checking which figure exceeds the horizontal limit
m = 1;
while m>0
    xposMax = xborder + (ceil(m./rowNumber)-1)*colOffSet + (mod(m-1,rowNumber))*xOffSet + xlen;
    if xposMax < (scrsz(3) - xborder)
        %fig fits on screen
        m = m+1;
    else
        % m-th figure exceeds limit
        maxNumFigs = m-1;
        break;
    end
end  

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
    xpos = scrsz(1) + scrOffSet_x + xborder + (ceil(n./rowNumber)-1)*colOffSet + (mod(n-1,rowNumber))*xOffSet;
    ypos = scrsz(2) + scrOffset_y + scrsz(4)-yborder-yFigHead-ylen - (mod(n-1,rowNumber))*yOffSet;
    set(hands(numfigs+1-n),'Position',[ xpos ypos xlen ylen ]); % move figure
end

end