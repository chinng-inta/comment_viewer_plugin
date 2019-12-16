-- このファイルはVCIから取り出したコピーです。
-- 有効にするにはファイル名先頭の'_'を削除してください 
----------------------------------------------------------------
--  Copyright (c) 2019 oO (https://github.com/oocytanb)
--  MIT Licensed
----------------------------------------------------------------

---@type cytanb @See `cytanb_annotations.lua`
local cytanb=(function()math.randomseed(os.time()-os.clock()*10000)local b='__CYTANB_INSTANCE_ID'local c;local d;local a;local e=function(f,g)for h=1,4 do local i=f[h]-g[h]if i~=0 then return i end end;return 0 end;local j;j={__eq=function(f,g)return f[1]==g[1]and f[2]==g[2]and f[3]==g[3]and f[4]==g[4]end,__lt=function(f,g)return e(f,g)<0 end,__le=function(f,g)return e(f,g)<=0 end,__tostring=function(k)local l=k[2]or 0;local m=k[3]or 0;return string.format('%08x-%04x-%04x-%04x-%04x%08x',bit32.band(k[1]or 0,0xFFFFFFFF),bit32.band(bit32.rshift(l,16),0xFFFF),bit32.band(l,0xFFFF),bit32.band(bit32.rshift(m,16),0xFFFF),bit32.band(m,0xFFFF),bit32.band(k[4]or 0,0xFFFFFFFF))end,__concat=function(f,g)local n=getmetatable(f)local o=n==j or type(n)=='table'and n.__concat==j.__concat;local p=getmetatable(g)local q=p==j or type(p)=='table'and p.__concat==j.__concat;if not o and not q then error('attempt to concatenate illegal values')end;return(o and j.__tostring(f)or f)..(q and j.__tostring(g)or g)end}local r='__CYTANB_CONST_VARIABLES'local s=function(table,t)local u=getmetatable(table)if u then local v=rawget(u,r)if v then local w=rawget(v,t)if type(w)=='function'then return w(table,t)else return w end end end;return nil end;local x=function(table,t,y)local u=getmetatable(table)if u then local v=rawget(u,r)if v then if rawget(v,t)~=nil then error('Cannot assign to read only field "'..t..'"')end end end;rawset(table,t,y)end;a={InstanceID=function()if d==''then d=vci.state.Get(b)or''end;return d end,SetConst=function(z,A,k)if type(z)~='table'then error('Cannot set const to non-table target')end;local B=getmetatable(z)local u=B or{}local C=rawget(u,r)if rawget(z,A)~=nil then error('Non-const field "'..A..'" already exists')end;if not C then C={}rawset(u,r,C)u.__index=s;u.__newindex=x end;rawset(C,A,k)if not B then setmetatable(z,u)end;return z end,SetConstEach=function(z,D)for E,y in pairs(D)do a.SetConst(z,E,y)end;return z end,Extend=function(z,F,G,H,I)if z==F or type(z)~='table'or type(F)~='table'then return z end;if G then if not I then I={}end;if I[F]then error('circular reference')end;I[F]=true end;for E,y in pairs(F)do if G and type(y)=='table'then local J=z[E]z[E]=a.Extend(type(J)=='table'and J or{},y,G,H,I)else z[E]=y end end;if not H then local K=getmetatable(F)if type(K)=='table'then if G then local L=getmetatable(z)setmetatable(z,a.Extend(type(L)=='table'and L or{},K,true))else setmetatable(z,K)end end end;if G then I[F]=nil end;return z end,Vars=function(y,M,N,I)local O;if M then O=M~='__NOLF'else M='  'O=true end;if not N then N=''end;if not I then I={}end;local P=type(y)if P=='table'then I[y]=I[y]and I[y]+1 or 1;local Q=O and N..M or''local R='('..tostring(y)..') {'local S=true;for t,T in pairs(y)do if S then S=false else R=R..(O and','or', ')end;if O then R=R..'\n'..Q end;if type(T)=='table'and I[T]and I[T]>0 then R=R..t..' = ('..tostring(T)..')'else R=R..t..' = '..a.Vars(T,M,Q,I)end end;if not S and O then R=R..'\n'..N end;R=R..'}'I[y]=I[y]-1;if I[y]<=0 then I[y]=nil end;return R elseif P=='function'or P=='thread'or P=='userdata'then return'('..P..')'elseif P=='string'then return'('..P..') '..string.format('%q',y)else return'('..P..') '..tostring(y)end end,GetLogLevel=function()return c end,SetLogLevel=function(U)c=U end,Log=function(U,...)if U<=c then local V=table.pack(...)if V.n==1 then local y=V[1]if y~=nil then print(type(y)=='table'and a.Vars(y)or tostring(y))else print('')end else local R=''for h=1,V.n do local y=V[h]if y~=nil then R=R..(type(y)=='table'and a.Vars(y)or tostring(y))end end;print(R)end end end,LogFatal=function(...)a.Log(a.LogLevelFatal,...)end,LogError=function(...)a.Log(a.LogLevelError,...)end,LogWarn=function(...)a.Log(a.LogLevelWarn,...)end,LogInfo=function(...)a.Log(a.LogLevelInfo,...)end,LogDebug=function(...)a.Log(a.LogLevelDebug,...)end,LogTrace=function(...)a.Log(a.LogLevelTrace,...)end,FatalLog=function(...)a.LogFatal(...)end,ErrorLog=function(...)a.LogError(...)end,WarnLog=function(...)a.LogWarn(...)end,InfoLog=function(...)a.LogInfo(...)end,DebugLog=function(...)a.LogDebug(...)end,TraceLog=function(...)a.LogTrace(...)end,ListToMap=function(W,X)local table={}local Y=X==nil;for E,y in pairs(W)do table[y]=Y and y or X end;return table end,Round=function(Z,_)if _ then local a0=10^_;return math.floor(Z*a0+0.5)/a0 else return math.floor(Z+0.5)end end,Clamp=function(k,a1,a2)return math.max(a1,math.min(k,a2))end,Lerp=function(a3,a4,P)if P<=0.0 then return a3 elseif P>=1.0 then return a4 else return a3+(a4-a3)*P end end,LerpUnclamped=function(a3,a4,P)if P==0.0 then return a3 elseif P==1.0 then return a4 else return a3+(a4-a3)*P end end,PingPong=function(P,a5)if a5==0 then return 0 end;local a6=math.floor(P/a5)local a7=P-a6*a5;if a6<0 then if(a6+1)%2==0 then return a5-a7 else return a7 end else if a6%2==0 then return a7 else return a5-a7 end end end,QuaternionToAngleAxis=function(a8)local a6=a8.normalized;local a9=math.acos(a6.w)local aa=math.sin(a9)local ab=math.deg(a9*2.0)local ac;if math.abs(aa)<=Quaternion.kEpsilon then ac=Vector3.right else local ad=1.0/aa;ac=Vector3.__new(a6.x*ad,a6.y*ad,a6.z*ad)end;return ab,ac end,ApplyQuaternionToVector3=function(a8,ae)local af=a8.w*ae.x+a8.y*ae.z-a8.z*ae.y;local ag=a8.w*ae.y-a8.x*ae.z+a8.z*ae.x;local ah=a8.w*ae.z+a8.x*ae.y-a8.y*ae.x;local ai=-a8.x*ae.x-a8.y*ae.y-a8.z*ae.z;return Vector3.__new(ai*-a8.x+af*a8.w+ag*-a8.z-ah*-a8.y,ai*-a8.y-af*-a8.z+ag*a8.w+ah*-a8.x,ai*-a8.z+af*-a8.y-ag*-a8.x+ah*a8.w)end,Random32=function()return bit32.band(math.random(-2147483648,2147483646),0xFFFFFFFF)end,RandomUUID=function()return a.UUIDFromNumbers(a.Random32(),bit32.bor(0x4000,bit32.band(a.Random32(),0xFFFF0FFF)),bit32.bor(0x80000000,bit32.band(a.Random32(),0x3FFFFFFF)),a.Random32())end,UUIDString=function(aj)return j.__tostring(aj)end,UUIDFromNumbers=function(...)local ak=...local P=type(ak)local al,am,an,ao;if P=='table'then al=ak[1]am=ak[2]an=ak[3]ao=ak[4]else al,am,an,ao=...end;local aj={bit32.band(al or 0,0xFFFFFFFF),bit32.band(am or 0,0xFFFFFFFF),bit32.band(an or 0,0xFFFFFFFF),bit32.band(ao or 0,0xFFFFFFFF)}setmetatable(aj,j)return aj end,UUIDFromString=function(R)local ap=string.len(R)if ap~=32 and ap~=36 then return nil end;local aq='[0-9a-f-A-F]+'local ar='^('..aq..')$'local as='^-('..aq..')$'local at,au,av,aw;if ap==32 then local aj=a.UUIDFromNumbers(0,0,0,0)local ax=1;for h,ay in ipairs({8,16,24,32})do at,au,av=string.find(string.sub(R,ax,ay),ar)if not at then return nil end;aj[h]=tonumber(av,16)ax=ay+1 end;return aj else at,au,av=string.find(string.sub(R,1,8),ar)if not at then return nil end;local al=tonumber(av,16)at,au,av=string.find(string.sub(R,9,13),as)if not at then return nil end;at,au,aw=string.find(string.sub(R,14,18),as)if not at then return nil end;local am=tonumber(av..aw,16)at,au,av=string.find(string.sub(R,19,23),as)if not at then return nil end;at,au,aw=string.find(string.sub(R,24,28),as)if not at then return nil end;local an=tonumber(av..aw,16)at,au,av=string.find(string.sub(R,29,36),ar)if not at then return nil end;local ao=tonumber(av,16)return a.UUIDFromNumbers(al,am,an,ao)end end,ParseUUID=function(R)return a.UUIDFromString(R)end,CreateCircularQueue=function(az)if type(az)~='number'or az<1 then error('Invalid argument: capacity = '..tostring(az))end;local self;local aA=math.floor(az)local aB={}local aC=0;local aD=0;local aE=0;self={Size=function()return aE end,Clear=function()aC=0;aD=0;aE=0 end,IsEmpty=function()return aE==0 end,Offer=function(aF)aB[aC+1]=aF;aC=(aC+1)%aA;if aE<aA then aE=aE+1 else aD=(aD+1)%aA end;return true end,OfferFirst=function(aF)aD=(aA+aD-1)%aA;aB[aD+1]=aF;if aE<aA then aE=aE+1 else aC=(aA+aC-1)%aA end;return true end,Poll=function()if aE==0 then return nil else local aF=aB[aD+1]aD=(aD+1)%aA;aE=aE-1;return aF end end,PollLast=function()if aE==0 then return nil else aC=(aA+aC-1)%aA;local aF=aB[aC+1]aE=aE-1;return aF end end,Peek=function()if aE==0 then return nil else return aB[aD+1]end end,PeekLast=function()if aE==0 then return nil else return aB[(aA+aC-1)%aA+1]end end,Get=function(aG)if aG<1 or aG>aE then a.LogError('CreateCircularQueue.Get: index is outside the range: '..aG)return nil end;return aB[(aD+aG-1)%aA+1]end,IsFull=function()return aE>=aA end,MaxSize=function()return aA end}return self end,ColorFromARGB32=function(aH)local aI=type(aH)=='number'and aH or 0xFF000000;return Color.__new(bit32.band(bit32.rshift(aI,16),0xFF)/0xFF,bit32.band(bit32.rshift(aI,8),0xFF)/0xFF,bit32.band(aI,0xFF)/0xFF,bit32.band(bit32.rshift(aI,24),0xFF)/0xFF)end,ColorToARGB32=function(aJ)return bit32.bor(bit32.lshift(bit32.band(a.Round(0xFF*aJ.a),0xFF),24),bit32.lshift(bit32.band(a.Round(0xFF*aJ.r),0xFF),16),bit32.lshift(bit32.band(a.Round(0xFF*aJ.g),0xFF),8),bit32.band(a.Round(0xFF*aJ.b),0xFF))end,ColorFromIndex=function(aK,aL,aM,aN,aO)local aP=math.max(math.floor(aL or a.ColorHueSamples),1)local aQ=aO and aP or aP-1;local aR=math.max(math.floor(aM or a.ColorSaturationSamples),1)local aS=math.max(math.floor(aN or a.ColorBrightnessSamples),1)local aG=a.Clamp(math.floor(aK or 0),0,aP*aR*aS-1)local aT=aG%aP;local aU=math.floor(aG/aP)local ad=aU%aR;local aV=math.floor(aU/aR)if aO or aT~=aQ then local w=aT/aQ;local aW=(aR-ad)/aR;local y=(aS-aV)/aS;return Color.HSVToRGB(w,aW,y)else local y=(aS-aV)/aS*ad/(aR-1)return Color.HSVToRGB(0.0,0.0,y)end end,
GetSubItemTransform=function(aX)local aY=aX.GetPosition()local aZ=aX.GetRotation()local a_=aX.GetLocalScale()return{positionX=aY.x,positionY=aY.y,positionZ=aY.z,rotationX=aZ.x,rotationY=aZ.y,rotationZ=aZ.z,rotationW=aZ.w,scaleX=a_.x,scaleY=a_.y,scaleZ=a_.z}end,TableToSerializable=function(b0,I)if type(b0)~='table'then return b0 end;if not I then I={}end;if I[b0]then error('circular reference')end;I[b0]=true;local b1={}for E,y in pairs(b0)do local b2=type(E)=='number'and tostring(E)..a.ArrayNumberTag or E;if type(y)=='number'and y<0 then b1[tostring(b2)..a.NegativeNumberTag]=tostring(y)else b1[b2]=a.TableToSerializable(y,I)end end;I[b0]=nil;return b1 end,TableFromSerializable=function(b1)if type(b1)~='table'then return b1 end;local b0={}for E,y in pairs(b1)do local b2;local b3;if type(E)=='string'then if string.endsWith(E,a.NegativeNumberTag)then b2=string.sub(E,1,-1-#a.NegativeNumberTag)b3=true else b2=E;b3=false end;if string.endsWith(b2,a.ArrayNumberTag)then local b4=string.sub(b2,1,-1-#a.ArrayNumberTag)b2=tonumber(b4)or b4 end else b2=E;b3=false end;b0[b2]=b3 and type(y)=='string'and tonumber(y)or a.TableFromSerializable(y)end;return b0 end,TableToSerialiable=function(b0,I)return a.TableToSerializable(b0,I)end,TableFromSerialiable=function(b1)return a.TableFromSerializable(b1)end,EmitMessage=function(A,b5)local table=b5 and a.TableToSerializable(b5)or{}table[a.InstanceIDParameterName]=a.InstanceID()vci.message.Emit(A,json.serialize(table))end,OnMessage=function(A,b6)local b7=function(b8,b9,ba)local bb=nil;if b8.type~='comment'and type(ba)=='string'then local bc,b1=pcall(json.parse,ba)if bc and type(b1)=='table'then bb=a.TableFromSerializable(b1)end end;local b5=bb and bb or{[a.MessageValueParameterName]=ba}b6(b8,b9,b5)end;vci.message.On(A,b7)return{Off=function()if b7 then b7=nil end end}end,OnInstanceMessage=function(A,b6)local b7=function(b8,b9,b5)local bd=a.InstanceID()if bd~=''and bd==b5[a.InstanceIDParameterName]then b6(b8,b9,b5)end end;return a.OnMessage(A,b7)end}a.SetConstEach(a,{LogLevelFatal=100,LogLevelError=200,LogLevelWarn=300,LogLevelInfo=400,LogLevelDebug=500,LogLevelTrace=600,ColorHueSamples=10,ColorSaturationSamples=4,ColorBrightnessSamples=5,NegativeNumberTag='#__CYTANB_NEGATIVE_NUMBER',ArrayNumberTag='#__CYTANB_ARRAY_NUMBER',InstanceIDParameterName='__CYTANB_INSTANCE_ID',MessageValueParameterName='__CYTANB_MESSAGE_VALUE'})a.SetConstEach(a,{ColorMapSize=a.ColorHueSamples*a.ColorSaturationSamples*a.ColorBrightnessSamples,FatalLogLevel=a.LogLevelFatal,ErrorLogLevel=a.LogLevelError,WarnLogLevel=a.LogLevelWarn,InfoLogLevel=a.LogLevelInfo,DebugLogLevel=a.LogLevelDebug,TraceLogLevel=a.LogLevelTrace})c=a.LogLevelInfo;package.loaded['cytanb']=a;d=vci.state.Get(b)or''if d==''and vci.assets.IsMine then d=tostring(a.RandomUUID())vci.state.Set(b,d)end;return a end)()


local commentList = {"Comment1","Comment2","Comment3","Comment4","Comment5","Comment6","Comment7","Comment8","Comment9"}
local opeCommentList = {"opeComment1","opeComment2","opeComment3","opeComment4","opeComment5","opeComment6","opeComment7","opeComment8","opeComment9"}

function chinng_gift_onMessage(sender, name, message)   
    print(name)
    print(message)
    local lComment = {}
    local lopeComment = {}
    if vci.assets.IsMine then
        if name == "ankoCommMsg" then
            local msg = message
            for i=1, #msg do
                local comm = {}
                local str=""
                if msg[i].live ~= nil then
                    str=""..str..msg[i].live
                end
                if msg[i].date ~= nil then
                    local ts=os.date("%T", msg[i].date)
                    str=""..str..ts
                    comm.date=msg[i].date
                else
                    comm.date=0
                end
                if msg[i].user ~= nil then
                    str=""..str..msg[i].user
                end
                if msg[i].msg ~= nil then
                    str=""..str..msg[i].msg
                else
                    str=msg[i]
                end
                comm.str = str
                if comm.date ~= 0 then
                    table.insert(lComment,comm)
                end
            end
        end
        if name == "ankoOpeCommMsg" then
            local msg = message
            for i=1, #msg do
                local comm = {}
                local str=""
                if msg[i].date ~= nil then
                    local ts=os.date("%T", msg[i].date)
                    str=""..str..ts
                    comm.date=msg[i].date
                else
                    comm.date=0
                end
                if msg[i].msg ~= nil then
                    str=""..str..msg[i].msg
                else
                    str=msg[i]
                end
                comm.str = str
                if comm.date ~= 0 then
                    table.insert(lopeComment,comm)
                end
            end
        end
        if name == "shocoroCommMsg" then
            local msg = message
            for i=1, #msg do
                local comm = {}
                local str=""
                if msg[i].live ~= nil then
                    str=""..str..msg[i].live
                end
                if msg[i].date ~= nil then
                    local ts=os.date("%T", msg[i].date)
--                    print(ts)
                    str=""..str..ts
                    comm.date=msg[i].date
                else
                    comm.date=0
                end
                if msg[i].user ~= nil then
                    str=""..str..msg[i].user
                end
                if msg[i].msg ~= nil then
                    str=""..str..msg[i].msg
                else
                    str=msg[i]
                end
                comm.str = str
                print(comm.str)
                if comm.date ~= 0 then
                    table.insert(lComment,comm)
                end
            end
        end
        if name == "shocoroOpeCommMsg" then
            local msg = message
            for i=1, #msg do
                local comm = {}
                local str=""
                if msg[i].date ~= nil then
                    local ts=os.date("%T", msg[i].date)
                    str=""..str..ts
                    comm.date=msg[i].date
                else
                    comm.date=0
                end
                if msg[i].msg ~= nil then
                    str=""..str..msg[i].msg
                else
                    str=msg[i]
                end
                comm.str = str
                if comm.date ~= 0 then
                    table.insert(lopeComment,comm)
                end
            end
        end
        if name == "mcvCommMsg" then
            local msg = message
            for i=1, #msg do
                local comm = {}
                local str=""
                if msg[i].live ~= nil then
                    str=""..str..msg[i].live
                end
                if msg[i].date ~= nil then
                    local ts=os.date("%T", msg[i].date)
                    str=""..str..ts
                    comm.date=msg[i].date
                else
                    comm.date=0
                end
                if msg[i].user ~= nil then
                    str=""..str..msg[i].user
                end
                if msg[i].msg ~= nil then
                    str=""..str..msg[i].msg
                else
                    str=msg[i]
                end
                comm.str = str
                if comm.date ~= 0 then
                    table.insert(lComment,comm)
                end
            end
        end
        if name == "ankoCommMsg" or name == "shocoroCommMsg" or name == "mcvCommMsg" then
            while #commentList > 0 do
                local comm = table.remove(commentList)
                if comm.date ~= nil then
                    local flag = false
                    for i=1, #lComment do
                        if lComment[i].msg == comm.str then
                            flag = true
                        end
                    end
                    if flag ~= true then
                        table.insert(lComment,comm)
                    end
                end
            end
            for i=1, #lComment do
                for j=i, #lComment-1 do
                    if lComment[i].date > lComment[j+1].date then
                        lComment[i], lComment[j+1] = lComment[j+1], lComment[i]
                    end
                end
            end
            
            while #lComment > 9 do
                local comm = table.remove(lComment, 1)
            end

            local lcomLen = 9 - #lComment
            for i=1, lcomLen do
                vci.assets._ALL_SetText("Text"..i, "Comment"..i+(9-lcomLen))
                table.insert(commentList, "Comment"..i+(9-lcomLen))
            end

            for i=1, #lComment do
                vci.assets._ALL_SetText("Text"..i+lcomLen, lComment[i].str)
                table.insert(commentList, lComment[i])
            end
        end
        if name == "ankoOpeCommMsg" or name == "shocoroOpeCommMsg" then
            while #opeCommentList > 0 do
                local comm = table.remove(opeCommentList)
                if comm.date ~= nil then
                    local flag = false
                    for i=1, #lopeComment do
                        if lopeComment[i].msg == comm.str then
                            flag = true
                        end
                    end
                    if flag ~= true then
                        table.insert(lopeComment,comm)
                    end
                end
            end
            for i=1, #lopeComment do
                for j=i, #lopeComment-1 do
                    if lopeComment[i].date > lopeComment[j+1].date then
                        lopeComment[i], lopeComment[j+1] = lopeComment[j+1], lopeComment[i]
                    end
                end
            end
            
            while #lopeComment > 9 do
                local comm = table.remove(lopeComment, 1)
            end

            local lcomLen = 9 - #lopeComment
            for i=1, lcomLen do
                vci.assets._ALL_SetText("opeText"..i, "運営Comment"..i+(9-lcomLen))
                table.insert(opeCommentList, "運営Comment"..i+(9-lcomLen))
            end

            for i=1, #lopeComment do
                vci.assets._ALL_SetText("opeText"..i+lcomLen, lopeComment[i].str)
                table.insert(opeCommentList, lopeComment[i])
            end
        end
    end
end

if vci.assets.IsMine then
    cytanb.OnMessage("ankoCommMsg", chinng_gift_onMessage)
    cytanb.OnMessage("ankoOpeCommMsg", chinng_gift_onMessage)
    cytanb.OnMessage("shocoroCommMsg", chinng_gift_onMessage)
    cytanb.OnMessage("shocoroOpeCommMsg", chinng_gift_onMessage)
    cytanb.OnMessage("mcvCommMsg", chinng_gift_onMessage)
end
