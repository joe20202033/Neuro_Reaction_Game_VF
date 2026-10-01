# Visual Discrimination Reaction Task (`game_VF.m`)

## Student Information
* **Course:** M1 Neuroscience, UE TechnEx (Lyon 1)
* **Date:** October 2026
* **Environment:** GNU Octave v11.3.0

---

## Game Overview & Rules
* **Goal:** A neuroscience visual discrimination task measuring reaction speed and stimulus differentiation.
* **Gameplay:**
  1. **Get Ready:** Player waits for targets during a randomized delay (1.0 to 2.5s).
  2. **Stimulus Pop-Up:** Green (Target) and Red (Distractor) circles appear simultaneously with a sound cue (`beep`).
  3. **Action:** Click the **GREEN** target as fast as possible (+10 pts).
  4. **Scoring:** Hitting RED penalizes -5 pts; taking >2.0s results in a timeout.
* **Output:** Automatically records reaction times and trial hit outcomes to `game_results.mat`.

---

## Files in Repository
* **`game_VF.m`**: Complete game function script with header metadata, loops, sound, and GUI.
* **`game_results.mat`**: Saved dataset of session trial results.
* **`game_fig.png`**: Interface screenshot.

---

## Interface Preview
![Game Interface](game_fig.png)# Neuro_Reaction_Game_VF
