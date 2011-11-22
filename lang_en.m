% English localization
lang = struct();
lang.instructions = {['You will be shown words, one at a time, printed in different colors.',...
                      ' Press r for word printed in red, g for green, b for blue and m for',...
                      ' magenta. Try to be as fast as possible but correct.'], ['[new press space',...
                      ' to start the experiment]']};

lang.correct = {'correct'};
lang.incorrect = {'incorrect'};

lang.words = {'red', 'green', 'blue', 'magenta'};
lang.colors = lang.words;
lang.keys = 'rgbm';
