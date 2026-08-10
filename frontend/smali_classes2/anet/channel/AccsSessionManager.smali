.class Lanet/channel/AccsSessionManager;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static c:Ljava/util/concurrent/CopyOnWriteArraySet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArraySet<",
            "Lanet/channel/ISessionListener;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field a:Lanet/channel/SessionCenter;

.field b:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 29
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArraySet;-><init>()V

    sput-object v0, Lanet/channel/AccsSessionManager;->c:Ljava/util/concurrent/CopyOnWriteArraySet;

    return-void
.end method

.method constructor <init>(Lanet/channel/SessionCenter;)V
    .locals 1

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lanet/channel/AccsSessionManager;->a:Lanet/channel/SessionCenter;

    .line 28
    sget-object v0, Ljava/util/Collections;->EMPTY_SET:Ljava/util/Set;

    iput-object v0, p0, Lanet/channel/AccsSessionManager;->b:Ljava/util/Set;

    iput-object p1, p0, Lanet/channel/AccsSessionManager;->a:Lanet/channel/SessionCenter;

    return-void
.end method

.method static synthetic a()Ljava/util/concurrent/CopyOnWriteArraySet;
    .locals 1

    sget-object v0, Lanet/channel/AccsSessionManager;->c:Ljava/util/concurrent/CopyOnWriteArraySet;

    return-object v0
.end method

.method private a(Ljava/lang/String;)V
    .locals 4

    .line 96
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanet/channel/AccsSessionManager;->a:Lanet/channel/SessionCenter;

    .line 99
    iget-object v0, v0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    const-string v1, "host"

    filled-new-array {v1, p1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "awcn.AccsSessionManager"

    const-string v3, "closeSessions"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lanet/channel/AccsSessionManager;->a:Lanet/channel/SessionCenter;

    .line 100
    invoke-virtual {v0, p1}, Lanet/channel/SessionCenter;->a(Ljava/lang/String;)Lanet/channel/SessionRequest;

    move-result-object p1

    const/4 v0, 0x0

    .line 101
    invoke-virtual {p1, v0}, Lanet/channel/SessionRequest;->b(Z)V

    return-void
.end method

.method private b()Z
    .locals 2

    .line 86
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-static {}, Lanet/channel/AwcnConfig;->isAccsSessionCreateForbiddenInBg()Z

    move-result v0

    if-eqz v0, :cond_0

    return v1

    .line 89
    :cond_0
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->isConnected()Z

    move-result v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    const/4 v0, 0x1

    return v0
.end method


# virtual methods
.method public declared-synchronized checkAndStartSession()V
    .locals 7

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lanet/channel/AccsSessionManager;->a:Lanet/channel/SessionCenter;

    .line 36
    iget-object v0, v0, Lanet/channel/SessionCenter;->g:Lanet/channel/c;

    invoke-virtual {v0}, Lanet/channel/c;->a()Ljava/util/Collection;

    move-result-object v0

    .line 38
    sget-object v1, Ljava/util/Collections;->EMPTY_SET:Ljava/util/Set;

    .line 39
    invoke-interface {v0}, Ljava/util/Collection;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    .line 40
    new-instance v1, Ljava/util/TreeSet;

    invoke-direct {v1}, Ljava/util/TreeSet;-><init>()V

    .line 43
    :cond_0
    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lanet/channel/SessionInfo;

    .line 44
    iget-boolean v3, v2, Lanet/channel/SessionInfo;->isKeepAlive:Z

    if-eqz v3, :cond_1

    .line 45
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object v3

    iget-object v4, v2, Lanet/channel/SessionInfo;->host:Ljava/lang/String;

    iget-boolean v5, v2, Lanet/channel/SessionInfo;->isAccs:Z

    if-eqz v5, :cond_2

    const-string v5, "https"

    goto :goto_1

    :cond_2
    const-string v5, "http"

    :goto_1
    invoke-interface {v3, v4, v5}, Lanet/channel/strategy/IStrategyInstance;->getSchemeByHost(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "://"

    .line 47
    iget-object v2, v2, Lanet/channel/SessionInfo;->host:Ljava/lang/String;

    invoke-static {v3, v4, v2}, Lanet/channel/util/StringUtils;->concatString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lanet/channel/AccsSessionManager;->b:Ljava/util/Set;

    .line 51
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_4
    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 52
    invoke-interface {v1, v2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    .line 53
    invoke-direct {p0, v2}, Lanet/channel/AccsSessionManager;->a(Ljava/lang/String;)V

    goto :goto_2

    .line 57
    :cond_5
    invoke-direct {p0}, Lanet/channel/AccsSessionManager;->b()Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_6

    .line 58
    monitor-exit p0

    return-void

    .line 61
    :cond_6
    :try_start_1
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_7

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    iget-object v3, p0, Lanet/channel/AccsSessionManager;->a:Lanet/channel/SessionCenter;

    .line 63
    sget-object v4, Lanet/channel/entity/ConnType$TypeLevel;->SPDY:Lanet/channel/entity/ConnType$TypeLevel;

    const-wide/16 v5, 0x0

    invoke-virtual {v3, v2, v4, v5, v6}, Lanet/channel/SessionCenter;->get(Ljava/lang/String;Lanet/channel/entity/ConnType$TypeLevel;J)Lanet/channel/Session;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_3

    :catch_0
    :try_start_3
    const-string v3, "start session failed"

    const-string v4, "host"

    .line 65
    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const/4 v5, 0x0

    invoke-static {v3, v5, v4, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_3

    :cond_7
    iput-object v1, p0, Lanet/channel/AccsSessionManager;->b:Ljava/util/Set;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 70
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized forceCloseSession(Z)V
    .locals 7

    monitor-enter p0

    const/4 v0, 0x1

    .line 73
    :try_start_0
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "awcn.AccsSessionManager"

    const-string v2, "forceCloseSession"

    iget-object v3, p0, Lanet/channel/AccsSessionManager;->a:Lanet/channel/SessionCenter;

    .line 74
    iget-object v3, v3, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "reCreate"

    const/4 v6, 0x0

    aput-object v5, v4, v6

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v4, v0

    invoke-static {v1, v2, v3, v4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    iget-object v0, p0, Lanet/channel/AccsSessionManager;->b:Ljava/util/Set;

    .line 76
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 77
    invoke-direct {p0, v1}, Lanet/channel/AccsSessionManager;->a(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    if-eqz p1, :cond_2

    .line 81
    invoke-virtual {p0}, Lanet/channel/AccsSessionManager;->checkAndStartSession()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 83
    :cond_2
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public notifyListener(Landroid/content/Intent;)V
    .locals 1

    .line 115
    new-instance v0, Lanet/channel/a;

    invoke-direct {v0, p0, p1}, Lanet/channel/a;-><init>(Lanet/channel/AccsSessionManager;Landroid/content/Intent;)V

    invoke-static {v0}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method

.method public registerListener(Lanet/channel/ISessionListener;)V
    .locals 1

    if-eqz p1, :cond_0

    sget-object v0, Lanet/channel/AccsSessionManager;->c:Ljava/util/concurrent/CopyOnWriteArraySet;

    .line 106
    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArraySet;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public unregisterListener(Lanet/channel/ISessionListener;)V
    .locals 1

    sget-object v0, Lanet/channel/AccsSessionManager;->c:Ljava/util/concurrent/CopyOnWriteArraySet;

    .line 111
    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArraySet;->remove(Ljava/lang/Object;)Z

    return-void
.end method
