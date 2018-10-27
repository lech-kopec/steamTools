require 'gruff'
require 'irb'

require 'matplotlib/pyplot'

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

xs = []
limit10k.to_i.times do |x|
  xs.push x
end

plt = Matplotlib::Pyplot
plt.plot (1..values.length).to_a, values
#plt.plot (1..trend.length).to_a, trend
plt.title "10K in months:  #{(limit10k/7/4).to_s}"

plt.figure 1
plt.plot (1..values.length).to_a, values

plt.figure 2
plt.plot (1..values.length).to_a, values
plt.plot (1..trend.length).to_a, trend
plt.show