
class SecretHandshake
  def initialize(input)
    @input = input
  end

  def commands
    code = format_input
    command_array = []
    command_array << "wink" if code[-1] == '1'
    command_array << "double blink" if code[-2] == '1'
    command_array << "close your eyes" if code[-3] == '1'
    command_array << "jump" if code[-4] == '1'
    command_array.reverse! if code[-5] == '1'
    command_array
  end

  private

  def format_input
    if @input.class == Fixnum
      @input.to_s(2)
    elsif @input.to_i.to_s == '0'
      []
    else
      @input
    end
  end
end
