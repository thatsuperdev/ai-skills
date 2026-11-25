---
name: assembly-video
description: "Make a hyper-realistic, satisfying Blender video in which a product 'builds itself piece by piece, then comes alive with light', with music, at 4:5 for X/Instagram. Use when the user asks for an assembly or build video, an exploded-to-assembled product animation, a satisfying 3D build video, a product reveal or launch video, or mentions 'assembly-video.prompt'. Also consider it for looser requests: '3D product video', 'product animation', '3D render video', 'CGI product video', 'promo or hero video of my device', 'show what's inside', 'X-ray or see-through product video', 'product teaser for Instagram, X, TikTok or Reels'. For those, confirm the format first (see 'Check the intent')."
---

# Assembly video

A reusable brief for "build itself" product videos in a transparent material, made in headless Blender (Cycles), with real sound effects and one royalty-free track.

## Files
- `references/prompt-template.txt`: the full prompt (brief, idea, look, team, sound, video, quality, tech, deliver, swap). It is the source of truth; read it all before starting.
- `references/example-fills.md`: a worked example of filling the template.

## Check the intent
This skill makes one specific format: a transparent product that assembles itself from flying parts, lights up on a music drop, then holds a hero orbit. It takes hours to render.

- **Go straight ahead** when the user clearly asks for that format, for example "assembly video", "build video", "builds itself", "exploded to assembled", "piece by piece", or names this skill or its prompt.
- **Ask first** when the request is broader, such as "3D product video", "product animation", "render a video of X", "promo video" or "hero shot". Ask one short question before any setup or rendering, and offer these choices:
  1. **Assembly video** (this skill): parts fly in and build the product, it lights up, then a hero orbit. 25–35 s with music.
  2. **Turntable or hero orbit:** the finished product rotating in a studio. No assembly, and quicker to render.
  3. **Something else:** an exploded-view still, in-use lifestyle shots, or a feature walkthrough.

  If the user picks 2 or 3, don't use this template. You may reuse its look, studio, sound and quality rules.
- **No one to ask** (for example a scheduled or headless run): if the request names building, assembling or exploding, proceed with the assembly video. Otherwise make a turntable, and say in the report which you chose and why.
- Also confirm the material if it's unclear. Transparent or see-through is the default, so check whether the user wants the real finish instead.

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
