.class Lanet/channel/strategy/StrategyInfoHolder;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/status/NetworkStatusHelper$INetworkStatusChangeListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/strategy/StrategyInfoHolder$LruStrategyMap;
    }
.end annotation


# instance fields
.field a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lanet/channel/strategy/StrategyTable;",
            ">;"
        }
    .end annotation
.end field

.field volatile b:Lanet/channel/strategy/StrategyConfig;

.field final c:Lanet/channel/strategy/a;

.field private final d:Lanet/channel/strategy/StrategyTable;

.field private final e:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private volatile f:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    new-instance v0, Lanet/channel/strategy/StrategyInfoHolder$LruStrategyMap;

    invoke-direct {v0}, Lanet/channel/strategy/StrategyInfoHolder$LruStrategyMap;-><init>()V

    iput-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->a:Ljava/util/Map;

    const/4 v0, 0x0

    iput-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->b:Lanet/channel/strategy/StrategyConfig;

    .line 34
    new-instance v0, Lanet/channel/strategy/a;

    invoke-direct {v0}, Lanet/channel/strategy/a;-><init>()V

    iput-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->c:Lanet/channel/strategy/a;

    .line 37
    new-instance v0, Lanet/channel/strategy/StrategyTable;

    const-string v1, "Unknown"

    invoke-direct {v0, v1}, Lanet/channel/strategy/StrategyTable;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->d:Lanet/channel/strategy/StrategyTable;

    .line 39
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->e:Ljava/util/Set;

    const-string v0, ""

    iput-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->f:Ljava/lang/String;

    .line 49
    :try_start_0
    invoke-direct {p0}, Lanet/channel/strategy/StrategyInfoHolder;->e()V

    .line 50
    invoke-direct {p0}, Lanet/channel/strategy/StrategyInfoHolder;->g()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 54
    :catchall_0
    invoke-direct {p0}, Lanet/channel/strategy/StrategyInfoHolder;->f()V

    return-void
.end method

.method public static a()Lanet/channel/strategy/StrategyInfoHolder;
    .locals 1

    .line 44
    new-instance v0, Lanet/channel/strategy/StrategyInfoHolder;

    invoke-direct {v0}, Lanet/channel/strategy/StrategyInfoHolder;-><init>()V

    return-object v0
.end method

.method private a(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)Ljava/lang/String;
    .locals 2

    .line 219
    invoke-virtual {p1}, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->isWifi()Z

    move-result v0

    const-string v1, ""

    if-eqz v0, :cond_1

    .line 220
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getWifiBSSID()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lanet/channel/util/StringUtils;->md5ToHex(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 221
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    move-object v1, p1

    .line 224
    :goto_0
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "WIFI$"

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    .line 225
    :cond_1
    invoke-virtual {p1}, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->isMobile()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 226
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->getType()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string p1, "$"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getApn()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_2
    :goto_1
    return-object v1
.end method

.method private e()V
    .locals 1

    .line 63
    invoke-static {p0}, Lanet/channel/status/NetworkStatusHelper;->addStatusChangeListener(Lanet/channel/status/NetworkStatusHelper$INetworkStatusChangeListener;)V

    .line 64
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getStatus()Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    move-result-object v0

    invoke-direct {p0, v0}, Lanet/channel/strategy/StrategyInfoHolder;->a(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->f:Ljava/lang/String;

    return-void
.end method

.method private f()V
    .locals 2

    iget-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->a:Ljava/util/Map;

    .line 68
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 69
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/strategy/StrategyTable;

    invoke-virtual {v1}, Lanet/channel/strategy/StrategyTable;->a()V

    goto :goto_0

    .line 72
    :cond_0
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->b:Lanet/channel/strategy/StrategyConfig;

    if-nez v0, :cond_1

    .line 74
    new-instance v0, Lanet/channel/strategy/StrategyConfig;

    invoke-direct {v0}, Lanet/channel/strategy/StrategyConfig;-><init>()V

    .line 75
    invoke-virtual {v0}, Lanet/channel/strategy/StrategyConfig;->b()V

    .line 76
    invoke-virtual {v0, p0}, Lanet/channel/strategy/StrategyConfig;->a(Lanet/channel/strategy/StrategyInfoHolder;)V

    iput-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->b:Lanet/channel/strategy/StrategyConfig;

    .line 79
    :cond_1
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private g()V
    .locals 4

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "awcn.StrategyInfoHolder"

    const-string v2, "restore"

    const/4 v3, 0x0

    .line 83
    invoke-static {v1, v2, v3, v0}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->f:Ljava/lang/String;

    .line 86
    invoke-static {}, Lanet/channel/AwcnConfig;->isAsyncLoadStrategyEnable()Z

    move-result v1

    if-nez v1, :cond_1

    .line 88
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    .line 89
    invoke-virtual {p0, v0, v1}, Lanet/channel/strategy/StrategyInfoHolder;->a(Ljava/lang/String;Z)V

    :cond_0
    const-string v1, "StrategyConfig"

    .line 92
    invoke-static {v1, v3}, Lanet/channel/strategy/m;->a(Ljava/lang/String;Lanet/channel/statist/StrategyStatObject;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/strategy/StrategyConfig;

    iput-object v1, p0, Lanet/channel/strategy/StrategyInfoHolder;->b:Lanet/channel/strategy/StrategyConfig;

    iget-object v1, p0, Lanet/channel/strategy/StrategyInfoHolder;->b:Lanet/channel/strategy/StrategyConfig;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lanet/channel/strategy/StrategyInfoHolder;->b:Lanet/channel/strategy/StrategyConfig;

    .line 94
    invoke-virtual {v1}, Lanet/channel/strategy/StrategyConfig;->b()V

    iget-object v1, p0, Lanet/channel/strategy/StrategyInfoHolder;->b:Lanet/channel/strategy/StrategyConfig;

    .line 95
    invoke-virtual {v1, p0}, Lanet/channel/strategy/StrategyConfig;->a(Lanet/channel/strategy/StrategyInfoHolder;)V

    .line 100
    :cond_1
    new-instance v1, Lanet/channel/strategy/d;

    invoke-direct {v1, p0, v0}, Lanet/channel/strategy/d;-><init>(Lanet/channel/strategy/StrategyInfoHolder;Ljava/lang/String;)V

    invoke-static {v1}, Lanet/channel/strategy/utils/a;->a(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method a(Lanet/channel/strategy/l$d;)V
    .locals 2

    .line 232
    iget v0, p1, Lanet/channel/strategy/l$d;->g:I

    if-eqz v0, :cond_0

    .line 233
    iget v0, p1, Lanet/channel/strategy/l$d;->g:I

    iget v1, p1, Lanet/channel/strategy/l$d;->h:I

    invoke-static {v0, v1}, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->updateAmdcLimit(II)V

    .line 236
    :cond_0
    invoke-virtual {p0}, Lanet/channel/strategy/StrategyInfoHolder;->d()Lanet/channel/strategy/StrategyTable;

    move-result-object v0

    .line 237
    invoke-virtual {v0, p1}, Lanet/channel/strategy/StrategyTable;->update(Lanet/channel/strategy/l$d;)V

    iget-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->b:Lanet/channel/strategy/StrategyConfig;

    .line 238
    invoke-virtual {v0, p1}, Lanet/channel/strategy/StrategyConfig;->a(Lanet/channel/strategy/l$d;)V

    return-void
.end method

.method protected a(Ljava/lang/String;Z)V
    .locals 6

    iget-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->e:Ljava/util/Set;

    .line 150
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lanet/channel/strategy/StrategyInfoHolder;->e:Ljava/util/Set;

    .line 151
    invoke-interface {v1, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    iget-object v1, p0, Lanet/channel/strategy/StrategyInfoHolder;->e:Ljava/util/Set;

    .line 152
    invoke-interface {v1, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 156
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    .line 159
    new-instance v1, Lanet/channel/statist/StrategyStatObject;

    invoke-direct {v1, v0}, Lanet/channel/statist/StrategyStatObject;-><init>(I)V

    .line 160
    iput-object p1, v1, Lanet/channel/statist/StrategyStatObject;->readStrategyFileId:Ljava/lang/String;

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 162
    :goto_0
    invoke-static {p1, v1}, Lanet/channel/strategy/m;->a(Ljava/lang/String;Lanet/channel/statist/StrategyStatObject;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lanet/channel/strategy/StrategyTable;

    if-eqz v2, :cond_1

    .line 164
    invoke-virtual {v2}, Lanet/channel/strategy/StrategyTable;->a()V

    iget-object v3, p0, Lanet/channel/strategy/StrategyInfoHolder;->a:Ljava/util/Map;

    .line 165
    monitor-enter v3

    :try_start_1
    iget-object v4, p0, Lanet/channel/strategy/StrategyInfoHolder;->a:Ljava/util/Map;

    .line 166
    iget-object v5, v2, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    invoke-interface {v4, v5, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 167
    monitor-exit v3

    goto :goto_1

    :catchall_0
    move-exception p1

    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1

    :cond_1
    :goto_1
    iget-object v3, p0, Lanet/channel/strategy/StrategyInfoHolder;->e:Ljava/util/Set;

    .line 169
    monitor-enter v3

    :try_start_2
    iget-object v4, p0, Lanet/channel/strategy/StrategyInfoHolder;->e:Ljava/util/Set;

    .line 170
    invoke-interface {v4, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 171
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    if-eqz p2, :cond_3

    if-eqz v2, :cond_2

    const/4 v0, 0x1

    .line 175
    :cond_2
    iput v0, v1, Lanet/channel/statist/StrategyStatObject;->isSucceed:I

    .line 176
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    invoke-interface {p1, v1}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    :cond_3
    return-void

    :catchall_1
    move-exception p1

    .line 171
    :try_start_3
    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw p1

    .line 154
    :cond_4
    :try_start_4
    monitor-exit v0

    return-void

    :catchall_2
    move-exception p1

    .line 156
    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    throw p1
.end method

.method b()V
    .locals 0

    .line 59
    invoke-static {p0}, Lanet/channel/status/NetworkStatusHelper;->removeStatusChangeListener(Lanet/channel/status/NetworkStatusHelper$INetworkStatusChangeListener;)V

    return-void
.end method

.method c()V
    .locals 4

    .line 184
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->a:Ljava/util/Map;

    .line 185
    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/strategy/StrategyTable;

    .line 186
    iget-boolean v2, v1, Lanet/channel/strategy/StrategyTable;->d:Z

    if-eqz v2, :cond_0

    .line 187
    new-instance v2, Lanet/channel/statist/StrategyStatObject;

    const/4 v3, 0x1

    invoke-direct {v2, v3}, Lanet/channel/statist/StrategyStatObject;-><init>(I)V

    .line 188
    iget-object v3, v1, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    iput-object v3, v2, Lanet/channel/statist/StrategyStatObject;->writeStrategyFileId:Ljava/lang/String;

    .line 189
    iget-object v3, v1, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    invoke-static {v1, v3, v2}, Lanet/channel/strategy/m;->a(Ljava/io/Serializable;Ljava/lang/String;Lanet/channel/statist/StrategyStatObject;)V

    const/4 v2, 0x0

    .line 190
    iput-boolean v2, v1, Lanet/channel/strategy/StrategyTable;->d:Z

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->b:Lanet/channel/strategy/StrategyConfig;

    .line 193
    invoke-virtual {v0}, Lanet/channel/strategy/StrategyConfig;->a()Lanet/channel/strategy/StrategyConfig;

    move-result-object v0

    const-string v1, "StrategyConfig"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lanet/channel/strategy/m;->a(Ljava/io/Serializable;Ljava/lang/String;Lanet/channel/statist/StrategyStatObject;)V

    .line 194
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method d()Lanet/channel/strategy/StrategyTable;
    .locals 4

    iget-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->d:Lanet/channel/strategy/StrategyTable;

    iget-object v1, p0, Lanet/channel/strategy/StrategyInfoHolder;->f:Ljava/lang/String;

    .line 203
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    iget-object v2, p0, Lanet/channel/strategy/StrategyInfoHolder;->a:Ljava/util/Map;

    .line 204
    monitor-enter v2

    :try_start_0
    iget-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->a:Ljava/util/Map;

    .line 205
    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lanet/channel/strategy/StrategyTable;

    if-eqz v0, :cond_0

    goto :goto_0

    .line 209
    :cond_0
    new-instance v0, Lanet/channel/strategy/StrategyTable;

    invoke-direct {v0, v1}, Lanet/channel/strategy/StrategyTable;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lanet/channel/strategy/StrategyInfoHolder;->a:Ljava/util/Map;

    .line 210
    invoke-interface {v3, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 212
    :goto_0
    monitor-exit v2

    goto :goto_1

    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    :cond_1
    :goto_1
    return-object v0
.end method

.method public onNetworkStatusChanged(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)V
    .locals 2

    .line 243
    invoke-direct {p0, p1}, Lanet/channel/strategy/StrategyInfoHolder;->a(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lanet/channel/strategy/StrategyInfoHolder;->f:Ljava/lang/String;

    iget-object p1, p0, Lanet/channel/strategy/StrategyInfoHolder;->f:Ljava/lang/String;

    .line 245
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lanet/channel/strategy/StrategyInfoHolder;->a:Ljava/util/Map;

    .line 246
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lanet/channel/strategy/StrategyInfoHolder;->a:Ljava/util/Map;

    .line 247
    invoke-interface {v1, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 248
    new-instance v1, Lanet/channel/strategy/e;

    invoke-direct {v1, p0, p1}, Lanet/channel/strategy/e;-><init>(Lanet/channel/strategy/StrategyInfoHolder;Ljava/lang/String;)V

    invoke-static {v1}, Lanet/channel/strategy/utils/a;->a(Ljava/lang/Runnable;)V

    .line 255
    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_1
    :goto_0
    return-void
.end method
