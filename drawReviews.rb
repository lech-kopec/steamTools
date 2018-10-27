require 'gruff'
require 'irb'

lines = IO.readlines 'F51Reviews'
values = []
lines.map do |x|
  splitted = x.split(';')
  value = splitted[1].to_i + splitted[2].to_i
  values.push value
end


n = values.length
sumYlnX = 0
sumY = 0
sumlnX = 0
sumlnX2 = 0
values.each_with_index do |y,x|
  x += 1
  sumYlnX += (y*Math.log(x))
  sumY += y
  sumlnX += Math.log(x)
  sumlnX2 += Math.log(x)**2
end

coefB = (n*sumYlnX - sumY*sumlnX) / (n*sumlnX2 - sumlnX**2)
coefA = (sumY - coefB * sumlnX) / n

limit10k = 2.718 ** ((10000 - coefA)/coefB)
trend = []
limit10k.to_i.times do |i|
  i += 1
  trend.push(coefA + (coefB*Math.log(i)))
end

g = Gruff::Line.new
g.hide_dots = true
g.title = "Current: #{n}; 10K reached #{limit10k/n/4} months"
g.data :Jimmy, values
g.data :Trend, trend
g.write('exciting.png')