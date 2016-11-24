#!/usr/bin/env ruby


complexity = ARGV[0].to_i ** ARGV[1].to_i

if complexity == 1
  puts "Usage: cracking_duration possibilities characters"
  puts "eg.: cracking_duration 95 8"
  exit 1
else
  puts "Complexity is #{complexity}\n"
end


def hr(v)
  return "#{v}s" if v < 60
  return "#{(v / 60.0).round(2)}m" if v < 3600
  return "#{(v / 3600.0).round(2)}h" if v < 3600*24
  return "#{(v / 3600.0 / 24).ceil}d" if v < 3600*24*365
  return "#{(v / 3600.0 / 24 / 365.25).ceil}y"
end

#
# how much does it cost to crack a value in less than 30 days?
#
# Amazon p2.16xlarge costs 14.4 USD per hour.
# Sagitta Brutalis costs 18500 USD, thats ~1285h (7.6 weeks) p2.16xlarge instance usage
# but the instance is only about half as fast, so it is rather 4 weeks and two instances
#
# Params: t – cracking time for one unit/instance in seconds
# Returns {price, units}
def cost(speed, complexity, multiplier)
  t = complexity / speed.to_f
  days = t / 3600.0 / 24.0
  units = (days / 30.0).ceil
  price = units * multiplier
  {time: t, price: price, units: units}
end

def brutalis(speed, complexity)
  cost(speed, complexity, 18500)
end

def amazon(speed, complexity)
  # instance for 30 days: 30 * 24 * 14.4 = 10368
  cost(speed, complexity, 10368)
end


speeds = {
  :MD5            => [73_286_500_000, 200_300_000_000],
  :Skype          => [46_770_600_000, 104_200_000_000],
  :AndroidPIN     => [21_515_000, 43_559_300],
  :MyWallet       => [290_800_000, 402_900_000],
  :BitcoinWallet  => [14_019, 36_030],
  :WPA2           => [1_316_200, 3_177_600],
  :LastPass       => [9_032_300, 18_513_000],
  :TrueCrypt      => [183_900, 292_800],
  :VeraCrypt      => [357, 595],
  :SHA256         => [12_275_600_000, 23_012_100_000],
  :BCrypt         => [33_943, 105_700]
}

puts "         hash |       EC2       |     Brutalis"
puts "--------------|-----------------|-----------------"

speeds.each_pair do |name, speed|
  name = name.to_s.rjust(13)
  ec2 = amazon(speed[0], complexity)
  bru = brutalis(speed[1], complexity)
  ec2_t = hr(ec2[:time]).to_s.rjust(16)
  bru_t = hr(bru[:time]).to_s.rjust(16)

  puts "#{name} |#{ec2_t} |#{bru_t} | $#{ec2[:price]} n=#{ec2[:units]} | $#{bru[:price]} n=#{bru[:units]}"

end
