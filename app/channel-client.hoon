::  /app/channel-client - a distributed chan client
/-  *channel
/+  default-agent, dbug, *mip
::
|%
+$  versioned-state
  $%  state-0
  ==
::
+$  state-0
  [%0 =chans]
::
+$  card  card:agent:gall
--
::
%-  agent:dbug
::
=|  state-0
=*  state  -
::
^-  agent:gall
=<
  |_  =bowl:gall
  +*  this  .
      snax  ~(. +> bowl)
      def   ~(. (default-agent this %|) bowl)
  ++  on-init
    ^-  (quip card _this)
    %-  (slog leaf+"%chan-client -online" ~)
    `this
  ::
  ++  on-save
    ^-  vase
    !>(state)
  ::
  ++  on-load
    |=  ole=vase
    ^-  (quip card _this)
    =/  old=versioned-state  !<(versioned-state ole)
    |-
    ?-  -.old
        %0  `this(state old)
    ==
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?+    mark  (on-poke:def mark vase)
        %channel-stacy
      =/  sac=stacy  !<(stacy vase)
      =^  cards  state
        ?-  -.sac
          %see-hoast  (see-hoast:chemo:snax ship.sac)
          %bye-hoast  (bye-hoast:chemo:snax ship.sac)
          %ack-notes  (ack-notes:chemo:snax note.sac ship.sac board.sac)
        ::
            %add-poast
          %:  add-poast:chemo:snax 
            maybe-index.sac
            image.sac
            message.sac
            ship.sac
            board.sac
          ==
        ==
      [cards this]
    ==
  ::
  ++  on-peek
    |=  pek=path
    ^-  (unit (unit cage))
    =,  enjs:format
    ?+    pek  (on-peek:def pek)
        [%x %providers %json ~]
      =-  ``json+!>(`json`-)
      %+  frond  %providers
      a+(turn ~(tap in ~(key by chans)) |=(@p s+(scot %p +<)))
    ::
        [%x %boards @ %json ~]
      ?~  ls=(~(get by chans) `@p`(slav %p +>-.pek))
        ``json+!>(`json`(frond error+s+'no-boards'))
      =-  ``json+!>(`json`-)
      %+  frond  'boards'
      :-  %a  %+  turn  ~(tap in u.ls)
      |=([b=@tas [a=? n=*]] (pairs ~[board+s+b admin+b+a]))
    ::
        [%x %notices @ @ %json ~]
      ?~  ls=(~(get by chans) (slav %p +>-.pek))
        ``json+!>(`json`(frond error+s+'host-not-found'))
      ?~  cd=(~(get by u.ls) (slav %tas +>+<.pek))
        ``json+!>(`json`(frond error+s+'board-not-found'))
      =-  ``json+!>(`json`-)
      %+  frond  'board-notices'
      :-  %a  %+  turn  ~(tap in notes.u.cd)
      |=  [i=@da n=@t a=@p]
      (frond ;;(@t +:(sect i)) (pairs ~[note+s+n admin+s+(scot %p a)]))
    ::
        [%x %check-admin @ @ %json ~]
      ?~  ls=(~(get by chans) (slav %p +>-.pek))
        ``json+!>(`json`(frond error+s+'host-not-found'))
      ?~  cd=(~(get by u.ls) (slav %tas +>+<.pek))
        ``json+!>(`json`(frond error+s+'board-not-found'))
      ``json+!>(`json`(frond 'am-admin' b+admin.u.cd))
    ==
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ?+    path  (on-watch:def path)
        [%website ~]
      :_  this
      =-  [%give %fact ~ json+!>(`json`-)]~
      %+  frond:enjs:format  'providers'
      a+(turn ~(tap in ~(key by chans)) |=(@p s+(scot %p +<)))
    ==
  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    ?+    wire  (on-agent:def wire sign)
        [%chan %server @ ~]
      ?>  =(src.bowl (slav %p +>-.wire))
      ?-    -.sign
        %poke-ack  `this
      ::
          %watch-ack
        ?~  =(~ p.sign)  `this
        `this(chans (~(del by chans) src.bowl))
      ::
          %kick
        :_  this
        :~  :^  %pass  wire  %agent
            [[src.bowl %channel-server] %watch wire]
        ==
      ::
          %fact
        =/  mog=moggs  !<(moggs q.cage.sign)
        ?-    -.mog
            %hav-boards
          =+  b=~(tap in boards.mog)
          =|  cards=(list card)
          |-
          ?~  b  [cards this]
          %=    $
            b      t.b
            chans  (~(put bi chans) src.bowl i.b [%.n ~])
          ::
              cards
            :_  cards
            :^  %pass  /chan/watch/(scot %tas i.b)  %agent
            :^  [our.bowl %group-view]  %poke  %group-view-action
            !>  ^-  gro-vew
            :+  %join  [src.bowl i.b]
            [src.bowl %groups %.n %.y]
          ==
        ::
            %del-boards
          `this(chans (~(del bi chans) src.bowl boards.mog))
        ::
            %big-notice
          ?~  bn=(~(get bi chans) src.bowl board.mog)  `this
          =.  chans
            %^  ~(put bi chans)  src.bowl  board.mog  
            [admin.u.bn (~(put by notes.u.bn) id.mog [notice.mog admin.mog])]
          =,  enjs:format
          :_  this
          :~  :^  %give  %fact  ~[/website]
              :-  %json  !>  ^-  json
              =-  %-  pairs
                  :~  news+(pairs -)
                      status-msg+s+'Notice for {<board.mog>} on {<src.bowl>}'
                  ==
              :~  host+s+(scot %p src.bowl)
                  board+s+board.mog
                  admin+b+admin.u.bn
                ::
                  :-  %notes
                  %-  pairs
                  %+  turn  ~(tap by notes.u.bn)
                  |=  [i=@da n=@t a=@p]
                  [;;(@t +:(sect i)) (pairs ~[note+s+n admin+s+(scot %p a)])]
              ==
          ==
        ::
            %new-admins
          =,  enjs:format
          ?.  (~(has in who.mog) our.bowl)  `this
          ?~  cd=(~(get bi chans) src.bowl board.mog)  `this
          =.  chans
            (~(put bi chans) src.bowl board.mog [%.y notes.u.cd])
          :_  this
          :~  :^  %give  %fact  ~[/website]
              =-  json+!>(`json`-)
              (frond status-msg+s+(crip "You're an admin on {<board.mog>}"))
          ==
        ::
            %not-admins
          =,  enjs:format
          ?.  (~(has in who.mog) our.bowl)  `this
          ?~  cd=(~(get bi chans) src.bowl board.mog)  `this
          =.  chans
            (~(put bi chans) src.bowl board.mog [%.n notes.u.cd])
          :_  this
          :~  :^  %give  %fact  ~[/website]
              =-  json+!>(`json`-)
              (frond status-msg+s+(crip "You're not an admin on {<board.mog>}"))
          ==
        ==
      ==
    ==
  ::
  ++  on-arvo   on-arvo:def
  ++  on-fail   on-fail:def
  ++  on-leave  on-leave:def
  --
|_  bol=bowl:gall
++  chemo
  |%
  ++  see-hoast
    |=  p=@p
    =,  enjs:format
    :_  state
    :~  :^  %pass  /chan/server/(scot %p p)  %agent
        [[p %channel-server] %watch /chan/server/(scot %p p)]
        :^  %give  %fact  ~[/website]
        json+!>((frond 'status-msg' s+(crip "Joining {<p>}...")))
    ==
  ++  bye-hoast
    |=  p=@p
    ^-  (quip card _state)
    =,  enjs:format
    :_  state(chans (~(del by chans) p))
    :~  [%pass /chan/server/(scot %p p) %agent [p %channel-server] %leave ~]
        :^  %give  %fact  ~[/website]
        =-  json+!>(`json`-)
        %-  pairs
        :~  :-  'providers'
            a+(turn ~(tap in ~(key by chans)) |=(@p s+(scot %p +<)))
          ::
            status-msg+s+(crip "Left {<p>}")
        ==
    ==
  ++  ack-notes
    |=  [n=(set @da) p=@p b=@tas]
    ^-  (quip card _state)
    =,  enjs:format
    ~|  '%chan-client-fail -unknown-board'
    ?~  set=(~(get bi chans) p b)  !!
    =+  nl=~(tap in n)
    |-
    ?~  nl
      :_  state(chans (~(put bi chans) p b u.set))
      :~  :^  %give  %fact  ~[/website]
          :-  %json  !>  ^-  json
          =-  (pairs ~[notes+(pairs -) status-msg+s+'Ack {<n>}'])
          :~  host+s+(scot %p p)
              board+s+b
              admin+b+admin.u.set
            ::
              :-  %notes
              %-  pairs
              %+  turn  ~(tap by notes.u.set)
              |=  [i=@da n=@t a=@p]
              [;;(@t +:(sect i)) (pairs ~[note+s+n admin+s+(scot %p a)])]
          ==
      ==
    %=    $
      nl     t.nl
      u.set  u.set(notes (~(del by notes.u.set) i.nl))
    ==
  ++  add-poast
    |=  [aye=(unit index) i=(unit @t) m=(list content) p=@p b=@tas]
    ^-  (quip card _state)
    =,  enjs:format
    ?~  i
      :_  state
      :~  :^  %pass  /chan/op/(scot %da now.bol)  %agent
          :^  [p %channel-server]  %poke  %channel-based
          !>(`based`[%add-poast aye m b])
        ::
          :^  %give  %fact  ~[/website]
          json+!>((frond 'status-msg' s+'Poast Sent...'))
      ==
    :_  state
    :~  :^  %pass  /chan/lol/(scot %da now.bol)  %agent
        :^  [p %channel-server]  %poke  %channel-based
        !>(`based`[%add-poast aye `(list content)`[url+u.i m] b])
      ::
        :^  %give  %fact  ~[/website]
        json+!>((frond 'status-msg' s+'Poast Sent...'))
    ==
  --
--