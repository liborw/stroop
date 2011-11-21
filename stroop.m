function trials = stroop()
%STROOP The Stroop test
%
% SINOPSIS
% INPUTS

NTRIALS = 10;
WORDS = {'èervená', 'modrá', 'zelená', 'fialová'};
COLORS = {'red', 'blue', 'green', 'cyan'};
KEYS = 'cmzf';


% Create Interface window
h = figure();
set(h, 'NumberTitle', 'off', ...
       'Name', 'Stroop Test', ...
       'Color', 'black', ...
       'MenuBar','none', ...
       'ToolBar', 'none');

% Show instructions
string = {['Lorem Ipsum is simply dummy text of the printing and',...
          ' typesetting industry. Lorem Ipsum has been the industrys',...
          ' standard dummy text ever since the 1500s, when an unknown',...
          ' printer took a galley of type and scrambled it to make a',...
          ' type specimen book [press any key to start]']};

% Display instruction
ht = show_text(h, string);
waitforspace(h);
delete(ht);

% Session variables
ntrials = 0; % Number of trials already preformed
nmixed  = 0; % Number of mixed trials
nerrors = 0; % Number of incorrect replies
trials  = cell(0,4);

% Start test
while ntrials < NTRIALS

    % Chose between normal or mixed
    mixed = rand() > (nmixed/(ntrials - nmixed))/2;

    % Create trial
    perm = randperm(4);
    iStimul = perm(1);
    iNoise = iif(mixed, perm(2), perm(1));

    % Pause for 1 + (0-2) s and display
    pause(0.5 + rand*2);
    ht = show_text(h, WORDS(iNoise), 'FontSize', 40, 'ForegroundColor', COLORS{iStimul});
    tic;

    % Wait for user input
    waitforbuttonpress;
    rtime = toc;
    ch = get(h, 'CurrentCharacter');
    delete(ht);

    if ch == KEYS(iStimul)
        ntrials = ntrials + 1;
        if mixed, nmixed = nmixed + 1; end;
        ht = show_text(h, {'correct'}, 'ForegroundColor', 'green');
    else
        nerrors = nerrors + 1;
        ht = show_text(h, {'incorrect'}, 'ForegroundColor', 'red');
    end

    % Store result
    trials{end+1, 1} = KEYS(iStimul);
    trials{end, 2} = KEYS(iNoise);
    trials{end, 3} = ch;
    trials{end, 4} = rtime;

    % Show result for 0.5 s and continue
    pause(0.5);
    delete(ht);
end

% Some stats
fprintf('# correct trials:   %d\n', ntrials);
fprintf('# mixed trials:     %d\n', nmixed);
fprintf('ratio mixed/normal: %0.3f\n', nmixed/(ntrials-nmixed));
fprintf('# all trials:       %d\n', size(trials, 1));
fprintf('# incorrect trials: %d\n', nerrors);


delete(h);
end

function waitforspace(h)

waitforbuttonpress;
key = get(h, 'CurrentKey');
while ~strcmp(key, 'space')
    waitforbuttonpress;
    key = get(h, 'CurrentKey');
end

end

function handle = show_text(parrent, string, varargin)

parpos = get(parrent, 'Position');
pos = [5 round(parpos(4)/2)-30 parpos(3)-10 60];

handle = uicontrol(parrent,...
    'Style','Text',...
    'BackgroundColor', 'black',...
    'ForegroundColor', 'white',...
    'Position', pos,...
    'FontUnits', 'pixels');

if length(varargin) > 0, set(handle, varargin{:}), end;
fontsize = get(handle, 'FontSize');

[outstring,newpos] = textwrap(handle,string);
height = length(outstring) * 1.1 * fontsize;
pos = [5 round(parpos(4)/2)-round(height/2) parpos(3)-10 height];
set(handle,'String',outstring,'Position', pos);
drawnow;

end

function ret = iif(test, valif, valelse)

if test
    ret = valif;
else
    ret = valelse;
end

end


