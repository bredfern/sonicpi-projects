# Conch Trumpet / Horn Sound Synthesis for Sonic Pi

use_bpm 60

live_loop :conch_trumpet do
  # Frequency parameters (D2 ~ 146.83 Hz / MIDI note 38)
  note_num = 60
  dur = 3.5
  
  use_synth_defaults sustain: dur * 0.8, release: dur * 0.2, amp: 0.8
  
  # Dynamic pitch stabilization & vibrato sub-loop running concurrently
  in_thread do
    tick
    # Pitch bend initialization and vibrato modulation
    with_fx :autotuner, depth: 0.15, rate: 5 do
      # Oscillator 1: Primary Sawtooth
      synth :saw, note: note_num - 0.03, cutoff: rrand(10, 85), note_slide: 0.4
      
      # Oscillator 2: Detuned Sawtooth for thickness
      synth :supersaw, note: note_num + 0.03, cutoff: rrand(20,85), note_slide: 0.4
      
      # Oscillator 3: Narrow Pulse for reed/conch resonance
      synth :pulse, note: note_num, pulse_width: 0.45, cutoff: rrand(20, 80), amp: 0.5, note_slide: 0.4
    end
  end
  
  # Low-pass filter automation mimicking the horn enclosure
  with_fx :lpf, cutoff: rrand(20, 88), cutoff_slide: dur do |f|
    control f, cutoff: rrand(20, 70)
  end
  
  # Warm room reverb matching natural shell acoustic
  with_fx :reverb, room: 0.6, mix: 0.35 do
    sleep dur + 0.5
  end
end