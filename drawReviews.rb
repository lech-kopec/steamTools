require_relative 'trend_line.rb'
require 'matplotlib/pyplot'

lines = IO.readlines 'F51Reviews'
values = []
lines.map do |x|
  splitted = x.split(';')
  value = splitted[1].to_i + splitted[2].to_i
  values.push value
end

a,b = TrendLines.calc_cooef_ln(values)
trend = TrendLines.calc_trend_line_values_ln(values.length * 2, a,b)

plt = Matplotlib::Pyplot
plt.plot (1..values.length).to_a, values

#plt.figure 1
plt.subplot(2,1,1)
plt.plot (1..values.length).to_a, values

#plt.figure 2
plt.subplot(2,1,2)
plt.plot (1..values.length).to_a, values
plt.plot (1..trend.length).to_a, trend
plt.show