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

Huge Thanks to Iryoku for helping me condense the coding and teaching me a bit of lua
]]

_addon.name = 'PartyP'
_addon.author = 'Allison Jane'
_addon.version = '0.2'
_addon.language = 'english'

texts = require('texts')
config = require('config')

defaults = T{}
defaults.pos = {}
defaults.pos.x = 200
defaults.pos.y = 100
defaults.step = {}
defaults.step.x = 90
defaults.step.y = 20
defaults.pet = {}
defaults.pet.x = 840
defaults.pet.y = 440
defaults.font_size = 12

settings = config.load(defaults)
config.save(settings)

config.register(settings, function(settings_table) 
    local nondefault = defaults
	if settings_table.pos.x ~= nil then
		nondefault = settings_table
	end
	
	hp_settings = {}
	hp_display = {}
	mp_settings = {}
	mp_display = {}
	
	for i = 0, 5 do
		hp_settings[i] = {pos = {x = nondefault.pos.x + (nondefault.step.x * i), y = nondefault.pos.y}, text = {size = nondefault.font_size}}
		hp_display[i] = texts.new('HP: ${hpp|---}%', hp_settings[i])
		mp_settings[i] = {pos = {x = nondefault.pos.x + (nondefault.step.x * i), y = nondefault.pos.y + nondefault.step.y}, text = {size = nondefault.font_size}}
		mp_display[i] = texts.new('MP: ${mpp|---}%', mp_settings[i])
	end
	
	pet_settings = {pos = {x = nondefault.pet.x, y = nondefault.pet.y}, text = {size = nondefault.font_size}}
	p0pet = texts.new(' Pet: ${hpp|---}%', pet_settings)
end)

function Update()
	local party = windower.ffxi.get_party()
	local mypet = windower.ffxi.get_mob_by_target('pet')
	
	if (party.p0 ~= nil) then
		hp_display[0].hpp = party.p0.hpp
		mp_display[0].mpp = party.p0.mpp
		hp_display[0]:show()
		mp_display[0]:show()
	else
		hp_display[0]:hide()
		mp_display[0]:hide()
	end

	if (party.p1 ~= nil) then
		hp_display[1].hpp = party.p1.hpp
		mp_display[1].mpp = party.p1.mpp
		hp_display[1]:show()
		mp_display[1]:show()
	else
		hp_display[1]:hide()
		mp_display[1]:hide()
	end
	
	if (party.p2 ~= nil) then
		hp_display[2].hpp = party.p2.hpp
		mp_display[2].mpp = party.p2.mpp
		hp_display[2]:show()
		mp_display[2]:show()
	else
		hp_display[2]:hide()
		mp_display[2]:hide()
	end
	
	if (party.p3 ~= nil) then
		hp_display[3].hpp = party.p3.hpp
		mp_display[3].mpp = party.p3.mpp
		hp_display[3]:show()
		mp_display[3]:show()
	else
		hp_display[3]:hide()
		mp_display[3]:hide()
	end

	if (party.p4 ~= nil) then
		hp_display[4].hpp = party.p4.hpp
		mp_display[4].mpp = party.p4.mpp
		hp_display[4]:show()
		mp_display[4]:show()
	else
		hp_display[4]:hide()
		mp_display[4]:hide()
	end

	if (party.p5 ~= nil) then
		hp_display[5].hpp = party.p5.hpp
		mp_display[5].mpp = party.p5.mpp
		hp_display[5]:show()
		mp_display[5]:show()
	else
		hp_display[5]:hide()
		mp_display[5]:hide()
	end

	if mypet ~= nil then
		p0pet.hpp = mypet.hpp
		p0pet:show()
	else
		p0pet:hide()
	end
end

windower.register_event('prerender', Update)
