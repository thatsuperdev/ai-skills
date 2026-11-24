---
name: assembly-video
description: "Make a hyper-realistic, satisfying Blender video in which a product 'builds itself piece by piece, then comes alive with light', with music, at 4:5 for X/Instagram. Use when the user asks for an assembly or build video, an exploded-to-assembled product animation, a satisfying 3D build video, a product reveal render, or mentions 'assembly-video.prompt'."
---

# Assembly video

A reusable brief for "build itself" product videos in a transparent material, made in headless Blender (Cycles), with real sound effects and one royalty-free track.

## Files
- `references/prompt-template.txt`: the full prompt (brief, idea, look, team, sound, video, quality, tech, deliver, swap). It is the source of truth; read it all before starting.
- `references/example-fills.md`: a worked example of filling the template.

## How to use
1. Read `references/prompt-template.txt`.
2. Fill every `[bracket]`:
   - title, object and material
   - inner parts and accents
   - the light-up ("alive") moment
   - sound cues and music mood
   - assembly order and the key part for the macro shot
   - the object in use, and the length

   The `<swap>` block lists example object + material pairs. If the user has CAD or STL files, use them for real dimensions.
3. Apply these overrides before running:
   - **Project rules win.** If the repo bans new Markdown docs, write `REPORT.html` instead of `REPORT.md`.
   - **"No downloaded models"** means you model the parts yourself. The user's own CAD or STL may still be imported for dimensions or as base meshes.
   - **"No real brand names"** means no third-party brands. The user's own logo or mark is allowed and usually wanted.
   - **Helpers:** if you can spawn subagents, start exactly 3 (A hardware, B look, C sound), each with its own sub-folder. If you can't, play the three roles yourself in sequence, keep the sub-folders and say so in the report.
4. Run the brief autonomously. Don't ask questions mid-run, except for the setup permissions below.

## Setup and permissions
- **Blender:** check `which blender` or, on macOS, `/Applications/Blender.app/Contents/MacOS/Blender`. If it is missing, ask the user once before installing it (`brew install --cask blender` on macOS, or the package manager or blender.org on Linux). Run it headless with `blender -b -P script.py`. On Apple Silicon, use Cycles with Metal; on NVIDIA, use OptiX or CUDA.
- **Downloads:** only from Pixabay (sounds and music), incompetech.com (music) and Poly Haven (HDRIs and textures). Put each download in its own folder and never execute it. Log every URL and licence in `CREDITS.txt`.
- **Renders:** only ONE full-quality render at a time.
- **Publishing:** don't commit, push or publish unless the user asks.

## Render budget
- Before any final render, make low-sample stills of every shot and an A/B test of at least 3 backgrounds.
- Use adaptive sampling with OpenImageDenoise, and check temporal stability for denoiser boiling.
- 30 s at 60 fps is 1800 frames, which takes hours on a laptop. With several products, render them in priority order and report what is unfinished rather than shipping broken frames.
- Measure loudness with `ffmpeg -af ebur128` and target about -16 LUFS. Encode H.264 with AAC 256k, 1080x1350, 60 fps.

## Deliverables (per video)
- `final/<name>.mp4`
- `final/contact_sheet.png` (12 frames)
- `CREDITS.txt`
- the build scripts
- a report covering:
  - the background chosen and why
  - what each helper built
  - the drop timestamp
  - the glitch-scan method and results
  - the measured LUFS and the render time
  - anything imperfect
