--[[Copyright © 2016, Allison Jane
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of <addon name> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Special Thanks to Mike McKee author of Enemybar, Morath86 author of barfiller, 
Cliff author of TParty, and sdahlka on the windower forums.  Looking at the 
coding of their various pieces really helped me piece this together
]]

_addon.name = 'PartyP'
_addon.author = 'Allison Jane'
_addon.version = '0.1b'
_addon.language = 'english'

texts = require('texts')
config = require('config')

defaults = T{}
defaults.pos = {}
defaults.pos.x = 300
defaults.pos.y = 480
defaults.step = 90
defaults.font_size = 12

settings = config.load(defaults)
config.save(settings)

config.register(settings, function(settings_table) 
    local nondefault = defaults
	if settings_table.pos.x ~= nil then
		nondefault = settings_table
	end
	p0_settings = {}
	p0_settings.pos = {}
	p0_settings.pos.x = nondefault.pos.x
	p0_settings.pos.y = nondefault.pos.y
	p0_settings.text = {}
	p0_settings.text.size = nondefault.font_size

	p1_settings = {}	
	p1_settings.pos = {}
	p1_settings.pos.x = nondefault.pos.x + nondefault.step
	p1_settings.pos.y = nondefault.pos.y
	p1_settings.text = {}
	p1_settings.text.size = nondefault.font_size

	p2_settings = {}
	p2_settings.pos = {}
	p2_settings.pos.x = nondefault.pos.x + (nondefault.step*2)
	p2_settings.pos.y = nondefault.pos.y
	p2_settings.text = {}
	p2_settings.text.size = nondefault.font_size
	
	p3_settings = {}
	p3_settings.pos = {}
	p3_settings.pos.x = nondefault.pos.x + (nondefault.step*3)
	p3_settings.pos.y = nondefault.pos.y
	p3_settings.text = {}
	p3_settings.text.size = nondefault.font_size
	
	p4_settings = {}
	p4_settings.pos = {}
	p4_settings.pos.x = nondefault.pos.x + (nondefault.step*4)
	p4_settings.pos.y = nondefault.pos.y
	p4_settings.text = {}
	p4_settings.text.size = nondefault.font_size
	
	p5_settings = {}
	p5_settings.pos = {}
	p5_settings.pos.x = nondefault.pos.x + (nondefault.step*5)
	p5_settings.pos.y = nondefault.pos.y
	p5_settings.text = {}
	p5_settings.text.size = nondefault.font_size
	
	pt0 = texts.new(' HP: ${hpp|---}%', p0_settings)
	pt1 = texts.new(' HP: ${hpp|---}%', p1_settings)
	pt2 = texts.new(' HP: ${hpp|---}%', p2_settings)
	pt3 = texts.new(' HP: ${hpp|---}%', p3_settings)
	pt4 = texts.new(' HP: ${hpp|---}%', p4_settings)
	pt5 = texts.new(' HP: ${hpp|---}%', p5_settings)
end)

function Update()
	local party = windower.ffxi.get_party()
	if (party.p0 ~= nil) then
		pt0.hpp = party.p0.hpp
		pt0:show()
	else
		pt0:hide()
	end
	if (party.p1 ~= nil) then
		pt1.hpp = party.p1.hpp
		pt1:show()
	else
		pt1:hide()
	end
	if (party.p2 ~= nil) then
		pt2.hpp = party.p2.hpp
		pt2:show()
	else
		pt2:hide()
	end
	if (party.p3 ~= nil) then
		pt3.hpp = party.p3.hpp
		pt3:show()
	else
		pt3:hide()
	end
	if (party.p4 ~= nil) then
		pt4.hpp = party.p4.hpp
		pt4:show()
	else
		pt4:hide()
	end
	if (party.p5 ~= nil) then
		pt5.hpp = party.p5.hpp
		pt5:show()
	else
		pt5:hide()
	end
end

windower.register_event('prerender', Update)
