# Coded by Sam Aaron
use_tuning :just
scale 50, :saba

with_fx :reverb, mix: 0.7 do
  live_loop :haunted do
    sample :perc_bell, rate: rrand(-1.5, 1.5)
    sleep rrand(0.1, 2)
  end
end
