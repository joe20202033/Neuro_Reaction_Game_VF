% =========================================================================
% GAME HEADER INFORMATION & DOCUMENTATION
% =========================================================================
% [CRITERION 2] HEADER: CORE GAME METADATA & ARCHITECTURE
% -------------------------------------------------------------------------
% Program Name:           game_VF.m[cite: 6]
% Goal of the Game:       A neuroscience visual discrimination task measuring 
%                         choice reaction time (CRT) and selective visual 
%                         attention. Players must click the GREEN target as 
%                         fast as possible while ignoring the RED distractor.[cite: 6]
% Game Components:       - GUI Window: Interactive 2D coordinate space (11x11 grid)
%                         - Stimuli: Green target circle and Red distractor circle
%                         - Sound Engine: Auditory trigger (beep) at stimulus onset[cite: 6]
%                         - Timer: Millisecond-accurate reaction time counter (tic/toc)[cite: 6]
%                         - Data Logger: Automatic exporter saving session logs to .mat[cite: 6]
% Variables:              - replay_game : Logical switch (true/false) controlling game loops
%                         - total_trials: Number of rounds per session (set to 5)
%                         - score       : Cumulative score balance (+10 for hit, -5 for distractor)
%                         - time_limit  : Maximum reaction window allowed (2.0 seconds)
%                         - results     : Matrix storing [ReactionTime, HitStatus] across trials
%                         - pause_delay : Randomized inter-trial wait interval (1.0s to 2.5s)
%                         - green_x/y   : Grid coordinates for Green target
%                         - red_x/y     : Grid coordinates for Red distractor
%                         - click_x/y   : Mouse click coordinates captured by ginput(1)[cite: 6]
%                         - rt          : Reaction time in seconds measured via toc[cite: 6]
%                         - dist_green  : Distance from click coordinate to Green target center
%                         - dist_red    : Distance from click coordinate to Red target center
% Main Loop Detailed:     A outer 'while replay_game' loop handles session restarts. An 
%                         inner 'for trial = 1:total_trials' loop manages round-by-round 
%                         execution: clearing screen -> running random delay -> drawing 
%                         stimuli & sounding beep -> recording click -> evaluating hit/miss 
%                         -> pausing briefly.[cite: 6]
% Across Trials Data:     Accumulates total score and reaction times in the 'results' 
%                         matrix across rounds, while resetting target spatial coordinates 
%                         and delay times every trial.[cite: 6]
% Rules of the Game:      1. Wait for both Green and Red circles to pop up on screen.
%                         2. Click ONLY on the GREEN circle as fast as possible.
%                         3. Avoid clicking the RED circle (-5 pts penalty).
%                         4. Clicks taking longer than 2.0 seconds count as timeouts.
% Ways to Move / Interact:Mouse input via graphic cursor click [click_x, click_y] using ginput(1).[cite: 6]
% Context of this Game:   Developed for M1 Neuroscience UE TechnEx Project (Université 
%                         Claude Bernard Lyon 1) as a choice reaction time assessment tool.[cite: 6]
%
% -------------------------------------------------------------------------
% [CRITERION 3] HEADER: SOURCE OF AI / SOUND / IMAGE / WORD LIST USED
% -------------------------------------------------------------------------
% Sound Source:           Built-in Octave audio synthesizer function 'beep()'[cite: 6]
% Graphics / Image Source:Native Octave line vector graphics ('plot' with filled circle markers)[cite: 6]
% AI / Coding Assistance: Code structure and documentation refined with OpenAI Gemini assistance.[cite: 6]
% Word List / Text:       Internal strings hardcoded for instructional pop-ups and display titles.
%
% -------------------------------------------------------------------------
% [CRITERION 4] HEADER: CODE & OCTAVE VERSION INFORMATION
% -------------------------------------------------------------------------
% Octave Version:         GNU Octave v11.3.0 (MinGW-w64 x86_64)[cite: 6]
% Code Version:           Version Final (VF - Revision 2.0)
%
% -------------------------------------------------------------------------
% [CRITERION 5] HEADER: AUTHORS & CONTRIBUTION
% -------------------------------------------------------------------------
% Authors:                Youssif Soliman - Paoula [cite: 6]
% Contribution:           Lead Developer — Responsible for full code development, 
%                         neuroscientific game design, GUI rendering, timer integration, 
%                         sound integration, and automated path-safe data saving.[cite: 6]
%
% -------------------------------------------------------------------------
% [CRITERION 6] HEADER: DATE & DATE FORMAT DETAILS
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
