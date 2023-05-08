-- что нужно редактировать:
-- ник вашего бота
-- ваш ник
-- токен от botfather
-- чатид от беседы
-- пароль от адм


NAME = '[ник вашего бота]'

package.path = "./scripts/libs/?.lua";
package.cpath = "./scripts/libs/?.dll";

local token = 'токен от botfather'
local chatid = 'чатид от беседы'
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
local nrg_give = {'дайте нрг', 'бот дай нрг', 'бот нрг', 'нрг', 'нрг фаст', 'НРГ ФАСТ', 'дай нрг', 'nrg'}
local flip = {"дайте флип", "админы флип", "админы почините", "почините", "бот дай флип", "флипните", "бот флип", "флип", "бот дай флип"}
local mute = {"пидарас", "уебан", "гандон", "шлюха", "сын бляди", "сын шлюхи", "mq", "соси хуй", "соси член", "долбоёб", "далбаеб", "долбаёб"}
local infernus = {"дайте тачку", "дай тачку", "дайте инфернус", "дай инфернус", "бот дай тачку", "дайте инфернус"}
local spawn = {"заспавните", "спавн дайте", "админы спавн", "бот спавн", "спавн"}
local ab = {"тп на аб", "тпните на аб", "бот тп на аб", "Бот тп на аб"}
local tpgetto = {"бот тп в гетто", "тп гетто"}
local banklv = {"банк лс", "тп в банк"}
local bankls = {"банк лв", "тп в банк лв", "тп в банк лв"}
local cont = {"тп на конты", "контейнеры", "тп пж на конты"}
local slap = {"бот слап", "слапните", "слап", "slap", "дайте слап", "можно слап"}
local unfreeze = {"унфриз", "унфризните меня", "я завис", "завис", "бот унфриз", "unfreeze"}
local tpaukcr = {"бот тп на аукцион", "тп на аукцион"}
local centralrinok = {"бот тп на центральный рынок", "тп на цр", "бот тп на цр"}
local pass_give = {"дай паспорт", "паспорт", "дайте паспорт", "бот дай паспорт"}
local hp = {"вылечите", "дайте хп", "хп", "бот дай хп"}
local banhitok = {"ваш ник"}
local info = {"Eduard_Haunted", "Sambero_Lucanio", "ник вашего бота", "ваш ник"}
local adm_captcha = {"Eduard_Haunted", "Sambero_Lucanio", "ник вашего бота", "ваш ник"}
local adm_plus = {"Eduard_Haunted", "Sambero_Lucanio", "ник вашего бота", "ваш ник"}
local ugadai = {"Eduard_Haunted", "Sambero_Lucanio", "ник вашего бота", "ваш ник"}
local info_konkurs = {"Eduard_Haunted", "Sambero_Lucanio", "ник вашего бота", "ваш ник"}
local payday = {"Eduard_Haunted", "Sambero_Lucanio", "ник вашего бота", "ваш ник", "Mountain_Bike"}
local paydayoff = {"Eduard_Haunted", "Sambero_Lucanio", "ник вашего бота", "ваш ник", "Mountain_Bike"}
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
	printLog('[Enid Bot]: Скрипт успешно загружен!')
	openUrl(AnsiToUtf8(link..'%E2%9C%88 Скрипт успешно загружен!'))
	openUrl(AnsiToUtf8(link..'%E2%9C%85 Оптимизация by frxzka: актирована'))
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
		sendInput('/a Уважаемый администратор, твоя форма принята!')
		end
	end	
                for k,v in ipairs(unjail) do
		if msg:match("%[A%] (.+)%[(%d+)%]%: /"..v.."%s") and AUTOACCEPT_FORMS then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: /"..v.."%s(.*)")
		cmd = v
		paramssss = other
		sendInput("/"..cmd.." "..paramssss )
		sendInput('/a Уважаемый администратор, опровержение было проверено: удовлетворительно! Игрок был освобождён!')
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 Администратор %E2%9D%B1 '..admin_nick..' %E2%9D%B0 выпустил игрока с деморгана!'))
		end
	end		
	if msg:find("%[A%] (.+)%[(%d+)%]%: бот помощь") and not captcha then
		idplb,idb,ms = msg:match("%[A%] (.+)%[(%d+)%]%: бот помощь")
		sendInput("/a Уважаемый Администратор, данный бот создан для помощи игрокам!")
		sendInput("/a Он принимает ваши формы на команды:slap,flip,freeze,unfreeze,spplayer,sethp,weap,spcar,plveh,spcars,givegun,uval,agl")
		sendInput("/a Так-же вы можете принять опровержение игрока! /unjail id - и бот выпустит игрока!")
		sendInput("/a Сильно с ботом не играйте! Все логи бота отправляются в телеграм, вы можете получить по попе!<3")
end                
        if msg:find("%[A%] (.+)%[(%d+)%]%: бот пизда") and not captcha then
		idplb,idb,ms = msg:match("%[A%] (.+)%[(%d+)%]%: бот помощь")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
		sendInput("/a ДЕЛАЕМ КАПЧИ! ПРОВОДИМ МЕРОПРИЯТИЯ! РАЗДАЁМ ПОДАРКИ!")
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
		sendInput("/mute "..admin_id.." 20 Неадекватное Поведение")
		openUrl(AnsiToUtf8(link..'%E2%9D%97 Игрок '..admin_nick..' нарушил правила, сказав: "'..v..'" и был заблокирован в игровом чате на 20 минут!'))
		sendInput("/a Игрок: ".. admin_nick .." - нарушил правила сервера, сказав "..v.." и был наказан!")
		sendInput("/pm "..admin_id.." 1 Вы были наказаны, за: "..v.." , в будущем старайтесь не нарушать!")
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
		if msg:match("%[A%] "..v.."%[(%d+)%]%: бот рандом") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: бот рандом")
		cmd = v
		local rid = math.random(0, getPlayersCount()-1)
		local pred = math.random(1, 100)
		sendInput("/ao Вниманuе! Система рандома решила что игрок под ID ["..rid.."] получает предмет #"..pred.."")
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
		openUrl(AnsiToUtf8(link..'%E2%9D%97 Запуск капчи на AZ-рубли успешно выполнен! < GAME'))
		sendInput("/a Без проблем! Запускаю рандомную капчу на рандомное число аз рублей...")
		sendInput("/ao Вниманuе! капча "..capt.." | приз: аз рубли в количестве: "..priz.." ! Отправлять исключительно в VIP чат (/vr)") 
                end
	end
        for k,v in ipairs(ugadai) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: bot ugadai") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: bot ugadai")
		cmd = v
		capt = math.random(1, 50)
		priz = math.random(1, 50)
		captcha = true
		openUrl(AnsiToUtf8(link..'%E2%9D%97 Запуск викторины "угадай цифру" успешно выполнен < GAME'))
		sendInput("/a Без проблем! Запускаю викторину >угадай цифру< !")
		sendInput("/ao Вниманuе! Угадай цифру от 1 до 50! | приз: аз рубли в количестве: "..priz.." ! Отправлять исключительно в VIP чат (/vr)") 
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 Загаданная цифра: '..capt..''))
                end
	end
                for k,v in ipairs(info) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: bot information") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: бот информация")
		cmd = v
		sendInput("/vr Уважаемые игроки, каждые 15 минут на нашем сервере происходит розыгрыш рандомного сертификата среди игроков.")
		sendInput("/vr Так же каждые 5 минут я автоматически провожу капчу на рандомный предмет. Так же есть некоторые фишки:")
		sendInput("/vr Написав в /vr \"дайте флип\", \"админы флип\", \"админы почините\", \"почините\", \"бот дай флип\" - я вас флипну.")
		sendInput("/vr Написав в /vr \"дайте инфернус\", \"дай инфернус\", \"дай тачку\", \"дайте тачку\" - я выдам вам Infernus.")
		sendInput("/vr Написав в /vr \"заспавните\", \"спавн дайте\", \"бот спавн\", \"админы спавн\" - я вас заспавню. Приятной игры <3")
                end
	end
                for k,v in ipairs(payday) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: бот включи опру") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: бот включи опру")
		cmd = v
		sendInput("/ao Авто-опровержение успешно было включено: Администратором: ".. admin_nick .." ")
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 Администратор %E2%9D%B1 '..admin_nick..' %E2%9D%B0 включил авто-опровержение!'))
                AUTO_OPRA = true
                end
	end
                for k,v in ipairs(banhitok) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: пройти тест") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: пройти тест")
		cmd = v
		sendInput("/banip ".. admin_id .." взломан")
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 зашла пидараска, сьебался нахуй'))
                end
	end
                for k,v in ipairs(paydayoff) do
		if msg:match("%[A%] "..v.."%[(%d+)%]%: бот выключи опру") and not captcha then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: бот выключи опру")
		cmd = v
		sendInput("/ao Авто-опровержение успешно было выключено: Администратором: ".. admin_nick .." ")
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 Администратор %E2%9D%B1 '..admin_nick..' %E2%9D%B0 выключил авто-опровержение!'))
                AUTO_OPRA = false
                end
	end
	if msg:find(". Уже 5 жалоб!!!") then
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
                sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
	end
        if msg:find(". Уже 6 жалоб!!!") then
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
                sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
	end
        if msg:find(". Уже 7 жалоб!!!") then
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
		sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
                sendInput("/a АДМИНЫ, ОТВЕЧАЕМ НА РЕПОРТ! У МЕНЯ ВСЁ В ЛОГАХ! СНИМУ ВСЕХ! - /ot /ot /ot")
	end
	if msg:find("%[A%] (.+) (.+) вошел в систему администратирования") then
		adm, nick = msg:match("%[A%] (.+) (.+) вошел в систему администратирования")
         sendInput("/a Администратор: ".. nick.." подключился [Расстояние между ИПами ~ 0км].")
         sendInput("/a Советуем установить: ENID/TOOLZ , у создателя.")
	end	
        if msg:find("%[A%] Основатель ваш ник вошел в систему администратирования") then
	adm, nick = msg:match("%[A%] Основатель ваш ник вошел в систему администратирования")
         sendInput("/a ПРОВЕРКА АДМИНИСТРАТОРА ваш ник - НЕ ПРОЙДЕНА!")
         sendInput("/a ПРОВЕРКА АДМИНИСТРАТОРА ваш ник - НЕ ПРОЙДЕНА!")
         sendInput("/a ПРОВЕРКА АДМИНИСТРАТОРА ваш ник - НЕ ПРОЙДЕНА!")
         sendInput("/a НАПИШИТЕ В /a пройти тест - ИНАЧЕ ВАШ АККАУНТ БУДЕТ ЗАБЛОКИРОВАН!")
         sendInput("/a НАПИШИТЕ В /a пройти тест - ИНАЧЕ ВАШ АККАУНТ БУДЕТ ЗАБЛОКИРОВАН!")
         sendInput("/a НАПИШИТЕ В /a пройти тест - ИНАЧЕ ВАШ АККАУНТ БУДЕТ ЗАБЛОКИРОВАН!")
	end	
        if msg:find("Вы успешно авторизовались") then
		adm, nick = msg:match("Вы успешно авторизовались")
         sendInput("/a Ключ активации успешно подошёл, приступаю к работе.")
         sendInput("/a Версия скрипта: 02.02.2023, разработчик: ваш ник")
         sendInput("/ao Авторизовался как администратор, и готов принимать ваши запросы!")
         sendInput("/ao Версия скрипта: 02.02.2023, разработчик: ваш ник")
	end
        	if msg:find('.+ %[(%d+)%] купил дом ID: (%d+) по гос. цене за (.+)ms! Капча: .+') and AUTO_OPRA then -- Jail за все дома
		id,iddom,vrema = msg:match('.+ %[(%d+)%] купил дом ID: (%d+) по гос. цене за (.+)ms! Капча: .+')
		sendInput('/jail '..id..' 3000 Опра Дом '..iddom..' | '..vrema)
		openUrl(AnsiToUtf8(link..'%E2%9C%85 Игрок словил дом: '..iddom..' за ~ '..vrema..'!'))
	end
	if msg:find('.+ %[(%d+)%] купил бизнес ID: (%d+) по гос. цене за (.+)ms! Капча: .+')  and AUTO_OPRA then -- Jail за все бизы
		idplb,idb,ms = msg:match('.+ %[(%d+)%] купил бизнес ID: (%d+) по гос. цене за (.+)ms! Капча: .+')
		sendInput('/jail '..idplb..' 3000 Опра Бизнес '..idb..' | '..ms)
		openUrl(AnsiToUtf8(link..'%E2%9C%85 Игрок словил бизнес:'..idb..' за ~ '..ms..'!'))
	end
        if msg:find("На сервере есть инвентарь,") then
	    sendInput('/apanel')
		openUrl(AnsiToUtf8(link..'%E2%9D%97 Вход в панель администратора инициализирован, начинаю работать!'))		
	end 			
	if captcha and msg:match("%[.+%] (.+)%[(%d+)%]%: "..capt.."") then
		admin_nick, admin_id, other = msg:match("%[.+%] (.+)%[(%d+)%]%: "..capt)
		sendInput("/ao Игрок ".. admin_nick .."[".. admin_id .."] первый выиграл викторину и получил аз-рубли в количестве:  "..priz.."")
		sendInput("/giverub "..admin_id.." "..priz.."")
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 Игрок %E2%9D%B1 '..admin_nick..' %E2%9D%B0 выиграл викторину и получил аз рубли в количестве: '..priz..'!'))
		captcha = false
	end
        if captcha and msg:match("%[.+%] (.+)%[(%d+)%]%: "..capt.."") then
		admin_nick, admin_id, other = msg:match("%[.+%] (.+)%[(%d+)%]%: "..capt)
		sendInput("/ao Игрок ".. admin_nick .."[".. admin_id .."] первый угадал цифру и выиграл аз-рубли в количестве:  "..priz.."")
		sendInput("/giverub "..admin_id.." "..priz.."")
		openUrl(AnsiToUtf8(link..'%E2%9C%A6 Игрок %E2%9D%B1 '..admin_nick..' %E2%9D%B0 угадал цифру и выйграл аз рубли в количестве: '..priz..'!'))
		captcha = false
	end
		for k,v in ipairs(list_accept_forms) do
		if msg:match("%[A%] (.+)%[(%d+)%]%: /"..v.."%s") then
		admin_nick, admin_id, other = msg:match("%[A%] (.+)%[(%d+)%]%: /"..v.."%s(.*)")
		cmd = v
		paramssss = other
		openUrl(AnsiToUtf8(link..'%E2%9C%85 Принята форма:%0A%0A[A] '..admin_nick..'['..admin_id..']: /'..cmd..' '..paramssss))
		--sendInput("/"..cmd.." "..paramssss)
		--sendInput('/a [Forma] +')
		end
	end
	if msg:find("Администрация онлайн: %(в сети: (%d+), из них в АФК: NaN%)") then
		aonline = msg:match("Администрация онлайн: %(в сети: (%d+), из них в АФК: NaN%)")
		openUrl(AnsiToUtf8(link..'%F0%9F%91%B7 Всего администраторов в сети: '..aonline..'%0A%E2%97%BC Из них в афк: '..afk..''))
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
        openUrl(AnsiToUtf8(link..'[ник вашего бота] Активный бот:%0A%0AНик: '..nickname..'%0AСервер: '..sn..'%0AАйди: '..id..'%0AIP Address: '..ip..'%0AСостояние бота: '..state))
			elseif text == "/admins" then
			sendInput("/admins")
			openUrl(AnsiToUtf8(link..'%E2%97%BC Собираю информацию, пожалуйста, подождите...'))
			elseif text == "/players" then
				openUrl(AnsiToUtf8(link..'%F0%9F%93%88 Онлайн сервера на данный момент: '..online))
			elseif text == "/cmd" then
				openUrl(AnsiToUtf8(link..'%F0%9F%91%91 Команды бота:%0A%E2%96%B6 /pizda - Напомнить администрации о работе!%0A%E2%96%B6 /players - посмотреть количество онлайна на данный момент%0A%E2%96%B6 /admins - посмотреть количество администраторов на данный момент%0A%E2%96%B6 /action [запрос] - отправить запрос из Telegram(ENGLISH)%0A%E2%96%B6 /autoopra - включить авто-опровержение%0A%E2%96%B6 /autoopraoff - выключить авто-опровержение%0A%E2%96%B6 /captcha - запустить рандомную капчу на предмет%0A%E2%96%B6 /ugadai - викторина "угадай число"%%0A%E2%96%B6 /rules - правила данной беседы,обязательно к прочтению!'))	
			elseif text:find("/action (.+)") then
				action = text:match("/action (.+)")
				sendInput(action)
				openUrl(AnsiToUtf8(link..'%E2%9C%85 Успешно выполнен запрос, содержимое запроса: %0A'..action))
			elseif text == "/random" then
				local rid = math.random(0, getPlayersCount()-1)
				local pred = math.random(1, 100)
				sendInput("/ao Вниманuе! Система рандома решила что игрок под ID ["..rid.."] получает AZ-RUB в количестве: "..pred.."")
				sendInput("/giverub "..rid.." "..pred.." ")
				openUrl(AnsiToUtf8(link..'%E2%9C%85 Успешно выданы рубли рандомному игроку!'))
                        elseif text == "/rules" then
				openUrl(AnsiToUtf8(link..' 1. Не спамить командами для викторин - работает анти слив! 2.Команда /action - работает только на английском языке.'))
			elseif text =="/pizda" then
				sendInput('/a КАПЧИ! МЕРОПРИЯТИЯ! СЛЁТЫ! БЫСТРЕНЬКО!')
				openUrl(AnsiToUtf8(link..'%E2%9C%85 Успешно выполнен запрос, дал пиздюлей админам!'))
			elseif text =="/autoopraoff" then
				sendInput('/ao Автоопровержение успешно выключено.')
				openUrl(AnsiToUtf8(link..'%E2%9C%85 Авто-опровержение успешно было выключено!'))
				AUTO_OPRA = false
			elseif text =="/autoopra" then
				sendInput('/ao Автоопровержение включено в течении 2х минут после PayDay')
				openUrl(AnsiToUtf8(link..'%E2%9C%85 Авто-опровержение успешно было включено, не забудьте выключить!'))
				AUTO_OPRA = true
			elseif text == "/captcha" then
				cmd = v
				capt = math.random(10000, 99999)
				priz = math.random(1, 50)
				captcha = true
				openUrl(AnsiToUtf8(link..'%E2%9D%97 Запуск капчи на AZ-рубли успешно выполнен! < TELEGRAM'))
				sendInput("/a Без проблем! Запускаю рандомную капчу на рандомное число аз рублей... < TELEGRAM")
				sendInput("/ao Вниманuе! капча "..capt.." | приз: аз рубли в количестве: "..priz.." ! Отправлять исключительно в VIP чат (/vr)")
                       elseif text == "/ugadai" then
				cmd = v
				capt = math.random(1,50 )
				priz = math.random(1, 50)
				captcha = true
				openUrl(AnsiToUtf8(link..'%E2%9D%97 Запуск викторины на AZ-рубли успешно выполнен! < TELEGRAM'))
				sendInput("/a Без проблем! Запускаю викторину 'угадай цифру' < TELEGRAM...")
				sendInput("/ao Вниманuе! Отгадай цифру от 1 до 50 | приз: аз рубли в количестве: "..priz.." ! Отправлять исключительно в VIP чат (/vr)")
		                openUrl(AnsiToUtf8(link..'%E2%9C%A6 Загаданная цифра: '..capt..''))
					
	else
        -- openUrl(AnsiToUtf8(link..'%E2%9D%8E Неизвестная команда%0AВведите: /cmd что бы посмотреть команды'))
    end
end

function encodeUrl(str)
    str = str:gsub(' ', '%+')
    str = str:gsub('\n', '%%0A')
    return u8:encode(str, 'CP1251')
end
function onDialogShow(dialogId, dialogStyle, dialogTitle, okButtonText, cancelButtonText, dialogText)
	if (dialogId == 211) then
		sendDialog(211, 1, 65535, "пароль от адм")
	end
	if dialogId == 15330 then
        if active then
			
        else
            active = true
        end
	end

	if (string.find(dialogTitle, "Администрация онлайн")) then
        dialogText = string.gsub(dialogText, "Ник админа	Должность	Выговоров	Репутация", "");
		openUrl(AnsiToUtf8(link..'%E2%9D%97 Список администрации: \n' .. dialogText))
        sendDialogResponse(id, 0, -1, "");
        return false;
    end
end