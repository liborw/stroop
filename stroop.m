function stroop()
%STROOP The Stroop test
%
% SINOPSIS
% INPUTS

% Create Interface window
h = figure();
set(h, 'NumberTitle', 'off', 'Name', 'Stroop Test');
set(h, 'Color', 'black');
set(h, 'MenuBar','none', 'ToolBar', 'none');

% Show instructions
string = {['Lorem Ipsum is simply dummy text of the printing and',...
          ' typesetting industry. Lorem Ipsum has been the industrys',...
          ' standard dummy text ever since the 1500s, when an unknown',...
          ' printer took a galley of type and scrambled it to make a',...
          ' type specimen book [press any key to start]']};

ht = show_text(h, string);

waitforbuttonpress;
delete(ht)

% Start test

end

function handle = show_text(parrent, string, varargin)

parpos = get(parrent, 'Position');
pos = [5 round(parpos(4)/2)-30 parpos(3)-10 60];

handle = uicontrol(parrent,... 
    'Style','Text',...
    'BackgroundColor', 'white',...
    'ForegroundColor', 'black',...
    'Position', pos);

[outstring,newpos] = textwrap(handle,string);
pos = [5 round(parpos(4)/2)-round(newpos(4)/2) parpos(3)-10 newpos(4)];
set(handle,'String',outstring,'Position', pos, varargin{:});

end

