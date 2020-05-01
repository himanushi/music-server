(this["webpackJsonpmusic-client"]=this["webpackJsonpmusic-client"]||[]).push([[0],{105:function(e,t,a){"use strict";a.r(t);var n,r,l=a(0),i=a.n(l),c=a(27),o=a.n(c),u=a(85),m=a(139),s=a(140),d=a(26),p=a(30),f=a(20),E=a(32),b=a(33),g=a.n(b),h=a(14);function v(){var e=Object(E.a)(["\n    mutation Signin($input: SigninInput!) {\n  signin(input: $input) {\n    error\n  }\n}\n    "]);return v=function(){return e},e}function y(){var e=Object(E.a)(["\n    mutation UpdateMe($input: UpdateMeInput!) {\n  updateMe(input: $input) {\n    currentUser {\n      id\n      username\n      name\n    }\n    error\n  }\n}\n    "]);return y=function(){return e},e}function w(){var e=Object(E.a)(["\n    query Me {\n  me {\n    id\n    name\n    username\n    role {\n      id\n      name\n      description\n      allowedActions\n    }\n  }\n}\n    "]);return w=function(){return e},e}function j(){var e=Object(E.a)(["\n    query Artists($offset: Int, $limit: PositiveNumber, $order: ArtistsQueryOrder!, $asc: Boolean) {\n  items: artists(offset: $offset, limit: $limit, order: $order, asc: $asc) {\n    id\n    name\n    artworkM {\n      url\n      width\n      height\n    }\n  }\n}\n    "]);return j=function(){return e},e}function O(){var e=Object(E.a)(["\n    query Artist($id: TTID!) {\n  artist(id: $id) {\n    id\n    name\n    artworkL {\n      url\n      width\n      height\n    }\n  }\n}\n    "]);return O=function(){return e},e}function k(){var e=Object(E.a)(["\n    query Albums($conditions: AlbumsConditions, $offset: Int, $limit: PositiveNumber, $order: AlbumsQueryOrder!, $asc: Boolean) {\n  items: albums(conditions: $conditions, offset: $offset, limit: $limit, order: $order, asc: $asc) {\n    id\n    artworkM {\n      url\n      width\n      height\n    }\n    appleMusicAlbum {\n      id\n    }\n    itunesAlbum {\n      id\n    }\n    spotifyAlbum {\n      id\n    }\n  }\n}\n    "]);return k=function(){return e},e}function A(){var e=Object(E.a)(["\n    query Album($id: TTID!) {\n  album(id: $id) {\n    id\n    totalTracks\n    name\n    releaseDate\n    artworkL {\n      url\n      width\n      height\n    }\n    artworkM {\n      url\n      width\n      height\n    }\n    appleMusicAlbum {\n      id\n      appleMusicId\n    }\n    itunesAlbum {\n      id\n      appleMusicId\n    }\n    spotifyAlbum {\n      id\n      spotifyId\n    }\n  }\n}\n    "]);return A=function(){return e},e}!function(e){e.Name="NAME",e.New="NEW",e.Release="RELEASE",e.Popularity="POPULARITY",e.TotalTracks="TOTAL_TRACKS"}(n||(n={})),function(e){e.New="NEW",e.Popularity="POPULARITY"}(r||(r={}));var I=g()(A());var M=g()(k());var $=g()(O());var S=g()(j());var x=g()(w());var P=g()(y());var C=g()(v());var L=a(131),T=a(128),F=function(e){var t=e.className,a=void 0===t?"":t,n=e.src,r=void 0===n?"":n,l=e.title,c=void 0===l?"":l,o=e.width;return""===r&&(r="".concat("","/no_image.png")),i.a.createElement(T.a,{className:a,image:r,title:c,style:{width:o,height:o}})},N=a(130),U=a(132),R=function(e){var t=e.linkUrl?{component:d.b,to:e.linkUrl}:{};return i.a.createElement(N.a,Object(f.a)({container:!0,item:!0,xs:!0,direction:"row",justify:"center",alignItems:"center"},t,{children:i.a.createElement(L.a,{style:{width:e.width,position:"relative"}},i.a.createElement(U.a,null,i.a.createElement(N.a,{container:!0,style:{position:"absolute",left:"5px",bottom:"5px"}},e.componentInImage?e.componentInImage:i.a.createElement(i.a.Fragment,null)),i.a.createElement(F,{src:e.src||"",width:e.width,title:e.title})))}))},q=function(e){var t=e.album,a=e.width,n={width:"15px",height:"15px",borderRadius:"50%",fontSize:"10px",color:"#fff",lineHeight:"15px",textAlign:"center",background:"#000"},r=[];t.appleMusicAlbum&&r.push(i.a.createElement(N.a,{item:!0,style:Object(f.a)({},n,{backgroundColor:"#ff2f56"})},"A")),t.itunesAlbum&&r.push(i.a.createElement(N.a,{item:!0,style:Object(f.a)({},n,{backgroundColor:"#0070c9"})},"iT")),t.spotifyAlbum&&r.push(i.a.createElement(N.a,{item:!0,style:Object(f.a)({},n,{backgroundColor:"#1DB954"})},"S"));var l=i.a.createElement(i.a.Fragment,null,r);return i.a.createElement(R,{title:t.name,src:t.artworkM.url,width:a,linkUrl:"/albums/".concat(t.id),componentInImage:l})},D=a(63),B=a(22),Q=a(81),J=function(e){var t=e.component,a=e.no,n=e.offset,r=e.limit,c=e.fetchMore,o=Object(l.useState)(!1),u=Object(B.a)(o,2),m=u[0],s=u[1],d=a===n-r;return i.a.createElement(i.a.Fragment,null,t,d?i.a.createElement(Q.a,{onEnter:function(){if(!m)return s(!0),c({variables:{offset:n},updateQuery:function(e,t){var a=t.fetchMoreResult;return a?Object(f.a)({},e,{},{items:[].concat(Object(D.a)(e.items),Object(D.a)(a.items))}):e}})}}):i.a.createElement(i.a.Fragment,null))},z=a(58),H=a.n(z);var W=function(){var e,t=function(){var e=Object(p.f)(),t=new URLSearchParams(e.search),a={};return function(e){var a=t.get(e);if(null===a)return[];var n=a.split(","),r=new Set;return n.forEach((function(e){r.add(e)})),Array.from(r)}("q").forEach((function(e){switch(!0){case/^art/.test(e):a=H.a.merge(a,{artists:{id:[e]}});break;case/^abm/.test(e):a=H.a.merge(a,{albums:{id:[e]}});break;case/^trk/.test(e):a=H.a.merge(a,{tracks:{id:[e]}})}})),a}(),a=(e={variables:Object(f.a)({offset:0,limit:50,order:n.Release,asc:!0},{conditions:t}),fetchPolicy:"cache-first"},h.c(M,e)),r=a.error,l=a.data,c=a.fetchMore;if(r)return i.a.createElement("div",null,r.message);var o=[];return l&&(o=l.items.map((function(e,t){return i.a.createElement(J,{key:t,component:i.a.createElement(q,{album:e,width:"150px",key:t}),no:t,offset:l.items.length,limit:50,fetchMore:c})}))),i.a.createElement(N.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},o)},Y=a(133),_=a(142),G=a(134),K=a(135),V=a(136),X=a(137),Z=a(82),ee=a.n(Z),te=a(83),ae=a.n(te),ne=function(e){var t=e.children,a=e.window,n=Object(Y.a)({target:a?a():void 0});return i.a.createElement(_.a,{appear:!1,direction:"down",in:!n},t)},re=function(){return i.a.createElement(i.a.Fragment,null,i.a.createElement(ne,null,i.a.createElement(G.a,null,i.a.createElement(K.a,null,i.a.createElement(N.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"center",spacing:3},i.a.createElement(N.a,{item:!0},i.a.createElement(V.a,{variant:"h6"},"\u30b2\u30fc\u30e0\u97f3\u697d")),i.a.createElement(N.a,{item:!0},i.a.createElement(X.a,{component:d.b,to:"/artists",edge:"start",size:"small",color:"inherit","aria-label":"menu"},i.a.createElement(ee.a,null),"\u30a2\u30fc\u30c6\u30a3\u30b9\u30c8")),i.a.createElement(N.a,{item:!0},i.a.createElement(X.a,{component:d.b,to:"/albums",edge:"start",size:"small",color:"inherit","aria-label":"menu"},i.a.createElement(ae.a,null),"\u30a2\u30eb\u30d0\u30e0")))))),i.a.createElement(K.a,{style:{margin:"4px"}}))},le=a(16),ie=a(31),ce=a(17),oe=a(87),ue=a(86),me=a(84),se=new oe.a({uri:"https://video-game-music.net/graphql",credentials:"include"}),de=new ce.a((function(e,t){return t(e)})),pe=Object(me.a)((function(e){var t=e.graphQLErrors,a=e.networkError;t&&t.map((function(e){var t=e.message,a=e.locations,n=e.path;return console.log("[GraphQL error]: Message: ".concat(t,", Location: ").concat(a,", Path: ").concat(n))})),a&&console.log("[Network error]: ".concat(a))})),fe=ce.a.from([de,se,pe]),Ee=new ie.a({link:fe,cache:new ue.a({dataIdFromObject:function(e){return e.id}})}),be=function(){var e,t=Object(p.g)().id,a=(e={variables:{id:t}},h.c(I,e)),n=a.loading,r=a.error,l=a.data;if(r)return i.a.createElement("div",null,r.message);var c=i.a.createElement(i.a.Fragment,null),o=function(e){var t=e.target;return t.style.width=document.documentElement.scrollWidth+"px",t.style.height=document.documentElement.scrollHeight-70+"px",e};if(n||!l);else if(l.album){var u=i.a.createElement(i.a.Fragment,null);l.album.appleMusicAlbum?u=i.a.createElement("iframe",{onLoad:function(e){return o(e)},title:l.album.id,allow:"autoplay *; encrypted-media *;",frameBorder:"0",width:"660",height:"500",style:{overflow:"hidden",background:"transparent"},src:"https://embed.music.apple.com/jp/album/game/".concat(l.album.appleMusicAlbum.appleMusicId,"?app=music")}):l.album.itunesAlbum?u=i.a.createElement("iframe",{onLoad:function(e){return o(e)},title:l.album.id,src:"https://tools.applemusic.com/embed/v1/album/".concat(l.album.itunesAlbum.appleMusicId,"?country=jp"),frameBorder:"0",width:"660",height:"500"}):l.album.spotifyAlbum&&(u=i.a.createElement("iframe",{onLoad:function(e){return o(e)},title:l.album.id,src:"https://open.spotify.com/embed/album/".concat(l.album.spotifyAlbum.spotifyId),width:"660",height:"500",frameBorder:"0",allowTransparency:!0,allow:"encrypted-media"})),c=i.a.createElement(i.a.Fragment,null,u)}return i.a.createElement(N.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},c)},ge=function(e){var t=e.artist,a=e.width,n=i.a.createElement("span",{style:{color:"black"}},t.name);return i.a.createElement(R,{title:t.name,src:t.artworkM.url,width:a,linkUrl:"/artists/".concat(t.id,"?q=").concat(t.id),componentInImage:n})},he=function(){var e=Object(h.c)(S,{variables:{offset:0,limit:30,order:"POPULARITY",asc:!1},fetchPolicy:"cache-first"}),t=e.error,a=e.data,n=e.fetchMore;if(t)return i.a.createElement("div",null,t.message);var r=[];return a&&(r=a.items.map((function(e,t){return i.a.createElement(J,{key:t,component:i.a.createElement(ge,{artist:e,width:"150px",key:t}),no:t,offset:a.items.length,limit:30,fetchMore:n})}))),i.a.createElement(N.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},r)},ve=function(){var e=Object(p.g)().id,t=Object(h.c)($,{variables:{id:e}}),a=t.error,n=t.data;if(a)return i.a.createElement("div",null,a.message);var r=i.a.createElement(i.a.Fragment,null);return n&&n.artist&&(r=i.a.createElement(N.a,null,i.a.createElement(R,{title:n.artist.name,src:n.artist.artworkL.url,width:270}),i.a.createElement("div",{style:{padding:"4px 0"}}),i.a.createElement(W,null))),i.a.createElement(N.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},r)},ye=a(145),we=a(143),je=a(144),Oe=a(138),ke=a(141),Ae=function(){var e,t=Object(l.useState)(i.a.createElement(i.a.Fragment,null)),a=Object(B.a)(t,2),n=a[0],r=a[1],c=Object(l.useState)(""),o=Object(B.a)(c,2),u=o[0],m=o[1],s=Object(l.useState)(""),d=Object(B.a)(s,2),p=d[0],f=d[1],E=(e={update:function(e,t){t.data.signin.error?r(i.a.createElement(ke.a,{severity:"error"},t.data.signin.error)):r(i.a.createElement(ke.a,{severity:"success"},"\u30ed\u30b0\u30a4\u30f3\u3057\u307e\u3057\u305f"))},variables:{input:{username:u,password:p}}},h.b(C,e)),b=Object(B.a)(E,1)[0];return i.a.createElement(N.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},i.a.createElement("form",{autoComplete:"off"},i.a.createElement("div",null,i.a.createElement(ye.a,null,i.a.createElement(we.a,null,"\u30e6\u30fc\u30b6\u30fc\u540d"),i.a.createElement(je.a,{value:u,onChange:function(e){return m(e.target.value||"")}}))),i.a.createElement("div",null,i.a.createElement(ye.a,null,i.a.createElement(we.a,null,"\u30d1\u30b9\u30ef\u30fc\u30c9"),i.a.createElement(je.a,{value:p,onChange:function(e){return f(e.target.value||"")},type:"password"}))),i.a.createElement("div",null,i.a.createElement(Oe.a,{type:"submit",onClick:function(e){e.preventDefault(),b()},variant:"contained"},"Signin")),i.a.createElement("div",null,n)))},Ie=function(){var e,t=Object(l.useState)(i.a.createElement(i.a.Fragment,null)),a=Object(B.a)(t,2),n=a[0],r=a[1],c=Object(l.useState)(""),o=Object(B.a)(c,2),u=o[0],m=o[1],s=Object(l.useState)(""),d=Object(B.a)(s,2),p=d[0],E=d[1],b=Object(l.useState)(""),g=Object(B.a)(b,2),v=g[0],y=g[1],w=Object(l.useState)({}),j=Object(B.a)(w,2),O=j[0],k=j[1],A=h.c(x,e).data;""===u&&""===p&&A&&A.me&&(m(A.me.name),E(A.me.username));var I=[i.a.createElement(i.a.Fragment,null)];A&&A.me&&(I=A.me.role.allowedActions.map((function(e){return i.a.createElement("p",null,e)})));var M=function(e){return h.b(P,e)}({update:function(e,t){t.data.updateMe.error?r(i.a.createElement(ke.a,{severity:"error"},t.data.updateMe.error)):r(i.a.createElement(ke.a,{severity:"success"},"\u66f4\u65b0\u3057\u307e\u3057\u305f"))},variables:{input:O}}),$=Object(B.a)(M,1)[0];return i.a.createElement(N.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},i.a.createElement("form",{autoComplete:"off"},i.a.createElement("div",null,"ID: ",A&&A.me?A.me.id:""),i.a.createElement("div",null,i.a.createElement(ye.a,null,i.a.createElement(we.a,null,"\u540d\u524d"),i.a.createElement(je.a,{value:u,onChange:function(e){m(e.target.value||""),k(Object(f.a)({},O,{name:e.target.value||""}))}}))),i.a.createElement("div",null,i.a.createElement(ye.a,null,i.a.createElement(we.a,null,"\u30e6\u30fc\u30b6\u30fc\u540d"),i.a.createElement(je.a,{value:p,onChange:function(e){E(e.target.value||""),k(Object(f.a)({},O,{username:e.target.value||""}))}}))),i.a.createElement("div",null,i.a.createElement(ye.a,null,i.a.createElement(we.a,null,"\u30d1\u30b9\u30ef\u30fc\u30c9\u518d\u8a2d\u5b9a"),i.a.createElement(je.a,{value:v,onChange:function(e){y(e.target.value||""),k(Object(f.a)({},O,{password:e.target.value||""}))},type:"password"}))),i.a.createElement("div",null,i.a.createElement(Oe.a,{type:"submit",onClick:function(e){e.preventDefault(),$()},variant:"contained"},"Update")),i.a.createElement("div",null,n),i.a.createElement("div",null,"\u6a29\u9650: ",I)))},Me=function(){return i.a.createElement(d.a,null,i.a.createElement(le.a,{client:Ee},i.a.createElement(re,null),i.a.createElement(p.c,null,i.a.createElement(p.a,{exact:!0,path:"/artists",component:he}),i.a.createElement(p.a,{exact:!0,path:"/artists/:id",component:ve}),i.a.createElement(p.a,{exact:!0,path:"/albums",component:W}),i.a.createElement(p.a,{exact:!0,path:"/albums/:id",component:be}),i.a.createElement(p.a,{exact:!0,path:"/signin",component:Ae}),i.a.createElement(p.a,{exact:!0,path:"/me",component:Ie}))))},$e=Object(u.a)({palette:{type:"dark"},typography:{fontFamily:['"Noto Sans JP"',"Roboto",'"Helvetica Neue"',"Arial","sans-serif",'"Apple Color Emoji"','"Segoe UI Emoji"','"Segoe UI Symbol"'].join(",")}}),Se=function(){return i.a.createElement(m.a,{theme:$e},i.a.createElement(s.a,null),i.a.createElement("link",{href:"https://fonts.googleapis.com/css?family=Noto+Sans+JP",rel:"stylesheet"}),i.a.createElement(Me,null))},xe=function(){return i.a.createElement(Se,null)};o.a.render(i.a.createElement(xe,null),document.querySelector("#app"))},92:function(e,t,a){e.exports=a(105)}},[[92,1,2]]]);
//# sourceMappingURL=main.39c9487f.chunk.js.map