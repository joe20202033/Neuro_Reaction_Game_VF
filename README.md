# Visual Discrimination Reaction Task (`game_VF.m`)

## Student & Project Metadata
* **Author:** Youssif Soliman - Paoula
* **Program:** M1 Neuroscience
* **Course:** UE TechnEx (Université Claude Bernard Lyon 1)
* **Date:** 8-10-2026
* **Environment:** GNU Octave v11.3.0

---

## 1. Neuroscientific Rationale ("Why We Thought About It")
In cognitive neuroscience, choice reaction time (CRT) protocols are essential tools used to evaluate **selective visual attention**, **inhibitory control**, and **sensorimotor processing speed**. 

This interactive game was designed as a laboratory-style paradigm where players must process two visual stimuli presented simultaneously under time constraints:
1. **Target Stimulus (Green Circle):** Represents the signal requiring immediate motor execution (mouse click).
2. **Distractor Stimulus (Red Circle):** Represents cognitive noise that the brain's executive control system must actively suppress.

By varying the inter-trial waiting window unpredictably (1.0s to 2.5s), the game prevents anticipation bias, forcing the player's brain to react strictly to the sudden onset of visual information.

---

## 2. Detailed Game Architecture & Structural Pipeline
The game operates through a 5-stage sequential architecture implemented in a main control loop:

1. **Phase I — Setup & Instructions:** Clears previous graphics, displays operating instructions in the terminal, and initializes scoring/timing data structures.
2. **Phase II — Inter-Trial Interval (Unpredictable Delay):** Displays a neutral "GET READY..." screen while waiting for a random period between 1.0 and 2.5 seconds.
3. **Phase III — Simultaneous Stimulus Onset:** Triggers an auditory tone (`beep`) while rendering both Green (Target) and Red (Distractor) circles at non-overlapping random coordinates.
4. **Phase IV — Precision Measurement & Evaluation:** 
   * Tracks user interaction via `ginput(1)`.
   * Calculates exact millisecond reaction time ($RT = toc - tic$).
   * Evaluates spatial Euclidean distance to determine whether the user hit Green (+10 pts), hit Red (-5 pts), or missed both.
   * Enforces a 2.0-second reaction time ceiling.
5. **Phase V — Performance Export & Replay Loop:** Calculates overall session averages, automatically exports trial logs to `game_results.mat`, and opens an interactive GUI prompt (`questdlg`) asking if the user wishes to replay.

---

## 3. Plain-English Variable Glossary
To make the codebase accessible to non-programmers, every variable used in `game_VF.m` is defined below:

* **`replay_game`**: A True/False switch that keeps the game running continuously until the user chooses to quit.
* **`total_trials`**: The number of rounds played per session (set to 5).
* **`score`**: The player's running point balance throughout the session.
* **`time_limit`**: Maximum allowed reaction duration (2.0 seconds) before a trial times out.
* **`results`**: A stored table containing the exact reaction time and outcome status for every round.
* **`fig`**: The graphical pop-up window containing the game arena.
* **`trial`**: Tracks the active round number (1 through 5).
* **`pause_delay`**: The randomized delay interval generated before targets appear.
* **`green_x` / `green_y`**: The exact grid coordinates for the Green target.
* **`red_x` / `red_y`**: The exact grid coordinates for the Red distractor.
* **`click_x` / `click_y`**: The exact screen coordinates where the user clicked.
* **`rt`**: Reaction Time — measured in seconds from target appearance to click.
* **`dist_green` / `dist_red`**: Calculated physical distance between the user's click and target centers.
* **`valid_rts`**: A filtered list containing reaction times from correct Green target hits only.
* **`avg_rt`**: The mean reaction speed calculated across all successful target hits.
* **`save_file`**: The absolute file path indicating where data logs are saved.

---

## 4. Repository File Index
* **`game_VF.m`**: The primary Octave script containing full game logic, GUI rendering, sound triggers, and data logging functions.
* **`game_results.mat`**: Binary dataset generated at game end storing session reaction times and hit matrices[cite: 6].
* **`game_fig.png`**: High-resolution screenshot showing the active visual discrimination game interface[cite: 6].
* **`README.md`**: Complete project documentation and scientific overview.

---

## Game Interface Preview
![Game Interface](game_fig.png)
