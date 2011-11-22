function trials = stroop(lang)
%STROOP The Stroop test
%
% SINOPSIS
% INPUTS

% Load language
eval(['lang_' lang]);

% Options
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

% Display instruction
ht = show_text(h, lang.instructions);
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
    ht = show_text(h, lang.words(iNoise),...
                'FontSize', 40,...
                'ForegroundColor', lang.colors{iStimul});
    tic;

    % Wait for user input
    waitforbuttonpress;
    rtime = toc;
    ch = get(h, 'CurrentCharacter');
    delete(ht);

    if ch == lang.keys(iStimul)
        ntrials = ntrials + 1;
        if mixed, nmixed = nmixed + 1; end;
        ht = show_text(h, lang.correct, 'ForegroundColor', 'green');
    else
        nerrors = nerrors + 1;
        ht = show_text(h, lang.incorrect, 'ForegroundColor', 'red');
    end

    % Store result
    trials{end+1, 1} = iStimul;
    trials{end, 2} = iNoise;
    trials{end, 3} = find(lang.keys == ch);
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

% Compute result
mixed = [trials{:,1}] ~= [trials{:,2}];
correct =  [trials{:,1}] == [trials{:,3}];
bins = [0.2:0.3:4];
fDiffer  = hist([trials{mixed & correct, 4}], bins);
fMatch = hist([trials{~mixed & correct, 4}], bins);

% Load data
if exist('stats.mat', 'file')
    load('stats.mat');
    FMatch = FMatch + fMatch;
    FDiffer = FDiffer + fDiffer;
    Count = Count + 1;
else
    FMatch = fMatch;
    FDiffer = fDiffer;
    Count = 1;
end

% Save results
save('stats.mat', 'FMatch', 'FDiffer', 'Count');

% Show results
figure(h);
set(h, 'Color', 'white');
subplot(2,1,1);
    bar(bins, [fMatch/sum(fMatch); fDiffer/sum(fDiffer)]');
    title(lang.current_results);
    xlabel(lang.xlabel);
    ylabel(lang.ylabel);
    legend(lang.label_agree, lang.label_differ);
subplot(2,1,2);
    bar(bins, [FMatch/sum(FMatch); FDiffer/sum(FDiffer)]');
    title(sprintf(lang.overall_results, Count));
    xlabel(lang.xlabel);
    ylabel(lang.ylabel);
    legend(lang.label_agree, lang.label_differ);

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


