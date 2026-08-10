.class public Lanetwork/channel/cookie/CookieManager;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanetwork/channel/cookie/CookieManager$a;
    }
.end annotation


# static fields
.field public static final TAG:Ljava/lang/String; = "anet.CookieManager"

.field private static volatile a:Z = false

.field private static b:Landroid/webkit/CookieManager; = null

.field private static c:Z = true

.field private static d:Lanetwork/channel/cookie/CookieManager$a;

.field private static e:Landroid/content/SharedPreferences;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a(Lanetwork/channel/cookie/CookieManager$a;)Lanetwork/channel/cookie/CookieManager$a;
    .locals 0

    sput-object p0, Lanetwork/channel/cookie/CookieManager;->d:Lanetwork/channel/cookie/CookieManager$a;

    return-object p0
.end method

.method static synthetic a()Ljava/lang/String;
    .locals 1

    .line 30
    invoke-static {}, Lanetwork/channel/cookie/CookieManager;->f()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static a(Ljava/lang/String;)V
    .locals 1

    .line 156
    new-instance v0, Lanetwork/channel/cookie/b;

    invoke-direct {v0, p0}, Lanetwork/channel/cookie/b;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitCookieMonitor(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method

.method private static a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .line 181
    new-instance v0, Lanetwork/channel/cookie/c;

    invoke-direct {v0, p0, p1}, Lanetwork/channel/cookie/c;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitCookieMonitor(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method

.method static synthetic b()Lanetwork/channel/cookie/CookieManager$a;
    .locals 1

    sget-object v0, Lanetwork/channel/cookie/CookieManager;->d:Lanetwork/channel/cookie/CookieManager$a;

    return-object v0
.end method

.method static synthetic c()Landroid/content/SharedPreferences;
    .locals 1

    sget-object v0, Lanetwork/channel/cookie/CookieManager;->e:Landroid/content/SharedPreferences;

    return-object v0
.end method

.method private static d()Z
    .locals 1

    sget-boolean v0, Lanetwork/channel/cookie/CookieManager;->a:Z

    if-nez v0, :cond_0

    .line 71
    invoke-static {}, Lanetwork/channel/http/NetworkSdkSetting;->getContext()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 72
    invoke-static {}, Lanetwork/channel/http/NetworkSdkSetting;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lanetwork/channel/cookie/CookieManager;->setup(Landroid/content/Context;)V

    :cond_0
    sget-boolean v0, Lanetwork/channel/cookie/CookieManager;->a:Z

    return v0
.end method

.method private static e()V
    .locals 1

    .line 140
    new-instance v0, Lanetwork/channel/cookie/a;

    invoke-direct {v0}, Lanetwork/channel/cookie/a;-><init>()V

    invoke-static {v0}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitCookieMonitor(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method

.method private static f()Ljava/lang/String;
    .locals 3

    sget-object v0, Lanetwork/channel/cookie/CookieManager;->e:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    const-string v2, "networksdk_target_cookie_name"

    .line 217
    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static declared-synchronized getCookie(Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    const-string v0, "get cookie failed. url="

    const-class v1, Lanetwork/channel/cookie/CookieManager;

    monitor-enter v1

    .line 122
    :try_start_0
    invoke-static {}, Lanetwork/channel/config/NetworkConfigCenter;->isCookieEnable()Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    const/4 v3, 0x0

    if-nez v2, :cond_0

    .line 123
    monitor-exit v1

    return-object v3

    .line 126
    :cond_0
    :try_start_1
    invoke-static {}, Lanetwork/channel/cookie/CookieManager;->d()Z

    move-result v2

    if-eqz v2, :cond_2

    sget-boolean v2, Lanetwork/channel/cookie/CookieManager;->c:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    if-nez v2, :cond_1

    goto :goto_1

    :cond_1
    :try_start_2
    sget-object v2, Lanetwork/channel/cookie/CookieManager;->b:Landroid/webkit/CookieManager;

    .line 131
    invoke-virtual {v2, p0}, Landroid/webkit/CookieManager;->getCookie(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v2

    :try_start_3
    const-string v4, "anet.CookieManager"

    .line 133
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-static {v4, v0, v3, v2, v5}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 135
    :goto_0
    invoke-static {p0, v3}, Lanetwork/channel/cookie/CookieManager;->a(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 136
    monitor-exit v1

    return-object v3

    .line 127
    :cond_2
    :goto_1
    monitor-exit v1

    return-object v3

    :catchall_1
    move-exception p0

    monitor-exit v1

    throw p0
.end method

.method public static declared-synchronized setCookie(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    const-class v0, Lanetwork/channel/cookie/CookieManager;

    monitor-enter v0

    .line 78
    :try_start_0
    invoke-static {}, Lanetwork/channel/config/NetworkConfigCenter;->isCookieEnable()Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v1, :cond_0

    .line 79
    monitor-exit v0

    return-void

    .line 82
    :cond_0
    :try_start_1
    invoke-static {}, Lanetwork/channel/cookie/CookieManager;->d()Z

    move-result v1

    if-eqz v1, :cond_2

    sget-boolean v1, Lanetwork/channel/cookie/CookieManager;->c:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    :try_start_2
    sget-object v1, Lanetwork/channel/cookie/CookieManager;->b:Landroid/webkit/CookieManager;

    .line 86
    invoke-virtual {v1, p0, p1}, Landroid/webkit/CookieManager;->setCookie(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v1, Lanetwork/channel/cookie/CookieManager;->b:Landroid/webkit/CookieManager;

    .line 90
    invoke-virtual {v1}, Landroid/webkit/CookieManager;->flush()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    :try_start_3
    const-string v2, "anet.CookieManager"

    const-string v3, "set cookie failed."

    const/4 v4, 0x4

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "url"

    const/4 v6, 0x0

    aput-object v5, v4, v6

    const/4 v5, 0x1

    aput-object p0, v4, v5

    const-string p0, "cookies"

    const/4 v5, 0x2

    aput-object p0, v4, v5

    const/4 p0, 0x3

    aput-object p1, v4, p0

    const/4 p0, 0x0

    .line 93
    invoke-static {v2, v3, p0, v1, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 95
    :goto_0
    monitor-exit v0

    return-void

    .line 83
    :cond_2
    :goto_1
    monitor-exit v0

    return-void

    :catchall_1
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static setCookie(Ljava/lang/String;Ljava/util/Map;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    .line 98
    invoke-static {}, Lanetwork/channel/config/NetworkConfigCenter;->isCookieEnable()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p0, :cond_4

    if-nez p1, :cond_1

    goto :goto_1

    .line 106
    :cond_1
    :try_start_0
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 107
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    if-eqz v2, :cond_2

    const-string v3, "Set-Cookie"

    .line 109
    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    const-string v3, "Set-Cookie2"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 110
    :cond_3
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 111
    invoke-static {p0, v2}, Lanetwork/channel/cookie/CookieManager;->setCookie(Ljava/lang/String;Ljava/lang/String;)V

    .line 112
    invoke-static {v2}, Lanetwork/channel/cookie/CookieManager;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "url"

    const-string v2, "\nheaders"

    .line 117
    filled-new-array {v1, p0, v2, p1}, [Ljava/lang/Object;

    move-result-object p0

    const-string p1, "anet.CookieManager"

    const-string v1, "set cookie failed"

    const/4 v2, 0x0

    invoke-static {p1, v1, v2, v0, p0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_4
    :goto_1
    return-void
.end method

.method public static setTargetMonitorCookieName(Ljava/lang/String;)V
    .locals 2

    if-eqz p0, :cond_0

    sget-object v0, Lanetwork/channel/cookie/CookieManager;->e:Landroid/content/SharedPreferences;

    if-eqz v0, :cond_0

    .line 209
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "networksdk_target_cookie_name"

    invoke-interface {v0, v1, p0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    :cond_0
    return-void
.end method

.method public static declared-synchronized setup(Landroid/content/Context;)V
    .locals 10

    const-class v0, Lanetwork/channel/cookie/CookieManager;

    monitor-enter v0

    .line 42
    :try_start_0
    invoke-static {}, Lanetwork/channel/config/NetworkConfigCenter;->isCookieEnable()Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v1, :cond_0

    .line 43
    monitor-exit v0

    return-void

    :cond_0
    :try_start_1
    sget-boolean v1, Lanetwork/channel/cookie/CookieManager;->a:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    if-eqz v1, :cond_1

    .line 47
    monitor-exit v0

    return-void

    :cond_1
    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 51
    :try_start_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 55
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v6

    sput-object v6, Lanetwork/channel/cookie/CookieManager;->b:Landroid/webkit/CookieManager;

    .line 56
    invoke-virtual {v6, v2}, Landroid/webkit/CookieManager;->setAcceptCookie(Z)V

    .line 60
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p0

    sput-object p0, Lanetwork/channel/cookie/CookieManager;->e:Landroid/content/SharedPreferences;

    .line 61
    invoke-static {}, Lanetwork/channel/cookie/CookieManager;->e()V

    const-string p0, "anet.CookieManager"

    const-string v6, "CookieManager setup."

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    const-string v8, "cost"

    aput-object v8, v7, v3

    .line 62
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    sub-long/2addr v8, v4

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    aput-object v4, v7, v2

    invoke-static {p0, v6, v1, v7}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p0

    :try_start_3
    sput-boolean v3, Lanetwork/channel/cookie/CookieManager;->c:Z

    const-string v4, "anet.CookieManager"

    const-string v5, "Cookie Manager setup failed!!!"

    new-array v3, v3, [Ljava/lang/Object;

    .line 65
    invoke-static {v4, v5, v1, p0, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    sput-boolean v2, Lanetwork/channel/cookie/CookieManager;->a:Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 68
    monitor-exit v0

    return-void

    :catchall_1
    move-exception p0

    monitor-exit v0

    throw p0
.end method
