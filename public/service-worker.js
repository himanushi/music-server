const CACHE_NAME = "music-client-v4-1626836325";
const urlsToCache = [
  "./",
  "./index.js",
  "./index.css"
];
console.log(CACHE_NAME);
self.addEventListener("install", (event) => {
  event.waitUntil(caches.open(CACHE_NAME).then((cache) => cache.addAll(urlsToCache)));
});
self.addEventListener("fetch", (event) => {
  if (event.request.cache === "only-if-cached" && event.request.mode !== "same-origin") {
    return;
  }
  event.respondWith(caches.match(event.request).then((response) => {
    if (response) {
      return response;
    }
    return fetch(event.request);
  }));
});
self.addEventListener("activate", (event) => {
  event.waitUntil(caches.keys().then((keys) => Promise.all(keys.map((key) => {
    if (!CACHE_NAME.includes(key)) {
      return caches.delete(key);
    }
    return void 0;
  }))).then(() => {
    console.log(`${CACHE_NAME} : activated`);
  }));
});
