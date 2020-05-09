(this["webpackJsonpmusic-client"]=this["webpackJsonpmusic-client"]||[]).push([[0],{111:function(e,t,a){e.exports=a(124)},124:function(e,t,a){"use strict";a.r(t);var n,r,l,c,i=a(0),o=a.n(i),u=a(13),m=a.n(u),s=a(104),d=a(174),p=a(177),E=a(29),b=a(40),f=a(14),v=a(43),h=a(44),g=a.n(h),y=a(24);function j(){var e=Object(v.a)(["\n    mutation Signin($input: SigninInput!) {\n  signin(input: $input) {\n    error\n  }\n}\n    "]);return j=function(){return e},e}function w(){var e=Object(v.a)(["\n    mutation UpdateMe($input: UpdateMeInput!) {\n  updateMe(input: $input) {\n    currentUser {\n      id\n      username\n      name\n    }\n    error\n  }\n}\n    "]);return w=function(){return e},e}function O(){var e=Object(v.a)(["\n    query Me {\n  me {\n    id\n    name\n    username\n    role {\n      id\n      name\n      description\n      allowedActions\n    }\n  }\n}\n    "]);return O=function(){return e},e}function A(){var e=Object(v.a)(["\n    query Artists($cursor: CursorInputObject, $sort: ArtistsSortInputObject, $conditions: ArtistsConditionsInputObject) {\n  items: artists(cursor: $cursor, sort: $sort, conditions: $conditions) {\n    id\n    name\n    status\n    artworkM {\n      url\n      width\n      height\n    }\n  }\n}\n    "]);return A=function(){return e},e}function S(){var e=Object(v.a)(["\n    query Artist($id: TTID!) {\n  artist(id: $id) {\n    id\n    name\n    artworkL {\n      url\n      width\n      height\n    }\n  }\n}\n    "]);return S=function(){return e},e}function I(){var e=Object(v.a)(["\n    query Albums($cursor: CursorInputObject, $sort: AlbumsSortInputObject, $conditions: AlbumsConditionsInputObject) {\n  items: albums(cursor: $cursor, sort: $sort, conditions: $conditions) {\n    id\n    name\n    status\n    artworkM {\n      url\n      width\n      height\n    }\n    appleMusicAlbum {\n      id\n    }\n    itunesAlbum {\n      id\n    }\n    spotifyAlbum {\n      id\n    }\n  }\n}\n    "]);return I=function(){return e},e}function k(){var e=Object(v.a)(["\n    query Album($id: TTID!) {\n  album(id: $id) {\n    id\n    totalTracks\n    name\n    releaseDate\n    artworkL {\n      url\n      width\n      height\n    }\n    artworkM {\n      url\n      width\n      height\n    }\n    appleMusicAlbum {\n      id\n      appleMusicId\n    }\n    itunesAlbum {\n      id\n      appleMusicId\n    }\n    spotifyAlbum {\n      id\n      spotifyId\n    }\n  }\n}\n    "]);return k=function(){return e},e}!function(e){e.New="NEW",e.Release="RELEASE",e.Popularity="POPULARITY"}(n||(n={})),function(e){e.Name="NAME",e.New="NEW",e.Popularity="POPULARITY"}(r||(r={})),function(e){e.Asc="ASC",e.Desc="DESC"}(l||(l={})),function(e){e.Pending="PENDING",e.Active="ACTIVE",e.Ignore="IGNORE"}(c||(c={}));var C=g()(k());var M=g()(I());var x=g()(S());var P=g()(A());var F=g()(O());var N=g()(w());var L=g()(j());var $=a(17),R=a(163),U=a(158),D=function(e){var t=e.className,a=void 0===t?"":t,n=e.src,r=void 0===n?"":n,l=e.title,c=void 0===l?"":l,i=e.width;return""===r&&(r="".concat("","/no_image.png")),o.a.createElement(U.a,{className:a,image:r,title:c,style:{width:i,height:i}})},T=a(162),W=a(164),q=a(165),B=a(166),G=function(e){var t=e.linkUrl?{component:E.b,to:e.linkUrl}:{};return o.a.createElement(T.a,Object($.a)({container:!0,item:!0,xs:!0,direction:"row",justify:"center",alignItems:"center",style:{textDecoration:"none"}},t,{children:o.a.createElement(R.a,{style:{width:e.width,position:"relative"}},o.a.createElement(W.a,null,o.a.createElement(T.a,{container:!0,style:{position:"absolute",left:"5px",bottom:"5px"}},e.componentInImage?e.componentInImage:o.a.createElement(o.a.Fragment,null)),o.a.createElement(D,{src:e.src||"",width:e.width,title:e.title})),o.a.createElement(q.a,{style:{padding:"5px 5px"}},o.a.createElement(B.a,{style:{overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"},variant:"caption",color:"textSecondary",component:"p"},e.title)))}))},z=a(50),J=a.n(z),Y={album:"b",artist:"a"},_="i",H="s",Q="o",V="r";function K(e){var t=Object(b.g)(),a=new URLSearchParams(t.search),n=Y[e],r=function(e){var t=a.get(e);if(null===t)return[];var n=t.split(","),r=new Set;return n.forEach((function(e){r.add(e)})),Array.from(r)},l={};return r(n+_).forEach((function(e){switch(!0){case/^art/.test(e):l=J.a.merge(l,{conditions:{artists:{id:[e]}}});break;case/^abm/.test(e):l=J.a.merge(l,{conditions:{albums:{id:[e]}}});break;case/^trk/.test(e):l=J.a.merge(l,{conditions:{tracks:{id:[e]}}})}})),r(n+H).forEach((function(e){l=J.a.merge(l,{conditions:{status:[e]}})})),r(n+Q).forEach((function(e){l=J.a.merge(l,{sort:{order:e}})})),r(n+V).forEach((function(e){l=J.a.merge(l,{sort:{type:e}})})),l}var X=function(e){var t=e.album,a=e.width,n={width:"15px",height:"15px",borderRadius:"50%",fontSize:"10px",color:"#fff",lineHeight:"15px",textAlign:"center",background:"#000"},r=[];t.appleMusicAlbum&&r.push(o.a.createElement(T.a,{key:1,item:!0,style:Object($.a)({},n,{backgroundColor:"#ff2f56"})},"A")),t.itunesAlbum&&r.push(o.a.createElement(T.a,{key:2,item:!0,style:Object($.a)({},n,{backgroundColor:"#0070c9"})},"iT")),t.spotifyAlbum&&r.push(o.a.createElement(T.a,{key:3,item:!0,style:Object($.a)({},n,{backgroundColor:"#1DB954"})},"S")),t.status===c.Pending?r.push(o.a.createElement(T.a,{key:10,item:!0,style:Object($.a)({},n,{color:"#000",backgroundColor:"#FFFF00"})},"PN")):t.status===c.Ignore&&r.push(o.a.createElement(T.a,{key:11,item:!0,style:Object($.a)({},n,{color:"#000",backgroundColor:"#FF0000"})},"IG"));var l=o.a.createElement(o.a.Fragment,null,r),i=new URLSearchParams;return i.set(Y.artist+_,t.id),o.a.createElement(G,{title:t.name,src:t.artworkM.url,width:a,linkUrl:"/albums/".concat(t.id,"?").concat(i.toString()),componentInImage:l})},Z=a(167),ee=a(181),te=a(178),ae=a(182),ne=a(84),re=a(100),le=function(e){var t=e.component,a=e.no,n=e.offset,r=e.limit,l=e.fetchMore,c=Object(i.useState)(t),u=Object(f.a)(c,2),m=u[0],s=u[1],d=Object(i.useState)(!1),p=Object(f.a)(d,2),E=p[0],b=p[1],v=a===n-r;return o.a.createElement(o.a.Fragment,null,t,v?o.a.createElement(re.a,{onEnter:function(){if(!E||m!==t)return b(!0),s(t),l({variables:{cursor:{offset:n}},updateQuery:function(e,t){var a=t.fetchMoreResult;return a?Object($.a)({},e,{},{items:[].concat(Object(ne.a)(e.items),Object(ne.a)(a.items))}):e}})}}):o.a.createElement(o.a.Fragment,null))},ce=function(){var e,t,a,n=Object(i.useState)("RELEASE.DESC"),r=Object(f.a)(n,2),l=r[0],c=r[1],u=K("album"),m=Object(b.f)(),s=(a={variables:{cursor:{offset:0,limit:50},sort:u.sort,conditions:u.conditions},fetchPolicy:"cache-first"},y.c(M,a)),d=s.error,p=s.data,E=s.fetchMore,v=(null===u||void 0===u?void 0:u.sort)?"".concat(null===u||void 0===u||null===(e=u.sort)||void 0===e?void 0:e.order,".").concat(null===u||void 0===u||null===(t=u.sort)||void 0===t?void 0:t.type):null;if(v&&l!==v&&c(v),d)return o.a.createElement("div",null,d.message);var h=[];p&&(h=p.items.map((function(e,t){return o.a.createElement(T.a,{item:!0,key:t},o.a.createElement(le,{component:o.a.createElement(X,{album:e,width:"150px"}),no:t,offset:p.items.length,limit:50,fetchMore:E}))})));return o.a.createElement(T.a,{container:!0,direction:"column",justify:"center",alignItems:"center",spacing:1},o.a.createElement(T.a,{item:!0},o.a.createElement(T.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"flex-start"},o.a.createElement(T.a,null,o.a.createElement(Z.a,{variant:"outlined",style:{minWidth:150}},o.a.createElement(ee.a,{id:"demo-simple-select-outlined-label"},"\u30a2\u30eb\u30d0\u30e0\u8868\u793a\u9806"),o.a.createElement(te.a,{labelId:"demo-simple-select-outlined-label",id:"demo-simple-select-outlined",value:l,onChange:function(e,t){var a=e.target.value,n=a.split("."),r=Object(f.a)(n,2),l=r[0],i=r[1];c(a);var o=new URLSearchParams(m.location.search);o.set(Y.album+Q,l),o.set(Y.album+V,i),m.push("".concat(m.location.pathname,"?").concat(o.toString()))},label:"\u30a2\u30eb\u30d0\u30e0\u8868\u793a\u9806"},o.a.createElement(ae.a,{value:"RELEASE.DESC"},"\u767a\u58f2\u65e5\u65b0\u3057\u3044\u9806"),o.a.createElement(ae.a,{value:"RELEASE.ASC"},"\u767a\u58f2\u65e5\u53e4\u3044\u9806"),o.a.createElement(ae.a,{value:"NEW.DESC"},"\u8ffd\u52a0\u65e5\u65b0\u3057\u3044\u9806"),o.a.createElement(ae.a,{value:"NEW.ASC"},"\u8ffd\u52a0\u65e5\u53e4\u3044\u9806"),o.a.createElement(ae.a,{value:"POPULARITY.DESC"},"\u4eba\u6c17\u9806")))))),o.a.createElement(T.a,{item:!0},o.a.createElement(T.a,{container:!0,direction:"row",justify:"center",alignItems:"center",spacing:1},h)))},ie=a(169),oe=a(170),ue=a(171),me=a(172),se=a(173),de=a(101),pe=a.n(de),Ee=a(102),be=a.n(Ee),fe=function(e){var t=e.children,a=e.window,n=Object(ie.a)({target:a?a():void 0});return o.a.createElement(oe.a,{appear:!1,direction:"down",in:!n},t)},ve=function(){return o.a.createElement(o.a.Fragment,null,o.a.createElement(fe,null,o.a.createElement(ue.a,null,o.a.createElement(me.a,null,o.a.createElement(T.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"center",spacing:3},o.a.createElement(T.a,{item:!0},o.a.createElement(B.a,{variant:"h6"},"\u30b2\u30fc\u30e0\u97f3\u697d")),o.a.createElement(T.a,{item:!0},o.a.createElement(se.a,{component:E.b,to:"/artists",edge:"start",size:"small",color:"inherit","aria-label":"menu"},o.a.createElement(pe.a,null))),o.a.createElement(T.a,{item:!0},o.a.createElement(se.a,{component:E.b,to:"/albums",edge:"start",size:"small",color:"inherit","aria-label":"menu"},o.a.createElement(be.a,null))))))),o.a.createElement(me.a,{style:{margin:"4px"}}))},he=a(20),ge=a(41),ye=a(21),je=a(106),we=a(105),Oe=a(103),Ae=new je.a({uri:"https://video-game-music.net/graphql",credentials:"include"}),Se=new ye.a((function(e,t){return t(e)})),Ie=Object(Oe.a)((function(e){var t=e.graphQLErrors,a=e.networkError;t&&t.map((function(e){var t=e.message,a=e.locations,n=e.path;return console.log("[GraphQL error]: Message: ".concat(t,", Location: ").concat(a,", Path: ").concat(n))})),a&&console.log("[Network error]: ".concat(a))})),ke=ye.a.from([Se,Ie,Ae]),Ce=new ge.a({link:ke,cache:new we.a({dataIdFromObject:function(e){return e.id}})}),Me=a(175),xe=a(179),Pe=a(176),Fe=function(e){var t=e.artist,a=e.width,n=new URLSearchParams;n.set(Y.album+_,t.id);var r={width:"15px",height:"15px",borderRadius:"50%",fontSize:"10px",color:"#fff",lineHeight:"15px",textAlign:"center",background:"#000"},l=[];t.status===c.Pending?l.push(o.a.createElement(T.a,{key:10,item:!0,style:Object($.a)({},r,{color:"#000",backgroundColor:"#FFFF00"})},"PN")):t.status===c.Ignore&&l.push(o.a.createElement(T.a,{key:11,item:!0,style:Object($.a)({},r,{color:"#000",backgroundColor:"#FF0000"})},"IG"));var i=o.a.createElement(o.a.Fragment,null,l);return o.a.createElement(G,{title:t.name,src:t.artworkM.url,width:a,linkUrl:"/artists/".concat(t.id,"?").concat(n.toString()),componentInImage:i})},Ne=function(){var e,t,a,n=Object(i.useState)("NAME.ASC"),r=Object(f.a)(n,2),l=r[0],c=r[1],u=K("artist"),m=Object(b.f)(),s=(a={variables:{cursor:{offset:0,limit:30},sort:u.sort,conditions:u.conditions},fetchPolicy:"cache-first"},y.c(P,a)),d=s.error,p=s.data,E=s.fetchMore,v=(null===u||void 0===u?void 0:u.sort)?"".concat(null===u||void 0===u||null===(e=u.sort)||void 0===e?void 0:e.order,".").concat(null===u||void 0===u||null===(t=u.sort)||void 0===t?void 0:t.type):null;if(v&&l!==v&&c(v),d)return o.a.createElement("div",null,d.message);var h=[];p&&(h=p.items.map((function(e,t){return o.a.createElement(T.a,{item:!0,key:t},o.a.createElement(le,{component:o.a.createElement(Fe,{artist:e,width:"150px"}),no:t,offset:p.items.length,limit:30,fetchMore:E}))})));return o.a.createElement(T.a,{container:!0,spacing:1,direction:"column",justify:"center",alignItems:"center"},o.a.createElement(T.a,{item:!0},o.a.createElement(T.a,{container:!0,direction:"row",justify:"flex-start",alignItems:"flex-start"},o.a.createElement(T.a,null,o.a.createElement(Z.a,{variant:"outlined",style:{minWidth:150}},o.a.createElement(ee.a,{id:"demo-simple-select-outlined-label"},"\u30a2\u30fc\u30c6\u30a3\u30b9\u30c8\u8868\u793a\u9806"),o.a.createElement(te.a,{labelId:"demo-simple-select-outlined-label",id:"demo-simple-select-outlined",value:l,onChange:function(e,t){var a=e.target.value,n=a.split("."),r=Object(f.a)(n,2),l=r[0],i=r[1];c(a);var o=new URLSearchParams(m.location.search);o.set(Y.artist+Q,l),o.set(Y.artist+V,i),m.push("".concat(m.location.pathname,"?").concat(o.toString()))},label:"\u30a2\u30fc\u30c6\u30a3\u30b9\u30c8\u8868\u793a\u9806"},o.a.createElement(ae.a,{value:"NAME.ASC"},"\u540d\u524d\u6607\u9806"),o.a.createElement(ae.a,{value:"NAME.DESC"},"\u540d\u524d\u964d\u9806"),o.a.createElement(ae.a,{value:"NEW.DESC"},"\u8ffd\u52a0\u65e5\u65b0\u3057\u3044\u9806"),o.a.createElement(ae.a,{value:"NEW.ASC"},"\u8ffd\u52a0\u65e5\u53e4\u3044\u9806"),o.a.createElement(ae.a,{value:"POPULARITY.DESC"},"\u4eba\u6c17\u9806")))))),o.a.createElement(T.a,{item:!0},o.a.createElement(T.a,{container:!0,direction:"row",justify:"center",alignItems:"center",spacing:1},h)))},Le=a(74),$e=a(75),Re=a(76),Ue=function(){var e,t,a,n,r=Object(b.h)().id,l=(n={variables:{id:r}},y.c(C,n)),c=l.loading,i=l.error,u=l.data,m=o.a.useState(null),p=Object(f.a)(m,2),E=p[0],v=p[1];if(i)return o.a.createElement("div",null,i.message);var h=o.a.createElement(o.a.Fragment,null),g=function(e){return e.target.style.width=document.documentElement.scrollWidth+"px",e};if(!c&&u&&u.album){null===E&&(u.album.appleMusicAlbum?v(0):u.album.itunesAlbum?v(1):u.album.spotifyAlbum&&v(2));var j=[];u.album.appleMusicAlbum&&j.push(o.a.createElement(T.a,{item:!0,key:0},o.a.createElement(d.a,{theme:Object(s.a)({palette:{primary:Le.a}})},o.a.createElement(Me.a,{href:"https://music.apple.com/jp/album/".concat(u.album.appleMusicAlbum.appleMusicId),target:"_blank",variant:"contained",color:"primary"},"Apple Music \u3067\u8074\u304f")))),u.album.itunesAlbum&&j.push(o.a.createElement(T.a,{item:!0,key:1},o.a.createElement(d.a,{theme:Object(s.a)({palette:{primary:$e.a}})},o.a.createElement(Me.a,{href:"https://music.apple.com/jp/album/".concat(u.album.itunesAlbum.appleMusicId),target:"_blank",variant:"contained",color:"primary"},"iTunes \u3067\u8074\u304f")))),u.album.spotifyAlbum&&j.push(o.a.createElement(T.a,{item:!0,key:2},o.a.createElement(d.a,{theme:Object(s.a)({palette:{primary:Re.a}})},o.a.createElement(Me.a,{href:"https://open.spotify.com/album/".concat(u.album.spotifyAlbum.spotifyId),target:"_blank",variant:"contained",color:"primary"},"Spotify \u3067\u8074\u304f"))));var w=o.a.createElement(o.a.Fragment,null);u.album.appleMusicAlbum&&0===E&&(w=o.a.createElement("iframe",{onLoad:function(e){return g(e)},title:u.album.id,allow:"autoplay *; encrypted-media *;",width:"300",height:"500",frameBorder:"0",style:{overflow:"hidden",background:"transparent"},src:"https://embed.music.apple.com/jp/album/game/".concat(u.album.appleMusicAlbum.appleMusicId,"?app=music")})),u.album.itunesAlbum&&1===E&&(w=o.a.createElement("iframe",{onLoad:function(e){return g(e)},title:u.album.id,src:"https://tools.applemusic.com/embed/v1/album/".concat(u.album.itunesAlbum.appleMusicId,"?country=jp"),frameBorder:"0",width:"300",height:"500"})),u.album.spotifyAlbum&&2===E&&(w=o.a.createElement("iframe",{onLoad:function(e){return g(e)},title:u.album.id,src:"https://open.spotify.com/embed/album/".concat(u.album.spotifyAlbum.spotifyId),width:"300",height:"500",frameBorder:"0",allow:"encrypted-media"})),h=o.a.createElement(T.a,{container:!0,direction:"column",justify:"center",alignItems:"center",spacing:2},o.a.createElement(T.a,{item:!0},w),o.a.createElement(T.a,{item:!0},o.a.createElement(T.a,{container:!0,spacing:1,direction:"row"},j)),o.a.createElement(T.a,{item:!0},o.a.createElement(T.a,{container:!0},o.a.createElement(Ne,null))))}return o.a.createElement(T.a,{container:!0,spacing:1,direction:"column",justify:"center",alignItems:"center"},o.a.createElement(T.a,{item:!0},o.a.createElement(xe.a,{value:E||0,onChange:function(e,t){return v(t)},indicatorColor:"primary",textColor:"primary",variant:"fullWidth","aria-label":"full width tabs example"},o.a.createElement(Pe.a,{label:"Apple Music",disabled:!(null===u||void 0===u||null===(e=u.album)||void 0===e?void 0:e.appleMusicAlbum)}),o.a.createElement(Pe.a,{label:"iTunes",disabled:!(null===u||void 0===u||null===(t=u.album)||void 0===t?void 0:t.itunesAlbum)}),o.a.createElement(Pe.a,{label:"Spotify",disabled:!(null===u||void 0===u||null===(a=u.album)||void 0===a?void 0:a.spotifyAlbum)}))),o.a.createElement(T.a,{item:!0},h))},De=function(){var e=Object(b.h)().id,t=Object(y.c)(x,{variables:{id:e}}),a=t.error,n=t.data;if(a)return o.a.createElement("div",null,a.message);var r=o.a.createElement(o.a.Fragment,null);return n&&n.artist&&(r=o.a.createElement(T.a,{item:!0},o.a.createElement(G,{title:n.artist.name,src:n.artist.artworkL.url,width:270}))),o.a.createElement(T.a,{container:!0,spacing:2,direction:"column",justify:"center",alignItems:"center"},r,o.a.createElement(T.a,{item:!0},o.a.createElement(ce,null)))},Te=a(168),We=a(180),qe=function(){var e,t=Object(i.useState)(o.a.createElement(o.a.Fragment,null)),a=Object(f.a)(t,2),n=a[0],r=a[1],l=Object(i.useState)(""),c=Object(f.a)(l,2),u=c[0],m=c[1],s=Object(i.useState)(""),d=Object(f.a)(s,2),p=d[0],E=d[1],b=(e={update:function(e,t){t.data.signin.error?r(o.a.createElement(We.a,{severity:"error"},t.data.signin.error)):r(o.a.createElement(We.a,{severity:"success"},"\u30ed\u30b0\u30a4\u30f3\u3057\u307e\u3057\u305f"))},variables:{input:{username:u,password:p}}},y.b(L,e)),v=Object(f.a)(b,1)[0];return o.a.createElement(T.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},o.a.createElement("form",{autoComplete:"off"},o.a.createElement("div",null,o.a.createElement(Z.a,null,o.a.createElement(ee.a,null,"\u30e6\u30fc\u30b6\u30fc\u540d"),o.a.createElement(Te.a,{value:u,onChange:function(e){return m(e.target.value||"")}}))),o.a.createElement("div",null,o.a.createElement(Z.a,null,o.a.createElement(ee.a,null,"\u30d1\u30b9\u30ef\u30fc\u30c9"),o.a.createElement(Te.a,{value:p,onChange:function(e){return E(e.target.value||"")},type:"password"}))),o.a.createElement("div",null,o.a.createElement(Me.a,{type:"submit",onClick:function(e){e.preventDefault(),v()},variant:"contained"},"Signin")),o.a.createElement("div",null,n)))},Be=function(){var e,t=Object(i.useState)(o.a.createElement(o.a.Fragment,null)),a=Object(f.a)(t,2),n=a[0],r=a[1],l=Object(i.useState)(""),c=Object(f.a)(l,2),u=c[0],m=c[1],s=Object(i.useState)(""),d=Object(f.a)(s,2),p=d[0],E=d[1],b=Object(i.useState)(""),v=Object(f.a)(b,2),h=v[0],g=v[1],j=Object(i.useState)(""),w=Object(f.a)(j,2),O=w[0],A=w[1],S=Object(i.useState)({oldPassword:h}),I=Object(f.a)(S,2),k=I[0],C=I[1],M=y.c(F,e).data;""===u&&""===p&&M&&M.me&&(m(M.me.name),E(M.me.username));var x=[];M&&M.me&&(x=M.me.role.allowedActions.map((function(e,t){return o.a.createElement("p",{key:t},e)})));var P=function(e){return y.b(N,e)}({update:function(e,t){t.data.updateMe.error?r(o.a.createElement(We.a,{severity:"error"},t.data.updateMe.error)):r(o.a.createElement(We.a,{severity:"success"},"\u66f4\u65b0\u3057\u307e\u3057\u305f"))},variables:{input:k}}),L=Object(f.a)(P,1)[0];return o.a.createElement(T.a,{container:!0,spacing:1,direction:"row",justify:"center",alignItems:"center"},o.a.createElement("form",{autoComplete:"off"},o.a.createElement("div",null,"ID: ",M&&M.me?M.me.id:""),o.a.createElement("div",null,o.a.createElement(Z.a,null,o.a.createElement(ee.a,null,"\u540d\u524d"),o.a.createElement(Te.a,{value:u,onChange:function(e){m(e.target.value||""),C(Object($.a)({},k,{name:e.target.value||""}))}}))),o.a.createElement("div",null,o.a.createElement(Z.a,null,o.a.createElement(ee.a,null,"\u30e6\u30fc\u30b6\u30fc\u540d"),o.a.createElement(Te.a,{value:p,onChange:function(e){E(e.target.value||""),C(Object($.a)({},k,{username:e.target.value||""}))}}))),o.a.createElement("div",null,o.a.createElement(Z.a,null,o.a.createElement(ee.a,null,"\u65b0\u3057\u3044\u30d1\u30b9\u30ef\u30fc\u30c9"),o.a.createElement(Te.a,{value:O,onChange:function(e){A(e.target.value||""),C(Object($.a)({},k,{newPassword:e.target.value||""}))},type:"password"}))),o.a.createElement("div",null,o.a.createElement(Z.a,{required:!0},o.a.createElement(ee.a,null,"\u53e4\u3044\u30d1\u30b9\u30ef\u30fc\u30c9"),o.a.createElement(Te.a,{value:h,onChange:function(e){g(e.target.value||""),C(Object($.a)({},k,{oldPassword:e.target.value||""}))},type:"password"}))),o.a.createElement("div",null,o.a.createElement(Me.a,{type:"submit",onClick:function(e){e.preventDefault(),L()},variant:"contained"},"Update")),o.a.createElement("div",null,n),o.a.createElement("div",null,"\u6a29\u9650: ",x)))},Ge=function(){return o.a.createElement(E.a,null,o.a.createElement(he.a,{client:Ce},o.a.createElement(ve,null),o.a.createElement(T.a,{container:!0,direction:"column",justify:"center",alignItems:"center"},o.a.createElement(T.a,{item:!0},o.a.createElement(b.c,null,o.a.createElement(b.a,{exact:!0,path:"/",component:ce}),o.a.createElement(b.a,{exact:!0,path:"/artists",component:Ne}),o.a.createElement(b.a,{exact:!0,path:"/artists/:id",component:De}),o.a.createElement(b.a,{exact:!0,path:"/albums",component:ce}),o.a.createElement(b.a,{exact:!0,path:"/albums/:id",component:Ue}),o.a.createElement(b.a,{exact:!0,path:"/signin",component:qe}),o.a.createElement(b.a,{exact:!0,path:"/me",component:Be}))))))},ze=Object(s.a)({palette:{type:"dark"},typography:{fontFamily:['"Noto Sans JP"',"Roboto",'"Helvetica Neue"',"Arial","sans-serif",'"Apple Color Emoji"','"Segoe UI Emoji"','"Segoe UI Symbol"'].join(",")}}),Je=function(){return o.a.createElement(d.a,{theme:ze},o.a.createElement(p.a,null),o.a.createElement("link",{href:"https://fonts.googleapis.com/css?family=Noto+Sans+JP",rel:"stylesheet"}),o.a.createElement(Ge,null))};Boolean("localhost"===window.location.hostname||"[::1]"===window.location.hostname||window.location.hostname.match(/^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$/));var Ye=function(){return o.a.createElement(Je,null)};"serviceWorker"in navigator&&navigator.serviceWorker.ready.then((function(e){e.unregister()})),m.a.render(o.a.createElement(Ye,null),document.querySelector("#app"))}},[[111,1,2]]]);
//# sourceMappingURL=main.fea51f43.chunk.js.map