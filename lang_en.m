% English localization
lang = struct();
lang.instructions = {['You will be shown words, one at a time, printed in different colors.',...
                      ' Press r for word printed in red, g for green, b for blue and m for',...
                      ' magenta. Try to be as fast as possible but correct.'], ['[now press space',...
                      ' to start the experiment]']};

lang.correct = {'correct'};
lang.incorrect = {'incorrect'};

lang.words = {'red', 'green', 'blue', 'magenta'};
lang.colors = lang.words;
lang.keys = 'rgbm';
lang.label_agree = 'Agreeing  stimulus';
lang.label_differ = 'Differing stimulus';
lang.xlabel = 'Reaction time (s)';
lang.ylabel = 'Normalized frequency';
lang.current_results = 'Current results';
lang.overall_results = 'Overall results of %d experiments';

