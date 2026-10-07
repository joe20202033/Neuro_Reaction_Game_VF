# Visual Discrimination Reaction Task (`game_VF.m`)

## Student & Project Metadata
* **Author:** Youssif Soliman - Paola
* **Program:** M1 Neuroscience.
* **Course:** UE TechnEx (Université Claude Bernard Lyon 1).
* **Date:** 08-10-2026.
* **Environment:** GNU Octave v11.3.0.

---



### Game Architecture & Core Mechanics
* **Goal of the Game:** A neuroscience visual discrimination task measuring choice reaction time (CRT) and selective visual attention. Players must click the GREEN target as fast as possible while ignoring the RED distractor.
* **Game Components:** 
  * **GUI Window:** Interactive 2D coordinate space (11x11 grid).
  * **Stimuli:** Green target circle and Red distractor circle.
  * **Sound Engine:** Auditory trigger (`beep`) at stimulus onset.
  * **Timer:** Millisecond-accurate reaction time counter (`tic`/`toc`).
  * **Data Logger:** Automatic exporter saving session logs to `game_results.mat`.
* **Variables:** `replay_game`, `total_trials`, `score`, `time_limit`, `results`, `pause_delay`, `green_x/y`, `red_x/y`, `click_x/y`, `rt`, `dist_green`, `dist_red`.
* **Main Loop Detailed:** An outer `while replay_game` loop manages session restarts[cite: 6]. An inner `for trial = 1:total_trials` loop manages round execution: screen reset $\rightarrow$ random delay $\rightarrow$ simultaneous stimuli rendering with audio cue $\rightarrow$ user click capture $\rightarrow$ hit/miss evaluation $\rightarrow$ feedback pause.
* **Across Trials Data:** Accumulates score and reaction times in the `results` matrix across rounds while resetting coordinates and delays.
* **Rules of the Game:**
  1. Wait for both Green and Red circles to pop up on screen.
  2. Click ONLY on the GREEN circle as fast as possible (+10 pts).
  3. Avoid clicking the RED circle (-5 pts penalty).
  4. Responses exceeding 2.0 seconds trigger a timeout.
* **Ways to Move / Interact:** Mouse input via visual cursor click using `ginput(1)`.
* **Context of this Game:** Developed for M1 Neuroscience UE TechnEx Project (Université Claude Bernard Lyon 1) as a choice reaction time assessment tool.

### Criterion 3: Sources
* **Sound Source:** Built-in Octave audio synthesizer function `beep()`.
* **Graphics / Image Source:** Native Octave line vector graphics (`plot` with filled circle markers).
* **AI / Coding Assistance:** Code structure and documentation refined with AI assistance.
* **Word List / Text:** Internal hardcoded strings for instructions, onscreen feedback, and display titles.

### Criterion 4: Environment & Versioning
* **Octave Version:** GNU Octave v11.3.0 (MinGW-w64 x86_64).
* **Code Version:** Version Final (`VF` - Revision 2.0).

### Criterion 5: Author & Contribution
* **Author:** Youssif Soliman - Paola
* **Contribution:** Lead Developer — Responsible for full code development, neuroscientific game design, GUI rendering, timer integration, sound integration, and path-safe data logging.

### Criterion 6: Date Specification
* **Date:** 08-10-2026
* **Date Format Detailed:** DD-MM-YYYY (2-digit day, 2-digit month, 4-digit year).

---

## 1. Neuroscientific Rationale ("Why We Thought About It")
In cognitive neuroscience, choice reaction time (CRT) protocols are essential tools used to evaluate **selective visual attention**, **inhibitory control**, and **sensorimotor processing speed**. 

This interactive game was designed as a laboratory-style paradigm where players must process two visual stimuli presented simultaneously under time constraints:
1. **Target Stimulus (Green Circle):** Represents the signal requiring immediate motor execution (mouse click).
2. **Distractor Stimulus (Red Circle):** Represents cognitive noise that the brain's executive control system must actively suppress.

By varying the inter-trial waiting window unpredictably (1.0s to 2.5s), the game prevents anticipation bias, forcing the player's brain to react strictly to the sudden onset of visual information.

---

## 2. Plain-English Variable Glossary
* **`replay_game`**: True/False switch controlling session restarts.
* **`total_trials`**: Number of rounds per session (5).
* **`score`**: Cumulative point total.
* **`time_limit`**: Maximum allowed reaction time (2.0s).
* **`results`**: Saved matrix of reaction times and hit outcomes.
* **`fig`**: The game figure window.
* **`trial`**: Current round number (1 to 5).
* **`pause_delay`**: Randomized waiting duration before targets appear.
* **`green_x` / `green_y`**: X and Y coordinates for the Green target.
* **`red_x` / `red_y`**: X and Y coordinates for the Red distractor.
* **`click_x` / `click_y`**: Mouse click location captured by `ginput(1)`.
* **`rt`**: Exact reaction time in seconds.
* **`dist_green` / `dist_red`**: Calculated physical distance from click to target centers.
* **`avg_rt`**: Mean reaction speed calculated across successful target hits.
* **`save_file`**: Path indicating where `game_results.mat` is written.

---

## 3. Repository Files
* **`game_VF.m`**: The primary Octave script containing full game logic, header metadata, GUI rendering, sound triggers, and data logging functions.
* **`game_results.mat`**: Binary dataset generated at game end storing session reaction times and hit matrices.
* **`game_fig.png`**: High-resolution screenshot showing the active visual discrimination game interface.
* **`README.md`**: Complete project documentation and scientific overview.

---

## Game Interface Preview
![Game Interface](game_fig.png)
