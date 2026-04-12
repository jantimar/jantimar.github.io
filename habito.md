---
layout: default
title: Habitoo
permalink: /habito.html
---

<style>
  .habitoo-page {
    --hb-bg: #f7f7f2;
    --hb-surface: #ffffff;
    --hb-surface-soft: #f1f5ee;
    --hb-text: #182018;
    --hb-muted: #5f6c5b;
    --hb-line: rgba(24, 32, 24, 0.08);
    --hb-main: #14b8a6;
    --hb-main-deep: #108777;
    --hb-accent: #c7d2fe;
    --hb-peach: #fed2c7;
    --hb-shadow: 0 18px 48px rgba(24, 32, 24, 0.1);
    color: var(--hb-text);
    font-family: "Avenir Next", "Segoe UI", sans-serif;
    margin: -30px calc(50% - 50vw) -40px;
    padding: 0 0 5rem;
    background:
      radial-gradient(circle at top left, rgba(20, 184, 166, 0.14), transparent 28%),
      radial-gradient(circle at top right, rgba(199, 210, 254, 0.34), transparent 26%),
      linear-gradient(180deg, #fcfcf8 0%, var(--hb-bg) 100%);
  }

  .habitoo-shell {
    max-width: 1120px;
    margin: 0 auto;
    padding: 0 1.5rem;
  }

  .habitoo-hero {
    padding: 4.5rem 0 2.5rem;
  }

  .habitoo-hero-grid,
  .habitoo-feature-grid,
  .habitoo-shot-grid,
  .habitoo-summary-grid {
    display: grid;
    gap: 1.25rem;
  }

  .habitoo-hero-grid {
    grid-template-columns: minmax(0, 1.1fr) minmax(250px, 0.9fr);
    align-items: center;
    gap: 2rem;
  }

  .habitoo-eyebrow {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.45rem 0.85rem;
    border-radius: 999px;
    border: 1px solid var(--hb-line);
    background: rgba(255, 255, 255, 0.78);
    color: var(--hb-muted);
    font-size: 0.82rem;
    letter-spacing: 0.04em;
    text-transform: uppercase;
  }

  .habitoo-title,
  .habitoo-section h2 {
    font-family: "Iowan Old Style", "Palatino Linotype", serif;
    letter-spacing: -0.03em;
  }

  .habitoo-title {
    margin: 1rem 0 0.85rem;
    font-size: clamp(2.8rem, 5vw, 5rem);
    line-height: 0.95;
    max-width: 10ch;
  }

  .habitoo-copy,
  .habitoo-section p,
  .habitoo-feature p,
  .habitoo-summary p,
  .habitoo-shot-note {
    color: var(--hb-muted);
    line-height: 1.75;
  }

  .habitoo-copy {
    max-width: 38rem;
    font-size: 1.05rem;
  }

  .habitoo-actions {
    display: flex;
    flex-wrap: wrap;
    gap: 0.85rem;
    margin: 1.6rem 0 1.2rem;
  }

  .habitoo-button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.95rem 1.3rem;
    border-radius: 999px;
    text-decoration: none;
    font-weight: 600;
    transition: transform 0.18s ease;
  }

  .habitoo-button:hover {
    transform: translateY(-1px);
  }

  .habitoo-button-primary {
    background: linear-gradient(135deg, var(--hb-main), var(--hb-main-deep));
    color: #fff;
    box-shadow: 0 14px 30px rgba(20, 184, 166, 0.24);
  }

  .habitoo-button-secondary {
    background: rgba(255, 255, 255, 0.84);
    border: 1px solid var(--hb-line);
    color: var(--hb-text);
  }

  .habitoo-points {
    display: flex;
    flex-wrap: wrap;
    gap: 0.7rem;
  }

  .habitoo-points span {
    padding: 0.5rem 0.8rem;
    border-radius: 999px;
    background: rgba(255, 255, 255, 0.72);
    border: 1px solid var(--hb-line);
    font-size: 0.94rem;
  }

  .habitoo-card,
  .habitoo-feature,
  .habitoo-summary,
  .habitoo-shot {
    background: var(--hb-surface);
    border: 1px solid var(--hb-line);
    box-shadow: var(--hb-shadow);
  }

  .habitoo-card {
    border-radius: 1.8rem;
    padding: 1.4rem;
    background:
      radial-gradient(circle at top right, rgba(254, 210, 199, 0.45), transparent 32%),
      linear-gradient(180deg, #ffffff, #f5f8f2);
  }

  .habitoo-apphead {
    display: flex;
    align-items: center;
    gap: 1rem;
  }

  .habitoo-icon {
    width: 84px;
    height: 84px;
    border-radius: 22px;
    object-fit: cover;
    box-shadow: 0 10px 24px rgba(24, 32, 24, 0.16);
  }

  .habitoo-appmeta strong {
    display: block;
    font-size: 1.3rem;
  }

  .habitoo-appmeta span {
    color: var(--hb-muted);
  }

  .habitoo-mini {
    margin-top: 1.2rem;
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 0.9rem;
  }

  .habitoo-mini div {
    border-radius: 1.1rem;
    background: rgba(255, 255, 255, 0.78);
    border: 1px solid var(--hb-line);
    padding: 0.9rem;
  }

  .habitoo-mini strong {
    display: block;
    font-size: 1.25rem;
    line-height: 1;
    margin-bottom: 0.3rem;
  }

  .habitoo-section {
    padding: 1.4rem 0;
  }

  .habitoo-section h2 {
    margin: 0 0 0.65rem;
    font-size: clamp(2rem, 3.5vw, 3rem);
    line-height: 1;
  }

  .habitoo-feature-grid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
    margin-top: 1.2rem;
  }

  .habitoo-feature,
  .habitoo-summary {
    border-radius: 1.4rem;
    padding: 1.3rem;
  }

  .habitoo-feature h3,
  .habitoo-summary h3 {
    margin: 0 0 0.5rem;
    font-family: "Iowan Old Style", "Palatino Linotype", serif;
    font-size: 1.4rem;
  }

  .habitoo-summary-grid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
    margin-top: 1.2rem;
  }

  .habitoo-shot-grid {
    grid-template-columns: repeat(4, minmax(0, 1fr));
    margin-top: 1.25rem;
  }

  .habitoo-shot {
    border-radius: 1.6rem;
    padding: 0.7rem;
  }

  .habitoo-shot img {
    display: block;
    width: 100%;
    height: auto;
    border-radius: 1.1rem;
  }

  .habitoo-shot-note {
    font-size: 0.92rem;
    margin-top: 0.95rem;
  }

  .habitoo-store {
    padding-top: 1.8rem;
  }

  .habitoo-store-box {
    border-radius: 1.8rem;
    padding: 1.7rem;
    background:
      radial-gradient(circle at top right, rgba(199, 210, 254, 0.45), transparent 30%),
      linear-gradient(135deg, #ffffff, #f6f7f1);
  }

  @media (max-width: 980px) {
    .habitoo-hero-grid,
    .habitoo-feature-grid,
    .habitoo-shot-grid,
    .habitoo-summary-grid {
      grid-template-columns: 1fr;
    }
  }

  @media (max-width: 560px) {
    .habitoo-page {
      margin-top: -20px;
    }

    .habitoo-shell {
      padding: 0 1rem;
    }

    .habitoo-actions {
      flex-direction: column;
    }

    .habitoo-button {
      width: 100%;
    }

    .habitoo-mini {
      grid-template-columns: 1fr;
    }
  }
</style>

<div class="habitoo-page">
  <div class="habitoo-shell">
    <section class="habitoo-hero">
      <div class="habitoo-hero-grid">
        <div>
          <span class="habitoo-eyebrow">Habitoo for iPhone</span>
          <h1 class="habitoo-title">Build habits that stick without the usual clutter.</h1>
          <p class="habitoo-copy">
            Habitoo is a simple habit tracker for iPhone. It helps you build routines, limit bad habits,
            stay consistent with reminders, and keep an eye on your progress with clear streaks, statistics,
            calendar history, tips, and achievements.
          </p>
          <div class="habitoo-actions">
            <a class="habitoo-button habitoo-button-primary" href="https://apps.apple.com/cz/app/habitoo/id6758296050">Open on the App Store</a>
          </div>
          <div class="habitoo-points">
            <span>Build, quit, or limit habits</span>
            <span>Targets by count, time, or distance</span>
            <span>Reminders and streaks</span>
            <span>Calendar history</span>
          </div>
        </div>

        <div class="habitoo-card">
          <div class="habitoo-apphead">
            <img class="habitoo-icon" src="https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/14/7f/58/147f585e-df1b-b578-9f85-bcfd0f0b210a/AppIcon-0-0-1x_U007ephone-0-1-85-220.png/460x0w.webp" alt="Habitoo app icon">
            <div class="habitoo-appmeta">
              <strong>Habitoo</strong>
              <span>Utilities · Free · Designed for iPhone</span>
            </div>
          </div>

          <div class="habitoo-mini">
            <div>
              <strong>Simple</strong>
              <span>Light, focused, and easy to use every day.</span>
            </div>
            <div>
              <strong>Motivating</strong>
              <span>Stats, streaks, achievements, and small wins.</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="habitoo-section">
      <h2>What Habitoo helps with</h2>
      <p>
        The app is built around a very clear idea: track the habits that matter, make progress visible,
        and remove the noise that usually gets in the way.
      </p>

      <div class="habitoo-feature-grid">
        <article class="habitoo-feature">
          <h3>Create the right type of habit</h3>
          <p>Use Habitoo to build a new habit, quit a bad one, or limit something you want to control better.</p>
        </article>
        <article class="habitoo-feature">
          <h3>Track more than simple checkmarks</h3>
          <p>Set targets by count, time, or distance and use the tracker for reading, movement, focus, hydration, and more.</p>
        </article>
        <article class="habitoo-feature">
          <h3>Stay consistent with reminders</h3>
          <p>Add reminders so the app supports your routine instead of expecting you to remember everything yourself.</p>
        </article>
        <article class="habitoo-feature">
          <h3>Review streaks and stats</h3>
          <p>See clear progress with streaks and statistics that help you understand whether the habit is actually sticking.</p>
        </article>
        <article class="habitoo-feature">
          <h3>Look back through calendar history</h3>
          <p>Use visual history to see completed days, missed days, and overall momentum across time.</p>
        </article>
        <article class="habitoo-feature">
          <h3>Keep motivation high</h3>
          <p>Tips and achievements give the app a lighter, more encouraging feel without making it noisy or overdesigned.</p>
        </article>
      </div>
    </section>

    <section class="habitoo-section" id="screenshots">
      <h2>Real App Store screenshots</h2>
      <p>
        These screenshots are taken from the current Habitoo App Store listing and show the actual app instead of a placeholder mockup.
      </p>

      <div class="habitoo-shot-grid">
        <figure class="habitoo-shot">
          <img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/9c/b4/a5/9cb4a58b-e405-c5ed-2db9-777bbf1db327/image1.png/460x996bb.webp" alt="Habitoo App Store screenshot 1">
        </figure>
        <figure class="habitoo-shot">
          <img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/2b/d0/20/2bd02032-ee7c-9f27-e2d2-b3caee7638d2/image2.png/460x996bb.webp" alt="Habitoo App Store screenshot 2">
        </figure>
        <figure class="habitoo-shot">
          <img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/8d/1b/3e/8d1b3ed2-726c-2469-359e-1b191d47e6b6/image3.png/460x996bb.webp" alt="Habitoo App Store screenshot 3">
        </figure>
        <figure class="habitoo-shot">
          <img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/94/d6/de/94d6de34-d960-d4e6-65f0-9e57596b8d37/image4.png/460x996bb.webp" alt="Habitoo App Store screenshot 4">
        </figure>
      </div>

      <p class="habitoo-shot-note">
        The page now uses the same calm green-and-soft-neutral direction as the app instead of the previous heavier concept layout.
      </p>
    </section>

    <section class="habitoo-section habitoo-store">
      <div class="habitoo-card habitoo-store-box">
        <h2>Ready to try Habitoo?</h2>
        <p>
          If the goal is a small, focused marketing page for the app, this is now a much better base.
          The next additions would be privacy policy, App Store badge artwork, and eventually user quotes or release notes.
        </p>
        <div class="habitoo-actions">
          <a class="habitoo-button habitoo-button-primary" href="https://apps.apple.com/cz/app/habitoo/id6758296050">View Habitoo on the App Store</a>
          <a class="habitoo-button habitoo-button-secondary" href="/projects.html">Back to projects</a>
        </div>
      </div>
    </section>
  </div>
</div>
