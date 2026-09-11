# Title: Halloween Spooktacular
# Description: Cauldron, Cackling Witches, Howling Ghosts, Moaning Monsters & Chains

use_bpm 60

# ==============================================================================
# 1. BUBBLING CAULDRON (Continuous Background)
# ==============================================================================
live_loop :cauldron do
  # Low rumbling fire/brew base
  use_synth :dark_ambience
  with_fx :lpf, cutoff: 60 do
    play :c1, sustain: 2, release: 1, amp: 1.2
  end
  
  # Random liquid bubbles
  16.times do
    if one_in(2)
      use_synth :chipbass
      with_fx :bpf, centre: rrand(70, 100), res: 0.8 do
        play rrand(60, 85),
          attack: 0.005,
          decay: rrand(0.02, 0.05),
          sustain: 0,
          release: 0.01,
          amp: rrand(0.3, 0.7),
          pan: rrand(-0.5, 0.5)
      end
    end
    sleep 0.125
  end
end

# ==============================================================================
# 2. CACKLING WITCH (Staccato FM Sweeps & Formants)
# ==============================================================================
live_loop :witch, auto_cue: false do
  sleep rrand(4, 8) # Pauses between cackles
  
  cackle_length = rdist(8, 12)
  base_note = rrand(68, 75)
  
  use_synth :mod_fm
  with_fx :echo, phase: 0.125, decay: 1.5 do
    with_fx :bpf, centre: 85, res: 0.7 do
      cackle_length.times do |i|
        # Pitch jumps higher and faster towards the end of the cackle
        pitch = base_note + (i * 1.5) + rrand(-2, 2)
        
        play pitch,
          mod_rate: rrand(12, 20),
          mod_index: 3,
          attack: 0.01,
          release: 0.08,
          amp: 0.8,
          pan: line(-0.8, 0.8, steps: cackle_length)[i]
        
        sleep rrand(0.06, 0.12)
      end
    end
  end
end

# ==============================================================================
# 3. HOWLING GHOSTS (Glissando Sine Waves with Reverb)
# ==============================================================================
live_loop :ghosts do
  sleep rrand(2, 5)
  
  use_synth :sing
  with_fx :reverb, room: 0.9, mix: 0.8 do
    with_fx :pan, pan: rrand(-0.8, 0.8) do
      # Pitch sweep up and down
      start_note = rrand(60, 72)
      target_note = rrand(75, 87)
      duration = rrand(3, 6)
      
      node = play start_note, attack: 1.5, sustain: duration, release: 2, amp: 0.6, vibe_rate: 4
      
      # Perform the pitch sweep (glissando)
      control node, note: target_note, note_slide: duration * 0.6
      sleep duration * 0.5
      control node, note: start_note - 5, note_slide: duration * 0.5
      
      sleep duration * 0.5 + 2
    end
  end
end

# ==============================================================================
# 4. MOANING MONSTERS & SHAKING CHAINS
# ==============================================================================
live_loop :monster_and_chains do
  sleep rrand(3, 6)
  
  # --- MONSTER MOAN ---
  in_thread do
    use_synth :saw
    with_fx :distortion, distort: 0.4 do
      with_fx :lpf, cutoff: rrand(40, 55) do
        moan_note = rrand(30, 38)
        node = play moan_note, attack: 1.0, sustain: 2.5, release: 1.5, amp: 0.9
        control node, note: moan_note - 4, note_slide: 3.0
      end
    end
  end
  
  # --- SHAKING CHAINS ---
  in_thread do
    sleep 0.5
    12.times do
      use_synth :cnoise
      # High metallic bandpass filters for iron ring
      with_fx :band_eq, centre: rrand(100, 120), res: 0.95 do
        with_fx :reverb, room: 0.6, mix: 0.4 do
          play :c4,
            attack: 0.001,
            decay: rrand(0.02, 0.06),
            sustain: 0,
            release: 0.01,
            amp: rrand(0.5, 1.0),
            pan: rrand(-0.6, 0.6)
        end
      end
      sleep rrand(0.05, 0.15)
    end
  end
end