require 'net/http'
require 'irb'

uri = URI 'https://store.steampowered.com/app/674020/World_War_3/?curator_clanid=4777282&utm_source=SteamDB'

response = Net::HTTP.get(uri)

results = response.scan(/user_reviews_count.{10}/)

mapped = results.map {|x| x.gsub(/\D/,'').to_i }

last_line = IO.readlines('F51Reviews')[-1]

prev_values = last_line.split(';')[1..2]
prev_values.map! { |x| x.to_i }

return if prev_values[0] == mapped[1] && prev_values[1] == mapped[2]

open('F51Reviews', 'a') do |f|
  f.puts Time.now.to_s + ' ; ' + mapped[1..2].join(';')
end
