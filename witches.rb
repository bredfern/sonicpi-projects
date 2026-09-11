# Atmospheric environment (spooky spatial echo)
with_fx :reverb, room: 0.9, mix: 0.22 do
  with_fx :echo, phase: 0.375, decay: 4, mix: 0.25 do
    
    # --------------------------------------------------
    # 1. MAIN WITCH CACKLE (Formant-Filtered Vocal Bends)
    # --------------------------------------------------
    live_loop :witch_cackle do
      # Random pauses between full cackling fits
      sleep rrand(3, 8)
      
      use_synth :chipnoise
      
      # Vocal-like bandpass filter modulation
      with_fx :bpf, centre: rrand(75, 95), res: 0.85 do |f|
        
        # Rapid staccato bursts ("Heh-heh-heh-heh")
        cackle_length = [5, 7, 9, 12].choose
        cackle_length.times do |i|
          
          # Cackles start high and slide down erratically
          base_note = :g4 + [0, 3, 6, 9, 12].choose
          
          node = play base_note,
            attack: 0.01,
            decay: 0.08,
            sustain: 0.02,
            release: 0.05,
            amp: rrand(1.2, 2.2),
            pan: rrand(-0.7, 0.7)
          
          # Upward or downward pitch bend per "laugh"
          control node, note: base_note + rrand(-5, 5), note_slide: 0.04
          
          # Laughs speed up toward the end of the burst
          sleep [0.1, 0.125, 0.15].choose * (1.0 - (i.to_f / cackle_length * 0.4))
        end
        
        # Long tail-end howl at the end of the cackle
        howl_note = :g5
        node = play howl_note, attack: 0.05, release: 1.2, amp: 2.0
        control node, note: howl_note - 14, note_slide: 0.8
        
      end
    end
    
    # --------------------------------------------------
    # 2. HIGH SHRIEK / SCREECH (Piercing Layer)
    # --------------------------------------------------
    live_loop :witch_shriek do
      sleep rrand(6, 14)
      
      use_synth :growl
      with_fx :hpf, cutoff: 90 do
        shriek_note = [:c6, :eb6, :fs6, :a6].choose
        
        node = play shriek_note, attack: 0.02, sustain: 0.3, release: 0.6, amp: 1.5
        control node, note: shriek_note - 8, note_slide: 0.4
      end
    end
    
    # --------------------------------------------------
    # 3. BUBBLING CAULDRON (Low Resonant Fluid Texture)
    # --------------------------------------------------
    live_loop :cauldron_bubbles do
      use_synth :sine
      
      # Micro-pops with pitch drops simulate bubbling liquid
      16.times do
        pop_note = rrand(48, 72)
        node = play pop_note, attack: 0.001, release: 0.03, amp: rrand(0.3, 0.8), pan: rrand(-0.4, 0.4)
        control node, note: pop_note + 12, note_slide: 0.01
        sleep [0.0625, 0.125, 0.1875].choose
      end
    end
    
    # --------------------------------------------------
    # 4. EERIE WIND GUSTS (Atmospheric Backdrop)
    # --------------------------------------------------
    live_loop :spooky_wind do
      use_synth :noise
      wind_time = rrand(4, 28)
      
      with_fx :bpf, centre: rrand(20, 70), res: 0.9 do
        play :c3, attack: wind_time * 0.5, release: wind_time * 0.5, amp: rrand(0.8, 1.4)
      end
      sleep wind_time
    end
    
  end
end