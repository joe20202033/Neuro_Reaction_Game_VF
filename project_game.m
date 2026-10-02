% =========================================================================
% GAME HEADER INFORMATION & DOCUMENTATION
% =========================================================================
% Program Name:           game_VF.m
% Context & Course:       M1 Neuroscience - UE TechnEx (Université Claude Bernard Lyon 1)
% Authors & Contribution: Lead Developer (Game Architecture, GUI, Signal Processing)
% Code & Octave Version:  GNU Octave v11.3.0
% Date:                   02-Oct-2026 (DD-MMM-YYYY format)
% AI/Sound/Image Sources: Built-in Octave graphics library & audio synthesizer (beep)
%
% -------------------------------------------------------------------------
% 1. SCIENTIFIC RATIONALE & MOTIVATION ("Why we thought about it")
% -------------------------------------------------------------------------
% In cognitive neuroscience, measuring visual reaction time and decision-
% making precision under time pressure is a foundational metric for assessing 
% selective attention, inhibitory control, and motor execution speeds. 
% We designed this task as a standalone interactive visual discrimination game 
% to simulate classic laboratory choice reaction time (CRT) protocols. By 
% introducing a target (Green) alongside a distractor (Red) at unpredictable 
% time intervals, the game forces the player's brain to quickly process 
% visual input, suppress the impulse to click the distractor, and execute 
% a precise target response.
%
% -------------------------------------------------------------------------
% 2. GAME STRUCTURE & ARCHITECTURE
% -------------------------------------------------------------------------
% The program is structured into five distinct functional phases:
%   Phase I:   Initialization & Guidance - Clears the workspace, resets graphics,
%              and displays clear instructions to the user.
%   Phase II:  Randomized Delay (Inter-Trial Interval) - Introduces an unpredictable
%              1.0 to 2.5-second waiting window to prevent anticipation bias.
%   Phase III: Stimulus Presentation - Simultaneously displays Green (target) and
%              Red (distractor) circles at non-overlapping random coordinates while
%              triggering an auditory cue (beep).
%   Phase IV:  Data Capture & Scoring - Captures click coordinates and exact reaction
%              time via high-resolution timers (tic/toc), evaluates spatial distance, 
%              and updates the running score.
%   Phase V:   Session Summary & Export - Computes performance metrics, saves the
%              trial matrix to 'game_results.mat', and presents a replay prompt.
%
% -------------------------------------------------------------------------
% 3. PLAIN-ENGLISH VARIABLE GLOSSARY (Easy-to-understand definitions)
% -------------------------------------------------------------------------
% - replay_game    : A True/False switch that keeps the game running as long
%                    as the player wants to continue playing.
% - total_trials   : The fixed number of rounds (5) played in a single game session.
% - score          : The player's current total points accummulated across rounds.
% - time_limit     : The maximum allowed time (2.0 seconds) for a player to respond.
% - results        : A memory grid (table) storing reaction times and hit outcomes.
% - fig            : The popup visual window where the game grid and targets appear.
% - trial          : The current round number (from 1 to 5).
% - pause_delay    : A randomized waiting duration before targets pop up.
% - green_x / y    : Horizontal and vertical map coordinates for the Green target.
% - red_x / y      : Horizontal and vertical map coordinates for the Red distractor.
% - click_x / y    : The exact horizontal and vertical positions where the user clicked.
% - button         : Stores which mouse button was pressed during input.
% - rt             : "Reaction Time" - The precise time (in seconds) the user took to click.
% - dist_green     : Distance between user's mouse click and the Green circle center.
% - dist_red       : Distance between user's mouse click and the Red circle center.
% - valid_rts      : A list containing only reaction times from successful Green hits.
% - avg_rt         : The average reaction time calculated from all successful hits.
% - script_path    : Auto-detected folder location where this code file is saved.
% - save_file      : Full folder location indicating where game_results.mat is written.
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
        total_trials = 5;                           % Number of rounds per session
        score = 0;                                   % Initial player score
        time_limit = 2.0;                            % Max time to react (seconds)
        results = zeros(total_trials, 2);            % Store [ReactionTime, HitStatus]
        
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
            
            % Random delay before pop-up (between 1.0 and 2.5 seconds)
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
            
            % Sound signal for pop-up stimulus
            beep();
            
            % Start precise reaction timer
            tic;
            [click_x, click_y, button] = ginput(1);
            rt = toc; % Record reaction time
            
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
        
        % Automatically locate the Project folder and force saving inside it
        script_path = mfilename('fullpath');
        if ~isempty(script_path)
            target_dir = fileparts(script_path);
        else
            target_dir = pwd;
        end
        
        save_file = fullfile(target_dir, 'game_results.mat');
        save(save_file, 'results', 'score');
        
        fprintf('\n=================================================\n');
        fprintf('SUCCESS: Results file created at:\n%s\n', save_file);
        fprintf('=================================================\n\n');
        
        % Ask for Replay
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
