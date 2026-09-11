# Set global reverb and delay to simulate underwater reverberation
with_fx :reverb, mix: 0.8, room: 0.9 do
  with_fx :echo, phase: 0.75, decay: 8, mix: 0.5 do
    
    live_loop :whale_song do
      use_synth :prophet
      
      # Pick random whale-like pitches (low register, wide intervals)
      start_note = [:c2, :eb2, :f2, :g2, :bb2, :c3].choose
      end_note   = [:c2, :eb2, :f2, :g2, :bb2, :c3].choose
      
      # Randomize call duration and glide timing
      duration = rrand(3, 7)
      
      # Filter sweep to mimic sound traveling through deep water
      with_fx :lpf, cutoff: rrand(50, 85) do
        
        # Trigger the initial note
        node = play start_note,
          attack: duration * 0.3,
          decay: 0,
          sustain: duration * 0.4,
          release: duration * 0.3,
          amp: 1.5
        
        # Smoothly slide pitch mid-note (the signature whale "cry")
        control node, note: end_note, note_slide: duration * 0.6
        
      end
      
      # Natural pause between whale calls
      sleep duration + rrand(1, 4)
    end
    
  end
end