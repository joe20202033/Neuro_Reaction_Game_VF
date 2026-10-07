% =========================================================================
% GAME HEADER INFORMATION & DOCUMENTATION
% =========================================================================
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
% Main Loop Detailed:     An outer 'while replay_game' loop handles session restarts. An 
%                         inner 'for trial = 1:total_trials' loop manages round-by-round 
%                         execution: clearing screen -> running random delay -> drawing 
%                         stimuli & sounding beep -> recording click -> evaluating hit/miss 
%                         -> pausing briefly.[cite: 6]
% Across Trials Data:     Accumulates total score and reaction times in the 'results' 
%                         matrix across rounds, while resetting target spatial coordinates 
%                         and delay times every trial.[cite: 6]
% Rules of the Game:      1. Wait for both Green and Red circles to pop up on screen.
%                         2. Click ONLY on the GREEN circle as fast as possible (+10 pts).
%                         3. Avoid clicking the RED circle (-5 pts penalty).
%                         4. Clicks taking longer than 2.0 seconds count as timeouts.
% Ways to Move / Interact:Mouse input via graphic cursor click [click_x, click_y] using ginput(1).[cite: 6]
% Context of this Game:   Developed for M1 Neuroscience UE TechnEx Project (Université 
%                         Claude Bernard Lyon 1) as a choice reaction time assessment tool.[cite: 6]
%
% -------------------------------------------------------------------------
% SOURCES & ENVIRONMENT SPECIFICATIONS
% -------------------------------------------------------------------------
% Sound Source:           Built-in Octave audio synthesizer function 'beep()'[cite: 6]
% Graphics / Image Source:Native Octave line vector graphics ('plot' with filled circle markers)[cite: 6]
% AI / Coding Assistance: Code structure and documentation refined with OpenAI Gemini assistance.[cite: 6]
% Word List / Text:       Internal strings hardcoded for instructional pop-ups and display titles.
% Octave Version:         GNU Octave v11.3.0 (MinGW-w64 x86_64)[cite: 6]
% Code Version:           Version Final (game_VF.m - Revision 2.0)[cite: 6]
% Authors:                Youssif Soliman - Paola[cite: 7]
% Contribution:           Lead Developer — Full code logic, GUI layout, timer integration,
%                         sound events, and data export implementation.[cite: 6]
% Date:                   08-10-2026 (Format:
