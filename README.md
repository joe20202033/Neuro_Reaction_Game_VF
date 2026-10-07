# 🎮 Cartoon Blitz: Neuroscience Choice Reaction Time Task

An interactive cognitive neuroscience visual discrimination experiment built in **GNU Octave**. This task measures **Choice Reaction Time (CRT)**, visual processing speed, and response inhibition through cartoon-styled stimuli, synthesized audio cues, dynamic action effects, and trial-by-trial data logging.

---

## ⚡ Game Features & Mechanics

* **Cartoon Visual Discrimination:** Players must rapidly identify and click the **Green Blob Monster** target while ignoring the **Spiky Red Bomb** distractor.
* **Rapid Sequence Timing Parameters:**
  * **Reaction Window:** 1.2 seconds per trial before timeout.
  * **Inter-Trial Delay:** Randomized between **0.5s and 1.2s** to eliminate anticipation effects.
  * **Feedback Duration:** **0.6 seconds** displaying action graphics (`POW!` starburst or `BOOM!`) before transitioning.
* **Interactive Control & Early Exit:**
  * On-screen clickable **RED STOP BOX** located at `[0.3, 0.3, 1.4, 0.8]`.
  * Keyboard listener supporting `q`, `Q`, or `Esc` keys for session interruption.
* **Automated Data Export:** Logs timing and accuracy variables directly to `game_results.mat` in the working directory.

---

## 🧠 Experimental Rules & Scoring Matrix

| Event | Action Trigger | Score Impact | Data Code (`results(:,2)`) |
| :--- | :--- | :---: | :---: |
| **Successful Hit** | Click Green Monster within 1.2s (`dist < 0.9`) | **+10 pts** | `1` |
| **Bomb Trap** | Click Spiky Red Bomb (`dist < 0.9`) | **-5 pts** | `-1` |
| **Timeout / Miss** | Click empty space or exceed 1.2s limit | **0 pts** | `0` |

---

## 🚀 How to Run

1. Open **GNU Octave** (v11.3.0 or compatible) or **MATLAB**.
2. Navigate to the folder containing `game_VF.m`.
3. Launch the game from the Command Window:
   ```matlab
   game_VF
