class PromptReader

  def initialize(std_in)
    @std_in = std_in
  end

  def get_input()
    std_in.gets.chomp
  end

  private

  attr_reader :std_in
end
