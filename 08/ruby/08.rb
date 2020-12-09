def parse_command(command)
  if command == "nop"
    :nop
  elsif command == "acc"
    :acc
  elsif command == "jmp"
    :jmp
  else
    raise "Invalid Command"
  end
end


class InstructionStatus
  attr_accessor :acc, :pos

  def initialize(acc, pos)
    @acc = acc
    @pos = pos
  end
end


class Instruction
  attr_accessor :command, :number, :executed

  def initialize(command, number, executed)
    @command = command
    @number = number
    @executed = executed
  end

  def self.parse(raw_instruction)
    command = parse_command raw_instruction[0]
    Instruction.new command, raw_instruction[1].to_i, false
  end

  def copy()
    Instruction.new @command, @number, @executed
  end

  def is_jmp()
    @command == :jmp
  end

  def is_acc()
    @command == :acc
  end

  def is_nop()
    @command == :nop
  end

  def run_instruction(status)
    if @executed
      raise "Loop"
    end
    @executed = true
    if self.is_acc
      status.acc += @number
      status.pos += 1
    elsif self.is_jmp
      status.pos += @number
    else
      status.pos += 1
    end
    status
  end
end


class ProgramStatus
  attr_accessor :terminated, :acc, :pos

  def initialize(terminated, acc, pos)
    @terminated = terminated
    @acc = acc
    @pos = pos
  end
end


def prepare_instructions(raw_instructions)
  raw_instructions.map{ |inst| Instruction.parse inst}
end


class Program
  attr_accessor :instructions

  def initialize(instructions)
    @instructions = instructions
  end

  def self.parse(raw_instructions)
    instructions = prepare_instructions(raw_instructions)
    Program.new(instructions)
  end

  def run()
    status = InstructionStatus.new(0, 0)
    begin
      while status.pos >= 0 and status.pos < instructions.length
        status = instructions[status.pos].run_instruction status
      end
      return ProgramStatus.new(true, status.acc, status.pos)
    rescue Exception => ex
      return ProgramStatus.new(false, status.acc, status.pos)
    end
  end
end


class Bruteforce
  attr_accessor :change_pos, :original_instructions

  def initialize(instructions)
    @original_instructions = instructions
    @change_pos = 0
  end

  def self.parse(raw_instructions)
    instructions = prepare_instructions(raw_instructions)
    Bruteforce.new(instructions)
  end


  def run()
    length = @original_instructions.length
    while @change_pos < length
      new_instructions = self.next_change
      program = Program.new(new_instructions)
      status = program.run
      if status.terminated
        return status
      end
    end
  end

  def next_change()
    @original_instructions[@change_pos..@original_instructions.length].each_with_index {
      |instruction, i|
      if instruction.is_nop
        @change_pos += i
        new_instructions = @original_instructions.map{|x| x.copy}  # deep copy
        new_instructions[@change_pos].command = :jmp
        @change_pos += 1
        return new_instructions
      elsif instruction.is_jmp
        @change_pos += i
        new_instructions = @original_instructions.map{|x| x.copy}  # deep copy
        new_instructions[@change_pos].command = :nop
        @change_pos += 1
        return new_instructions
      end
    }
    raise "No termination possible"
  end
end

def read_file(filename)
  file = File.open(filename)
  file.readlines.map(&:chomp).map(&:split)
end


def part1(filename)
  instruction_list = read_file(filename)
  program = Program.parse(instruction_list)
  status = program.run
  puts "Part 1:"
  puts status.acc
end


def part2(filename)
  instruction_list = read_file(filename)
  bruteforce = Bruteforce.parse(instruction_list)
  status = bruteforce.run
  puts "Part 2:"
  puts status.acc
end


puts part1("input.txt")
puts part2("input.txt")
