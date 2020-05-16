(this["webpackJsonpmusic-client"]=this["webpackJsonpmusic-client"]||[]).push([[0],{120:function(e,t,a){e.exports=a(134)},134:function(e,t,a){"use strict";a.r(t);var n,r,c,l,i=a(0),o=a.n(i),u=a(14),s=a.n(u),m=a(113),p=a(184),d=a(194),E=a(25),f=a(41),h=a(13),b=a(44),y=a(45),v=a.n(y),g=a(27);function k(){var e=Object(b.a)(["\n    mutation Signin($input: SigninInput!) {\n  signin(input: $input) {\n    error\n  }\n}\n    "]);return k=function(){return e},e}function j(){var e=Object(b.a)(["\n    mutation UpdateMe($input: UpdateMeInput!) {\n  updateMe(input: $input) {\n    currentUser {\n      id\n      username\n      name\n    }\n    error\n  }\n}\n    "]);return j=function(){return e},e}function w(){var e=Object(b.a)(["\n    query Me {\n  me {\n    id\n    name\n    username\n    role {\n      id\n      name\n      description\n      allowedActions\n    }\n  }\n}\n    "]);return w=function(){return e},e}function O(){var e=Object(b.a)(["\n    query Artists($cursor: CursorInputObject, $sort: ArtistsSortInputObject, $conditions: ArtistsConditionsInputObject) {\n  items: artists(cursor: $cursor, sort: $sort, conditions: $conditions) {\n    id\n    name\n    status\n    artworkM {\n      url\n      width\n      height\n    }\n  }\n}\n    "]);return O=function(){return e},e}function S(){var e=Object(b.a)(["\n    query Artist($id: TTID!) {\n  artist(id: $id) {\n    id\n    name\n    artworkL {\n      url\n      width\n      height\n    }\n  }\n}\n    "]);return S=function(){return e},e}function x(){var e=Object(b.a)(["\n    query Albums($cursor: CursorInputObject, $sort: AlbumsSortInputObject, $conditions: AlbumsConditionsInputObject) {\n  items: albums(cursor: $cursor, sort: $sort, conditions: $conditions) {\n    id\n    name\n    status\n    artworkM {\n      url\n      width\n      height\n    }\n    appleMusicAlbum {\n      id\n    }\n    itunesAlbum {\n      id\n    }\n    spotifyAlbum {\n      id\n    }\n  }\n}\n    "]);return x=function(){return e},e}function P(){var e=Object(b.a)(["\n    query Album($id: TTID!) {\n  album(id: $id) {\n    id\n    totalTracks\n    name\n    releaseDate\n    artworkL {\n      url\n      width\n      height\n    }\n    artworkM {\n      url\n      width\n      height\n    }\n    appleMusicAlbum {\n      id\n      appleMusicId\n    }\n    itunesAlbum {\n      id\n      appleMusicId\n    }\n    spotifyAlbum {\n      id\n      spotifyId\n    }\n    tracks {\n      id\n      isrc\n      name\n      discNumber\n      trackNumber\n      durationMs\n      previewUrl\n      popularity\n      artworkM {\n        url\n        width\n        height\n      }\n    }\n  }\n}\n    "]);return P=function(){return e},e}!function(e){e.New="NEW",e.Release="RELEASE",e.Popularity="POPULARITY"}(n||(n={})),function(e){e.Name="NAME",e.New="NEW",e.Popularity="POPULARITY"}(r||(r={})),function(e){e.Asc="ASC",e.Desc="DESC"}(c||(c={})),function(e){e.Pending="PENDING",e.Active="ACTIVE",e.Ignore="IGNORE"}(l||(l={}));var A=v()(P());var I=v()(x());var N=v()(S());var C=v()(O());var F=v()(w());var M=v()(j());var L=v()(k());var D=a(10),U=a(173),T=a(168),R=function(e){var t=e.className,a=void 0===t?"":t,n=e.src,r=void 0===n?"":n,c=e.title,l=void 0===c?"":c,i=e.width;return""===r&&(r="".concat("","/no_image.png")),o.a.createElement(T.a,{className:a,image:r,title:l,style:{width:i,height:i}})},$=a(172),Y=a(174),W=a(175),_=a(176),z=function(e){var t=e.linkUrl?{component:E.b,to:e.linkUrl}:{};return Object(i.createElement)($.a,Object(D.a)({item:!0,style:{textDecoration:"none"}},t,{children:o.a.createElement(U.a,{style:{width:e.width,position:"relative"}},o.a.createElement(Y.a,null,o.a.createElement($.a,{container:!0,style:{position:"absolute",left:"5px",bottom:"5px"}},e.componentInImage?e.componentInImage:o.a.createElement(o.a.Fragment,null)),o.a.createElement(R,{src:e.src||"",width:e.width,title:e.title})),""===e.title?o.a.createElement(o.a.Fragment,null):o.a.createElement(W.a,{style:{padding:"5px 5px"}},o.a.createElement(_.a,{style:{overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"},variant:"caption",color:"textSecondary",component:"p"},e.title)))}))},G=a(36),q=a.n(G),H={album:"b",artist:"a"},J="i",Q="s",X="o",B="r";function V(e){var t=Object(f.g)(),a=new URLSearchParams(t.search),n=H[e],r=function(e){var t=a.get(e);if(null===t)return[];var n=t.split("-"),r=new Set;return n.forEach((function(e){r.add(e)})),Array.from(r)},c=function(e,t){if(q.a.isArray(e))return e.concat(t)},l={};r(n+J).forEach((function(e){switch(!0){case/^art/.test(e):l=q.a.merge(l,{conditions:{artists:{id:[e]}}});break;case/^abm/.test(e):l=q.a.merge(l,{conditions:{albums:{id:[e]}}});break;case/^trk/.test(e):l=q.a.merge(l,{conditions:{tracks:{id:[e]}}})}}));var i={status:[]};return r(n+Q).forEach((function(e){i=q.a.mergeWith(i,{status:[e]},c)})),0!==i.status.length&&(l=q.a.mergeWith(l,{conditions:Object(D.a)({},i)})),r(n+X).forEach((function(e){l=q.a.merge(l,{sort:{order:e}})})),r(n+B).forEach((function(e){l=q.a.merge(l,{sort:{type:e}})})),l}var K,Z,ee=function(e){var t=e.album,a=e.width,n=Object(f.f)(),r=new URLSearchParams(n.location.search);r.set(H.artist+J,t.id);var c=r.get(H.album+Q);null!==c&&r.set(H.album+Q,c);var i={width:"15px",height:"15px",borderRadius:"50%",fontSize:"10px",color:"#fff",lineHeight:"15px",textAlign:"center",background:"#000"},u=[];t.appleMusicAlbum&&u.push(o.a.createElement($.a,{key:1,item:!0,style:Object(D.a)({},i,{backgroundColor:"#ff2f56"})},"A")),t.itunesAlbum&&u.push(o.a.createElement($.a,{key:2,item:!0,style:Object(D.a)({},i,{backgroundColor:"#0070c9"})},"iT")),t.spotifyAlbum&&u.push(o.a.createElement($.a,{key:3,item:!0,style:Object(D.a)({},i,{backgroundColor:"#1DB954"})},"S")),t.status===l.Pending?u.push(o.a.createElement($.a,{key:10,item:!0,style:Object(D.a)({},i,{color:"#000",backgroundColor:"#FFFF00"})},"PN")):t.status===l.Ignore&&u.push(o.a.createElement($.a,{key:11,item:!0,style:Object(D.a)({},i,{color:"#000",backgroundColor:"#FF0000"})},"IG"));var s=o.a.createElement(o.a.Fragment,null,u);return o.a.createElement(z,{title:t.name,src:t.artworkM.url,width:a,linkUrl:"/albums/".concat(t.id,"?").concat(r.toString()),componentInImage:s})},te=a(177),ae=a(197),ne=a(195),re=a(198),ce=a(88),le=a(104),ie=function(e){var t=e.component,a=e.no,n=e.offset,r=e.limit,c=e.fetchMore,l=Object(i.useState)(t),u=Object(h.a)(l,2),s=u[0],m=u[1],p=Object(i.useState)(!1),d=Object(h.a)(p,2),E=d[0],f=d[1],b=a===n-r;return o.a.createElement(o.a.Fragment,null,t,b?o.a.createElement(le.a,{onEnter:function(){if(!E||s!==t)return f(!0),m(t),c({variables:{cursor:{offset:n}},updateQuery:function(e,t){var a=t.fetchMoreResult;return a?Object(D.a)({},e,{},{items:[].concat(Object(ce.a)(e.items),Object(ce.a)(a.items))}):e}})}}):o.a.createElement(o.a.Fragment,null))},oe=function(){var e,t,a,n=Object(i.useState)("RELEASE.DESC"),r=Object(h.a)(n,2),c=r[0],l=r[1],u=V("album"),s=Object(f.f)(),m=(a={variables:{cursor:{offset:0,limit:50},sort:u.sort,conditions:u.conditions},fetchPolicy:"cache-first"},g.c(I,a)),p=m.error,d=m.data,E=m.fetchMore,b=(null===u||void 0===u?void 0:u.sort)?"".concat(null===u||void 0===u||null===(e=u.sort)||void 0===e?void 0:e.order,".").concat(null===u||void 0===u||null===(t=u.sort)||void 0===t?void 0:t.type):null;if(b&&c!==b&&l(b),p)return o.a.createElement("div",null,p.message);var y=[];d&&(y=d.items.map((function(e,t){return o.a.createElement($.a,{item:!0,key:t},o.a.createElement(ie,{component:o.a.createElement(ee,{album:e,width:"150px"}),no:t,offset:d.items.length,limit:50,fetchMore:E}))})));return o.a.createElement($.a,{container:!0,spacing:2,direction:"column",justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0},o.a.createElement($.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"flex-start"},o.a.createElement($.a,{item:!0},o.a.createElement(te.a,{variant:"outlined",style:{minWidth:150}},o.a.createElement(ae.a,{id:"demo-simple-select-outlined-label"},"\u30a2\u30eb\u30d0\u30e0\u8868\u793a\u9806"),o.a.createElement(ne.a,{labelId:"demo-simple-select-outlined-label",id:"demo-simple-select-outlined",value:c,onChange:function(e,t){var a=e.target.value,n=a.split("."),r=Object(h.a)(n,2),c=r[0],i=r[1];l(a);var o=new URLSearchParams(s.location.search);o.set(H.album+X,c),o.set(H.album+B,i),s.push("".concat(s.location.pathname,"?").concat(o.toString()))},label:"\u30a2\u30eb\u30d0\u30e0\u8868\u793a\u9806"},o.a.createElement(re.a,{value:"RELEASE.DESC"},"\u767a\u58f2\u65e5\u65b0\u3057\u3044\u9806"),o.a.createElement(re.a,{value:"RELEASE.ASC"},"\u767a\u58f2\u65e5\u53e4\u3044\u9806"),o.a.createElement(re.a,{value:"NEW.DESC"},"\u8ffd\u52a0\u65e5\u65b0\u3057\u3044\u9806"),o.a.createElement(re.a,{value:"NEW.ASC"},"\u8ffd\u52a0\u65e5\u53e4\u3044\u9806"),o.a.createElement(re.a,{value:"POPULARITY.DESC"},"\u4eba\u6c17\u9806")))))),o.a.createElement($.a,{item:!0},o.a.createElement($.a,{container:!0,direction:"row",justify:"space-evenly",alignItems:"center",spacing:1},y)))},ue=a(179),se=a(180),me=a(181),pe=a(182),de=a(183),Ee=a(106),fe=a.n(Ee),he=a(76),be=a.n(he),ye=function(e){var t=e.children,a=e.window,n=Object(ue.a)({target:a?a():void 0});return o.a.createElement(se.a,{appear:!1,direction:"down",in:!n},t)},ve=function(){return o.a.createElement(o.a.Fragment,null,o.a.createElement(ye,null,o.a.createElement(me.a,null,o.a.createElement(pe.a,null,o.a.createElement($.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"center",spacing:3},o.a.createElement($.a,{item:!0},o.a.createElement(_.a,{variant:"h6"},"\u30b2\u30fc\u30e0\u97f3\u697d")),o.a.createElement($.a,{item:!0},o.a.createElement(de.a,{component:E.b,to:"/artists",edge:"start",size:"small",color:"inherit","aria-label":"menu"},o.a.createElement(fe.a,null))),o.a.createElement($.a,{item:!0},o.a.createElement(de.a,{component:E.b,to:"/albums",edge:"start",size:"small",color:"inherit","aria-label":"menu"},o.a.createElement(be.a,null))))))))},ge=a(23),ke=a(42),je=a(24),we=a(115),Oe=a(114),Se=a(107),xe=new we.a({uri:"https://video-game-music.net/graphql",credentials:"include"}),Pe=new je.a((function(e,t){return t(e)})),Ae=Object(Se.a)((function(e){var t=e.graphQLErrors,a=e.networkError;t&&t.map((function(e){var t=e.message,a=e.locations,n=e.path;return console.log("[GraphQL error]: Message: ".concat(t,", Location: ").concat(a,", Path: ").concat(n))})),a&&console.log("[Network error]: ".concat(a))})),Ie=je.a.from([Pe,Ae,xe]),Ne=new ke.a({link:Ie,cache:new Oe.a({dataIdFromObject:function(e){return e.id}})}),Ce=function(e){var t=e.artist,a=e.width,n=Object(f.f)(),r=new URLSearchParams(n.location.search);r.set(H.album+J,t.id);var c=r.get(H.artist+Q);null!==c&&r.set(H.album+Q,c);var i={width:"15px",height:"15px",borderRadius:"50%",fontSize:"10px",color:"#fff",lineHeight:"15px",textAlign:"center",background:"#000"},u=[];t.status===l.Pending?u.push(o.a.createElement($.a,{key:10,item:!0,style:Object(D.a)({},i,{color:"#000",backgroundColor:"#FFFF00"})},"PN")):t.status===l.Ignore&&u.push(o.a.createElement($.a,{key:11,item:!0,style:Object(D.a)({},i,{color:"#000",backgroundColor:"#FF0000"})},"IG"));var s=o.a.createElement(o.a.Fragment,null,u);return o.a.createElement(z,{title:t.name,src:t.artworkM.url,width:a,linkUrl:"/artists/".concat(t.id,"?").concat(r.toString()),componentInImage:s})},Fe=function(){var e,t,a,n=Object(i.useState)("NAME.ASC"),r=Object(h.a)(n,2),c=r[0],l=r[1],u=V("artist"),s=Object(f.f)(),m=(a={variables:{cursor:{offset:0,limit:30},sort:u.sort,conditions:u.conditions},fetchPolicy:"cache-first"},g.c(C,a)),p=m.error,d=m.data,E=m.fetchMore,b=(null===u||void 0===u?void 0:u.sort)?"".concat(null===u||void 0===u||null===(e=u.sort)||void 0===e?void 0:e.order,".").concat(null===u||void 0===u||null===(t=u.sort)||void 0===t?void 0:t.type):null;if(b&&c!==b&&l(b),p)return o.a.createElement("div",null,p.message);var y=[];d&&(y=d.items.map((function(e,t){return o.a.createElement($.a,{item:!0,key:t},o.a.createElement(ie,{component:o.a.createElement(Ce,{artist:e,width:"150px"}),no:t,offset:d.items.length,limit:30,fetchMore:E}))})));return o.a.createElement($.a,{container:!0,spacing:2,direction:"column",justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0},o.a.createElement($.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"flex-start"},o.a.createElement($.a,null,o.a.createElement(te.a,{variant:"outlined",style:{minWidth:150}},o.a.createElement(ae.a,{id:"demo-simple-select-outlined-label"},"\u30a2\u30fc\u30c6\u30a3\u30b9\u30c8\u8868\u793a\u9806"),o.a.createElement(ne.a,{labelId:"demo-simple-select-outlined-label",id:"demo-simple-select-outlined",value:c,onChange:function(e,t){var a=e.target.value,n=a.split("."),r=Object(h.a)(n,2),c=r[0],i=r[1];l(a);var o=new URLSearchParams(s.location.search);o.set(H.artist+X,c),o.set(H.artist+B,i),s.push("".concat(s.location.pathname,"?").concat(o.toString()))},label:"\u30a2\u30fc\u30c6\u30a3\u30b9\u30c8\u8868\u793a\u9806"},o.a.createElement(re.a,{value:"NAME.ASC"},"\u540d\u524d\u6607\u9806"),o.a.createElement(re.a,{value:"NAME.DESC"},"\u540d\u524d\u964d\u9806"),o.a.createElement(re.a,{value:"NEW.DESC"},"\u8ffd\u52a0\u65e5\u65b0\u3057\u3044\u9806"),o.a.createElement(re.a,{value:"NEW.ASC"},"\u8ffd\u52a0\u65e5\u53e4\u3044\u9806"),o.a.createElement(re.a,{value:"POPULARITY.DESC"},"\u4eba\u6c17\u9806")))))),o.a.createElement($.a,{item:!0},o.a.createElement($.a,{container:!0,direction:"row",justify:"space-evenly",alignItems:"center",spacing:1},y)))},Me=a(189),Le=a(117),De=a(190),Ue=a(191),Te=a(187),Re=a(188),$e=a(192),Ye=a(20),We=a.n(Ye),_e=a(34),ze=a(108),Ge=a(109),qe=a(110),He=function(){function e(t){var a=this,n=t.linkUrl,r=t.tracks,c=t.dispatch;Object(ze.a)(this,e),this.linkUrl=void 0,this.playlist=void 0,this.tracks=void 0,this.currentPlaybackNo=void 0,this.dispatch=void 0,this.linkUrl=n,this.currentPlaybackNo=0,this.playlist=r.map((function(e){return new qe.Howl({src:e.previewUrl,html5:!0,preload:!1,autoplay:!1,onend:function(){var e=Object(_e.a)(We.a.mark((function e(){return We.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return e.abrupt("return",a.autoNextPlay());case 1:case"end":return e.stop()}}),e)})));return function(){return e.apply(this,arguments)}}()})})),this.tracks=r,this.dispatch=c}return Object(Ge.a)(e,[{key:"currentTrack",value:function(){if(0!==this.playlist.length)return this.tracks[this.currentPlaybackNo]}},{key:"currentPlaybackTime",value:function(){return 0===this.playlist.length?0:"unloaded"!==this.playlist[this.currentPlaybackNo].state()?this.playlist[this.currentPlaybackNo].seek():0}},{key:"play",value:function(){var e=Object(_e.a)(We.a.mark((function e(t){return We.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(0!==this.playlist.length){e.next=2;break}return e.abrupt("return");case 2:if(void 0!==t){e.next=7;break}return e.next=5,this.playlist[this.currentPlaybackNo].play();case 5:e.next=9;break;case 7:this.stopAndPlay(this.currentPlaybackNo,t),this.currentPlaybackNo=t;case 9:case"end":return e.stop()}}),e,this)})));return function(t){return e.apply(this,arguments)}}()},{key:"autoNextPlay",value:function(){var e=Object(_e.a)(We.a.mark((function e(){return We.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:this.dispatch&&this.dispatch({type:"NEXT_PLAY"});case 1:case"end":return e.stop()}}),e,this)})));return function(){return e.apply(this,arguments)}}()},{key:"nextPlay",value:function(){var e=Object(_e.a)(We.a.mark((function e(){var t;return We.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(0!==this.playlist.length){e.next=2;break}return e.abrupt("return",0);case 2:if(t=this.currentPlaybackNo+1,!(this.playlist.length-1<t)){e.next=11;break}return e.next=6,this.playlist[this.currentPlaybackNo].stop();case 6:return this.currentPlaybackNo=0,this.dispatch&&this.dispatch({type:"STATUS_FINISH"}),e.abrupt("return",this.currentPlaybackNo);case 11:return this.stopAndPlay(this.currentPlaybackNo,t),e.abrupt("return",this.currentPlaybackNo=t);case 13:case"end":return e.stop()}}),e,this)})));return function(){return e.apply(this,arguments)}}()},{key:"stopAndPlay",value:function(){var e=Object(_e.a)(We.a.mark((function e(t,a){return We.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,this.playlist[t].stop();case 2:return e.next=4,this.playlist[a].play();case 4:case"end":return e.stop()}}),e,this)})));return function(t,a){return e.apply(this,arguments)}}()},{key:"pause",value:function(){var e=Object(_e.a)(We.a.mark((function e(){return We.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(0!==this.playlist.length){e.next=2;break}return e.abrupt("return");case 2:return e.next=4,this.playlist[this.currentPlaybackNo].pause();case 4:case"end":return e.stop()}}),e,this)})));return function(){return e.apply(this,arguments)}}()},{key:"stop",value:function(){var e=Object(_e.a)(We.a.mark((function e(){return We.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(0!==this.playlist.length){e.next=2;break}return e.abrupt("return");case 2:return e.next=4,this.playlist[this.currentPlaybackNo].stop();case 4:this.currentPlaybackNo=0;case 5:case"end":return e.stop()}}),e,this)})));return function(){return e.apply(this,arguments)}}()}]),e}(),Je=a(185),Qe=a(79),Xe=a(80),Be=a(81),Ve=function(e){var t=e.album,a=[];return(null===t||void 0===t?void 0:t.appleMusicAlbum)&&a.push(o.a.createElement($.a,{item:!0,key:0},o.a.createElement(p.a,{theme:Object(m.a)({palette:{primary:Qe.a}})},o.a.createElement(Je.a,{href:"https://music.apple.com/jp/album/".concat(t.appleMusicAlbum.appleMusicId),target:"_blank",variant:"contained",color:"primary"},"Apple Music \u3067\u8074\u304f")))),(null===t||void 0===t?void 0:t.itunesAlbum)&&a.push(o.a.createElement($.a,{item:!0,key:1},o.a.createElement(p.a,{theme:Object(m.a)({palette:{primary:Xe.a}})},o.a.createElement(Je.a,{href:"https://music.apple.com/jp/album/".concat(t.itunesAlbum.appleMusicId),target:"_blank",variant:"contained",color:"primary"},"iTunes \u3067\u8074\u304f")))),(null===t||void 0===t?void 0:t.spotifyAlbum)&&a.push(o.a.createElement($.a,{item:!0,key:2},o.a.createElement(p.a,{theme:Object(m.a)({palette:{primary:Be.a}})},o.a.createElement(Je.a,{href:"https://open.spotify.com/album/".concat(t.spotifyAlbum.spotifyId),target:"_blank",variant:"contained",color:"primary"},"Spotify \u3067\u8074\u304f")))),o.a.createElement($.a,{container:!0,spacing:2,direction:"row",justify:"center",alignItems:"center"},a)},Ke=Object(i.createContext)({});!function(e){e[e.None=0]="None",e[e.Play=1]="Play",e[e.Pause=2]="Pause",e[e.Stop=3]="Stop"}(K||(K={})),function(e){e[e.None=0]="None",e[e.Loading=1]="Loading",e[e.Done=2]="Done"}(Z||(Z={}));var Ze={player:new He({linkUrl:"",tracks:[]}),currentNo:0,playbackStatus:K.None,loadingStatus:Z.Done},et=function(e,t){switch(t.type){case"SET_PLAYER":return e.player.stop(),Object(D.a)({},e,{player:t.player,playbackStatus:K.Stop});case"PLAY":e.player.play(t.no);var a=void 0===t.no?e.currentNo:t.no;return Object(D.a)({},e,{playbackStatus:K.Play,currentNo:a});case"NEXT_PLAY":return Object(_e.a)(We.a.mark((function t(){return We.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:return t.next=2,e.player.nextPlay();case 2:return t.abrupt("return",t.sent);case 3:case"end":return t.stop()}}),t)})))(),Object(D.a)({},e,{currentNo:e.player.currentPlaybackNo,playbackStatus:K.Play});case"PAUSE":return e.player.pause(),Object(D.a)({},e,{playbackStatus:K.Pause});case"STOP":return e.player.stop(),Object(D.a)({},e,{playbackStatus:K.Play});case"LOADING_START":return Object(D.a)({},e,{loadingStatus:Z.Loading});case"LOADING_DONE":return Object(D.a)({},e,{loadingStatus:Z.Done});case"STATUS_FINISH":return Object(D.a)({},e,{currentNo:e.player.currentPlaybackNo,playbackStatus:K.Pause,loadingStatus:Z.Done});default:return e}},tt=function(e){var t=e.children,a=Object(i.useReducer)(et,Ze),n=Object(h.a)(a,2),r=n[0],c=n[1];return o.a.createElement(Ke.Provider,{value:{state:r,dispatch:c}},t)},at=Ke,nt=a(186),rt=a(59),ct=a.n(rt),lt=Object(nt.a)((function(e){return{"@keyframes playing-icon-spin":{from:{transform:"rotate(0deg)"},to:{transform:"rotate(360deg)"}},playingIcon:{height:24,width:24,animationName:"$playing-icon-spin",animationDuration:"2000ms",animationIterationCount:"infinite",animationTimingFunction:"linear"}}})),it=function(e){var t,a=e.track,n=e.index,r=e.playAction,c=lt(),l=Object(i.useContext)(at).state,u=null!==a.previewUrl,s=l.playbackStatus===K.Play,m=n===l.currentNo&&a.id===(null===(t=l.player.currentTrack())||void 0===t?void 0:t.id),p=o.a.createElement(be.a,{color:"primary",className:c.playingIcon,component:function(e){return o.a.createElement("svg",e,o.a.createElement("defs",null,o.a.createElement("linearGradient",{id:"gradient1"},s?o.a.createElement(o.a.Fragment,null,o.a.createElement("stop",{offset:"10%",stopColor:"#4AC6D2"}),o.a.createElement("stop",{offset:"90%",stopColor:"#F2D349"})):o.a.createElement("stop",{offset:"100%",stopColor:"#4AC6D2"}))),o.a.cloneElement(e.children[0],{fill:"url(#gradient1)"}))}});return o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center"},u?m?o.a.createElement(de.a,{component:"span"},p):o.a.createElement(de.a,{onClick:function(){return r(n)},component:"span"},o.a.createElement(ct.a,null)):o.a.createElement(o.a.Fragment,null)),o.a.createElement(Re.a,null,a.name))},ot=function(e){var t=e.album,a=Object(i.useContext)(at).dispatch,n=Object(f.g)(),r=t.tracks.map((function(e){return e.durationMs})).reduce((function(e,t){return e+t})),c=new Intl.DateTimeFormat("jp",{year:"numeric"}).formatToParts(new Date(t.releaseDate)),l=Object(h.a)(c,2),u=l[0].value,s=l[1].value,m="".concat(u).concat(s),p=Object(i.useRef)(!0),d=function(e){if(p.current){var r=new He({linkUrl:"".concat(n.pathname).concat(n.search),tracks:t.tracks,dispatch:a});a({type:"SET_PLAYER",player:r}),p.current=!1}console.log("dispatch PLAY"),a({type:"PLAY",no:e})};return o.a.createElement(Me.a,{component:Le.a,style:{maxWidth:"600px"}},o.a.createElement(De.a,{size:"small"},o.a.createElement(Ue.a,null,o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center",colSpan:2,style:{border:"none"}},o.a.createElement($.a,{container:!0,justify:"center",alignItems:"center"},o.a.createElement(z,{title:"",src:t.artworkL.url,width:"250px"})))),o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center",colSpan:2,style:{border:"none"}},t.name)),o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center",colSpan:2,style:{border:"none"}},"".concat(m,"\u767a\u58f2\u3001").concat(t.totalTracks,"\u66f2\u3001").concat(function(e){var t=parseInt((e/1e3).toFixed(0)),a=parseInt((e/6e4).toFixed(0)),n=parseInt((e/36e5).toFixed(0)),r=parseInt((e/864e5).toFixed(0));return t<60?t+"\u79d2":a<60?a+"\u5206":n<24?n+"\u6642\u9593":r+"\u65e5"}(r)))),o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center",colSpan:2},o.a.createElement(Ve,{album:t}))),o.a.createElement(Te.a,null,o.a.createElement(Re.a,{align:"center"},"\u8a66\u8074"),o.a.createElement(Re.a,null,"\u30bf\u30a4\u30c8\u30eb"))),o.a.createElement($e.a,null,t.tracks.map((function(e,t){return o.a.createElement(it,{key:t,track:e,index:t,playAction:d})})))))},ut=function(){var e,t=Object(f.h)().id,a=(e={variables:{id:t}},g.c(A,e)),n=a.loading,r=a.error,c=a.data;if(r)return o.a.createElement("div",null,r.message);var l=o.a.createElement(o.a.Fragment,null);if(!n&&c&&c.album){var i=o.a.createElement(ot,{album:c.album});l=o.a.createElement($.a,{container:!0,direction:"column",justify:"center",alignItems:"center",spacing:2},o.a.createElement($.a,{item:!0},i),o.a.createElement($.a,{item:!0},o.a.createElement(Fe,null)))}return o.a.createElement($.a,{container:!0,spacing:1,direction:"column",justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0},l))},st=function(){var e=Object(f.h)().id,t=Object(g.c)(N,{variables:{id:e}}),a=t.error,n=t.data;if(a)return o.a.createElement("div",null,a.message);var r=o.a.createElement(o.a.Fragment,null);return n&&n.artist&&(r=o.a.createElement(z,{title:n.artist.name,src:n.artist.artworkL.url,width:270})),o.a.createElement($.a,{container:!0,spacing:2,direction:"column",justify:"center",alignItems:"center"},r,o.a.createElement($.a,{item:!0},o.a.createElement(oe,null)))},mt=a(178),pt=a(196),dt=function(){var e,t=Object(i.useState)(o.a.createElement(o.a.Fragment,null)),a=Object(h.a)(t,2),n=a[0],r=a[1],c=Object(i.useState)(""),l=Object(h.a)(c,2),u=l[0],s=l[1],m=Object(i.useState)(""),p=Object(h.a)(m,2),d=p[0],E=p[1],f=(e={update:function(e,t){t.data.signin.error?r(o.a.createElement(pt.a,{severity:"error"},t.data.signin.error)):r(o.a.createElement(pt.a,{severity:"success"},"\u30ed\u30b0\u30a4\u30f3\u3057\u307e\u3057\u305f"))},variables:{input:{username:u,password:d}}},g.b(L,e)),b=Object(h.a)(f,1)[0];return o.a.createElement($.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},o.a.createElement("form",{autoComplete:"off"},o.a.createElement("div",null,o.a.createElement(te.a,null,o.a.createElement(ae.a,null,"\u30e6\u30fc\u30b6\u30fc\u540d"),o.a.createElement(mt.a,{value:u,onChange:function(e){return s(e.target.value||"")}}))),o.a.createElement("div",null,o.a.createElement(te.a,null,o.a.createElement(ae.a,null,"\u30d1\u30b9\u30ef\u30fc\u30c9"),o.a.createElement(mt.a,{value:d,onChange:function(e){return E(e.target.value||"")},type:"password"}))),o.a.createElement("div",null,o.a.createElement(Je.a,{type:"submit",onClick:function(e){e.preventDefault(),b()},variant:"contained"},"Signin")),o.a.createElement("div",null,n)))},Et=function(){var e,t=Object(i.useState)(o.a.createElement(o.a.Fragment,null)),a=Object(h.a)(t,2),n=a[0],r=a[1],c=Object(i.useState)(""),l=Object(h.a)(c,2),u=l[0],s=l[1],m=Object(i.useState)(""),p=Object(h.a)(m,2),d=p[0],E=p[1],f=Object(i.useState)(""),b=Object(h.a)(f,2),y=b[0],v=b[1],k=Object(i.useState)(""),j=Object(h.a)(k,2),w=j[0],O=j[1],S=Object(i.useState)({oldPassword:y}),x=Object(h.a)(S,2),P=x[0],A=x[1],I=g.c(F,e).data;""===u&&""===d&&I&&I.me&&(s(I.me.name),E(I.me.username));var N=[];I&&I.me&&(N=I.me.role.allowedActions.map((function(e,t){return o.a.createElement("p",{key:t},e)})));var C=function(e){return g.b(M,e)}({update:function(e,t){t.data.updateMe.error?r(o.a.createElement(pt.a,{severity:"error"},t.data.updateMe.error)):r(o.a.createElement(pt.a,{severity:"success"},"\u66f4\u65b0\u3057\u307e\u3057\u305f"))},variables:{input:P}}),L=Object(h.a)(C,1)[0];return o.a.createElement($.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},o.a.createElement("form",{autoComplete:"off"},o.a.createElement("div",null,"ID: ",I&&I.me?I.me.id:""),o.a.createElement("div",null,o.a.createElement(te.a,null,o.a.createElement(ae.a,null,"\u540d\u524d"),o.a.createElement(mt.a,{value:u,onChange:function(e){s(e.target.value||""),A(Object(D.a)({},P,{name:e.target.value||""}))}}))),o.a.createElement("div",null,o.a.createElement(te.a,null,o.a.createElement(ae.a,null,"\u30e6\u30fc\u30b6\u30fc\u540d"),o.a.createElement(mt.a,{value:d,onChange:function(e){E(e.target.value||""),A(Object(D.a)({},P,{username:e.target.value||""}))}}))),o.a.createElement("div",null,o.a.createElement(te.a,null,o.a.createElement(ae.a,null,"\u65b0\u3057\u3044\u30d1\u30b9\u30ef\u30fc\u30c9"),o.a.createElement(mt.a,{value:w,onChange:function(e){O(e.target.value||""),A(Object(D.a)({},P,{newPassword:e.target.value||""}))},type:"password"}))),o.a.createElement("div",null,o.a.createElement(te.a,{required:!0},o.a.createElement(ae.a,null,"\u53e4\u3044\u30d1\u30b9\u30ef\u30fc\u30c9"),o.a.createElement(mt.a,{value:y,onChange:function(e){v(e.target.value||""),A(Object(D.a)({},P,{oldPassword:e.target.value||""}))},type:"password"}))),o.a.createElement("div",null,o.a.createElement(Je.a,{type:"submit",onClick:function(e){e.preventDefault(),L()},variant:"contained"},"Update")),o.a.createElement("div",null,n),o.a.createElement("div",null,"\u6a29\u9650: ",N)))},ft=a(193),ht=a(112),bt=a.n(ht),yt=a(111),vt=a.n(yt),gt=a(87),kt=a.n(gt),jt=Object(nt.a)((function(e){return{"@keyframes loading-icon-spin":{from:{transform:"rotate(0deg)"},to:{transform:"rotate(360deg)"}},loadingIcon:{height:35,width:35,animationName:"$loading-icon-spin",animationDuration:"2000ms",animationIterationCount:"infinite",animationTimingFunction:"linear"}}})),wt=function(){var e=Object(i.useContext)(at),t=e.state,a=e.dispatch,n=jt(),r=o.a.createElement(o.a.Fragment,null),c=o.a.createElement(de.a,{color:"inherit",onClick:function(){return a({type:"NEXT_PLAY"})}},o.a.createElement(kt.a,{fontSize:"large"}));if(t.loadingStatus===Z.Loading)c=r=o.a.createElement(de.a,{"aria-label":"loading",disabled:!0},o.a.createElement(vt.a,{className:n.loadingIcon}));else switch(t.playbackStatus){case K.None:r=o.a.createElement(de.a,{color:"inherit",disabled:!0},o.a.createElement(ct.a,{fontSize:"large"})),c=o.a.createElement(de.a,{color:"inherit",disabled:!0},o.a.createElement(kt.a,{fontSize:"large"}));break;case K.Play:r=o.a.createElement(de.a,{color:"inherit",onClick:function(){return a({type:"PAUSE"})}},o.a.createElement(bt.a,{fontSize:"large"}));break;case K.Pause:r=o.a.createElement(de.a,{color:"inherit",onClick:function(){return a({type:"PLAY"})}},o.a.createElement(ct.a,{fontSize:"large"}));break;case K.Stop:r=o.a.createElement(de.a,{color:"inherit",onClick:function(){return a({type:"PLAY",no:0})}},o.a.createElement(ct.a,{fontSize:"large"}))}var l=o.a.createElement(o.a.Fragment,null),u=o.a.createElement(o.a.Fragment,null);if(t.player.tracks[t.currentNo]){var s,m=t.player.tracks[t.currentNo];(null===(s=m.artworkM)||void 0===s?void 0:s.url)&&(l=o.a.createElement(z,{linkUrl:"".concat(t.player.linkUrl,"#").concat(m.id),title:"",src:m.artworkM.url,width:"40px"})),u=o.a.createElement(_.a,{style:{overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"},variant:"caption",component:"p"},m.name)}return o.a.createElement($.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"center"},o.a.createElement($.a,{item:!0,xs:5},o.a.createElement($.a,{container:!0,direction:"row",justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0,xs:1}),o.a.createElement($.a,{item:!0,xs:3},l),o.a.createElement($.a,{item:!0,xs:1}),o.a.createElement($.a,{item:!0,xs:7},u))),o.a.createElement($.a,{item:!0,xs:2},o.a.createElement($.a,{container:!0,justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0},r))),o.a.createElement($.a,{item:!0,xs:2},o.a.createElement($.a,{container:!0,justify:"center",alignItems:"center"},o.a.createElement($.a,{item:!0},c))),o.a.createElement($.a,{item:!0,xs:2}),o.a.createElement($.a,{item:!0,xs:1}))},Ot=function(){return o.a.createElement(me.a,{position:"fixed",color:"secondary",style:{top:"auto",bottom:0}},o.a.createElement(wt,null))},St=function(){return o.a.createElement(E.a,null,o.a.createElement(ge.a,{client:Ne},o.a.createElement(tt,null,o.a.createElement(ve,null),o.a.createElement(Ot,null),o.a.createElement(ft.a,{style:{flexGrow:1}},o.a.createElement($.a,{container:!0,direction:"column",justify:"center",alignItems:"center",spacing:1},o.a.createElement($.a,{item:!0},o.a.createElement(pe.a,null)),o.a.createElement($.a,{item:!0},o.a.createElement(f.c,null,o.a.createElement(f.a,{exact:!0,path:"/",component:oe}),o.a.createElement(f.a,{exact:!0,path:"/artists",component:Fe}),o.a.createElement(f.a,{exact:!0,path:"/artists/:id",component:st}),o.a.createElement(f.a,{exact:!0,path:"/albums",component:oe}),o.a.createElement(f.a,{exact:!0,path:"/albums/:id",component:ut}),o.a.createElement(f.a,{exact:!0,path:"/signin",component:dt}),o.a.createElement(f.a,{exact:!0,path:"/me",component:Et}))),o.a.createElement($.a,{item:!0},o.a.createElement(pe.a,null)))))))},xt=Object(m.a)({palette:{type:"dark",primary:{main:"#222222"},secondary:{main:"#4AC6D2"}},typography:{fontFamily:['"Noto Sans JP"',"Roboto",'"Helvetica Neue"',"Arial","sans-serif",'"Apple Color Emoji"','"Segoe UI Emoji"','"Segoe UI Symbol"'].join(",")}}),Pt=function(){return o.a.createElement(p.a,{theme:xt},o.a.createElement(d.a,null),o.a.createElement("link",{href:"https://fonts.googleapis.com/css?family=Noto+Sans+JP",rel:"stylesheet"}),o.a.createElement(St,null))};Boolean("localhost"===window.location.hostname||"[::1]"===window.location.hostname||window.location.hostname.match(/^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$/));var At=function(){return o.a.createElement(Pt,null)};"serviceWorker"in navigator&&navigator.serviceWorker.ready.then((function(e){e.unregister()})),s.a.render(o.a.createElement(At,null),document.querySelector("#app"))}},[[120,1,2]]]);
//# sourceMappingURL=main.ab97fcfa.chunk.js.map