#!/usr/bin/env ruby


require 'digest/md5'

class Block
  attr_accessor :h, :data , :nonce
  def initialize pre_hash,data
    self.h = pre_hash 
    self.data = data 
    self.nonce = 100
  end
  def is_sanity?
    num = 4
    self.hash[0..num] == "0"*(num+1)
  end
  def calc 
    100000.times do |i |
      self.nonce = i
      if self.is_sanity? then
        return true
      end
    end
    return false
  end
  def hash
    Digest::MD5.hexdigest(self.h.to_s + self.data + self.nonce.to_s)
  end
  def inspect
    "#{self.h} #{self.data} #{self.nonce} : #{self.hash}"
    "#{self.data}: #{self.h} -> #{self.hash}"
  end
end




block_chain = []

blk = Block.new(0,"first")
blk.calc
block_chain << blk


1000.times do |i|
  try_data = "data#{i}"
  blk = Block.new(block_chain.last.hash,try_data)
  if blk.calc then
    p blk
    block_chain << blk
  end
end

