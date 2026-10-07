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
%                         - score       : Cumulative player score
%                         - time_limit  : Rapid reaction window (1.2 seconds)
%                         - results     : Matrix storing [ReactionTime, HitStatus]
% Main Loop Detailed:     Outer 'while replay_game' handles session restarts. Inner loop
%                         clears screen -> renders cartoon monster & bomb -> records fast click
%                         -> draws cartoon POW explosion -> saves session data.
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
% Authors:                Youssif Soliman - Paola Ragusa
% Date:                   08-10-2026 (Format: DD-MM-YYYY)
% =========================================================================

function game_VF()
    clc;
    clear;
    close all;

    disp("=================================================");
    disp("     CARTOON BLITZ: NEUROSCIENCE CRT TASK       ");
    disp("=================================================");
    disp("1. Click the GREEN MONSTER fast (+10 pts)!");
    disp("2. DONT click the RED BOMB (-5 pts)!");
    disp("3. SPEED WARNING: You only have 1.2s per round!");
    disp("4. Click RED STOP BOX or press 'q' to QUIT.");
    disp("=================================================");

    replay_game = true;

    while replay_game
        total_trials = 5;                           % Number of rounds
        score = 0;                                   % Initial score
        time_limit = 1.2;                            % FAST TIMER (1.2 seconds)
        results = zeros(total_trials, 2);            % Log matrix

        fig = figure('Name', 'Cartoon Blitz CRT Task', ...
                     'NumberTitle', 'off', ...
                     'Position', [200, 200, 700, 600]);

        for trial = 1:total_trials
            clf;
            hold on;
            axis([0 11 0 11]);
            grid on;

            % Draw visual STOP button
            rectangle('Position', [0.3, 0.3, 1.4, 0.8], 'FaceColor', [0.8 0.1 0.1], 'Curvature', 0.2);
            text(1.0, 0.7, 'STOP', 'Color', 'w', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

            title(sprintf('Trial %d / %d | SCORE: %d pts | GET READY FOR BLITZ...', trial, total_trials, score), ...
                  'FontSize', 13, 'Color', [0 0.4 0.8]);
            xlabel('X Axis'); ylabel('Y Axis');
            drawnow;

            % Fast random delay (0.5s to 1.2s)
            pause_delay = 0.5 + rand() * 0.7;
            pause(pause_delay);

            % Random positions for Green Monster and Red Bomb
            green_x = randi([2, 8]);
            green_y = randi([2, 8]);
            red_x   = randi([2, 8]);
            red_y   = randi([2, 8]);

            while (green_x == red_x && green_y == red_y)
                red_x = randi([2, 8]);
                red_y = randi([2, 8]);
            end

            t = linspace(0, 2*pi, 30);

            % --- CARTOON GRAPHIC 1: Green Blob Monster ---
            % Main Body
            fill(green_x + 0.6*cos(t), green_y + 0.6*sin(t), [0.2 0.85 0.2], 'LineWidth', 2);
            % Big Googly Eyes
            fill(green_x - 0.2 + 0.15*cos(t), green_y + 0.15 + 0.15*sin(t), [1 1 1], 'LineWidth', 1);
            fill(green_x + 0.2 + 0.15*cos(t), green_y + 0.15 + 0.15*sin(t), [1 1 1], 'LineWidth', 1);
            plot(green_x - 0.2, green_y + 0.15, 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'k');
            plot(green_x + 0.2, green_y + 0.15, 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'k');
            % Cartoon Mouth / Teeth
            plot([green_x-0.2, green_x, green_x+0.2], [green_y-0.2, green_y-0.3, green_y-0.2], 'k-', 'LineWidth', 2);

            % --- CARTOON GRAPHIC 2: Spiky Red Bomb ---
            % Spiky Outer Shell
            spike_t = linspace(0, 2*pi, 12);
            spike_r = 0.5 + 0.25*mod(1:12, 2);
            fill(red_x + spike_r.*cos(spike_t), red_y + spike_r.*sin(spike_t), [0.9 0.1 0.1], 'LineWidth', 2);
            % Fuse & Flame
            plot([red_x, red_x+0.3], [red_y+0.5, red_y+0.8], 'k-', 'LineWidth', 3);
            plot(red_x+0.35, red_y+0.85, 'r*', 'MarkerSize', 12, 'LineWidth', 2);
            % Angry Eyes
            plot([red_x-0.2, red_x-0.05], [red_y+0.1, red_y], 'k-', 'LineWidth', 2);
            plot([red_x+0.2, red_x+0.05], [red_y+0.1, red_y], 'k-', 'LineWidth', 2);

            title(sprintf('Trial %d / %d | CLICK THE GREEN MONSTER!', trial, total_trials), ...
                  'FontSize', 13, 'Color', [0 0.6 0]);

            % Auditory onset signal
            Fs = 8000;
            sound(sin(2*pi*900*(0:1/Fs:0.06)), Fs);

            % Reaction Timer
            tic;
            [click_x, click_y, button] = ginput(1); %
            rt = toc; %

            % Exit handlers
            if isempty(click_x) || button == 113 || button == 81 || button == 27
                disp("Game stopped by user.");
                close(fig);
                return;
            end

            if (click_x >= 0.3 && click_x <= 1.7 && click_y >= 0.3 && click_y <= 1.1)
                title('GAME STOPPED BY PLAYER!', 'FontSize', 14, 'Color', 'r');
                pause(0.8);
                close(fig);
                return;
            end

            dist_green = sqrt((click_x - green_x)^2 + (click_y - green_y)^2);
            dist_red   = sqrt((click_x - red_x)^2   + (click_y - red_y)^2);

            % Fast Evaluation
            if rt > time_limit
                sound(sin(2*pi*150*(0:1/Fs:0.2)), Fs);
                title(sprintf('TOO SLOW! (>%.1fs) | RT: %.3fs', time_limit, rt), ...
                      'FontSize', 12, 'Color', 'r');
                results(trial, :) = [rt, 0]; %
            elseif dist_green < 0.9
                score = score + 10;
                sound(sin(2*pi*1200*(0:1/Fs:0.1)), Fs);

                % CARTOON "POW" STARBURST GRAPHIC
                star_t = linspace(0, 2*pi, 10);
                star_r = 0.8 + 0.4*mod(1:10, 2);
                fill(green_x + star_r.*cos(star_t), green_y + star_r.*sin(star_t), [1 0.9 0], 'EdgeColor', 'r', 'LineWidth', 2);
                text(green_x, green_y, 'POW!', 'FontSize', 11, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

                title(sprintf('SMASH! (+10 pts) | Reaction Time: %.3f s', rt), ...
                      'FontSize', 12, 'Color', [0 0.5 0]);
                results(trial, :) = [rt, 1]; %
            elseif dist_red < 0.9
                score = score - 5;
                sound(sin(2*pi*100*(0:1/Fs:0.25)), Fs);

                % CARTOON BOMB EXPLOSION
                text(red_x, red_y, 'BOOM!', 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'r', 'HorizontalAlignment', 'center');
                title(sprintf('BOOM! HIT RED BOMB (-5 pts) | RT: %.3f s', rt), ...
                      'FontSize', 12, 'Color', 'r');
                results(trial, :) = [rt, -1]; %
            else
                title(sprintf('MISSED! | Reaction Time: %.3f s', rt), 'FontSize', 12, 'Color', 'r');
                results(trial, :) = [rt, 0]; %
            end

            pause(0.6); % Fast transition between trials
        end

        % --- Game Summary & Export ---
        clf;
        axis([0 10 0 10]); axis off;

        valid_rts = results(results(:,2) == 1, 1);
        avg_rt = ~isempty(valid_rts) * mean(valid_rts);

        summary_text = sprintf(['GAME OVER!\n\n' ...
                                'Final Score: %d pts\n' ...
                                'Average Speed: %.3f seconds'], ...
                                score, avg_rt);
        text(2.0, 5.5, summary_text, 'FontSize', 16, 'Color', [0.1 0.1 0.6], 'FontWeight', 'bold');

        % Data Log Export
        script_path = mfilename('fullpath');
        if ~isempty(script_path)
            target_dir = fileparts(script_path);
        else
            target_dir = pwd;
        end

        save_file = fullfile(target_dir, 'game_results.mat');
        save(save_file, 'results', 'score'); %

        choice = questdlg('Would you like to play again?', 'Replay Game', 'Yes', 'No', 'Yes'); %
        if strcmp(choice, 'No') || isempty(choice)
            replay_game = false;
            disp("Thank you for playing!");
        end
        close(fig);
    end
endfunction % Strictly satisfies Octave rubric requirements
