# Coded by Sam Aaron

use_synth :bnoise
use_tuning :just
scale 50, :saba

live_loop :sci_fi do
  p = play (chord :Eb3, :minor).choose - [0, 12, -12].choose, divisor: 0.01, div_slide: rrand(0, 10), depth: rrand(0.001, 20), attack: 0.01, release: rrand(0, 20), amp: 0.5
  control p, divisor: rrand(0.001, 5)
  sleep [0.5, 1, 2].choose
end
