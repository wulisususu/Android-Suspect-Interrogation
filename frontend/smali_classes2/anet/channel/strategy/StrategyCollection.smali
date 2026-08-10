.class Lanet/channel/strategy/StrategyCollection;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field a:Ljava/lang/String;

.field volatile b:J

.field volatile c:Ljava/lang/String;

.field d:Z

.field e:I

.field private f:Lanet/channel/strategy/StrategyList;

.field private transient g:J

.field private transient h:Z


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lanet/channel/strategy/StrategyCollection;->b:J

    iput-object v0, p0, Lanet/channel/strategy/StrategyCollection;->c:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanet/channel/strategy/StrategyCollection;->d:Z

    iput v0, p0, Lanet/channel/strategy/StrategyCollection;->e:I

    iput-wide v1, p0, Lanet/channel/strategy/StrategyCollection;->g:J

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanet/channel/strategy/StrategyCollection;->h:Z

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;)V
    .locals 3

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lanet/channel/strategy/StrategyCollection;->b:J

    iput-object v0, p0, Lanet/channel/strategy/StrategyCollection;->c:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanet/channel/strategy/StrategyCollection;->d:Z

    iput v0, p0, Lanet/channel/strategy/StrategyCollection;->e:I

    iput-wide v1, p0, Lanet/channel/strategy/StrategyCollection;->g:J

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanet/channel/strategy/StrategyCollection;->h:Z

    iput-object p1, p0, Lanet/channel/strategy/StrategyCollection;->a:Ljava/lang/String;

    .line 35
    invoke-static {p1}, Lanet/channel/strategy/dispatch/DispatchConstants;->isAmdcServerDomain(Ljava/lang/String;)Z

    move-result p1

    iput-boolean p1, p0, Lanet/channel/strategy/StrategyCollection;->d:Z

    return-void
.end method


# virtual methods
.method public declared-synchronized checkInit()V
    .locals 4

    monitor-enter p0

    .line 39
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lanet/channel/strategy/StrategyCollection;->b:J

    sub-long/2addr v0, v2

    const-wide/32 v2, 0xa4cb800

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    const/4 v0, 0x0

    iput-object v0, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 41
    monitor-exit p0

    return-void

    :cond_0
    :try_start_1
    iget-object v0, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    if-eqz v0, :cond_1

    .line 44
    invoke-virtual {v0}, Lanet/channel/strategy/StrategyList;->checkInit()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 46
    :cond_1
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public isExpired()Z
    .locals 4

    .line 79
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lanet/channel/strategy/StrategyCollection;->b:J

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public declared-synchronized notifyConnEvent(Lanet/channel/strategy/IConnStrategy;Lanet/channel/strategy/ConnEvent;)V
    .locals 4

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    if-eqz v0, :cond_0

    .line 64
    invoke-virtual {v0, p1, p2}, Lanet/channel/strategy/StrategyList;->notifyConnEvent(Lanet/channel/strategy/IConnStrategy;Lanet/channel/strategy/ConnEvent;)V

    .line 65
    iget-boolean p1, p2, Lanet/channel/strategy/ConnEvent;->isSuccess:Z

    if-nez p1, :cond_0

    iget-object p1, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    .line 67
    invoke-virtual {p1}, Lanet/channel/strategy/StrategyList;->shouldRefresh()Z

    move-result p1

    if-eqz p1, :cond_0

    .line 68
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iget-wide v0, p0, Lanet/channel/strategy/StrategyCollection;->g:J

    sub-long v0, p1, v0

    const-wide/32 v2, 0xea60

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    .line 70
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object v0

    iget-object v1, p0, Lanet/channel/strategy/StrategyCollection;->a:Ljava/lang/String;

    invoke-interface {v0, v1}, Lanet/channel/strategy/IStrategyInstance;->forceRefreshStrategy(Ljava/lang/String;)V

    iput-wide p1, p0, Lanet/channel/strategy/StrategyCollection;->g:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 76
    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized queryStrategyList()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lanet/channel/strategy/IConnStrategy;",
            ">;"
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    if-nez v0, :cond_0

    .line 50
    sget-object v0, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :cond_0
    :try_start_1
    iget-boolean v0, p0, Lanet/channel/strategy/StrategyCollection;->h:Z

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanet/channel/strategy/StrategyCollection;->h:Z

    .line 55
    new-instance v1, Lanet/channel/statist/PolicyVersionStat;

    iget-object v2, p0, Lanet/channel/strategy/StrategyCollection;->a:Ljava/lang/String;

    iget v3, p0, Lanet/channel/strategy/StrategyCollection;->e:I

    invoke-direct {v1, v2, v3}, Lanet/channel/statist/PolicyVersionStat;-><init>(Ljava/lang/String;I)V

    .line 56
    iput v0, v1, Lanet/channel/statist/PolicyVersionStat;->reportType:I

    .line 57
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v0

    invoke-interface {v0, v1}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    :cond_1
    iget-object v0, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    .line 59
    invoke-virtual {v0}, Lanet/channel/strategy/StrategyList;->getStrategyList()Ljava/util/List;

    move-result-object v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 117
    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v1, 0x20

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v1, "\nStrategyList = "

    .line 118
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Lanet/channel/strategy/StrategyCollection;->b:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    if-eqz v1, :cond_0

    .line 120
    invoke-virtual {v1}, Lanet/channel/strategy/StrategyList;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lanet/channel/strategy/StrategyCollection;->c:Ljava/lang/String;

    if-eqz v1, :cond_1

    const/16 v1, 0x5b

    .line 122
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lanet/channel/strategy/StrategyCollection;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "=>"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lanet/channel/strategy/StrategyCollection;->c:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x5d

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_1
    const-string v1, "[]"

    .line 124
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 127
    :goto_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public declared-synchronized update(Lanet/channel/strategy/l$b;)V
    .locals 7

    monitor-enter p0

    .line 83
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget v2, p1, Lanet/channel/strategy/l$b;->b:I

    int-to-long v2, v2

    const-wide/16 v4, 0x3e8

    mul-long/2addr v2, v4

    add-long/2addr v0, v2

    iput-wide v0, p0, Lanet/channel/strategy/StrategyCollection;->b:J

    .line 85
    iget-object v0, p1, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    iget-object v1, p0, Lanet/channel/strategy/StrategyCollection;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez v0, :cond_0

    const-string v0, "StrategyCollection"

    const-string v3, "update error!"

    const/4 v4, 0x4

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "host"

    const/4 v6, 0x0

    aput-object v5, v4, v6

    iget-object v5, p0, Lanet/channel/strategy/StrategyCollection;->a:Ljava/lang/String;

    aput-object v5, v4, v1

    const-string v1, "dnsInfo.host"

    const/4 v5, 0x2

    aput-object v1, v4, v5

    .line 86
    iget-object p1, p1, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    const/4 v1, 0x3

    aput-object p1, v4, v1

    invoke-static {v0, v3, v2, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 87
    monitor-exit p0

    return-void

    :cond_0
    :try_start_1
    iget v0, p0, Lanet/channel/strategy/StrategyCollection;->e:I

    .line 90
    iget v3, p1, Lanet/channel/strategy/l$b;->l:I

    if-eq v0, v3, :cond_1

    .line 91
    iget v0, p1, Lanet/channel/strategy/l$b;->l:I

    iput v0, p0, Lanet/channel/strategy/StrategyCollection;->e:I

    .line 93
    new-instance v0, Lanet/channel/statist/PolicyVersionStat;

    iget-object v3, p0, Lanet/channel/strategy/StrategyCollection;->a:Ljava/lang/String;

    iget v4, p0, Lanet/channel/strategy/StrategyCollection;->e:I

    invoke-direct {v0, v3, v4}, Lanet/channel/statist/PolicyVersionStat;-><init>(Ljava/lang/String;I)V

    .line 94
    iput v1, v0, Lanet/channel/statist/PolicyVersionStat;->reportType:I

    .line 95
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v1

    invoke-interface {v1, v0}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    .line 98
    :cond_1
    iget-object v0, p1, Lanet/channel/strategy/l$b;->d:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/strategy/StrategyCollection;->c:Ljava/lang/String;

    .line 101
    iget-object v0, p1, Lanet/channel/strategy/l$b;->f:[Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p1, Lanet/channel/strategy/l$b;->f:[Ljava/lang/String;

    array-length v0, v0

    if-eqz v0, :cond_2

    iget-object v0, p1, Lanet/channel/strategy/l$b;->h:[Lanet/channel/strategy/l$a;

    if-eqz v0, :cond_2

    iget-object v0, p1, Lanet/channel/strategy/l$b;->h:[Lanet/channel/strategy/l$a;

    array-length v0, v0

    if-nez v0, :cond_3

    :cond_2
    iget-object v0, p1, Lanet/channel/strategy/l$b;->i:[Lanet/channel/strategy/l$e;

    if-eqz v0, :cond_5

    iget-object v0, p1, Lanet/channel/strategy/l$b;->i:[Lanet/channel/strategy/l$e;

    array-length v0, v0

    if-nez v0, :cond_3

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    if-nez v0, :cond_4

    .line 109
    new-instance v0, Lanet/channel/strategy/StrategyList;

    invoke-direct {v0}, Lanet/channel/strategy/StrategyList;-><init>()V

    iput-object v0, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    :cond_4
    iget-object v0, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;

    .line 112
    invoke-virtual {v0, p1}, Lanet/channel/strategy/StrategyList;->update(Lanet/channel/strategy/l$b;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 113
    monitor-exit p0

    return-void

    :cond_5
    :goto_0
    :try_start_2
    iput-object v2, p0, Lanet/channel/strategy/StrategyCollection;->f:Lanet/channel/strategy/StrategyList;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 105
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
