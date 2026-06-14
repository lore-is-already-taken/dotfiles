return {
  "sphamba/smear-cursor.nvim",
  opts = {
    -- Color of the smear (matches your accent orange)
    cursor_color = "#f39816",

    -- Smear cursor when switching buffers or windows
    smear_between_buffers = true,

    -- Smear when moving within a line or to a neighbor line
    smear_between_neighbor_lines = true,

    -- Draw the smear in buffer space instead of screen space,
    -- avoids a "stretched" look when scrolling
    scroll_buffer_space = true,

    -- Smooth out the diagonal edges with sub-character resolution
    -- (requires a terminal that supports legacy computing symbols, e.g. Kitty)
    legacy_computing_symbols_support = true,

    -- Insert-mode beam cursor also gets smeared
    smear_insert_mode = true,

    -- ── Exaggerated but FAST motion: long, whippy, snappy trail ───
    stiffness = 0.7, -- head snaps quickly toward the target
    trailing_stiffness = 0.45, -- tail still drags for a visible streak
    trailing_exponent = 5, -- bunch the body toward the tail for a long streak
    anticipation = 0.6, -- big backward whip before launching forward
    damping = 0.8, -- enough velocity loss to settle fast (no slow drift)
    max_length = 40, -- allow a very long smear (default 25)
    max_length_insert_mode = 8, -- noticeable trail even in insert mode

    distance_stop_animating = 0.3, -- settle a touch sooner -> feels snappier
    time_interval = 7, -- ~140fps for a smooth, fast-moving trail

    -- ── Color / gradient drama ───────────────────────────────────
    gamma = 1.5, -- punchier color blending
    gradient_exponent = 1.5, -- stronger fade along the streak
    color_levels = 32, -- more shades -> smoother gradient
    matrix_pixel_threshold = 0.5, -- denser pixels -> thicker, more visible smear

    hide_target_hack = false, -- keep the real cursor visible under the smear

    -- ── Particles: spark trail flying off the cursor ─────────────
    particles_enabled = true,
    particles_per_second = 300, -- spawn rate (default 200) -> denser bursts
    particles_per_length = 1.5, -- more particles over distance moved
    particle_max_num = 150, -- allow more on screen at once (default 100)
    min_distance_emit_particles = 1.0, -- start emitting on smaller moves
    particle_spread = 0.7, -- wider scatter
    particle_max_lifetime = 400, -- particles linger a bit longer (ms)
    particle_max_initial_velocity = 14, -- launch them faster
    particle_random_velocity = 120, -- more chaotic spray
    particle_gravity = 25, -- they fall away -> nice spark feel
    particles_over_text = false, -- don't draw particles on top of code
  },
}
