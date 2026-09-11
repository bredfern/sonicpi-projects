use_bpm 60

# Reverb and low-pass filtering simulate outdoor atmospheric density
with_fx :reverb, room: 0.85, mix: 0.6, damp: 0.5 do
  
  # --------------------------------------------------
  # 1. DENSE RAIN WALL (Continuous Heavy Downpour)
  # --------------------------------------------------
  live_loop :rain_wall do
    use_synth :bnoise
    
    # Dual-filter stack shapes white noise into a roaring wall of water
    with_fx :lpf, cutoff: rrand(75, 90) do
      with_fx :hpf, cutoff: 35 do
        play :c3, attack: 0.5, sustain: 2, release: 0.5, amp: rrand(1.8, 2.4)
      end
    end
    sleep 2.5
  end

  # --------------------------------------------------
  # 2. DROP IMPACTS (Heavy Drops Striking Surfaces)
  # --------------------------------------------------
  live_loop :heavy_drops do
    use_synth :sine
    
    # Fast micro-bursts of pitch-dropping sine waves mimic distinct drops
    8.times do
      drop_pitch = rrand(60, 85)
      
      node = play drop_pitch, 
        attack: 0.001, 
        release: rrand(0.02, 0.05), 
        amp: rrand(0.4, 0.9), 
        pan: rrand(-0.8, 0.8)
        
      # Rapid downward pitch-bend simulates liquid impact
      control node, note: drop_pitch - 12, note_slide: 0.01
      
      sleep [0.0625, 0.125, 0.1875].choose
    end
  end

  # --------------------------------------------------
  # 3. HIGH SPLASH & SPRAY (Misting Noise Layer)
  # --------------------------------------------------
  live_loop :splash_spray do
    use_synth :cnoise
    
    # High-pass filter isolates the crisp, sizzle quality of heavy splashing
    with_fx :hpf, cutoff: 85 do
      play :c4, attack: 0.2, sustain: 1, release: 0.3, amp: rrand(0.5, 0.9)
    end
    sleep 1.25
  end

  # --------------------------------------------------
  # 4. WATER SURGES (Dynamic Downpour Swells)
  # --------------------------------------------------
  live_loop :rain_surge do
    # Periodic swells simulate sudden torrential bursts
    sleep rrand(4, 8)
    
    use_synth :pink_noise
    surge_time = rrand(2, 4)
    
    with_fx :lpf, cutoff: rrand(80, 105) do
      play :c2, attack: surge_time * 0.5, release: surge_time * 0.5, amp: rrand(1.2, 2.0)
    end
  end

end