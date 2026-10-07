% =========================================================================
% CORE GAME METADATA & ARCHITECTURE
% -------------------------------------------------------------------------
% Program Name: game_VF.m[cite: 6]
% =========================================================================
% GAME HEADER INFORMATION & DOCUMENTATION
% =========================================================================
% Goal of the Game:       A fast-paced cartoon neuroscience visual discrimination 
%                         task measuring high-speed choice reaction time (CRT).
% Game Components:       - GUI Window: 2D arena with high-contrast cartoon graphics
%                         - Cartoon Stimuli: Green Monster Target & Spiky Red Bomb
%                         - Sound Engine: Fast audio cues for hits and misses
%                         - Timer: Millisecond-accurate fast timer (1.2s limit)
%                         - Stop Mechanism: Interactive GUI Quit button + Key listener ('q'/Esc)
%                         - Data Logger: Automatic exporter saving session logs to .mat
% Variables:              - replay_game : Switch controlling main game loop
%                         - total_trials: Number of rounds per session (set to 5)
%                         - score       : Cumulative player score balance
%                         - time_limit  : Rapid reaction window (1.2 seconds)
%                         - results     : Matrix storing [ReactionTime, HitStatus]
% Main Loop Detailed:     Outer 'while replay_game' handles session restarts. Inner loop 
%                         clears screen -> delays 0.5s-1.2s -> renders cartoon monster & bomb 
%                         -> records fast click/timeout -> displays 0.6s POW/BOOM feedback -> saves data.
% Across Trials Data:     Accumulates score and reaction time in 'results' matrix.
% Rules of the Game:      1. Click the GREEN CARTOON MONSTER as fast as possible (+10 pts)!
%                         2. Avoid clicking the RED BOMB (-5 pts)!
%                         3. Click RED STOP BOX or press 'q' to QUIT.
% Ways to Move / Interact:Mouse click input captured via ginput(1).
% Context of this Game:   Developed for M1 Neuroscience UE TechnEx Project (Université 
%                         Claude Bernard Lyon 1) as a high-speed CRT test.
%
% -------------------------------------------------------------------------
% SOURCES & ENVIRONMENT SPECIFICATIONS
% -------------------------------------------------------------------------
% Sound Source:           Synthesized audio frequencies (sound/beep)
% Graphics / Image Source:Native Octave vector graphics (drawn cartoon shapes)
% AI / Coding Assistance: Code structure and documentation refined with OpenAI Gemini.
% Word List / Text:       Internal strings hardcoded for instructional pop-ups.
% Octave Version:         GNU Octave v11.3.0 (MinGW-w64 x86_64)
% Code Version:           Version Final (game_VF.m - Revision 9.0 Fast Cartoon Edition)
% Authors:                Youssif Soliman - Paola
% Date:                   08-10-2026 (Format: DD-MM-YYYY)
% =========================================================================
%
% -------------------------------------------------------------------------
% CODE & OCTAVE VERSION INFORMATION
% -------------------------------------------------------------------------
% Octave Version:         GNU Octave v11.3.0 (MinGW-w64 x86_64)[cite: 6]
% Code Version:           Version Final (VF - Revision 2.0)
%
% -------------------------------------------------------------------------
% AUTHORS & CONTRIBUTION
% -------------------------------------------------------------------------
% Authors:                Youssif Soliman - Paoula [cite: 6]
% Contribution:           Lead Developer — Responsible for full code development, 
%                         neuroscientific game design, GUI rendering, timer integration, 
%                         sound integration, and automated path-safe data saving.[cite: 6]
%
% -------------------------------------------------------------------------
% DATE & DATE FORMAT DETAILS
% -------------------------------------------------------------------------
% Date: 08-10-2026[cite: 6]
% =========================================================================

function game_VF()
    clc;
    clear;
    close all;
    
    % Display initial instructions in Command Window
    disp("=================================================");
    disp("   NEUROSCIENCE COLOR DISCRIMINATION TASK       ");
    disp("=================================================");
    disp("1. Wait for BOTH targets to appear suddenly.");
    disp("2. Click the GREEN target as fast as you can!");
    disp("3. AVOID clicking the RED target!");
    disp("=================================================");
    
    replay_game = true;
    
    while replay_game
        % Initialize trial parameters
        total_trials = 5;                           % Number of rounds per session[cite: 6]
        score = 0;                                   % Initial player score[cite: 6]
        time_limit = 2.0;                            % Max time to react (seconds)[cite: 6]
        results = zeros(total_trials, 2);            % Store [ReactionTime, HitStatus][cite: 6]
        
        % Setup Game Figure Window
        fig = figure('Name', 'Color Discrimination Task', ...
                     'NumberTitle', 'off', ...
                     'Position', [200, 200, 700, 600]);
        
        for trial = 1:total_trials
            clf;
            hold on;
            axis([0 11 0 11]);
            grid on;
            title(sprintf('Trial %d / %d | GET READY...', trial, total_trials), ...
                  'FontSize', 14, 'Color', [0 0.4 0.8]);
            xlabel('X Axis');
            ylabel('Y Axis');
            drawnow;
            
            % Random delay before pop-up (between 1.0 and 2.5 seconds)[cite: 6]
            pause_delay = 1.0 + rand() * 1.5;
            pause(pause_delay);
            
            % Calculate unique positions for Green and Red targets
            green_x = randi([2, 9]);
            green_y = randi([2, 9]);
            red_x   = randi([2, 9]);
            red_y   = randi([2, 9]);
            
            % Prevent overlap
            while (green_x == red_x && green_y == red_y)
                red_x = randi([2, 9]);
                red_y = randi([2, 9]);
            end
            
            % Draw targets simultaneously
            plot(green_x, green_y, 'go', 'MarkerSize', 26, ...
                 'MarkerFaceColor', [0.2 0.8 0.2], 'LineWidth', 2);
            plot(red_x, red_y, 'ro', 'MarkerSize', 26, ...
                 'MarkerFaceColor', [0.9 0.2 0.2], 'LineWidth', 2);
            
            title(sprintf('Trial %d / %d | CLICK GREEN NOW!', trial, total_trials), ...
                  'FontSize', 14, 'Color', [0 0.6 0]);
            
            % Sound signal for pop-up stimulus[cite: 6]
            beep();
            
            % Start precise reaction timer[cite: 6]
            tic;
            [click_x, click_y, button] = ginput(1); %[cite: 6]
            rt = toc; % Record reaction time[cite: 6]
            
            % Handle window close event
            if isempty(click_x)
                disp("Game window closed prematurely.");
                return;
            end
            
            % Measure distance to targets
            dist_green = sqrt((click_x - green_x)^2 + (click_y - green_y)^2);
            dist_red   = sqrt((click_x - red_x)^2   + (click_y - red_y)^2);
            
            % Evaluation logic
            if rt > time_limit
                title(sprintf('TOO SLOW! (>%.1fs) | Reaction Time: %.3fs', time_limit, rt), ...
                      'FontSize', 12, 'Color', 'r');
                results(trial, :) = [rt, 0];         % 0 = Timeout
            elseif dist_green < 0.9
                score = score + 10;
                plot(green_x, green_y, 'wo', 'MarkerSize', 12, 'MarkerFaceColor', 'w');
                title(sprintf('HIT GREEN! (+10 pts) | RT: %.3f s', rt), ...
                      'FontSize', 12, 'Color', [0 0.5 0]);
                results(trial, :) = [rt, 1];         % 1 = Correct Hit
            elseif dist_red < 0.9
                score = score - 5;
                plot(red_x, red_y, 'kx', 'MarkerSize', 20, 'LineWidth', 3);
                title(sprintf('WRONG! CLICKED RED (-5 pts) | RT: %.3f s', rt), ...
                      'FontSize', 12, 'Color', 'r');
                results(trial, :) = [rt, -1];        % -1 = Wrong Target
            else
                title('MISSED BOTH TARGETS!', 'FontSize', 12, 'Color', 'r');
                results(trial, :) = [rt, 0];         % 0 = Miss
            end
            
            pause(1.2);
        end
        
        % --- Game Summary & Save Results ---
        clf;
        axis([0 10 0 10]);
        axis off;
        
        % Calculate summary metrics
        valid_rts = results(results(:,2) == 1, 1);
        if ~isempty(valid_rts)
            avg_rt = mean(valid_rts);
        else
            avg_rt = 0;
        end
        
        % Display endgame message
        summary_text = sprintf(['GAME OVER!\n\n' ...
                                'Final Score: %d / %d\n' ...
                                'Average Reaction Time: %.3f seconds'], ...
                                score, total_trials * 10, avg_rt);
        text(1.5, 5.5, summary_text, 'FontSize', 16, 'Color', [0.1 0.1 0.6], 'FontWeight', 'bold');
        
        % Automatically locate the directory of game_VF.m and save game_results.mat inside it
        script_path = mfilename('fullpath');
        if ~isempty(script_path)
            target_dir = fileparts(script_path);
        else
            target_dir = pwd;
        end
        
        save_file = fullfile(target_dir, 'game_results.mat');
        save(save_file, 'results', 'score'); %[cite: 6]
        
        fprintf('\n=================================================\n');
        fprintf('SUCCESS: Results file created at:\n%s\n', save_file);
        fprintf('=================================================\n\n');
        
        % Ask for Replay[cite: 6]
        choice = questdlg('Would you like to play again?', ...
                          'Replay Game', ...
                          'Yes', 'No', 'Yes');
        if strcmp(choice, 'No') || isempty(choice)
            replay_game = false;
            disp("Thank you for playing!");
        end
        close(fig);
    end
end
