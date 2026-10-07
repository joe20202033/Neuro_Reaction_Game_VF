# Visual Discrimination Reaction Task (`game_VF.m`)

## Student & Project Metadata
* **Author:** Youssif Soliman - Paola
* **Program:** M1 Neuroscience[cite: 7]
* **Course:** UE TechnEx (Université Claude Bernard Lyon 1)[cite: 7]
* **Date:** 08-10-2026 (Format: DD-MM-YYYY)[cite: 6, 7]
* **Environment:** GNU Octave v11.3.0[cite: 6, 7]

---



### Game Architecture & Core Mechanics
* **Goal of the Game:** A neuroscience visual discrimination task measuring choice reaction time (CRT) and selective visual attention. Players must click the GREEN target as fast as possible while ignoring the RED distractor.
* **Game Components:** 
  * **GUI Window:** Interactive 2D coordinate space (11x11 grid)[cite: 6].
  * **Stimuli:** Green target circle and Red distractor circle[cite: 6].
  * **Sound Engine:** Auditory trigger (`beep`) at stimulus onset[cite: 6].
  * **Timer:** Millisecond-accurate reaction time counter (`tic`/`toc`)[cite: 6].
  * **Data Logger:** Automatic exporter saving session logs to `game_results.mat`[cite: 6].
* **Variables:** `replay_game`, `total_trials`, `score`, `time_limit`, `results`, `pause_delay`, `green_x/y`, `red_x/y`, `click_x/y`, `rt`, `dist_green`, `dist_red`[cite: 6].
* **Main Loop Detailed:** An outer `while replay_game` loop manages session restarts[cite: 6]. An inner `for trial = 1:total_trials` loop manages round execution: screen reset $\rightarrow$ random delay $\rightarrow$ simultaneous stimuli rendering with audio cue $\rightarrow$ user click capture $\rightarrow$ hit/miss evaluation $\rightarrow$ feedback pause[cite: 6].
* **Across Trials Data:** Accumulates score and reaction times in the `results` matrix across rounds while resetting coordinates and delays[cite: 6].
* **Rules of the Game:**
  1. Wait for both Green and Red circles to pop up on screen[cite: 6].
  2. Click ONLY on the GREEN circle as fast as possible (+10 pts)[cite: 6].
  3. Avoid clicking the RED circle (-5 pts penalty)[cite: 6].
  4. Responses exceeding 2.0 seconds trigger a timeout[cite: 6].
* **Ways to Move / Interact:** Mouse input via visual cursor click using `ginput(1)`[cite: 6].
* **Context of this Game:** Developed for M1 Neuroscience UE TechnEx Project (Université Claude Bernard Lyon 1) as a choice reaction time assessment tool[cite: 6, 7].

### Criterion 3: Sources
* **Sound Source:** Built-in Octave audio synthesizer function `beep()`[cite: 6].
* **Graphics / Image Source:** Native Octave line vector graphics (`plot` with filled circle markers)[cite: 6].
* **AI / Coding Assistance:** Code structure and documentation refined with AI assistance[cite: 6].
* **Word List / Text:** Internal hardcoded strings for instructions, onscreen feedback, and display titles.

### Criterion 4: Environment & Versioning
* **Octave Version:** GNU Octave v11.3.0 (MinGW-w64 x86_64)[cite: 6, 7].
* **Code Version:** Version Final (`VF` - Revision 2.0)[cite: 6].

### Criterion 5: Author & Contribution
* **Author:** Youssif Soliman - Paola[cite: 7]
* **Contribution:** Lead Developer — Responsible for full code development, neuroscientific game design, GUI rendering, timer integration, sound integration, and path-safe data logging[cite: 6].

### Criterion 6: Date Specification
* **Date:** 08-10-2026[cite: 6, 7]
* **Date Format Detailed:** DD-MM-YYYY (2-digit day, 2-digit month, 4-digit year)[cite: 6].

---

## 1. Neuroscientific Rationale ("Why We Thought About It")
In cognitive neuroscience, choice reaction time (CRT) protocols are essential tools used to evaluate **selective visual attention**, **inhibitory control**, and **sensorimotor processing speed**. 

This interactive game was designed as a laboratory-style paradigm where players must process two visual stimuli presented simultaneously under time constraints:
1. **Target Stimulus (Green Circle):** Represents the signal requiring immediate motor execution (mouse click)[cite: 6].
2. **Distractor Stimulus (Red Circle):** Represents cognitive noise that the brain's executive control system must actively suppress[cite: 6].

By varying the inter-trial waiting window unpredictably (1.0s to 2.5s), the game prevents anticipation bias, forcing the player's brain to react strictly to the sudden onset of visual information[cite: 6].

---

## 2. Plain-English Variable Glossary
* **`replay_game`**: True/False switch controlling session restarts[cite: 6].
* **`total_trials`**: Number of rounds per session (5)[cite: 6].
* **`score`**: Cumulative point total[cite: 6].
* **`time_limit`**: Maximum allowed reaction time (2.0s)[cite: 6].
* **`results`**: Saved matrix of reaction times and hit outcomes[cite: 6].
* **`fig`**: The game figure window[cite: 6].
* **`trial`**: Current round number (1 to 5)[cite: 6].
* **`pause_delay`**: Randomized waiting duration before targets appear[cite: 6].
* **`green_x` / `green_y`**: X and Y coordinates for the Green target[cite: 6].
* **`red_x` / `red_y`**: X and Y coordinates for the Red distractor[cite: 6].
* **`click_x` / `click_y`**: Mouse click location captured by `ginput(1)`[cite: 6].
* **`rt`**: Exact reaction time in seconds[cite: 6].
* **`dist_green` / `dist_red`**: Calculated physical distance from click to target centers[cite: 6].
* **`avg_rt`**: Mean reaction speed calculated across successful target hits[cite: 6].
* **`save_file`**: Path indicating where `game_results.mat` is written[cite: 6].

---

## 3. Repository Files
* **`game_VF.m`**: The primary Octave script containing full game logic, header metadata, GUI rendering, sound triggers, and data logging functions[cite: 6].
* **`game_results.mat`**: Binary dataset generated at game end storing session reaction times and hit matrices[cite: 6].
* **`game_fig.png`**: High-resolution screenshot showing the active visual discrimination game interface[cite: 6].
* **`README.md`**: Complete project documentation and scientific overview[cite: 7].

---

## Game Interface Preview
![Game Interface](game_fig.png)
