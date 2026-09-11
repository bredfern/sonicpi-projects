use_bpm 60

# Atmospheric environment (spooky spatial echo)
with_fx :reverb, room: 0.9, mix: 0.75 do
  with_fx :echo, phase: 0.375, decay: 4, mix: 0.45 do

    # --------------------------------------------------
    # 1. MAIN WITCH CACKLE (Formant-Filtered Vocal Bends)
    # --------------------------------------------------
    live_loop :witch_cackle do
      sleep rrand(4, 9)
      
      use_synth :saw
      
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
    # 2. HEAVY FOOTSTEPS (Slow, Muffled Floorboard Thuds)
    # --------------------------------------------------
    live_loop :footsteps do
      # Occurs in small walking bursts
      sleep rrand(6, 12)
      
      step_count = [3, 4, 5, 6].choose
      step_count.times do
        # Low noise impact with a sub-frequency thump
        with_fx :lpf, cutoff: rrand(45, 60) do
          use_synth :brown_noise
          play :c2, attack: 0.01, release: 0.12, amp: rrand(1.8, 2.4), pan: rrand(-0.5, 0.5)
          
          use_synth :sine
          node = play :c1, attack: 0.005, release: 0.1, amp: 2.0
          control node, note: :c1 - 7, note_slide: 0.02
        end
        
        # Paced human walking rhythm
        sleep rrand(0.65, 0.85)
      end
    end

    # --------------------------------------------------
    # 3. CREAKING DOOR (High-Resonance Sweeping Friction)
    # --------------------------------------------------
    live_loop :creaking_door do
      sleep rrand(8, 16)
      
      use_synth :saw
      creak_duration = rrand(1.5, 3.0)
      start_freq = rrand(60, 75)
      end_freq = start_freq + rrand(-15, 20)
      
      # Extreme resonance (res: 0.98) creates the wooden groaning tone
      with_fx :bpf, centre: start_freq, res: 0.98 do |f|
        node = play :c3, attack: creak_duration * 0.2, release: creak_duration * 0.8, amp: 2.2, pan: rrand(-0.8, 0.8)
        
        # Slow filter sweep mimics the door slowly swinging open/shut
        control f, centre: end_freq, centre_slide: creak_duration
        
        # Micro pitch wobble adds uneven friction sound
        (creak_duration * 10).to_i.times do
          control node, note: :c3 + rrand(-2, 2), note_slide: 0.08
          sleep 0.1
        end
      end
    end

    # --------------------------------------------------
    # 4. BUBBLING CAULDRON (Fluid Texture)
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
    # 5. EERIE WIND GUSTS (Atmosphere)
    # --------------------------------------------------
    live_loop :spooky_wind do
      use_synth :pink_noise
      wind_time = rrand(4, 8)
      
      with_fx :bpf, centre: rrand(50, 70), res: 0.9 do
        play :c3, attack: wind_time * 0.5, release: wind_time * 0.5, amp: rrand(0.7, 1.2)
      end
      sleep wind_time
    end

  end
end