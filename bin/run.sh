#!/usr/bin/env ruby

#Setup Load Path
lib = File.expand_path("../../lib", __FILE__)
$:.unshift(lib)

require 'board_factory'
require 'command_line_app'
require 'command_line_player_factory'
require 'command_line_ui'
require 'prompt_reader'
require 'prompt_writer'

writer = PromptWriter.new($stdout)
reader = PromptReader.new($stdin)
command_line_ui = CommandLineUI.new(writer, reader)

board_factory = BoardFactory.new
player_factory = CommandLinePlayerFactory.new

command_line_app = CommandLineApp.new(command_line_ui, board_factory, player_factory)
command_line_app.start
