#!/usr/bin/env ruby

#Setup Load Path
lib = File.expand_path("../../lib", __FILE__)
ttt_lib = File.expand_path("../../../Apprenticeship-RubyTicTacToe/lib", __FILE__)
$:.unshift(lib).unshift(ttt_lib)

require 'command_line_app'
require 'command_line_ui'
require 'board_factory'
require 'command_line_player_factory'
require 'prompt_writer'
require 'prompt_reader'

writer = PromptWriter.new($stdout)
reader = PromptReader.new($stdin)
command_line_ui = CommandLineUI.new(writer, reader)

board_factory = BoardFactory.new
player_factory = CommandLinePlayerFactory.new

command_line_app = CommandLineApp.new(command_line_ui, board_factory, player_factory)
command_line_app.start
