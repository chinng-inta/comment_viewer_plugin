-- このファイルはVCIから取り出したコピーです。
-- 有効にするにはファイル名先頭の'_'を削除してください 
-- SPDX-License-Identifier: MIT
-- Copyright (c) 2019 oO (https://github.com/oocytanb)
---@type cytanb @See `cytanb_annotations.lua`
local cytanb=(function()local b='__CYTANB_INSTANCE_ID'local c;local d;local e;local f;local g=false;local h;local i;local j;local a;local k=function(l,m)for n=1,4 do local o=l[n]-m[n]if o~=0 then return o end end;return 0 end;local p;p={__eq=function(l,m)return l[1]==m[1]and l[2]==m[2]and l[3]==m[3]and l[4]==m[4]end,__lt=function(l,m)return k(l,m)<0 end,__le=function(l,m)return k(l,m)<=0 end,__tostring=function(q)local r=q[2]or 0;local s=q[3]or 0;return string.format('%08x-%04x-%04x-%04x-%04x%08x',bit32.band(q[1]or 0,0xFFFFFFFF),bit32.band(bit32.rshift(r,16),0xFFFF),bit32.band(r,0xFFFF),bit32.band(bit32.rshift(s,16),0xFFFF),bit32.band(s,0xFFFF),bit32.band(q[4]or 0,0xFFFFFFFF))end,__concat=function(l,m)local t=getmetatable(l)local u=t==p or type(t)=='table'and t.__concat==p.__concat;local v=getmetatable(m)local w=v==p or type(v)=='table'and v.__concat==p.__concat;if not u and not w then error('UUID: attempt to concatenate illegal values',2)end;return(u and p.__tostring(l)or l)..(w and p.__tostring(m)or m)end}local x='__CYTANB_CONST_VARIABLES'local y=function(table,z)local A=getmetatable(table)if A then local B=rawget(A,x)if B then local C=rawget(B,z)if type(C)=='function'then return C(table,z)else return C end end end;return nil end;local D=function(table,z,E)local A=getmetatable(table)if A then local B=rawget(A,x)if B then if rawget(B,z)~=nil then error('Cannot assign to read only field "'..z..'"',2)end end end;rawset(table,z,E)end;local F=function(G,H)local I=G[a.TypeParameterName]if a.NillableHasValue(I)and a.NillableValue(I)~=H then return false,false end;return a.NillableIfHasValueOrElse(c[H],function(J)local K=J.compositionFieldNames;local L=J.compositionFieldLength;local M=false;for N,E in pairs(G)do if K[N]then L=L-1;if L<=0 and M then break end elseif N~=a.TypeParameterName then M=true;if L<=0 then break end end end;return L<=0,M end,function()return false,false end)end;local O=function(P)return string.gsub(string.gsub(P,a.EscapeSequenceTag,a.EscapeSequenceTag..a.EscapeSequenceTag),'/',a.SolidusTag)end;local Q=function(P,R)local S=string.len(P)local T=string.len(a.EscapeSequenceTag)if T>S then return P end;local U=''local n=1;while n<S do local V,W=string.find(P,a.EscapeSequenceTag,n,true)if not V then if n==1 then U=P else U=U..string.sub(P,n)end;break end;if V>n then U=U..string.sub(P,n,V-1)end;local X=false;for Y,Z in ipairs(d)do local _,a0=string.find(P,Z.pattern,V)if _ then U=U..(R and R(Z.tag)or Z.replacement)n=a0+1;X=true;break end end;if not X then U=U..a.EscapeSequenceTag;n=W+1 end end;return U end;local a1;a1=function(a2,a3)if type(a2)~='table'then return a2 end;if not a3 then a3={}end;if a3[a2]then error('circular reference')end;a3[a2]=true;local a4={}for N,E in pairs(a2)do local a5=type(N)local a6;if a5=='string'then a6=O(N)elseif a5=='number'then a6=tostring(N)..a.ArrayNumberTag else a6=N end;local a7=type(E)if a7=='string'then a4[a6]=O(E)elseif a7=='number'and E<0 then a4[tostring(a6)..a.NegativeNumberTag]=tostring(E)else a4[a6]=a1(E,a3)end end;a3[a2]=nil;return a4 end;local a8;a8=function(a4,a9)if type(a4)~='table'then return a4 end;local a2={}for N,E in pairs(a4)do local a6;local aa=false;if type(N)=='string'then local ab=false;a6=Q(N,function(ac)if ac==a.NegativeNumberTag then aa=true elseif ac==a.ArrayNumberTag then ab=true end;return nil end)if ab then a6=tonumber(a6)or a6 end else a6=N;aa=false end;if aa and type(E)=='string'then a2[a6]=tonumber(E)elseif type(E)=='string'then a2[a6]=Q(E,function(ac)return e[ac]end)else a2[a6]=a8(E,a9)end end;if not a9 then a.NillableIfHasValue(a2[a.TypeParameterName],function(ad)a.NillableIfHasValue(c[ad],function(J)local ae,M=J.fromTableFunc(a2)if not M then a.NillableIfHasValue(ae,function(q)a2=q end)end end)end)end;return a2 end;a={InstanceID=function()if i==''then i=vci.state.Get(b)or''end;return i end,NillableHasValue=function(af)return af~=nil end,NillableValue=function(af)if af==nil then error('nillable: value is nil',2)end;return af end,NillableValueOrDefault=function(af,ag)if af==nil then if ag==nil then error('nillable: defaultValue is nil',2)end;return ag else return af end end,NillableIfHasValue=function(af,ah)if af==nil then return nil else return ah(af)end end,NillableIfHasValueOrElse=function(af,ah,ai)if af==nil then return ai()else return ah(af)end end,SetConst=function(aj,ak,q)if type(aj)~='table'then error('Cannot set const to non-table target',2)end;local al=getmetatable(aj)local A=al or{}local am=rawget(A,x)if rawget(aj,ak)~=nil then error('Non-const field "'..ak..'" already exists',2)end;if not am then am={}rawset(A,x,am)A.__index=y;A.__newindex=D end;rawset(am,ak,q)if not al then setmetatable(aj,A)end;return aj end,SetConstEach=function(aj,an)for N,E in pairs(an)do a.SetConst(aj,N,E)end;return aj end,Extend=function(aj,ao,ap,aq,a3)if aj==ao or type(aj)~='table'or type(ao)~='table'then return aj end;if ap then if not a3 then a3={}end;if a3[ao]then error('circular reference')end;a3[ao]=true end;for N,E in pairs(ao)do if ap and type(E)=='table'then local ar=aj[N]aj[N]=a.Extend(type(ar)=='table'and ar or{},E,ap,aq,a3)else aj[N]=E end end;if not aq then local as=getmetatable(ao)if type(as)=='table'then if ap then local at=getmetatable(aj)setmetatable(aj,a.Extend(type(at)=='table'and at or{},as,true))else setmetatable(aj,as)end end end;if ap then a3[ao]=nil end;return aj end,Vars=function(E,au,av,a3)local aw;if au then aw=au~='__NOLF'else au='  'aw=true end;if not av then av=''end;if not a3 then a3={}end;local ax=type(E)if ax=='table'then a3[E]=a3[E]and a3[E]+1 or 1;local ay=aw and av..au or''local P='('..tostring(E)..') {'local az=true;for z,aA in pairs(E)do if az then az=false else P=P..(aw and','or', ')end;if aw then P=P..'\n'..ay end;if type(aA)=='table'and a3[aA]and a3[aA]>0 then P=P..z..' = ('..tostring(aA)..')'else P=P..z..' = '..a.Vars(aA,au,ay,a3)end end;if not az and aw then P=P..'\n'..av end;P=P..'}'a3[E]=a3[E]-1;if a3[E]<=0 then a3[E]=nil end;return P elseif ax=='function'or ax=='thread'or ax=='userdata'then return'('..ax..')'elseif ax=='string'then return'('..ax..') '..string.format('%q',E)else return'('..ax..') '..tostring(E)end end,GetLogLevel=function()return f end,SetLogLevel=function(aB)f=aB end,IsOutputLogLevelEnabled=function()return g end,SetOutputLogLevelEnabled=function(aC)g=not not aC end,Log=function(aB,...)if aB<=f then local aD=g and(h[aB]or'LOG LEVEL '..tostring(aB))..' | 'or''local aE=table.pack(...)if aE.n==1 then local E=aE[1]if E~=nil then local P=type(E)=='table'and a.Vars(E)or tostring(E)print(g and aD..P or P)else print(aD)end else local P=aD;for n=1,aE.n do local E=aE[n]if E~=nil then P=P..(type(E)=='table'and a.Vars(E)or tostring(E))end end;print(P)end end end,LogFatal=function(...)a.Log(a.LogLevelFatal,...)end,LogError=function(...)a.Log(a.LogLevelError,...)end,LogWarn=function(...)a.Log(a.LogLevelWarn,...)end,LogInfo=function(...)a.Log(a.LogLevelInfo,...)end,LogDebug=function(...)a.Log(a.LogLevelDebug,...)end,LogTrace=function(...)a.Log(a.LogLevelTrace,...)end,FatalLog=function(...)a.LogFatal(...)end,ErrorLog=function(...)a.LogError(...)end,WarnLog=function(...)a.LogWarn(...)end,InfoLog=function(...)a.LogInfo(...)end,DebugLog=function(...)a.LogDebug(...)end,TraceLog=function(...)a.LogTrace(...)end,ListToMap=function(aF,aG)local table={}local aH=aG==nil;for N,E in pairs(aF)do table[E]=aH and E or aG end;return table end,Round=function(aI,aJ)if aJ then local aK=10^aJ;return math.floor(aI*aK+0.5)/aK else return math.floor(aI+0.5)end end,Clamp=function(q,aL,aM)return math.max(aL,math.min(q,aM))end,Lerp=function(aN,aO,ax)if ax<=0.0 then return aN elseif ax>=1.0 then return aO else return aN+(aO-aN)*ax end end,LerpUnclamped=function(aN,aO,ax)if ax==0.0 then return aN elseif ax==1.0 then return aO else return aN+(aO-aN)*ax end end,PingPong=function(ax,aP)if aP==0 then return 0 end;local aQ=math.floor(ax/aP)local aR=ax-aQ*aP;if aQ<0 then if(aQ+1)%2==0 then return aP-aR else return aR end else if aQ%2==0 then return aR else return aP-aR end end end,VectorApproximatelyEquals=function(aS,aT)return(aS-aT).sqrMagnitude<1E-10 end,QuaternionApproximatelyEquals=function(aS,aT)local aU=Quaternion.Dot(aS,aT)return aU<1.0+1E-06 and aU>1.0-1E-06 end,
QuaternionToAngleAxis=function(aV)local aQ=aV.normalized;local aW=math.acos(aQ.w)local aX=math.sin(aW)local aY=math.deg(aW*2.0)local aZ;if math.abs(aX)<=Quaternion.kEpsilon then aZ=Vector3.right else local a_=1.0/aX;aZ=Vector3.__new(aQ.x*a_,aQ.y*a_,aQ.z*a_)end;return aY,aZ end,ApplyQuaternionToVector3=function(aV,b0)local b1=aV.w*b0.x+aV.y*b0.z-aV.z*b0.y;local b2=aV.w*b0.y-aV.x*b0.z+aV.z*b0.x;local b3=aV.w*b0.z+aV.x*b0.y-aV.y*b0.x;local b4=-aV.x*b0.x-aV.y*b0.y-aV.z*b0.z;return Vector3.__new(b4*-aV.x+b1*aV.w+b2*-aV.z-b3*-aV.y,b4*-aV.y-b1*-aV.z+b2*aV.w+b3*-aV.x,b4*-aV.z+b1*-aV.y-b2*-aV.x+b3*aV.w)end,RotateAround=function(b5,b6,b7,b8)return b7+a.ApplyQuaternionToVector3(b8,b5-b7),b8*b6 end,Random32=function()return bit32.band(math.random(-2147483648,2147483646),0xFFFFFFFF)end,RandomUUID=function()return a.UUIDFromNumbers(a.Random32(),bit32.bor(0x4000,bit32.band(a.Random32(),0xFFFF0FFF)),bit32.bor(0x80000000,bit32.band(a.Random32(),0x3FFFFFFF)),a.Random32())end,UUIDString=function(b9)return p.__tostring(b9)end,UUIDFromNumbers=function(...)local ba=...local ax=type(ba)local bb,bc,bd,be;if ax=='table'then bb=ba[1]bc=ba[2]bd=ba[3]be=ba[4]else bb,bc,bd,be=...end;local b9={bit32.band(bb or 0,0xFFFFFFFF),bit32.band(bc or 0,0xFFFFFFFF),bit32.band(bd or 0,0xFFFFFFFF),bit32.band(be or 0,0xFFFFFFFF)}setmetatable(b9,p)return b9 end,UUIDFromString=function(P)local S=string.len(P)if S~=32 and S~=36 then return nil end;local bf='[0-9a-f-A-F]+'local bg='^('..bf..')$'local bh='^-('..bf..')$'local bi,bj,bk,bl;if S==32 then local b9=a.UUIDFromNumbers(0,0,0,0)local bm=1;for n,bn in ipairs({8,16,24,32})do bi,bj,bk=string.find(string.sub(P,bm,bn),bg)if not bi then return nil end;b9[n]=tonumber(bk,16)bm=bn+1 end;return b9 else bi,bj,bk=string.find(string.sub(P,1,8),bg)if not bi then return nil end;local bb=tonumber(bk,16)bi,bj,bk=string.find(string.sub(P,9,13),bh)if not bi then return nil end;bi,bj,bl=string.find(string.sub(P,14,18),bh)if not bi then return nil end;local bc=tonumber(bk..bl,16)bi,bj,bk=string.find(string.sub(P,19,23),bh)if not bi then return nil end;bi,bj,bl=string.find(string.sub(P,24,28),bh)if not bi then return nil end;local bd=tonumber(bk..bl,16)bi,bj,bk=string.find(string.sub(P,29,36),bg)if not bi then return nil end;local be=tonumber(bk,16)return a.UUIDFromNumbers(bb,bc,bd,be)end end,ParseUUID=function(P)return a.UUIDFromString(P)end,CreateCircularQueue=function(bo)if type(bo)~='number'or bo<1 then error('CreateCircularQueue: Invalid arguments: capacity = '..tostring(bo),2)end;local self;local bp=math.floor(bo)local U={}local bq=0;local br=0;local bs=0;self={Size=function()return bs end,Clear=function()bq=0;br=0;bs=0 end,IsEmpty=function()return bs==0 end,Offer=function(bt)U[bq+1]=bt;bq=(bq+1)%bp;if bs<bp then bs=bs+1 else br=(br+1)%bp end;return true end,OfferFirst=function(bt)br=(bp+br-1)%bp;U[br+1]=bt;if bs<bp then bs=bs+1 else bq=(bp+bq-1)%bp end;return true end,Poll=function()if bs==0 then return nil else local bt=U[br+1]br=(br+1)%bp;bs=bs-1;return bt end end,PollLast=function()if bs==0 then return nil else bq=(bp+bq-1)%bp;local bt=U[bq+1]bs=bs-1;return bt end end,Peek=function()if bs==0 then return nil else return U[br+1]end end,PeekLast=function()if bs==0 then return nil else return U[(bp+bq-1)%bp+1]end end,Get=function(bu)if bu<1 or bu>bs then a.LogError('CreateCircularQueue.Get: index is outside the range: '..bu)return nil end;return U[(br+bu-1)%bp+1]end,IsFull=function()return bs>=bp end,MaxSize=function()return bp end}return self end,DetectClicks=function(bv,bw,bx)local by=bv or 0;local bz=bx or TimeSpan.FromMilliseconds(500)local bA=vci.me.Time;local bB=bw and bA>bw+bz and 1 or by+1;return bB,bA end,ColorRGBToHSV=function(bC)local aR=math.max(0.0,math.min(bC.r,1.0))local bD=math.max(0.0,math.min(bC.g,1.0))local aO=math.max(0.0,math.min(bC.b,1.0))local aM=math.max(aR,bD,aO)local aL=math.min(aR,bD,aO)local bE=aM-aL;local C;if bE==0.0 then C=0.0 elseif aM==aR then C=(bD-aO)/bE/6.0 elseif aM==bD then C=(2.0+(aO-aR)/bE)/6.0 else C=(4.0+(aR-bD)/bE)/6.0 end;if C<0.0 then C=C+1.0 end;local bF=aM==0.0 and bE or bE/aM;local E=aM;return C,bF,E end,ColorFromARGB32=function(bG)local bH=type(bG)=='number'and bG or 0xFF000000;return Color.__new(bit32.band(bit32.rshift(bH,16),0xFF)/0xFF,bit32.band(bit32.rshift(bH,8),0xFF)/0xFF,bit32.band(bH,0xFF)/0xFF,bit32.band(bit32.rshift(bH,24),0xFF)/0xFF)end,ColorToARGB32=function(bC)return bit32.bor(bit32.lshift(bit32.band(a.Round(0xFF*bC.a),0xFF),24),bit32.lshift(bit32.band(a.Round(0xFF*bC.r),0xFF),16),bit32.lshift(bit32.band(a.Round(0xFF*bC.g),0xFF),8),bit32.band(a.Round(0xFF*bC.b),0xFF))end,ColorFromIndex=function(bI,bJ,bK,bL,bM)local bN=math.max(math.floor(bJ or a.ColorHueSamples),1)local bO=bM and bN or bN-1;local bP=math.max(math.floor(bK or a.ColorSaturationSamples),1)local bQ=math.max(math.floor(bL or a.ColorBrightnessSamples),1)local bu=a.Clamp(math.floor(bI or 0),0,bN*bP*bQ-1)local bR=bu%bN;local bS=math.floor(bu/bN)local a_=bS%bP;local bT=math.floor(bS/bP)if bM or bR~=bO then local C=bR/bO;local bF=(bP-a_)/bP;local E=(bQ-bT)/bQ;return Color.HSVToRGB(C,bF,E)else local E=(bQ-bT)/bQ*a_/(bP-1)return Color.HSVToRGB(0.0,0.0,E)end end,ColorToIndex=function(bC,bJ,bK,bL,bM)local bN=math.max(math.floor(bJ or a.ColorHueSamples),1)local bO=bM and bN or bN-1;local bP=math.max(math.floor(bK or a.ColorSaturationSamples),1)local bQ=math.max(math.floor(bL or a.ColorBrightnessSamples),1)local C,bF,E=a.ColorRGBToHSV(bC)local a_=a.Round(bP*(1.0-bF))if bM or a_<bP then local bU=a.Round(bO*C)if bU>=bO then bU=0 end;if a_>=bP then a_=bP-1 end;local bT=math.min(bQ-1,a.Round(bQ*(1.0-E)))return bU+bN*(a_+bP*bT)else local bV=a.Round((bP-1)*E)if bV==0 then local bW=a.Round(bQ*(1.0-E))if bW>=bQ then return bN-1 else return bN*(1+a.Round(E*(bP-1)/(bQ-bW)*bQ)+bP*bW)-1 end else return bN*(1+bV+bP*a.Round(bQ*(1.0-E*(bP-1)/bV)))-1 end end end,ColorToTable=function(bC)return{[a.TypeParameterName]=a.ColorTypeName,r=bC.r,g=bC.g,b=bC.b,a=bC.a}end,ColorFromTable=function(G)local aO,M=F(G,a.ColorTypeName)return aO and Color.__new(G.r,G.g,G.b,G.a)or nil,M end,Vector2ToTable=function(q)return{[a.TypeParameterName]=a.Vector2TypeName,x=q.x,y=q.y}end,Vector2FromTable=function(G)local aO,M=F(G,a.Vector2TypeName)return aO and Vector2.__new(G.x,G.y)or nil,M end,Vector3ToTable=function(q)return{[a.TypeParameterName]=a.Vector3TypeName,x=q.x,y=q.y,z=q.z}end,Vector3FromTable=function(G)local aO,M=F(G,a.Vector3TypeName)return aO and Vector3.__new(G.x,G.y,G.z)or nil,M end,Vector4ToTable=function(q)return{[a.TypeParameterName]=a.Vector4TypeName,x=q.x,y=q.y,z=q.z,w=q.w}end,Vector4FromTable=function(G)local aO,M=F(G,a.Vector4TypeName)return aO and Vector4.__new(G.x,G.y,G.z,G.w)or nil,M end,QuaternionToTable=function(q)return{[a.TypeParameterName]=a.QuaternionTypeName,x=q.x,y=q.y,z=q.z,w=q.w}end,QuaternionFromTable=function(G)local aO,M=F(G,a.QuaternionTypeName)return aO and Quaternion.__new(G.x,G.y,G.z,G.w)or nil,M end,TableToSerializable=function(a2)return a1(a2)end,TableFromSerializable=function(a4,a9)return a8(a4,a9)end,TableToSerialiable=function(a2)return a1(a2)end,TableFromSerialiable=function(a4,a9)return a8(a4,a9)end,EmitMessage=function(ak,bX)local a4=a.NillableIfHasValueOrElse(bX,function(a2)if type(a2)~='table'then error('EmitMessage: Invalid arguments: table expected',3)end;return a.TableToSerializable(a2)end,function()return{}end)a4[a.InstanceIDParameterName]=a.InstanceID()vci.message.Emit(ak,json.serialize(a4))end,OnMessage=function(ak,ah)local bY=function(bZ,b_,c0)local c1=nil;if bZ.type~='comment'and type(c0)=='string'then local c2,a4=pcall(json.parse,c0)if c2 and type(a4)=='table'then c1=a.TableFromSerializable(a4)end end;local bX=c1 and c1 or{[a.MessageValueParameterName]=c0}ah(bZ,b_,bX)end;vci.message.On(ak,bY)return{Off=function()if bY then bY=nil end end}end,OnInstanceMessage=function(ak,ah)local bY=function(bZ,b_,bX)local c3=a.InstanceID()if c3~=''and c3==bX[a.InstanceIDParameterName]then ah(bZ,b_,bX)end end;return a.OnMessage(ak,bY)end,GetEffekseerEmitterMap=function(ak)local c4=vci.assets.GetEffekseerEmitters(ak)if not c4 then return nil end;local c5={}for n,c6 in pairs(c4)do c5[c6.EffectName]=c6 end;return c5 end,ClientID=function()return j end,CreateLocalSharedProperties=function(c7,c8)local c9=TimeSpan.FromSeconds(5)local ca='33657f0e-7c44-4ee7-acd9-92dd8b8d807a'local cb='__CYTANB_LOCAL_SHARED_PROPERTIES_LISTENER_MAP'if type(c7)~='string'or string.len(c7)<=0 or type(c8)~='string'or string.len(c8)<=0 then error('LocalSharedProperties: Invalid arguments',2)end;local cc=_G[ca]if not cc then cc={}_G[ca]=cc end;cc[c8]=vci.me.UnscaledTime;local cd=_G[c7]if not cd then cd={[cb]={}}_G[c7]=cd end;local ce=cd[cb]return{GetLspID=function()return c7 end,GetLoadID=function()return c8 end,GetProperty=function(z,ag)local q=cd[z]if q==nil then return ag else return q end end,SetProperty=function(z,q)if z==cb then error('LocalSharedProperties: Invalid arguments: key = ',z,2)end;local bA=vci.me.UnscaledTime;local cf=cd[z]cd[z]=q;for cg,c3 in pairs(ce)do local ax=cc[c3]if ax and ax+c9>=bA then cg(z,q,cf)else cg(a.LOCAL_SHARED_PROPERTY_EXPIRED_KEY,true,false)ce[cg]=nil;cc[c3]=nil end end end,AddListener=function(cg)ce[cg]=c8 end,RemoveListener=function(cg)ce[cg]=nil end,UpdateAlive=function()cc[c8]=vci.me.UnscaledTime end}end,
EstimateFixedTimestep=function(ch)local ci=1.0;local cj=1000.0;local ck=TimeSpan.FromSeconds(0.02)local cl=0xFFFF;local cm=a.CreateCircularQueue(64)local cn=TimeSpan.FromSeconds(5)local co=TimeSpan.FromSeconds(30)local cp=false;local cq=vci.me.Time;local cr=a.Random32()local cs=Vector3.__new(bit32.bor(0x400,bit32.band(cr,0x1FFF)),bit32.bor(0x400,bit32.band(bit32.rshift(cr,16),0x1FFF)),0.0)ch.SetPosition(cs)ch.SetRotation(Quaternion.identity)ch.SetVelocity(Vector3.zero)ch.SetAngularVelocity(Vector3.zero)ch.AddForce(Vector3.__new(0.0,0.0,ci*cj))local self={Timestep=function()return ck end,Precision=function()return cl end,IsFinished=function()return cp end,Update=function()if cp then return ck end;local ct=vci.me.Time-cq;local cu=ct.TotalSeconds;if cu<=Vector3.kEpsilon then return ck end;local cv=ch.GetPosition().z-cs.z;local cw=cv/cu;local cx=cw/cj;if cx<=Vector3.kEpsilon then return ck end;cm.Offer(cx)local cy=cm.Size()if cy>=2 and ct>=cn then local cz=0.0;for n=1,cy do cz=cz+cm.Get(n)end;local cA=cz/cy;local cB=0.0;for n=1,cy do cB=cB+(cm.Get(n)-cA)^2 end;local cC=cB/cy;if cC<cl then cl=cC;ck=TimeSpan.FromSeconds(cA)end;if ct>co then cp=true;ch.SetPosition(cs)ch.SetRotation(Quaternion.identity)ch.SetVelocity(Vector3.zero)ch.SetAngularVelocity(Vector3.zero)end else ck=TimeSpan.FromSeconds(cx)end;return ck end}return self end,AlignSubItemOrigin=function(cD,cE,cF)local cG=cD.GetRotation()if not a.QuaternionApproximatelyEquals(cE.GetRotation(),cG)then cE.SetRotation(cG)end;local cH=cD.GetPosition()if not a.VectorApproximatelyEquals(cE.GetPosition(),cH)then cE.SetPosition(cH)end;if cF then cE.SetVelocity(Vector3.zero)cE.SetAngularVelocity(Vector3.zero)end end,CreateSubItemGlue=function()local cI={}local self;self={Contains=function(cJ,cK)return a.NillableIfHasValueOrElse(cI[cJ],function(an)return a.NillableHasValue(an[cK])end,function()return false end)end,Add=function(cJ,cL,cF)if not cJ or not cL then local cM='CreateSubItemGlue.Add: Invalid arguments '..(not cJ and', parent = '..tostring(cJ)or'')..(not cL and', children = '..tostring(cL)or'')error(cM,2)end;local an=a.NillableIfHasValueOrElse(cI[cJ],function(cN)return cN end,function()local cN={}cI[cJ]=cN;return cN end)if type(cL)=='table'then for z,aA in pairs(cL)do an[aA]={velocityReset=not not cF}end else an[cL]={velocityReset=not not cF}end end,Remove=function(cJ,cK)return a.NillableIfHasValueOrElse(cI[cJ],function(an)if a.NillableHasValue(an[cK])then an[cK]=nil;return true else return false end end,function()return false end)end,RemoveParent=function(cJ)if a.NillableHasValue(cI[cJ])then cI[cJ]=nil;return true else return false end end,RemoveAll=function()cI={}return true end,Each=function(ah,cO)return a.NillableIfHasValueOrElse(cO,function(cJ)return a.NillableIfHasValue(cI[cJ],function(an)for cK,cP in pairs(an)do if ah(cK,cJ,self)==false then return false end end end)end,function()for cJ,an in pairs(cI)do if self.Each(ah,cJ)==false then return false end end end)end,Update=function(cQ)for cJ,an in pairs(cI)do local cR=cJ.GetPosition()local cS=cJ.GetRotation()for cK,cP in pairs(an)do if cQ or cK.IsMine then if not a.QuaternionApproximatelyEquals(cK.GetRotation(),cS)then cK.SetRotation(cS)end;if not a.VectorApproximatelyEquals(cK.GetPosition(),cR)then cK.SetPosition(cR)end;if cP.velocityReset then cK.SetVelocity(Vector3.zero)cK.SetAngularVelocity(Vector3.zero)end end end end end}return self end,CreateSubItemConnector=function()local cT=function(cU,cE,cV)cU.item=cE;cU.position=cE.GetPosition()cU.rotation=cE.GetRotation()cU.initialPosition=cU.position;cU.initialRotation=cU.rotation;cU.propagation=not not cV;return cU end;local cW=function(cX)for cE,cU in pairs(cX)do cT(cU,cE,cU.propagation)end end;local cY=function(cZ,b8,cU,c_,d0)local d1=cZ-cU.initialPosition;local d2=b8*Quaternion.Inverse(cU.initialRotation)cU.position=cZ;cU.rotation=b8;for cE,d3 in pairs(c_)do if cE~=cU.item and(not d0 or d0(d3))then d3.position,d3.rotation=a.RotateAround(d3.initialPosition+d1,d3.initialRotation,cZ,d2)cE.SetPosition(d3.position)cE.SetRotation(d3.rotation)end end end;local d4={}local d5=true;local d6=false;local self;self={IsEnabled=function()return d5 end,SetEnabled=function(aC)d5=aC;if aC then cW(d4)d6=false end end,Contains=function(d7)return a.NillableHasValue(d4[d7])end,Add=function(d8,d9)if not d8 then error('CreateSubItemConnector.Add: Invalid arguments: subItems = '..tostring(d8),2)end;local da=type(d8)=='table'and d8 or{d8}cW(d4)d6=false;for N,cE in pairs(da)do d4[cE]=cT({},cE,not d9)end end,Remove=function(d7)local aO=a.NillableHasValue(d4[d7])d4[d7]=nil;return aO end,RemoveAll=function()d4={}return true end,Each=function(ah)for cE,cU in pairs(d4)do if ah(cE,self)==false then return false end end end,GetItems=function()local da={}for cE,cU in pairs(d4)do table.insert(da,cE)end;return da end,Update=function()if not d5 then return end;local db=false;for cE,cU in pairs(d4)do local dc=cE.GetPosition()local dd=cE.GetRotation()if not a.VectorApproximatelyEquals(dc,cU.position)or not a.QuaternionApproximatelyEquals(dd,cU.rotation)then if cU.propagation then if cE.IsMine then cY(dc,dd,d4[cE],d4,function(d3)if d3.item.IsMine then return true else d6=true;return false end end)db=true;break else d6=true end else d6=true end end end;if not db and d6 then cW(d4)d6=false end end}return self end,GetSubItemTransform=function(d7)local cZ=d7.GetPosition()local b8=d7.GetRotation()local de=d7.GetLocalScale()return{positionX=cZ.x,positionY=cZ.y,positionZ=cZ.z,rotationX=b8.x,rotationY=b8.y,rotationZ=b8.z,rotationW=b8.w,scaleX=de.x,scaleY=de.y,scaleZ=de.z}end,RestoreCytanbTransform=function(df)local dc=df.positionX and df.positionY and df.positionZ and Vector3.__new(df.positionX,df.positionY,df.positionZ)or nil;local dd=df.rotationX and df.rotationY and df.rotationZ and df.rotationW and Quaternion.__new(df.rotationX,df.rotationY,df.rotationZ,df.rotationW)or nil;local de=df.scaleX and df.scaleY and df.scaleZ and Vector3.__new(df.scaleX,df.scaleY,df.scaleZ)or nil;return dc,dd,de end}a.SetConstEach(a,{LogLevelOff=0,LogLevelFatal=100,LogLevelError=200,LogLevelWarn=300,LogLevelInfo=400,LogLevelDebug=500,LogLevelTrace=600,LogLevelAll=0x7FFFFFFF,ColorHueSamples=10,ColorSaturationSamples=4,ColorBrightnessSamples=5,EscapeSequenceTag='#__CYTANB',SolidusTag='#__CYTANB_SOLIDUS',NegativeNumberTag='#__CYTANB_NEGATIVE_NUMBER',ArrayNumberTag='#__CYTANB_ARRAY_NUMBER',InstanceIDParameterName='__CYTANB_INSTANCE_ID',MessageValueParameterName='__CYTANB_MESSAGE_VALUE',TypeParameterName='__CYTANB_TYPE',ColorTypeName='Color',Vector2TypeName='Vector2',Vector3TypeName='Vector3',Vector4TypeName='Vector4',QuaternionTypeName='Quaternion',LOCAL_SHARED_PROPERTY_EXPIRED_KEY='__CYTANB_LOCAL_SHARED_PROPERTY_EXPIRED'})a.SetConstEach(a,{ColorMapSize=a.ColorHueSamples*a.ColorSaturationSamples*a.ColorBrightnessSamples,FatalLogLevel=a.LogLevelFatal,ErrorLogLevel=a.LogLevelError,WarnLogLevel=a.LogLevelWarn,InfoLogLevel=a.LogLevelInfo,DebugLogLevel=a.LogLevelDebug,TraceLogLevel=a.LogLevelTrace})c={[a.ColorTypeName]={compositionFieldNames=a.ListToMap({'r','g','b','a'}),compositionFieldLength=4,toTableFunc=a.ColorToTable,fromTableFunc=a.ColorFromTable},[a.Vector2TypeName]={compositionFieldNames=a.ListToMap({'x','y'}),compositionFieldLength=2,toTableFunc=a.Vector2ToTable,fromTableFunc=a.Vector2FromTable},[a.Vector3TypeName]={compositionFieldNames=a.ListToMap({'x','y','z'}),compositionFieldLength=3,toTableFunc=a.Vector3ToTable,fromTableFunc=a.Vector3FromTable},[a.Vector4TypeName]={compositionFieldNames=a.ListToMap({'x','y','z','w'}),compositionFieldLength=4,toTableFunc=a.Vector4ToTable,fromTableFunc=a.Vector4FromTable},[a.QuaternionTypeName]={compositionFieldNames=a.ListToMap({'x','y','z','w'}),compositionFieldLength=4,toTableFunc=a.QuaternionToTable,fromTableFunc=a.QuaternionFromTable}}d={{tag=a.NegativeNumberTag,pattern='^'..a.NegativeNumberTag,replacement=''},{tag=a.ArrayNumberTag,pattern='^'..a.ArrayNumberTag,replacement=''},{tag=a.SolidusTag,pattern='^'..a.SolidusTag,replacement='/'},{tag=a.EscapeSequenceTag,pattern='^'..a.EscapeSequenceTag..a.EscapeSequenceTag,replacement=a.EscapeSequenceTag}}e=a.ListToMap({a.NegativeNumberTag,a.ArrayNumberTag})f=a.LogLevelInfo;h={[a.LogLevelFatal]='FATAL',[a.LogLevelError]='ERROR',[a.LogLevelWarn]='WARN',[a.LogLevelInfo]='INFO',[a.LogLevelDebug]='DEBUG',[a.LogLevelTrace]='TRACE'}package.loaded['cytanb']=a;i,j=(function()local c7='eff3a188-bfc7-4b0e-93cb-90fd1adc508c'local cd=_G[c7]if not cd then cd={}_G[c7]=cd end;local dg=cd.randomSeedValue;if not dg then dg=os.time()-os.clock()*10000;cd.randomSeedValue=dg;math.randomseed(dg)end;local dh=cd.clientID;if type(dh)~='string'then dh=tostring(a.RandomUUID())cd.clientID=dh end;local di=vci.state.Get(b)or''if di==''and vci.assets.IsMine then di=tostring(a.RandomUUID())vci.state.Set(b,di)end;return di,dh end)()return a end)()


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
                    str=""..str.." "..ts
                    comm.date=msg[i].date
                else
                    comm.date=0
                end
                if msg[i].user ~= nil then
                    str=""..str.." "..msg[i].user
                end
                if msg[i].msg ~= nil then
                    str=""..str.." "..msg[i].msg
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
                    str=""..str.." "..msg[i].msg
                else
                    str=msg[i]
                end
                comm.str = str
                if comm.date ~= 0 then
                    table.insert(lopeComment,comm)
                end
            end
        end
        if name == "ncvCommMsg" then
            local msg = message
            for i=1, #msg do
                local comm = {}
                local str=""
                if msg[i].live ~= nil then
                    str=""..str..msg[i].live
                end
                if msg[i].date ~= nil then
                    local ts=os.date("%T", msg[i].date)
                    str=""..str.." "..ts
                    comm.date=msg[i].date
                else
                    comm.date=0
                end
                if msg[i].user ~= nil then
                    str=""..str.." "..msg[i].user
                end
                if msg[i].msg ~= nil then
                    str=""..str.." "..msg[i].msg
                else
                    str=msg[i]
                end
                comm.str = str
                if comm.date ~= 0 then
                    table.insert(lComment,comm)
                end
            end
        end
        if name == "ncvOpeCommMsg" then
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
                    str=""..str.." "..msg[i].msg
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
                    str=""..str.." "..ts
                    comm.date=msg[i].date
                else
                    comm.date=0
                end
                if msg[i].user ~= nil then
                    str=""..str.." "..msg[i].user
                end
                if msg[i].msg ~= nil then
                    str=""..str.." "..msg[i].msg
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
                    str=""..str.." "..msg[i].msg
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
                    str=""..str.." "..ts
                    comm.date=msg[i].date
                else
                    comm.date=0
                end
                if msg[i].user ~= nil then
                    str=""..str.." "..msg[i].user
                end
                if msg[i].msg ~= nil then
                    str=""..str.." "..msg[i].msg
                else
                    str=msg[i]
                end
                comm.str = str
                if comm.date ~= 0 then
                    table.insert(lComment,comm)
                end
            end
        end
        if name == "ankoCommMsg" or name == "shocoroCommMsg" or name == "ncvCommMsg" or name == "mcvCommMsg" then
            while #commentList > 0 do
                local comm = table.remove(commentList)
                if comm.date ~= nil then
                    local flag = false
                    for i=1, #lComment do
                        if lComment[i].str == comm.str then
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
        if name == "ankoOpeCommMsg" or name == "shocoroOpeCommMsg" or name == "ncvOpeCommMsg" then
            while #opeCommentList > 0 do
                local comm = table.remove(opeCommentList)
                if comm.date ~= nil then
                    local flag = false
                    for i=1, #lopeComment do
                        if lopeComment[i].str == comm.str then
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
    cytanb.OnMessage("ncvCommMsg", chinng_gift_onMessage)
    cytanb.OnMessage("ncvOpeCommMsg", chinng_gift_onMessage)
    cytanb.OnMessage("shocoroCommMsg", chinng_gift_onMessage)
    cytanb.OnMessage("shocoroOpeCommMsg", chinng_gift_onMessage)
    cytanb.OnMessage("mcvCommMsg", chinng_gift_onMessage)
end
