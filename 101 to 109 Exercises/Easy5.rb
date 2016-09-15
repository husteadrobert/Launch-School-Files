# ASCII String Value

def ascii_value(message)
  sum = 0
  message.each_char {|value| sum += value.ord}
  sum
end

# After Midnight (Part 1)

def time_of_day(minutes)
  current_hour = 0
  current_minute = 0

  hour_diff = minutes.abs / 60 % 24
  minute_diff = minutes.abs % 60

  if minutes > 0
    current_hour += hour_diff
    current_minute += minute_diff
  elsif minutes < 0
    current_hour  = 23 - hour_diff
    current_minute = 60 - minute_diff
  end
  if current_hour < 10
    current_hour = '0' << current_hour.to_s
  end
  if current_minute < 10
    current_minute = '0' << current_minute.to_s
  end
  current_hour.to_s << ':' << current_minute.to_s
end
# LS Solution
MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR

def time_of_day(delta_minutes)
  delta_minutes =  delta_minutes % MINUTES_PER_DAY
  hours, minutes = delta_minutes.divmod(MINUTES_PER_HOUR)
  format('%02d:%02d', hours, minutes)
end

# After Midnight (Part 2)

def before_midnight(time)
  time_array = time.split(':').map{|val| val.to_i}
  total_minutes = (time_array[0] * 60) + time_array[1]
  before = 1440 - total_minutes
  if before == 1440 then return 0 end
  return before
end

def after_midnight(time)
  time_array = time.split(':').map{|val| val.to_i}
  total_minutes = (time_array[0] * 60) + time_array[1]
  if total_minutes == 1440 then return 0 end
  return total_minutes
end
# LS Solution
HOURS_PER_DAY = 24
MINUTES_PER_HOUR = 60
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR

def after_midnight(time_str)
  hours, minutes = time_str.split(':').map(&:to_i)
  (hours * MINUTES_PER_HOUR + minutes) % MINUTES_PER_DAY
end

def before_midnight(time_str)
  delta_minutes = MINUTES_PER_DAY - after_midnight(time_str)
  delta_minutes = 0 if delta_minutes == MINUTES_PER_DAY
  delta_minutes
end

# Letter Swap
def swap(message)
  new_message = []
  message.split.map do |word|
    if word.length == 1
      new_message << word
      next
    end
    first_letter = word[0]
    last_letter = word[-1]
    new_word = last_letter << word[1..(word.length - 2)] << first_letter
    new_message << new_word
  end
  new_message.join(' ')
end
# LS Solution
def swap_first_last_characters(word)
  word[0], word[-1] = word[-1], word[0]
  word
end

def swap(words)
  result = words.split.map do |word|
    swap_first_last_characters(word)
  end
  result.join(' ')
end

