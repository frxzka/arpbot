-- ��� ����� �������������:
-- ��� ������ ����
-- ��� ���
-- ����� �� botfather
-- ����� �� ������
-- ������ �� ���


NAME = '[��� ������ ����]'

package.path = "./scripts/libs/?.lua";
package.cpath = "./scripts/libs/?.dll";

local token = '����� �� botfather'
local chatid = '����� �� ������'
local link = ('https://api.telegram.org/bot' .. token .. '/sendMessage?chat_id=' .. chatid .. '&text=' )

local tgbot = require("lua-bot-api").configure(token)
local lanes = require("lanes").configure()
local linda = lanes.linda()
require 'Tasking'
onScriptUpdate = Tasking.tick
local json = require 'cjson'
local effil = require("effil")
local encoding = require("encoding")
encoding.default = 'CP1251'
u8 = encoding.UTF8

local list_auto_opra
local list_accept_forms = {'slap', 'flip', 'freeze', 'unfreeze', 'spplayer', 'sethp', 'weap', 'spcar', 'plveh', 'spcars', 'givegun', 'uval', 'agl', 'acceptadmin'}
local aonline = 0
local afk = 0

-- BOT
local autoopra  = true
local AUTO_OPRA = false
local AUTOACCEPT_FORMS = true
local list_accept_forms = {'slap', 'flip', 'freeze', 'unfreeze', 'spplayer', 'sethp', 'weap', 'spcar', 'plveh', 'spcars', 'givegun', 'uval', 'agl'}
local unjail = {'unjail'}
local nrg_give = {'����� ���', '��� ��� ���', '��� ���', '���', '��� ����', '��� ����', '��� ���', 'nrg'}
local flip = {"����� ����", "������ ����", "������ ��������", "��������", "��� ��� ����", "��������", "��� ����", "����", "��� ��� ����"}
local mute = {"�������", "�����", "������", "�����", "��� �����", "��� �����", "mq", "���� ���", "���� ����", "������", "�������", "������"}
local infernus = {"����� �����", "��� �����", "����� ��������", "��� ��������", "��� ��� �����", "����� ��������"}
local spawn = {"����������", "����� �����", "������ �����", "��� �����", "�����"}
local ab = {"�� �� ��", "������ �� ��", "��� �� �� ��", "��� �� �� ��"}
local tpgetto = {"��� �� � �����", "�� �����"}
local banklv = {"���� ��", "�� � ����"}
local bankls = {"���� ��", "�� � ���� ��", "�� � ���� ��"}
local cont = {"�� �� �����", "����������", "�� �� �� �����"}
local slap = {"��� ����", "��������", "����", "slap", "����� ����", "����� ����"}
local unfreeze = {"������", "���������� ����", "� �����", "�����", "��� ������", "unfreeze"}
local tpaukcr = {"��� �� �� �������", "�� �� �������"}
local centralrinok = {"��� �� �� ����������� �����", "�� �� ��", "��� �� �� ��"}
local pass_give = {"��� �������", "�������", "����� �������", "��� ��� �������"}
local hp = {"��������", "����� ��", "��", "��� ��� ��"}
local banhitok = {"��� ���"}
local info = {"Eduard_Haunted", "Sambero_Lucanio", "��� ������ ����", "��� ���"}
local adm_captcha = {"Eduard_Haunted", "Sambero_Lucanio", "��� ������ ����", "��� ���"}
local adm_plus = {"Eduard_Haunted", "Sambero_Lucanio", "��� ������ ����", "��� ���"}
local ugadai = {"Eduard_Haunted", "Sambero_Lucanio", "��� ������ ����", "��� ���"}
local info_konkurs = {"Eduard_Haunted", "Sambero_Lucanio", "��� ������ ����", "��� ���"}
local payday = {"Eduard_Haunted", "Sambero_Lucanio", "��� ������ ����", "��� ���", "Mountain_Bike"}
local paydayoff = {"Eduard_Haunted", "Sambero_Lucanio", "��� ������ ����", "��� ���", "Mountain_Bike"}
local captcha = false
-- BOT

local ansi_decode={
	 [128]='\208\130',[129]='\208\131',[130]='\226\128\154',[131]='\209\147',[132]='\226\128\158',[133]='\226\128\166',
	 [134]='\226\128\160',[135]='\226\128\161',[136]='\226\130\172',[137]='\226\128\176',[138]='\208\137',[139]='\226\128\185',
	 [140]='\208\138',[141]='\208\140',[142]='\208\139',[143]='\208\143',[144]='\209\146',[145]='\226\128\152',
	 [146]='\226\128\153',[147]='\226\128\156',[148]='\226\128\157',[149]='\226\128\162',[150]='\226\128\147',[151]='\226\128\148',
	 [152]='\194\152',[153]='\226\132\162',[154]='\209\153',[155]='\226\128\186',[156]='\209\154',[157]='\209\156',
	 [158]='\209\155',[159]='\209\159',[160]='\194\160',[161]='\209\142',[162]='\209\158',[163]='\208\136',
	 [164]='\194\164',[165]='\210\144',[166]='\194\166',[167]='\194\167',[168]='\208\129',[169]='\194\169',
	 [170]='\208\132',[171]='\194\171',[172]='\194\172',[173]='\194\173',[174]='\194\174',[175]='\208\135',
	 [176]='\194\176',[177]='\194\177',[178]='\208\134',[179]='\209\150',[180]='\210\145',[181]='\194\181',
	 [182]='\194\182',[183]='\194\183',[184]='\209\145',[185]='\226\132\150',[186]='\209\148',[187]='\194\187',
	 [188]='\209\152',[189]='\208\133',[190]='\209\149',[191]='\209\151'
}
function AnsiToUtf8(s)
	 local r, b = ''
	 for i = 1, s and s:len() or 0 do
	   b = s:byte(i)
	   if b < 128 then
	     r = r..string.char(b)
	   else
      if b > 239 then
	       r = r..'\209'..string.char(b - 112)
	     elseif b > 191 then
	       r = r..'\208'..string.char(b - 48)
	     elseif ansi_decode[b] then
	       r = r..ansi_decode[b]
	     else
	       r = r..'_'
	     end
	   end
	 end
  return r
end

function getIp()
	ip = openUrl('https://api.ipify.org/?format=json')

	return ip:match('{\"ip\":\"(.*)\"}')
end

function updateThread(token)
    local bot, ext = require("lua-bot-api").configure(token)

    ext.onTextReceive = function(msg)
        linda:send("tg_message_recv", { from = msg.from.id, text = msg.text })
    end

    ext.run()
end

function onScriptUpdate()
    local eventName, eventData = linda:receive(0, "tg_message_recv")
    if eventName == "tg_message_recv" then
    onTelegramMessage(eventData.from, eventData.text)
    end
end

function onScriptStart()
	math.randomseed(os.time())
  lanes.gen("*", updateThread)(token)
	printLog('[Enid Bot]: ������ ������� ��������!')
	openUrl(AnsiToUtf8(link..'%E2%9C%88 ������ ������� ��������!'))
	openUrl(AnsiToUtf8(link..'%E2%9C%85 ����������� by frxzka: ����������'))
end


function isCoordsInArea2d(x, y, ax, ay, bx, by)
	if x > ax and x < bx and y < ay and y > by then
		return true
	end
	return false
end

function onServerMessage(msg)
		for k,v in ipairs(list_accept_forms) do
		if msg:match("%[A%] (.+)%[(%d+)%]%: /"..v.."%s") and AUTOACCEPT_FORMS then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: /"..v.."%s(.*)")
		cmd = v
		paramssss = other
		sendInput("/"..cmd.." "..paramssss)
		sendInput('/a ��������� �������������, ���� ����� �������!')
		end
	end	
                for k,v in ipairs(unjail) do
		if msg:match("%[A%] (.+)%[(%d+)%]%: /"..v.."%s") and AUTOACCEPT_FORMS then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: /"..v.."%s(.*)")
		cmd = v
		paramssss = other
		sendInput("/"..cmd.." "..paramssss )
		sendInput('/a ��������� �������������, ������������ ���� ���������: �����������������! ����� ��� ���������!')
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 ������������� %E2%9D%B1 '..admin_nick..' %E2%9D%B0 �������� ������ � ���������!'))
		end
	end		
	if msg:find("%[A%] (.+)%[(%d+)%]%: ��� ������") and not captcha then
		idplb,idb,ms = msg:match("%[A%] (.+)%[(%d+)%]%: ��� ������")
		sendInput("/a ��������� �������������, ������ ��� ������ ��� ������ �������!")
		sendInput("/a �� ��������� ���� ����� �� �������:slap,flip,freeze,unfreeze,spplayer,sethp,weap,spcar,plveh,spcars,givegun,uval,agl")
		sendInput("/a ���-�� �� ������ ������� ������������ ������! /unjail id - � ��� �������� ������!")
		sendInput("/a ������ � ����� �� �������! ��� ���� ���� ������������ � ��������, �� ������ �������� �� ����!<3")
end                
        if msg:find("%[A%] (.+)%[(%d+)%]%: ��� �����") and not captcha then
		idplb,idb,ms = msg:match("%[A%] (.+)%[(%d+)%]%: ��� ������")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
		sendInput("/a ������ �����! �������� �����������! ������� �������!")
end           
                for k,v in ipairs(nrg_give) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/plveh "..admin_id.." 522 1")
		sendInput("/apanel")
		end
	end
		for k,v in ipairs(pass_give) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/givepass "..admin_id.." 1")
		sendInput("/apanel")
		end
	end
                for k,v in ipairs(mute) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/mute "..admin_id.." 20 ������������ ���������")
		openUrl(AnsiToUtf8(link..'%E2%9D%97 ����� '..admin_nick..' ������� �������, ������: "'..v..'" � ��� ������������ � ������� ���� �� 20 �����!'))
		sendInput("/a �����: ".. admin_nick .." - ������� ������� �������, ������ "..v.." � ��� �������!")
		sendInput("/pm "..admin_id.." 1 �� ���� ��������, ��: "..v.." , � ������� ���������� �� ��������!")
		end
	end
		for k,v in ipairs(flip) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (%w+_?%w+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/flip "..admin_id.."")
		sendInput("/apanel")
		end

	end

        	for k,v in ipairs(hp) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (%w+_?%w+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/sethp "..admin_id.." 100")
		end
	end
                for k,v in ipairs(slap) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (%w+_?%w+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/slap "..admin_id.." 1")
                sendInput("/slap "..admin_id.." 1")
		sendInput("/vr ".. admin_nick .." +")
		sendInput("/apanel")
		end
	end
                for k,v in ipairs(unfreeze) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (%w+_?%w+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/unfreeze "..admin_id.." 1")
                sendInput("/unfreeze "..admin_id.." 1")
		sendInput("/vr ".. admin_nick .." +")
		sendInput("/apanel")
		end
	end
	
                for k,v in ipairs(infernus) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/plveh "..admin_id.." 411 0")
		sendInput("/apanel")
		end
	end
	for k,v in ipairs(spawn) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/spplayer "..admin_id.." 1")
		end
	end
	for k,v in ipairs(ab) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/vr ".. admin_nick .." +")
		sendInput("/tpab ".. admin_id .."")
		end
	end
        for k,v in ipairs(cont) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/vr ".. admin_nick .." +")
		sendInput("/tpcont ".. admin_id .."")
		end
	end
	for k,v in ipairs(centralrinok) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (%w+_?%w+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/vr ".. admin_nick .." +")
		sendInput("/tpac ".. admin_id .."")
		end
	end
	for k,v in ipairs(banklv) do
		if msg:match('%[.+%] (.+)%[(%d+)%]%: '..v..'') then
		admin_nick, admin_id, other = msg:match('%[.+%] (%w+_?%w+)%[(%d+)%]%: '..v..'')
		cmd = v
		sendInput("/vr ".. admin_nick .." +")
		sendInput("/tpbanklv ".. admin_id .."")
		end
	end
		for k,v in ipairs(adm_plus) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: ��� ������") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: ��� ������")
		cmd = v
		local rid = math.random(0, getPlayersCount()-1)
		local pred = math.random(1, 100)
		sendInput("/ao ������u�! ������� ������� ������ ��� ����� ��� ID ["..rid.."] �������� ������� #"..pred.."")
		sendInput("/giveitem "..rid.." "..pred.." 1 0")
		end
	end
        for k,v in ipairs(adm_captcha) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: bot captcha") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: bot captcha")
		cmd = v
		capt = math.random(10000, 99999)
		priz = math.random(1, 50)
		captcha = true
		openUrl(AnsiToUtf8(link..'%E2%9D%97 ������ ����� �� AZ-����� ������� ��������! < GAME'))
		sendInput("/a ��� �������! �������� ��������� ����� �� ��������� ����� �� ������...")
		sendInput("/ao ������u�! ����� "..capt.." | ����: �� ����� � ����������: "..priz.." ! ���������� ������������� � VIP ��� (/vr)") 
                end
	end
        for k,v in ipairs(ugadai) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: bot ugadai") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: bot ugadai")
		cmd = v
		capt = math.random(1, 50)
		priz = math.random(1, 50)
		captcha = true
		openUrl(AnsiToUtf8(link..'%E2%9D%97 ������ ��������� "������ �����" ������� �������� < GAME'))
		sendInput("/a ��� �������! �������� ��������� >������ �����< !")
		sendInput("/ao ������u�! ������ ����� �� 1 �� 50! | ����: �� ����� � ����������: "..priz.." ! ���������� ������������� � VIP ��� (/vr)") 
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 ���������� �����: '..capt..''))
                end
	end
                for k,v in ipairs(info) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: bot information") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: ��� ����������")
		cmd = v
		sendInput("/vr ��������� ������, ������ 15 ����� �� ����� ������� ���������� �������� ���������� ����������� ����� �������.")
		sendInput("/vr ��� �� ������ 5 ����� � ������������� ������� ����� �� ��������� �������. ��� �� ���� ��������� �����:")
		sendInput("/vr ������� � /vr \"����� ����\", \"������ ����\", \"������ ��������\", \"��������\", \"��� ��� ����\" - � ��� ������.")
		sendInput("/vr ������� � /vr \"����� ��������\", \"��� ��������\", \"��� �����\", \"����� �����\" - � ����� ��� Infernus.")
		sendInput("/vr ������� � /vr \"����������\", \"����� �����\", \"��� �����\", \"������ �����\" - � ��� ��������. �������� ���� <3")
                end
	end
                for k,v in ipairs(payday) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: ��� ������ ����") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: ��� ������ ����")
		cmd = v
		sendInput("/ao ����-������������ ������� ���� ��������: ���������������: ".. admin_nick .." ")
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 ������������� %E2%9D%B1 '..admin_nick..' %E2%9D%B0 ������� ����-������������!'))
                AUTO_OPRA = true
                end
	end
                for k,v in ipairs(banhitok) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: ������ ����") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: ������ ����")
		cmd = v
		sendInput("/banip ".. admin_id .." �������")
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 ����� ���������, �������� �����'))
                end
	end
                for k,v in ipairs(paydayoff) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: ��� ������� ����") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: ��� ������� ����")
		cmd = v
		sendInput("/ao ����-������������ ������� ���� ���������: ���������������: ".. admin_nick .." ")
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 ������������� %E2%9D%B1 '..admin_nick..' %E2%9D%B0 �������� ����-������������!'))
                AUTO_OPRA = false
                end
	end
	if msg:find(". ��� 5 �����!!!") then
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
                sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
	end
        if msg:find(". ��� 6 �����!!!") then
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
                sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
	end
        if msg:find(". ��� 7 �����!!!") then
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
		sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
                sendInput("/a ������, �������� �� ������! � ���� �Ѩ � �����! ����� ����! - /ot /ot /ot")
	end
	if msg:find("%[A%] (.+) (.+) ����� � ������� �������������������") then
		adm, nick = msg:match("%[A%] (.+) (.+) ����� � ������� �������������������")
         sendInput("/a �������������: ".. nick.." ����������� [���������� ����� ����� ~ 0��].")
         sendInput("/a �������� ����������: ENID/TOOLZ , � ���������.")
	end	
        if msg:find("%[A%] ���������� ��� ��� ����� � ������� �������������������") then
	adm, nick = msg:match("%[A%] ���������� ��� ��� ����� � ������� �������������������")
         sendInput("/a �������� �������������� ��� ��� - �� ��������!")
         sendInput("/a �������� �������������� ��� ��� - �� ��������!")
         sendInput("/a �������� �������������� ��� ��� - �� ��������!")
         sendInput("/a �������� � /a ������ ���� - ����� ��� ������� ����� ������������!")
         sendInput("/a �������� � /a ������ ���� - ����� ��� ������� ����� ������������!")
         sendInput("/a �������� � /a ������ ���� - ����� ��� ������� ����� ������������!")
	end	
        if msg:find("�� ������� ��������������") then
		adm, nick = msg:match("�� ������� ��������������")
         sendInput("/a ���� ��������� ������� �������, ��������� � ������.")
         sendInput("/a ������ �������: 02.02.2023, �����������: ��� ���")
         sendInput("/ao ������������� ��� �������������, � ����� ��������� ���� �������!")
         sendInput("/ao ������ �������: 02.02.2023, �����������: ��� ���")
	end
        	if msg:find('.+ %[(%d+)%] ����� ��� ID: (%d+) �� ���. ���� �� (.+)ms! �����: .+') and AUTO_OPRA then -- Jail �� ��� ����
		id,iddom,vrema = msg:match('.+ %[(%d+)%] ����� ��� ID: (%d+) �� ���. ���� �� (.+)ms! �����: .+')
		sendInput('/jail '..id..' 3000 ���� ��� '..iddom..' | '..vrema)
		openUrl(AnsiToUtf8(link..'%E2%9C%85 ����� ������ ���: '..iddom..' �� ~ '..vrema..'!'))
	end
	if msg:find('.+ %[(%d+)%] ����� ������ ID: (%d+) �� ���. ���� �� (.+)ms! �����: .+')  and AUTO_OPRA then -- Jail �� ��� ����
		idplb,idb,ms = msg:match('.+ %[(%d+)%] ����� ������ ID: (%d+) �� ���. ���� �� (.+)ms! �����: .+')
		sendInput('/jail '..idplb..' 3000 ���� ������ '..idb..' | '..ms)
		openUrl(AnsiToUtf8(link..'%E2%9C%85 ����� ������ ������:'..idb..' �� ~ '..ms..'!'))
	end
        if msg:find("�� ������� ���� ���������,") then
	    sendInput('/apanel')
		openUrl(AnsiToUtf8(link..'%E2%9D%97 ���� � ������ �������������� ���������������, ������� ��������!'))		
	end 			
	if captcha and msg:match("%[.+%] (.+)%[(%d+)%]%: "..capt.."") then
		admin_nick, admin_id, other = msg:match("%[.+%] (.+)%[(%d+)%]%: "..capt)
		sendInput("/ao ����� ".. admin_nick .."[".. admin_id .."] ������ ������� ��������� � ������� ��-����� � ����������:  "..priz.."")
		sendInput("/giverub "..admin_id.." "..priz.."")
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 ����� %E2%9D%B1 '..admin_nick..' %E2%9D%B0 ������� ��������� � ������� �� ����� � ����������: '..priz..'!'))
		captcha = false
	end
        if captcha and msg:match("%[.+%] (.+)%[(%d+)%]%: "..capt.."") then
		admin_nick, admin_id, other = msg:match("%[.+%] (.+)%[(%d+)%]%: "..capt)
		sendInput("/ao ����� ".. admin_nick .."[".. admin_id .."] ������ ������ ����� � ������� ��-����� � ����������:  "..priz.."")
		sendInput("/giverub "..admin_id.." "..priz.."")
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 ����� %E2%9D%B1 '..admin_nick..' %E2%9D%B0 ������ ����� � ������� �� ����� � ����������: '..priz..'!'))
		captcha = false
	end
		for k,v in ipairs(list_accept_forms) do
		if msg:match("%[A%] (.+)%[(%d+)%]%: /"..v.."%s") then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: /"..v.."%s(.*)")
		cmd = v
		paramssss = other
		openUrl(AnsiToUtf8(link..'%E2%9C%85 ������� �����:%0A%0A[A] '..admin_nick..'['..admin_id..']: /'..cmd..' '..paramssss))
		--sendInput("/"..cmd.." "..paramssss)
		--sendInput('/a [Forma] +')
		end
	end
	if msg:find("������������� ������: %(� ����: (%d+), �� ��� � ���: NaN%)") then
		aonline = msg:match("������������� ������: %(� ����: (%d+), �� ��� � ���: NaN%)")
		openUrl(AnsiToUtf8(link..'%F0%9F%91%B7 ����� ��������������� � ����: '..aonline..'%0A%E2%97%BC �� ��� � ���: '..afk..''))
	end
end
function onTelegramMessage(from, text)
	sn = getServerName()
	nickname = getNickName()
	money = getMoney()
	id = getBotId()
	ip = getServerAddress()
	state = getBotState()
	online = getPlayersCount()
    if text == "/active" then
        openUrl(AnsiToUtf8(link..'[��� ������ ����] �������� ���:%0A%0A���: '..nickname..'%0A������: '..sn..'%0A����: '..id..'%0AIP Address: '..ip..'%0A��������� ����: '..state))
			elseif text == "/admins" then
			sendInput("/admins")
			openUrl(AnsiToUtf8(link..'%E2%97%BC ������� ����������, ����������, ���������...'))
			elseif text == "/players" then
				openUrl(AnsiToUtf8(link..'%F0%9F%93%88 ������ ������� �� ������ ������: '..online))
			elseif text == "/cmd" then
				openUrl(AnsiToUtf8(link..'%F0%9F%91%91 ������� ����:%0A%E2%96%B6 /pizda - ��������� ������������� � ������!%0A%E2%96%B6 /players - ���������� ���������� ������� �� ������ ������%0A%E2%96%B6 /admins - ���������� ���������� ��������������� �� ������ ������%0A%E2%96%B6 /action [������] - ��������� ������ �� Telegram(ENGLISH)%0A%E2%96%B6 /autoopra - �������� ����-������������%0A%E2%96%B6 /autoopraoff - ��������� ����-������������%0A%E2%96%B6 /captcha - ��������� ��������� ����� �� �������%0A%E2%96%B6 /ugadai - ��������� "������ �����"%%0A%E2%96%B6 /rules - ������� ������ ������,����������� � ���������!'))	
			elseif text:find("/action (.+)") then
				action = text:match("/action (.+)")
				sendInput(action)
				openUrl(AnsiToUtf8(link..'%E2%9C%85 ������� �������� ������, ���������� �������: %0A'..action))
			elseif text == "/random" then
				local rid = math.random(0, getPlayersCount()-1)
				local pred = math.random(1, 100)
				sendInput("/ao ������u�! ������� ������� ������ ��� ����� ��� ID ["..rid.."] �������� AZ-RUB � ����������: "..pred.."")
				sendInput("/giverub "..rid.." "..pred.." ")
				openUrl(AnsiToUtf8(link..'%E2%9C%85 ������� ������ ����� ���������� ������!'))
                        elseif text == "/rules" then
				openUrl(AnsiToUtf8(link..' 1. �� ������� ��������� ��� �������� - �������� ���� ����! 2.������� /action - �������� ������ �� ���������� �����.'))
			elseif text =="/pizda" then
				sendInput('/a �����! �����������! �˨��! ����������!')
				openUrl(AnsiToUtf8(link..'%E2%9C%85 ������� �������� ������, ��� �������� �������!'))
			elseif text =="/autoopraoff" then
				sendInput('/ao ���������������� ������� ���������.')
				openUrl(AnsiToUtf8(link..'%E2%9C%85 ����-������������ ������� ���� ���������!'))
				AUTO_OPRA = false
			elseif text =="/autoopra" then
				sendInput('/ao ���������������� �������� � ������� 2� ����� ����� PayDay')
				openUrl(AnsiToUtf8(link..'%E2%9C%85 ����-������������ ������� ���� ��������, �� �������� ���������!'))
				AUTO_OPRA = true
			elseif text == "/captcha" then
				cmd = v
				capt = math.random(10000, 99999)
				priz = math.random(1, 50)
				captcha = true
				openUrl(AnsiToUtf8(link..'%E2%9D%97 ������ ����� �� AZ-����� ������� ��������! < TELEGRAM'))
				sendInput("/a ��� �������! �������� ��������� ����� �� ��������� ����� �� ������... < TELEGRAM")
				sendInput("/ao ������u�! ����� "..capt.." | ����: �� ����� � ����������: "..priz.." ! ���������� ������������� � VIP ��� (/vr)")
                       elseif text == "/ugadai" then
				cmd = v
				capt = math.random(1,50 )
				priz = math.random(1, 50)
				captcha = true
				openUrl(AnsiToUtf8(link..'%E2%9D%97 ������ ��������� �� AZ-����� ������� ��������! < TELEGRAM'))
				sendInput("/a ��� �������! �������� ��������� '������ �����' < TELEGRAM...")
				sendInput("/ao ������u�! ������� ����� �� 1 �� 50 | ����: �� ����� � ����������: "..priz.." ! ���������� ������������� � VIP ��� (/vr)")
		                openUrl(AnsiToUtf8(link..'%E2%9C%A6 ���������� �����: '..capt..''))
					
	else
        -- openUrl(AnsiToUtf8(link..'%E2%9D%8E ����������� �������%0A�������: /cmd ��� �� ���������� �������'))
    end
end

function encodeUrl(str)
    str = str:gsub(' ', '%+')
    str = str:gsub('\n', '%%0A')
    return u8:encode(str, 'CP1251')
end
function onDialogShow(dialogId, dialogStyle, dialogTitle, okButtonText, cancelButtonText, dialogText)
	if (dialogId == 211) then
		sendDialog(211, 1, 65535, "������ �� ���")
	end
	if dialogId == 15330 then
        if active then
			
        else
            active = true
        end
	end

	if (string.find(dialogTitle, "������������� ������")) then
        dialogText = string.gsub(dialogText, "��� ������	���������	���������	���������", "");
		openUrl(AnsiToUtf8(link..'%E2%9D%97 ������ �������������: \n' .. dialogText))
        sendDialogResponse(id, 0, -1, "");
        return false;
    end
end