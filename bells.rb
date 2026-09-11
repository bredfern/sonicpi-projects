use_bpm 60

# Atmospheric environment (spooky spatial echo)
with_fx :reverb, room: 0.9, mix: 0.75 do
  with_fx :echo, phase: 0.375, decay: 4, mix: 0.45 do
    
    # --------------------------------------------------
    # 1. WOLF HOWL (Mournful Pitch-Slide & Bandpass Filter)
    # --------------------------------------------------
    live_loop :wolf_howl do
      sleep rrand(10, 20)
      
      use_synth :beep
      howl_duration = rrand(4.0, 6.0)
      start_note = :g3
      peak_note = :d4
      end_note = :a3
      
      # Dual bandpass filtering mimics animal vocal tracts
      with_fx :bpf, centre: 70, res: 0.85 do
        with_fx :bpf, centre: 85, res: 0.7 do
          
          # Initial attack and swell
          node = play start_note,
            attack: howl_duration * 0.25,
            sustain: howl_duration * 0.35,
            release: howl_duration * 0.4,
            amp: 2.2,
            pan: rrand(-0.9, 0.9)
          
          # Slide pitch UP to peak, then slowly DOWN to fade
          control node, note: peak_note, note_slide: howl_duration * 0.3
          sleep howl_duration * 0.3
          
          control node, note: end_note, note_slide: howl_duration * 0.5
          sleep howl_duration * 0.7
        end
      end
    end
    
    # --------------------------------------------------
    # 2. BAT SCREECHES & ECHOLOCATION (Ultrasonic Chirps)
    # --------------------------------------------------
    live_loop :bat_screeches do
      sleep rrand(5, 12)
      
      use_synth :blade
      chirp_count = rrand_i(4, 9)
      
      # Bats fly across the stereo field in quick flutter bursts
      fly_pan = rrand(-0.8, 0.8)
      
      chirp_count.times do
        base_pitch = rrand(96, 108) # Very high register (C7 - C8)
        
        # High-frequency chirp dropping rapidly in pitch
        node = play base_pitch,
          attack: 0.001,
          release: rrand(0.015, 0.035),
          amp: rrand(0.6, 1.2),
          pan: fly_pan
        
        control node, note: base_pitch - rrand(12, 24), note_slide: 0.01
        
        sleep rrand(0.04, 0.09)
      end
    end
    
    # --------------------------------------------------
    # 3. MAIN WITCH CACKLE (Formant-Filtered Vocal Bends)
    # --------------------------------------------------
    live_loop :witch_cackle do
      sleep rrand(6, 12)
      
      use_synth :chipnoise
      
      with_fx :bpf, centre: rrand(75, 95), res: 0.85 do
        cackle_length = [5, 7, 9, 12].choose
        cackle_length.times do |i|
          base_note = :g4 + [0, 3, 6, 9, 12].choose
          
          node = play base_note,
            attack: 0.01,
            decay: 0.08,
            sustain: 0.02,
            release: 0.05,
            amp: rrand(1.2, 2.2),
            pan: rrand(-0.7, 0.7)
          
          control node, note: base_note + rrand(-5, 5), note_slide: 0.04
          sleep [0.1, 0.125, 0.15].choose * (1.0 - (i.to_f / cackle_length * 0.4))
        end
        
        howl_note = :g5
        node = play howl_note, attack: 0.05, release: 1.2, amp: 2.0
        control node, note: howl_note - 14, note_slide: 0.8
      end
    end
    
    # --------------------------------------------------
    # 4. HEAVY FOOTSTEPS (Slow, Muffled Floorboard Thuds)
    # --------------------------------------------------
    live_loop :footsteps do
      sleep rrand(8, 15)
      
      step_count = [3, 4, 5, 6].choose
      step_count.times do
        with_fx :lpf, cutoff: rrand(45, 60) do
          use_synth :bnoise
          play :c2, attack: 0.01, release: 0.12, amp: rrand(1.8, 2.4), pan: rrand(-0.5, 0.5)
          
          use_synth :sine
          node = play :c1, attack: 0.005, release: 0.1, amp: 2.0
          control node, note: :c1 - 7, note_slide: 0.02
        end
        sleep rrand(0.65, 0.85)
      end
    end
    
    # --------------------------------------------------
    # 5. CREAKING DOOR (High-Resonance Sweeping Friction)
    # --------------------------------------------------
    live_loop :creaking_door do
      sleep rrand(10, 18)
      
      use_synth :saw
      creak_duration = rrand(1.5, 3.0)
      start_freq = rrand(60, 75)
      end_freq = start_freq + rrand(-15, 20)
      
      with_fx :bpf, centre: start_freq, res: 0.98 do |f|
        node = play :c3, attack: creak_duration * 0.2, release: creak_duration * 0.8, amp: 2.2, pan: rrand(-0.8, 0.8)
        control f, centre: end_freq, centre_slide: creak_duration
        
        (creak_duration * 10).to_i.times do
          control node, note: :c3 + rrand(-2, 2), note_slide: 0.08
          sleep 0.1
        end
      end
    end
    
    # --------------------------------------------------
    # 6. BUBBLING CAULDRON (Fluid Texture)
    # --------------------------------------------------
    live_loop :cauldron_bubbles do
      use_synth :sine
      16.times do
        pop_note = rrand(48, 72)
        node = play pop_note, attack: 0.001, release: 0.03, amp: rrand(0.3, 0.8), pan: rrand(-0.4, 0.4)
        control node, note: pop_note + 12, note_slide: 0.01
        sleep [0.0625, 0.125, 0.1875].choose
      end
    end
    
    # --------------------------------------------------
    # 7. EERIE WIND GUSTS (Atmosphere)
    # --------------------------------------------------
    live_loop :spooky_wind do
      use_synth :pnoise
      wind_time = rrand(4, 8)
      
      with_fx :bpf, centre: rrand(50, 70), res: 0.9 do
        play :c3, attack: wind_time * 0.5, release: wind_time * 0.5, amp: rrand(0.7, 1.2)
      end
      sleep wind_time
    end
    
  end
end