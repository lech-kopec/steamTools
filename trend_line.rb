module TrendLines

  # input - array of values
  def TrendLines.calc_cooef_ln(values)
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

    return coefA, coefB
  end

  # n - length of trend line
  # a - first cooeficient for ln trend line
  # b - second cooeficient for ln trend line
  # returns values calculated with y = a + b * ln(x)
  def TrendLines.calc_trend_line_values_ln(n, a, b)
    trend = []
    n.times do |i|
      i += 1
      trend.push(a + (b * Math.log(i)))
    end
    return trend
  end

  def TrendLines.calc_trend_line_ln (values)
    a,b = TrendLines.calc_cooef_ln(values)
    ys = TrendLines.calc_trend_line_values_ln(values.length, a,b)
    return ys
  end

end
