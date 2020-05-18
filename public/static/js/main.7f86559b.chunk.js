(this["webpackJsonpmusic-client"]=this["webpackJsonpmusic-client"]||[]).push([[0],{121:function(e,t,a){e.exports=a(135)},135:function(e,t,a){"use strict";a.r(t);var n,r,c,i,l=a(0),o=a.n(l),s=a(14),u=a.n(s),m=a(114),p=a(185),d=a(195),f=a(26),E=a(42),b=a(13),h=a(45),v=a(46),y=a.n(v),g=a(28);function k(){var e=Object(h.a)(["\n    mutation Signin($input: SigninInput!) {\n  signin(input: $input) {\n    error\n  }\n}\n    "]);return k=function(){return e},e}function w(){var e=Object(h.a)(["\n    mutation UpdateMe($input: UpdateMeInput!) {\n  updateMe(input: $input) {\n    currentUser {\n      id\n      username\n      name\n    }\n    error\n  }\n}\n    "]);return w=function(){return e},e}function j(){var e=Object(h.a)(["\n    query Me {\n  me {\n    id\n    name\n    username\n    role {\n      id\n      name\n      description\n      allowedActions\n    }\n  }\n}\n    "]);return j=function(){return e},e}function O(){var e=Object(h.a)(["\n    query Artists($cursor: CursorInputObject, $sort: ArtistsSortInputObject, $conditions: ArtistsConditionsInputObject) {\n  items: artists(cursor: $cursor, sort: $sort, conditions: $conditions) {\n    id\n    name\n    status\n    artworkM {\n      url\n      width\n      height\n    }\n  }\n}\n    "]);return O=function(){return e},e}function S(){var e=Object(h.a)(["\n    query Artist($id: TTID!) {\n  artist(id: $id) {\n    id\n    name\n    artworkL {\n      url\n      width\n      height\n    }\n  }\n}\n    "]);return S=function(){return e},e}function x(){var e=Object(h.a)(["\n    query Albums($cursor: CursorInputObject, $sort: AlbumsSortInputObject, $conditions: AlbumsConditionsInputObject) {\n  items: albums(cursor: $cursor, sort: $sort, conditions: $conditions) {\n    id\n    name\n    status\n    artworkM {\n      url\n      width\n      height\n    }\n    appleMusicAlbum {\n      id\n    }\n    itunesAlbum {\n      id\n    }\n    spotifyAlbum {\n      id\n    }\n  }\n}\n    "]);return x=function(){return e},e}function P(){var e=Object(h.a)(["\n    query Album($id: TTID!) {\n  album(id: $id) {\n    id\n    totalTracks\n    name\n    releaseDate\n    artworkL {\n      url\n      width\n      height\n    }\n    artworkM {\n      url\n      width\n      height\n    }\n    appleMusicAlbum {\n      id\n      appleMusicId\n    }\n    itunesAlbum {\n      id\n      appleMusicId\n    }\n    spotifyAlbum {\n      id\n      spotifyId\n    }\n    tracks {\n      id\n      isrc\n      name\n      discNumber\n      trackNumber\n      durationMs\n      previewUrl\n      popularity\n      artworkM {\n        url\n        width\n        height\n      }\n    }\n  }\n}\n    "]);return P=function(){return e},e}!function(e){e.New="NEW",e.Release="RELEASE",e.Popularity="POPULARITY"}(n||(n={})),function(e){e.Name="NAME",e.New="NEW",e.Popularity="POPULARITY"}(r||(r={})),function(e){e.Asc="ASC",e.Desc="DESC"}(c||(c={})),function(e){e.Pending="PENDING",e.Active="ACTIVE",e.Ignore="IGNORE"}(i||(i={}));var A=y()(P());var I=y()(x());var N=y()(S());var C=y()(O());var U=y()(j());var F=y()(w());var L=y()(k());var M=a(10),D=a(174),T=a(169),R=function(e){var t=e.className,a=void 0===t?"":t,n=e.src,r=void 0===n?"":n,c=e.title,i=void 0===c?"":c,l=e.width;return""===r&&(r="".concat("","/no_image.png")),o.a.createElement(T.a,{className:a,image:r,title:i,style:{width:l,height:l}})},$=a(173),W=a(175),Y=a(176),_=a(177),z=function(e){var t=e.linkUrl?{component:f.b,to:e.linkUrl}:{};return Object(l.createElement)($.a,Object(M.a)({item:!0,style:{textDecoration:"none"}},t,{children:o.a.createElement(D.a,{style:{width:e.width,position:"relative"}},o.a.createElement(W.a,null,o.a.createElement($.a,{container:!0,style:{position:"absolute",left:"5px",bottom:"5px"}},e.componentInImage?e.componentInImage:o.a.createElement(o.a.Fragment,null)),o.a.createElement(R,{src:e.src||"",width:e.width,title:e.title})),""===e.title?o.a.createElement(o.a.Fragment,null):o.a.createElement(Y.a,{style:{padding:"5px 5px"}},o.a.createElement(_.a,{style:{overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"},variant:"caption",color:"textSecondary",component:"p"},e.title)))}))},G=a(22),q=a.n(G),H={album:"b",artist:"a"},B="i",J="s",Q="o",X="r";function V(e){var t=Object(E.g)(),a=new URLSearchParams(t.search),n=H[e],r=function(e){var t=a.get(e);if(null===t)return[];var n=t.split("-"),r=new Set;return n.forEach((function(e){r.add(e)})),Array.from(r)},c=function(e,t){if(q.a.isArray(e))return e.concat(t)},i={};r(n+B).forEach((function(e){switch(!0){case/^art/.test(e):i=q.a.merge(i,{conditions:{artists:{id:[e]}}});break;case/^abm/.test(e):i=q.a.merge(i,{conditions:{albums:{id:[e]}}});break;case/^trk/.test(e):i=q.a.merge(i,{conditions:{tracks:{id:[e]}}})}}));var l={status:[]};return r(n+J).forEach((function(e){l=q.a.mergeWith(l,{status:[e]},c)})),0!==l.status.length&&(i=q.a.mergeWith(i,{conditions:Object(M.a)({},l)})),r(n+Q).forEach((function(e){i=q.a.merge(i,{sort:{order:e}})})),r(n+X).forEach((function(e){i=q.a.merge(i,{sort:{type:e}})})),i}var K,Z,ee=function(e){var t=e.album,a=e.width,n=Object(E.f)(),r=new URLSearchParams(n.location.search);r.set(H.artist+B,t.id);var c=r.get(H.album+J);null!==c&&r.set(H.album+J,c);var l={width:"15px",height:"15px",borderRadius:"50%",fontSize:"10px",color:"#fff",lineHeight:"15px",textAlign:"center",background:"#000"},s=[];t.appleMusicAlbum&&s.push(o.a.createElement($.a,{key:1,item:!0,style:Object(M.a)({},l,{backgroundColor:"#ff2f56"})},"A")),t.itunesAlbum&&s.push(o.a.createElement($.a,{key:2,item:!0,style:Object(M.a)({},l,{backgroundColor:"#0070c9"})},"iT")),t.spotifyAlbum&&s.push(o.a.createElement($.a,{key:3,item:!0,style:Object(M.a)({},l,{backgroundColor:"#1DB954"})},"S")),t.status===i.Pending?s.push(o.a.createElement($.a,{key:10,item:!0,style:Object(M.a)({},l,{color:"#000",backgroundColor:"#FFFF00"})},"PN")):t.status===i.Ignore&&s.push(o.a.createElement($.a,{key:11,item:!0,style:Object(M.a)({},l,{color:"#000",backgroundColor:"#FF0000"})},"IG"));var u=o.a.createElement(o.a.Fragment,null,s);return o.a.createElement(z,{title:t.name,src:t.artworkM.url,width:a,linkUrl:"/albums/".concat(t.id,"?").concat(r.toString()),componentInImage:u})},te=a(178),ae=a(198),ne=a(196),re=a(199),ce=a(88),ie=a(104),le=function(e){var t=e.component,a=e.no,n=e.offset,r=e.limit,c=e.fetchMore,i=Object(l.useState)(t),s=Object(b.a)(i,2),u=s[0],m=s[1],p=Object(l.useState)(!1),d=Object(b.a)(p,2),f=d[0],E=d[1],h=a===n-r;return o.a.createElement(o.a.Fragment,null,t,h?o.a.createElement(ie.a,{onEnter:function(){if(!f||u!==t)return E(!0),m(t),c({variables:{cursor:{offset:n}},updateQuery:function(e,t){var a=t.fetchMoreResult;return a?Object(M.a)({},e,{},{items:[].concat(Object(ce.a)(e.items),Object(ce.a)(a.items))}):e}})}}):o.a.createElement(o.a.Fragment,null))},oe=function(){var e,t,a,n=Object(l.useState)("RELEASE.DESC"),r=Object(b.a)(n,2),c=r[0],i=r[1],s=V("album"),u=Object(E.f)(),m=(a={variables:{cursor:{offset:0,limit:50},sort:s.sort,conditions:s.conditions},fetchPolicy:"cache-first"},g.c(I,a)),p=m.error,d=m.data,f=m.fetchMore,h=(null===s||void 0===s?void 0:s.sort)?"".concat(null===s||void 0===s||null===(e=s.sort)||void 0===e?void 0:e.order,".").concat(null===s||void 0===s||null===(t=s.sort)||void 0===t?void 0:t.type):null;if(h&&c!==h&&i(h),p)return o.a.createElement("div",null,p.message);var v=[];d&&(v=d.items.map((function(e,t){return o.a.createElement($.a,{item:!0,key:t},o.a.createElement(le,{component:o.a.createElement(ee,{album:e,width:"150px"}),no:t,offset:d.items.length,limit:50,fetchMore:f}))})));return o.a.createElement($.a,{container:!0,spacing:2,direction:"column",justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0},o.a.createElement($.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"flex-start"},o.a.createElement($.a,{item:!0},o.a.createElement(te.a,{variant:"outlined",style:{minWidth:150}},o.a.createElement(ae.a,{id:"demo-simple-select-outlined-label"},"\u30a2\u30eb\u30d0\u30e0\u8868\u793a\u9806"),o.a.createElement(ne.a,{labelId:"demo-simple-select-outlined-label",id:"demo-simple-select-outlined",value:c,onChange:function(e,t){var a=e.target.value,n=a.split("."),r=Object(b.a)(n,2),c=r[0],l=r[1];i(a);var o=new URLSearchParams(u.location.search);o.set(H.album+Q,c),o.set(H.album+X,l),u.push("".concat(u.location.pathname,"?").concat(o.toString()))},label:"\u30a2\u30eb\u30d0\u30e0\u8868\u793a\u9806"},o.a.createElement(re.a,{value:"RELEASE.DESC"},"\u767a\u58f2\u65e5\u65b0\u3057\u3044\u9806"),o.a.createElement(re.a,{value:"RELEASE.ASC"},"\u767a\u58f2\u65e5\u53e4\u3044\u9806"),o.a.createElement(re.a,{value:"NEW.DESC"},"\u8ffd\u52a0\u65e5\u65b0\u3057\u3044\u9806"),o.a.createElement(re.a,{value:"NEW.ASC"},"\u8ffd\u52a0\u65e5\u53e4\u3044\u9806"),o.a.createElement(re.a,{value:"POPULARITY.DESC"},"\u4eba\u6c17\u9806")))))),o.a.createElement($.a,{item:!0},o.a.createElement($.a,{container:!0,direction:"row",justify:"space-evenly",alignItems:"center",spacing:1},v)))},se=a(180),ue=a(181),me=a(182),pe=a(183),de=a(184),fe=a(106),Ee=a.n(fe),be=a(76),he=a.n(be),ve=function(e){var t=e.children,a=e.window,n=Object(se.a)({target:a?a():void 0});return o.a.createElement(ue.a,{appear:!1,direction:"down",in:!n},t)},ye=function(){return o.a.createElement(o.a.Fragment,null,o.a.createElement(ve,null,o.a.createElement(me.a,null,o.a.createElement(pe.a,null,o.a.createElement($.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"center",spacing:3},o.a.createElement($.a,{item:!0},o.a.createElement(_.a,{variant:"h6"},"\u30b2\u30fc\u30e0\u97f3\u697d")),o.a.createElement($.a,{item:!0},o.a.createElement(de.a,{component:f.b,to:"/artists",edge:"start",size:"small",color:"inherit","aria-label":"menu"},o.a.createElement(Ee.a,null))),o.a.createElement($.a,{item:!0},o.a.createElement(de.a,{component:f.b,to:"/albums",edge:"start",size:"small",color:"inherit","aria-label":"menu"},o.a.createElement(he.a,null))))))))},ge=a(24),ke=a(43),we=a(25),je=a(116),Oe=a(115),Se=a(107),xe=new je.a({uri:"https://video-game-music.net/graphql",credentials:"include"}),Pe=new we.a((function(e,t){return t(e)})),Ae=Object(Se.a)((function(e){var t=e.graphQLErrors,a=e.networkError;t&&t.map((function(e){var t=e.message,a=e.locations,n=e.path;return console.log("[GraphQL error]: Message: ".concat(t,", Location: ").concat(a,", Path: ").concat(n))})),a&&console.log("[Network error]: ".concat(a))})),Ie=we.a.from([Pe,Ae,xe]),Ne=new ke.a({link:Ie,cache:new Oe.a({dataIdFromObject:function(e){return e.id}})}),Ce=function(e){var t=e.artist,a=e.width,n=Object(E.f)(),r=new URLSearchParams(n.location.search);r.set(H.album+B,t.id);var c=r.get(H.artist+J);null!==c&&r.set(H.album+J,c);var l={width:"15px",height:"15px",borderRadius:"50%",fontSize:"10px",color:"#fff",lineHeight:"15px",textAlign:"center",background:"#000"},s=[];t.status===i.Pending?s.push(o.a.createElement($.a,{key:10,item:!0,style:Object(M.a)({},l,{color:"#000",backgroundColor:"#FFFF00"})},"PN")):t.status===i.Ignore&&s.push(o.a.createElement($.a,{key:11,item:!0,style:Object(M.a)({},l,{color:"#000",backgroundColor:"#FF0000"})},"IG"));var u=o.a.createElement(o.a.Fragment,null,s);return o.a.createElement(z,{title:t.name,src:t.artworkM.url,width:a,linkUrl:"/artists/".concat(t.id,"?").concat(r.toString()),componentInImage:u})},Ue=function(){var e,t,a,n=Object(l.useState)("NAME.DESC"),r=Object(b.a)(n,2),c=r[0],i=r[1],s=V("artist"),u=Object(E.f)(),m=(a={variables:{cursor:{offset:0,limit:30},sort:s.sort,conditions:s.conditions},fetchPolicy:"cache-first"},g.c(C,a)),p=m.error,d=m.data,f=m.fetchMore,h=(null===s||void 0===s?void 0:s.sort)?"".concat(null===s||void 0===s||null===(e=s.sort)||void 0===e?void 0:e.order,".").concat(null===s||void 0===s||null===(t=s.sort)||void 0===t?void 0:t.type):null;if(h&&c!==h&&i(h),p)return o.a.createElement("div",null,p.message);var v=[];d&&(v=d.items.map((function(e,t){return o.a.createElement($.a,{item:!0,key:t},o.a.createElement(le,{component:o.a.createElement(Ce,{artist:e,width:"150px"}),no:t,offset:d.items.length,limit:30,fetchMore:f}))})));return o.a.createElement($.a,{container:!0,spacing:2,direction:"column",justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0},o.a.createElement($.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"flex-start"},o.a.createElement($.a,null,o.a.createElement(te.a,{variant:"outlined",style:{minWidth:150}},o.a.createElement(ae.a,{id:"demo-simple-select-outlined-label"},"\u30a2\u30fc\u30c6\u30a3\u30b9\u30c8\u8868\u793a\u9806"),o.a.createElement(ne.a,{labelId:"demo-simple-select-outlined-label",id:"demo-simple-select-outlined",value:c,onChange:function(e,t){var a=e.target.value,n=a.split("."),r=Object(b.a)(n,2),c=r[0],l=r[1];i(a);var o=new URLSearchParams(u.location.search);o.set(H.artist+Q,c),o.set(H.artist+X,l),u.push("".concat(u.location.pathname,"?").concat(o.toString()))},label:"\u30a2\u30fc\u30c6\u30a3\u30b9\u30c8\u8868\u793a\u9806"},o.a.createElement(re.a,{value:"NAME.DESC"},"\u540d\u524d\u964d\u9806"),o.a.createElement(re.a,{value:"NAME.ASC"},"\u540d\u524d\u6607\u9806"),o.a.createElement(re.a,{value:"NEW.DESC"},"\u8ffd\u52a0\u65e5\u65b0\u3057\u3044\u9806"),o.a.createElement(re.a,{value:"NEW.ASC"},"\u8ffd\u52a0\u65e5\u53e4\u3044\u9806"),o.a.createElement(re.a,{value:"POPULARITY.DESC"},"\u4eba\u6c17\u9806")))))),o.a.createElement($.a,{item:!0},o.a.createElement($.a,{container:!0,direction:"row",justify:"space-evenly",alignItems:"center",spacing:1},v)))},Fe=a(190),Le=a(118),Me=a(191),De=a(192),Te=a(188),Re=a(189),$e=a(193),We=a(20),Ye=a.n(We),_e=a(35),ze=a(108),Ge=a(109),qe=a(110),He=function(){function e(t){var a=this,n=t.linkUrl,r=t.tracks,c=t.dispatch;Object(ze.a)(this,e),this.linkUrl=void 0,this.playlist=void 0,this.tracks=void 0,this.currentPlaybackNo=void 0,this.dispatch=void 0,this.linkUrl=n,this.currentPlaybackNo=0,this.playlist={},r.forEach((function(e,t){e.previewUrl&&(a.playlist[t]=new qe.Howl({src:e.previewUrl,html5:!0,preload:!1,autoplay:!1,onend:function(){var e=Object(_e.a)(Ye.a.mark((function e(){return Ye.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return e.abrupt("return",a.autoNextPlay());case 1:case"end":return e.stop()}}),e)})));return function(){return e.apply(this,arguments)}}()}))})),this.tracks=r,this.dispatch=c}return Object(Ge.a)(e,[{key:"currentTrack",value:function(){if(!Object(G.isEmpty)(this.playlist))return this.tracks[this.currentPlaybackNo]}},{key:"play",value:function(){var e=Object(_e.a)(Ye.a.mark((function e(t){var a;return Ye.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(!Object(G.isEmpty)(this.playlist)){e.next=2;break}return e.abrupt("return");case 2:if(void 0!==t){e.next=13;break}if(!(a=this.playlist[this.currentPlaybackNo])){e.next=9;break}return e.next=7,a.play();case 7:e.next=11;break;case 9:return e.next=11,this.autoNextPlay();case 11:e.next=15;break;case 13:this.stopAndPlay(this.currentPlaybackNo,t),this.currentPlaybackNo=t;case 15:case"end":return e.stop()}}),e,this)})));return function(t){return e.apply(this,arguments)}}()},{key:"autoNextPlay",value:function(){var e=Object(_e.a)(Ye.a.mark((function e(){return Ye.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:this.dispatch&&this.dispatch({type:"NEXT_PLAY"});case 1:case"end":return e.stop()}}),e,this)})));return function(){return e.apply(this,arguments)}}()},{key:"nextPlay",value:function(){var e=Object(_e.a)(Ye.a.mark((function e(){var t,a;return Ye.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(!Object(G.isEmpty)(this.playlist)){e.next=2;break}return e.abrupt("return",0);case 2:if(t=this.currentPlaybackNo+1,!(this.tracks.length-1<t)){e.next=11;break}return e.next=6,this.playlist[this.currentPlaybackNo].stop();case 6:return this.currentPlaybackNo=0,this.dispatch&&this.dispatch({type:"STATUS_FINISH"}),e.abrupt("return",this.currentPlaybackNo);case 11:return a=this.currentPlaybackNo,this.currentPlaybackNo=t,e.next=15,this.stopAndPlay(a,t);case 15:return e.abrupt("return",this.currentPlaybackNo);case 16:case"end":return e.stop()}}),e,this)})));return function(){return e.apply(this,arguments)}}()},{key:"stopAndPlay",value:function(){var e=Object(_e.a)(Ye.a.mark((function e(t,a){var n,r;return Ye.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,null===(n=this.playlist[t])||void 0===n?void 0:n.stop();case 2:if(!(r=this.playlist[a])){e.next=8;break}return e.next=6,r.play();case 6:e.next=10;break;case 8:return e.next=10,this.autoNextPlay();case 10:case"end":return e.stop()}}),e,this)})));return function(t,a){return e.apply(this,arguments)}}()},{key:"pause",value:function(){var e=Object(_e.a)(Ye.a.mark((function e(){return Ye.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(!Object(G.isEmpty)(this.playlist)){e.next=2;break}return e.abrupt("return");case 2:return e.next=4,this.playlist[this.currentPlaybackNo].pause();case 4:case"end":return e.stop()}}),e,this)})));return function(){return e.apply(this,arguments)}}()},{key:"stop",value:function(){var e=Object(_e.a)(Ye.a.mark((function e(){return Ye.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(!Object(G.isEmpty)(this.playlist)){e.next=2;break}return e.abrupt("return");case 2:return e.next=4,this.playlist[this.currentPlaybackNo].stop();case 4:this.currentPlaybackNo=0;case 5:case"end":return e.stop()}}),e,this)})));return function(){return e.apply(this,arguments)}}()}]),e}(),Be=a(186),Je=a(79),Qe=a(80),Xe=a(81),Ve=Object(l.createContext)({});!function(e){e[e.None=0]="None",e[e.Play=1]="Play",e[e.Pause=2]="Pause",e[e.Stop=3]="Stop"}(K||(K={})),function(e){e[e.None=0]="None",e[e.Loading=1]="Loading",e[e.Done=2]="Done"}(Z||(Z={}));var Ke={player:new He({linkUrl:"",tracks:[]}),currentNo:0,playbackStatus:K.None,loadingStatus:Z.Done},Ze=function(e,t){switch(t.type){case"SET_PLAYER":return e.player.stop(),Object(M.a)({},e,{player:t.player,playbackStatus:K.Stop});case"PLAY":e.player.play(t.no);var a=void 0===t.no?e.currentNo:t.no;return Object(M.a)({},e,{playbackStatus:K.Play,currentNo:a});case"NEXT_PLAY":return Object(_e.a)(Ye.a.mark((function t(){return Ye.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:return t.next=2,e.player.nextPlay();case 2:return t.abrupt("return",t.sent);case 3:case"end":return t.stop()}}),t)})))(),Object(M.a)({},e,{currentNo:e.player.currentPlaybackNo,playbackStatus:K.Play});case"PAUSE":return e.player.pause(),Object(M.a)({},e,{playbackStatus:K.Pause});case"STOP":return e.player.stop(),Object(M.a)({},e,{playbackStatus:K.Play});case"LOADING_START":return Object(M.a)({},e,{loadingStatus:Z.Loading});case"LOADING_DONE":return Object(M.a)({},e,{loadingStatus:Z.Done});case"STATUS_FINISH":return Object(M.a)({},e,{currentNo:e.player.currentPlaybackNo,playbackStatus:K.Pause,loadingStatus:Z.Done});default:return e}},et=function(e){var t=e.children,a=Object(l.useReducer)(Ze,Ke),n=Object(b.a)(a,2),r=n[0],c=n[1];return o.a.createElement(Ve.Provider,{value:{state:r,dispatch:c}},t)},tt=Ve,at=function(e){var t=e.album,a=Object(l.useContext)(tt).dispatch,n=[];return(null===t||void 0===t?void 0:t.appleMusicAlbum)&&n.push(o.a.createElement($.a,{item:!0,key:0},o.a.createElement(p.a,{theme:Object(m.a)({palette:{primary:Je.a}})},o.a.createElement(Be.a,{href:"https://music.apple.com/jp/album/".concat(t.appleMusicAlbum.appleMusicId),target:"_blank",variant:"contained",color:"primary",onClick:function(){return a({type:"PAUSE"})}},"Apple Music \u3067\u8074\u304f")))),(null===t||void 0===t?void 0:t.itunesAlbum)&&n.push(o.a.createElement($.a,{item:!0,key:1},o.a.createElement(p.a,{theme:Object(m.a)({palette:{primary:Qe.a}})},o.a.createElement(Be.a,{href:"https://music.apple.com/jp/album/".concat(t.itunesAlbum.appleMusicId),target:"_blank",variant:"contained",color:"primary",onClick:function(){return a({type:"PAUSE"})}},"iTunes \u3067\u8074\u304f")))),(null===t||void 0===t?void 0:t.spotifyAlbum)&&n.push(o.a.createElement($.a,{item:!0,key:2},o.a.createElement(p.a,{theme:Object(m.a)({palette:{primary:Xe.a}})},o.a.createElement(Be.a,{href:"https://open.spotify.com/album/".concat(t.spotifyAlbum.spotifyId),target:"_blank",variant:"contained",color:"primary",onClick:function(){return a({type:"PAUSE"})}},"Spotify \u3067\u8074\u304f")))),o.a.createElement($.a,{container:!0,spacing:2,direction:"row",justify:"center",alignItems:"center"},n)},nt=a(187),rt=a(59),ct=a.n(rt),it=a(111),lt=a.n(it),ot=Object(nt.a)((function(e){return{"@keyframes playing-icon-spin":{from:{transform:"rotate(0deg)"},to:{transform:"rotate(360deg)"}},playingIcon:{height:24,width:24,animationName:"$playing-icon-spin",animationDuration:"2000ms",animationIterationCount:"infinite",animationTimingFunction:"linear"}}})),st=function(e){var t,a=e.track,n=e.index,r=e.playAction,c=e.averagePopularity,i=ot(),s=Object(l.useContext)(tt).state,u=null!==a.previewUrl,m=s.playbackStatus===K.Play,p=n===s.currentNo&&a.id===(null===(t=s.player.currentTrack())||void 0===t?void 0:t.id),d=o.a.createElement(he.a,{color:"primary",className:i.playingIcon,component:function(e){return o.a.createElement("svg",e,o.a.createElement("defs",null,o.a.createElement("linearGradient",{id:"gradient1"},m?o.a.createElement(o.a.Fragment,null,o.a.createElement("stop",{offset:"20%",stopColor:"#4AC6D2"}),o.a.createElement("stop",{offset:"80%",stopColor:"#F2D349"})):o.a.createElement("stop",{offset:"100%",stopColor:"#4AC6D2"}))),o.a.cloneElement(e.children[0],{fill:"url(#gradient1)"}))}}),f=!1;return c<a.popularity&&(f=!0),o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center"},p?o.a.createElement(de.a,{component:"span"},d):o.a.createElement(de.a,{onClick:function(){return r(n)},disabled:!u,component:"span"},f?o.a.createElement(lt.a,null):o.a.createElement(ct.a,null))),o.a.createElement(Re.a,null,a.name))},ut=function(e){var t=e.album,a=Object(l.useContext)(tt).dispatch,n=Object(E.g)(),r=t.tracks.map((function(e){return e.durationMs})).reduce((function(e,t){return e+t})),c=new Intl.DateTimeFormat("jp",{year:"numeric"}).formatToParts(new Date(t.releaseDate)),i=Object(b.a)(c,2),s=i[0].value,u=i[1].value,m="".concat(s).concat(u),p=Object(l.useRef)(!0),d=function(e){if(p.current){var r=new He({linkUrl:"".concat(n.pathname).concat(n.search),tracks:t.tracks,dispatch:a});a({type:"SET_PLAYER",player:r}),p.current=!1}console.log("dispatch PLAY"),a({type:"PLAY",no:e})},f=q.a.meanBy(t.tracks,(function(e){return e.popularity}));return o.a.createElement(Fe.a,{component:Le.a,style:{maxWidth:"600px"}},o.a.createElement(Me.a,{size:"small"},o.a.createElement(De.a,null,o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center",colSpan:2,style:{border:"none"}},o.a.createElement($.a,{container:!0,justify:"center",alignItems:"center"},o.a.createElement(z,{title:"",src:t.artworkL.url,width:"250px"})))),o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center",colSpan:2,style:{border:"none"}},t.name)),o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center",colSpan:2,style:{border:"none"}},"".concat(m,"\u767a\u58f2\u3001").concat(t.totalTracks,"\u66f2\u3001").concat(function(e){var t=parseInt((e/1e3).toFixed(0)),a=parseInt((e/6e4).toFixed(0)),n=parseInt((e/36e5).toFixed(0)),r=parseInt((e/864e5).toFixed(0));return t<60?t+"\u79d2":a<60?a+"\u5206":n<24?n+"\u6642\u9593":r+"\u65e5"}(r)))),o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center",colSpan:2},o.a.createElement(at,{album:t}))),o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center"},"\u8a66\u8074"),o.a.createElement(Re.a,null,"\u30bf\u30a4\u30c8\u30eb"))),o.a.createElement($e.a,null,t.tracks.map((function(e,t){return o.a.createElement(st,{key:t,track:e,index:t,playAction:d,averagePopularity:f})})))))},mt=function(){var e,t=Object(E.h)().id,a=(e={variables:{id:t}},g.c(A,e)),n=a.loading,r=a.error,c=a.data;if(r)return o.a.createElement("div",null,r.message);var i=o.a.createElement(o.a.Fragment,null);if(!n&&c&&c.album){var l=o.a.createElement(ut,{album:c.album});i=o.a.createElement($.a,{container:!0,direction:"column",justify:"center",alignItems:"center",spacing:2},o.a.createElement($.a,{item:!0},l),o.a.createElement($.a,{item:!0},o.a.createElement(Ue,null)))}return o.a.createElement($.a,{container:!0,spacing:1,direction:"column",justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0},i))},pt=function(){var e=Object(E.h)().id,t=Object(g.c)(N,{variables:{id:e}}),a=t.error,n=t.data;if(a)return o.a.createElement("div",null,a.message);var r=o.a.createElement(o.a.Fragment,null);return n&&n.artist&&(r=o.a.createElement(z,{title:n.artist.name,src:n.artist.artworkL.url,width:270})),o.a.createElement($.a,{container:!0,spacing:2,direction:"column",justify:"center",alignItems:"center"},r,o.a.createElement($.a,{item:!0},o.a.createElement(oe,null)))},dt=a(179),ft=a(197),Et=function(){var e,t=Object(l.useState)(o.a.createElement(o.a.Fragment,null)),a=Object(b.a)(t,2),n=a[0],r=a[1],c=Object(l.useState)(""),i=Object(b.a)(c,2),s=i[0],u=i[1],m=Object(l.useState)(""),p=Object(b.a)(m,2),d=p[0],f=p[1],E=(e={update:function(e,t){t.data.signin.error?r(o.a.createElement(ft.a,{severity:"error"},t.data.signin.error)):r(o.a.createElement(ft.a,{severity:"success"},"\u30ed\u30b0\u30a4\u30f3\u3057\u307e\u3057\u305f"))},variables:{input:{username:s,password:d}}},g.b(L,e)),h=Object(b.a)(E,1)[0];return o.a.createElement($.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},o.a.createElement("form",{autoComplete:"off"},o.a.createElement("div",null,o.a.createElement(te.a,null,o.a.createElement(ae.a,null,"\u30e6\u30fc\u30b6\u30fc\u540d"),o.a.createElement(dt.a,{value:s,onChange:function(e){return u(e.target.value||"")}}))),o.a.createElement("div",null,o.a.createElement(te.a,null,o.a.createElement(ae.a,null,"\u30d1\u30b9\u30ef\u30fc\u30c9"),o.a.createElement(dt.a,{value:d,onChange:function(e){return f(e.target.value||"")},type:"password"}))),o.a.createElement("div",null,o.a.createElement(Be.a,{type:"submit",onClick:function(e){e.preventDefault(),h()},variant:"contained"},"Signin")),o.a.createElement("div",null,n)))},bt=function(){var e,t=Object(l.useState)(o.a.createElement(o.a.Fragment,null)),a=Object(b.a)(t,2),n=a[0],r=a[1],c=Object(l.useState)(""),i=Object(b.a)(c,2),s=i[0],u=i[1],m=Object(l.useState)(""),p=Object(b.a)(m,2),d=p[0],f=p[1],E=Object(l.useState)(""),h=Object(b.a)(E,2),v=h[0],y=h[1],k=Object(l.useState)(""),w=Object(b.a)(k,2),j=w[0],O=w[1],S=Object(l.useState)({oldPassword:v}),x=Object(b.a)(S,2),P=x[0],A=x[1],I=g.c(U,e).data;""===s&&""===d&&I&&I.me&&(u(I.me.name),f(I.me.username));var N=[];I&&I.me&&(N=I.me.role.allowedActions.map((function(e,t){return o.a.createElement("p",{key:t},e)})));var C=function(e){return g.b(F,e)}({update:function(e,t){t.data.updateMe.error?r(o.a.createElement(ft.a,{severity:"error"},t.data.updateMe.error)):r(o.a.createElement(ft.a,{severity:"success"},"\u66f4\u65b0\u3057\u307e\u3057\u305f"))},variables:{input:P}}),L=Object(b.a)(C,1)[0];return o.a.createElement($.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},o.a.createElement("form",{autoComplete:"off"},o.a.createElement("div",null,"ID: ",I&&I.me?I.me.id:""),o.a.createElement("div",null,o.a.createElement(te.a,null,o.a.createElement(ae.a,null,"\u540d\u524d"),o.a.createElement(dt.a,{value:s,onChange:function(e){u(e.target.value||""),A(Object(M.a)({},P,{name:e.target.value||""}))}}))),o.a.createElement("div",null,o.a.createElement(te.a,null,o.a.createElement(ae.a,null,"\u30e6\u30fc\u30b6\u30fc\u540d"),o.a.createElement(dt.a,{value:d,onChange:function(e){f(e.target.value||""),A(Object(M.a)({},P,{username:e.target.value||""}))}}))),o.a.createElement("div",null,o.a.createElement(te.a,null,o.a.createElement(ae.a,null,"\u65b0\u3057\u3044\u30d1\u30b9\u30ef\u30fc\u30c9"),o.a.createElement(dt.a,{value:j,onChange:function(e){O(e.target.value||""),A(Object(M.a)({},P,{newPassword:e.target.value||""}))},type:"password"}))),o.a.createElement("div",null,o.a.createElement(te.a,{required:!0},o.a.createElement(ae.a,null,"\u53e4\u3044\u30d1\u30b9\u30ef\u30fc\u30c9"),o.a.createElement(dt.a,{value:v,onChange:function(e){y(e.target.value||""),A(Object(M.a)({},P,{oldPassword:e.target.value||""}))},type:"password"}))),o.a.createElement("div",null,o.a.createElement(Be.a,{type:"submit",onClick:function(e){e.preventDefault(),L()},variant:"contained"},"Update")),o.a.createElement("div",null,n),o.a.createElement("div",null,"\u6a29\u9650: ",N)))},ht=a(194),vt=a(113),yt=a.n(vt),gt=a(112),kt=a.n(gt),wt=a(87),jt=a.n(wt),Ot=Object(nt.a)((function(e){return{"@keyframes loading-icon-spin":{from:{transform:"rotate(0deg)"},to:{transform:"rotate(360deg)"}},loadingIcon:{height:35,width:35,animationName:"$loading-icon-spin",animationDuration:"2000ms",animationIterationCount:"infinite",animationTimingFunction:"linear"}}})),St=function(){var e=Object(l.useContext)(tt),t=e.state,a=e.dispatch,n=Ot(),r=o.a.createElement(o.a.Fragment,null),c=o.a.createElement(de.a,{color:"inherit",onClick:function(){return a({type:"NEXT_PLAY"})}},o.a.createElement(jt.a,{fontSize:"large"}));if(t.loadingStatus===Z.Loading)c=r=o.a.createElement(de.a,{"aria-label":"loading",disabled:!0},o.a.createElement(kt.a,{className:n.loadingIcon}));else switch(t.playbackStatus){case K.None:r=o.a.createElement(de.a,{color:"inherit",disabled:!0},o.a.createElement(ct.a,{fontSize:"large"})),c=o.a.createElement(de.a,{color:"inherit",disabled:!0},o.a.createElement(jt.a,{fontSize:"large"}));break;case K.Play:r=o.a.createElement(de.a,{color:"inherit",onClick:function(){return a({type:"PAUSE"})}},o.a.createElement(yt.a,{fontSize:"large"}));break;case K.Pause:r=o.a.createElement(de.a,{color:"inherit",onClick:function(){return a({type:"PLAY"})}},o.a.createElement(ct.a,{fontSize:"large"}));break;case K.Stop:r=o.a.createElement(de.a,{color:"inherit",onClick:function(){return a({type:"PLAY",no:0})}},o.a.createElement(ct.a,{fontSize:"large"}))}var i=o.a.createElement(o.a.Fragment,null),s=o.a.createElement(o.a.Fragment,null);if(t.player.tracks[t.currentNo]){var u,m=t.player.tracks[t.currentNo];(null===(u=m.artworkM)||void 0===u?void 0:u.url)&&(i=o.a.createElement(z,{linkUrl:"".concat(t.player.linkUrl,"#").concat(m.id),title:"",src:m.artworkM.url,width:"40px"})),s=o.a.createElement(_.a,{style:{overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"},variant:"caption",component:"p"},m.name)}return o.a.createElement($.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"center"},o.a.createElement($.a,{item:!0,xs:5},o.a.createElement($.a,{container:!0,direction:"row",justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0,xs:1}),o.a.createElement($.a,{item:!0,xs:3},i),o.a.createElement($.a,{item:!0,xs:1}),o.a.createElement($.a,{item:!0,xs:7},s))),o.a.createElement($.a,{item:!0,xs:2},o.a.createElement($.a,{container:!0,justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0},r))),o.a.createElement($.a,{item:!0,xs:2},o.a.createElement($.a,{container:!0,justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0},c))),o.a.createElement($.a,{item:!0,xs:2}),o.a.createElement($.a,{item:!0,xs:1}))},xt=function(){return o.a.createElement(me.a,{position:"fixed",color:"secondary",style:{top:"auto",bottom:0}},o.a.createElement(St,null))},Pt=function(){return o.a.createElement(f.a,null,o.a.createElement(ge.a,{client:Ne},o.a.createElement(et,null,o.a.createElement(ye,null),o.a.createElement(xt,null),o.a.createElement(ht.a,{style:{flexGrow:1}},o.a.createElement($.a,{container:!0,direction:"column",justify:"center",alignItems:"center",spacing:2},o.a.createElement($.a,{item:!0},o.a.createElement(pe.a,null)),o.a.createElement($.a,{item:!0},o.a.createElement(E.c,null,o.a.createElement(E.a,{exact:!0,path:"/",component:oe}),o.a.createElement(E.a,{exact:!0,path:"/artists",component:Ue}),o.a.createElement(E.a,{exact:!0,path:"/artists/:id",component:pt}),o.a.createElement(E.a,{exact:!0,path:"/albums",component:oe}),o.a.createElement(E.a,{exact:!0,path:"/albums/:id",component:mt}),o.a.createElement(E.a,{exact:!0,path:"/signin",component:Et}),o.a.createElement(E.a,{exact:!0,path:"/me",component:bt}))),o.a.createElement($.a,{item:!0},o.a.createElement(pe.a,null)))))))},At=Object(m.a)({palette:{type:"dark",primary:{main:"#222222"},secondary:{main:"#4AC6D2"}},typography:{fontFamily:['"Noto Sans JP"',"Roboto",'"Helvetica Neue"',"Arial","sans-serif",'"Apple Color Emoji"','"Segoe UI Emoji"','"Segoe UI Symbol"'].join(",")}}),It=function(){return o.a.createElement(p.a,{theme:At},o.a.createElement(d.a,null),o.a.createElement("link",{href:"https://fonts.googleapis.com/css?family=Noto+Sans+JP",rel:"stylesheet"}),o.a.createElement(Pt,null))},Nt=Boolean("localhost"===window.location.hostname||"[::1]"===window.location.hostname||window.location.hostname.match(/^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$/));function Ct(e,t){navigator.serviceWorker.register(e).then((function(e){e.onupdatefound=function(){var a=e.installing;null!=a&&(a.onstatechange=function(){"installed"===a.state&&(navigator.serviceWorker.controller?(console.log("New content is available and will be used when all tabs for this page are closed. See https://bit.ly/CRA-PWA."),t&&t.onUpdate&&t.onUpdate(e)):(console.log("Content is cached for offline use."),t&&t.onSuccess&&t.onSuccess(e)))})}})).catch((function(e){console.error("Error during service worker registration:",e)}))}var Ut=function(){return o.a.createElement(It,null)};[/Android/i,/webOS/i,/iPhone/i,/iPad/i,/iPod/i,/BlackBerry/i,/Windows Phone/i].some((function(e){return navigator.userAgent.match(e)}))?function(e){if("serviceWorker"in navigator){if(new URL("",window.location.href).origin!==window.location.origin)return;window.addEventListener("load",(function(){var t="".concat("","/service-worker.js");Nt?(!function(e,t){fetch(e).then((function(a){var n=a.headers.get("content-type");404===a.status||null!=n&&-1===n.indexOf("javascript")?navigator.serviceWorker.ready.then((function(e){e.unregister().then((function(){window.location.reload()}))})):Ct(e,t)})).catch((function(){console.log("No internet connection found. App is running in offline mode.")}))}(t,e),navigator.serviceWorker.ready.then((function(){console.log("This web app is being served cache-first by a service worker. To learn more, visit https://bit.ly/CRA-PWA")}))):Ct(t,e)}))}}():"serviceWorker"in navigator&&navigator.serviceWorker.ready.then((function(e){e.unregister()})),u.a.render(o.a.createElement(Ut,null),document.querySelector("#app"))}},[[121,1,2]]]);
//# sourceMappingURL=main.7f86559b.chunk.js.map