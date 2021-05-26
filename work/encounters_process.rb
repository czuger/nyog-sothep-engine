require 'ostruct'
require 'pp'
require 'yaml'

lines = File.open('encounters.tsv', 'r').readlines.map{ |e| e.strip }

tables = { 1 => {}, 2 => {} }

def add_to_struct!(struct, code, str)
  if str && str != ''
    struct[code] = str.downcase.to_sym
  end
end

1.upto(2).each do |table|
  lines.shift
  0.upto(17).each do |i|
    s = lines.shift.split("\t")
    p s
    struct = {}
    struct[:san] = s[3].to_i if s[3] && s[3] != ''
    add_to_struct! struct, :action, s[2]
    add_to_struct! struct, :found, s[4]
    add_to_struct! struct, :lost, s[5]

    tables[table][i+1] = OpenStruct.new struct
  end
end

pp tables

File.open('../data/encounters.yaml', 'w') do |f|
  f.write(tables.to_yaml)
end

