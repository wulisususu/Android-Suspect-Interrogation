if ('serviceWorker' in navigator) {
  if (!sessionStorage.getItem('sw_cleaned')) {
    sessionStorage.setItem('sw_cleaned', '1');
    caches.keys().then(function(keys) { keys.forEach(function(k) { caches.delete(k); }); });
    navigator.serviceWorker.getRegistrations().then(function(regs) {
      regs.forEach(function(r) { r.unregister(); });
      location.reload();
    });
  }
}