#!/usr/bin/env ruby


def hr(v)
  return "#{v}s" if v < 60
  return "#{(v / 60.0).round(2)}m" if v < 3600
  return "#{(v / 3600.0).round(2)}h" if v < 3600*24
  return "#{(v / 3600.0 / 24).ceil}d" if v < 3600*24*365
  return "#{(v / 3600.0 / 24 / 365.25).ceil}y"
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

complexity = ARGV[0].to_i ** ARGV[1].to_i

if complexity == 1
  puts "Usage: cracking_duration possibilities characters"
  puts "eg.: cracking_duration 95 8"
  exit 1
else
  puts "Complexity is #{complexity}\n"
end

puts "         hash |       EC2       |     Brutalis"
puts "--------------|-----------------|-----------------"

speeds.each_pair do |name, speed|
  name = name.to_s.rjust(13)
  ec2 = hr(complexity / speed[0]).to_s.rjust(16)
  bru = hr(complexity / speed[1]).to_s.rjust(16)
  puts "#{name} |#{ec2} |#{bru}"
end
