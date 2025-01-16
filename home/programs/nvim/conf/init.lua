local vg = vim.g
local vo = vim.o

vg.mapleader = ' '
vg.maplocalleader = ' '
vo.clipboard = 'unnamedplus'
vo.number = true
vo.relativenumber = true
vo.signcolumn = 'yes'
vo.tabstop = 2
vo.shiftwidth = 2
vo.updatetime = 100

require('config.lazy')
require('lazy').setup('plugins')
