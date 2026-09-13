# Coded by Sam Aaron
use_tuning :just
scale 60, :zirguleli_hicaz_2
use_debug false
use_random_seed 667
load_sample :ambi_drone
sleep 1

live_loop :travelling do
  use_synth :blade
  notes = scale(:e3, :bayati_araban, num_octaves: 1)
  use_random_seed 679
  tick_reset_all
  with_fx :echo, phase: 0.125, mix: 0.4, reps: 16 do
    sleep 0.25
    play notes.choose, attack: 0, release: 0.1, pan: (range -1, 1, step: 0.125).tick, amp: rrand(2, 2.5)
  end
end

live_loop :comet, auto_cue: false do
  if one_in 4
    synth :chiplead
    puts :comet_landing
  end
  sleep 8
end

live_loop :shuff, auto_cue: false do
  with_fx :hpf, cutoff: 10, reps: 8 do
    tick
    sleep 0.25
    sample :bd_haus, amp: factor?(look, 8) ? 6 : 4
    sleep 0.25
    sample :hat_raw, amp: factor?(look, 2) ? 12 : 4
    sleep 0.25
    sample :drum_snare_hard, amp: factor?(look, 2) ? 12 : 4
    use_synth :tb303
    use_synth_defaults cutoff_attack: 1, cutoff_release: 0, env_curve: 2
    play (knit :e2, 24, :c2, 8).look, release: 1.5, cutoff: (range 70, 90).look, amp: 2 if factor?(look, 2)
    sample :drum_snare_hard, rate: -1, sustain: 0, release: (knit 0.05, 3, 0.5, 1).look
  end
end

use_random_seed 667
load_sample :ambi_lunar_land
sleep 1

live_loop :travelling do
  use_synth :beep
  notes = scale(38, :acemli_rast, num_octaves: 2)
  use_random_seed 679
  tick_reset_all
  with_fx :echo, phase: 0.125, mix: 0.4, reps: 16 do
    sleep 0.25
    play notes.choose, attack: 0, release: 0.1, pan: (range -1, 1, step: 0.125).tick, amp: rrand(2, 2.5)
  end
end

live_loop :comet, auto_cue: false do
  if one_in 4
    synth :prophet
    puts :comet_landing
  end
  sleep 8
end

live_loop :snare do
  if one_in 8
    sample :drum_snare_hard
    puts :comet_landing
  end
end


live_loop :shuff, auto_cue: false do
  with_fx :hpf, cutoff: 10, reps: 8 do
    tick
    sleep 0.25
    sample :bd_haus, amp: factor?(look, 8) ? 6 : 4
    sleep 0.25
    use_synth :tb303
    use_synth_defaults cutoff_attack: 1, cutoff_release: 0, env_curve: 2
    play (knit :e2, 24, :c2, 8).look, release: 1.5, cutoff: (range 70, 90).look, amp: 2 if factor?(look, 2)
    sample :sn_dub, rate: -1, sustain: 0, release: (knit 0.05, 3, 0.5, 1).look
  end
end
