.class Lanetwork/channel/entity/f;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanetwork/channel/aidl/DefaultFinishEvent;

.field final synthetic b:Lanetwork/channel/aidl/ParcelableNetworkListener;

.field final synthetic c:Lanetwork/channel/entity/c;


# direct methods
.method constructor <init>(Lanetwork/channel/entity/c;Lanetwork/channel/aidl/DefaultFinishEvent;Lanetwork/channel/aidl/ParcelableNetworkListener;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/entity/f;->c:Lanetwork/channel/entity/c;

    iput-object p2, p0, Lanetwork/channel/entity/f;->a:Lanetwork/channel/aidl/DefaultFinishEvent;

    iput-object p3, p0, Lanetwork/channel/entity/f;->b:Lanetwork/channel/aidl/ParcelableNetworkListener;

    .line 113
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 11

    const-string v0, "anet.Repeater"

    const-string v1, "]end, "

    const-string v2, "[traceId:"

    iget-object v3, p0, Lanetwork/channel/entity/f;->a:Lanetwork/channel/aidl/DefaultFinishEvent;

    const/4 v4, 0x0

    if-eqz v3, :cond_0

    .line 116
    invoke-virtual {v3, v4}, Lanetwork/channel/aidl/DefaultFinishEvent;->setContext(Ljava/lang/Object;)V

    .line 119
    :cond_0
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    iget-object v3, p0, Lanetwork/channel/entity/f;->a:Lanetwork/channel/aidl/DefaultFinishEvent;

    .line 120
    iget-object v3, v3, Lanetwork/channel/aidl/DefaultFinishEvent;->rs:Lanet/channel/statist/RequestStatistic;

    if-eqz v3, :cond_1

    .line 122
    iput-wide v5, v3, Lanet/channel/statist/RequestStatistic;->rspCbStart:J

    .line 123
    iget-wide v7, v3, Lanet/channel/statist/RequestStatistic;->rspEnd:J

    sub-long v7, v5, v7

    iput-wide v7, v3, Lanet/channel/statist/RequestStatistic;->lastProcessTime:J

    .line 124
    iget-wide v7, v3, Lanet/channel/statist/RequestStatistic;->retryCostTime:J

    iget-wide v9, v3, Lanet/channel/statist/RequestStatistic;->start:J

    sub-long v9, v5, v9

    add-long/2addr v7, v9

    iput-wide v7, v3, Lanet/channel/statist/RequestStatistic;->oneWayTime:J

    iget-object v7, p0, Lanetwork/channel/entity/f;->a:Lanetwork/channel/aidl/DefaultFinishEvent;

    .line 125
    invoke-virtual {v7}, Lanetwork/channel/aidl/DefaultFinishEvent;->getStatisticData()Lanetwork/channel/statist/StatisticData;

    move-result-object v7

    invoke-virtual {v7, v3}, Lanetwork/channel/statist/StatisticData;->filledBy(Lanet/channel/statist/RequestStatistic;)V

    :cond_1
    iget-object v7, p0, Lanetwork/channel/entity/f;->b:Lanetwork/channel/aidl/ParcelableNetworkListener;

    iget-object v8, p0, Lanetwork/channel/entity/f;->a:Lanetwork/channel/aidl/DefaultFinishEvent;

    .line 127
    invoke-interface {v7, v8}, Lanetwork/channel/aidl/ParcelableNetworkListener;->onFinished(Lanetwork/channel/aidl/DefaultFinishEvent;)V

    if-eqz v3, :cond_2

    .line 129
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    .line 130
    iput-wide v7, v3, Lanet/channel/statist/RequestStatistic;->rspCbEnd:J

    sub-long/2addr v7, v5

    .line 131
    iput-wide v7, v3, Lanet/channel/statist/RequestStatistic;->callbackTime:J

    .line 134
    invoke-static {}, Lanet/channel/fulltrace/a;->a()Lanet/channel/fulltrace/IFullTraceAnalysis;

    move-result-object v5

    iget-object v6, v3, Lanet/channel/statist/RequestStatistic;->traceId:Ljava/lang/String;

    invoke-interface {v5, v6, v3}, Lanet/channel/fulltrace/IFullTraceAnalysis;->commitRequest(Ljava/lang/String;Lanet/channel/statist/RequestStatistic;)V

    :cond_2
    iget-object v5, p0, Lanetwork/channel/entity/f;->c:Lanetwork/channel/entity/c;

    .line 137
    invoke-static {v5}, Lanetwork/channel/entity/c;->b(Lanetwork/channel/entity/c;)Lanetwork/channel/aidl/adapter/ParcelableInputStreamImpl;

    move-result-object v5

    if-eqz v5, :cond_3

    iget-object v5, p0, Lanetwork/channel/entity/f;->c:Lanetwork/channel/entity/c;

    .line 138
    invoke-static {v5}, Lanetwork/channel/entity/c;->b(Lanetwork/channel/entity/c;)Lanetwork/channel/aidl/adapter/ParcelableInputStreamImpl;

    move-result-object v5

    invoke-virtual {v5}, Lanetwork/channel/aidl/adapter/ParcelableInputStreamImpl;->writeEnd()V

    :cond_3
    if-eqz v3, :cond_c

    .line 142
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, v3, Lanet/channel/statist/RequestStatistic;->traceId:Ljava/lang/String;

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 143
    invoke-virtual {v3}, Lanet/channel/statist/RequestStatistic;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lanetwork/channel/entity/f;->c:Lanetwork/channel/entity/c;

    .line 144
    invoke-static {v2}, Lanetwork/channel/entity/c;->d(Lanetwork/channel/entity/c;)Ljava/lang/String;

    move-result-object v2

    const/4 v5, 0x0

    new-array v6, v5, [Ljava/lang/Object;

    invoke-static {v0, v1, v2, v6}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 147
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getBucketInfo()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v1

    const/4 v2, 0x1

    if-eqz v1, :cond_4

    .line 149
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v6

    move v7, v5

    :goto_0
    add-int/lit8 v8, v6, -0x1

    if-ge v7, v8, :cond_4

    .line 151
    invoke-interface {v1, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    add-int/lit8 v9, v7, 0x1

    invoke-interface {v1, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    invoke-virtual {v3, v8, v9}, Lanet/channel/statist/RequestStatistic;->putExtra(Ljava/lang/String;Ljava/lang/Object;)V

    add-int/lit8 v7, v7, 0x2

    goto :goto_0

    .line 155
    :cond_4
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v1

    if-eqz v1, :cond_5

    const-string v1, "restrictBg"

    .line 156
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getRestrictBackgroundStatus()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v3, v1, v6}, Lanet/channel/statist/RequestStatistic;->putExtra(Ljava/lang/String;Ljava/lang/Object;)V

    .line 160
    :cond_5
    invoke-static {}, Lanet/channel/fulltrace/a;->a()Lanet/channel/fulltrace/IFullTraceAnalysis;

    move-result-object v1

    invoke-interface {v1}, Lanet/channel/fulltrace/IFullTraceAnalysis;->getSceneInfo()Lanet/channel/fulltrace/b;

    move-result-object v1

    if-eqz v1, :cond_7

    .line 162
    invoke-virtual {v1}, Lanet/channel/fulltrace/b;->toString()Ljava/lang/String;

    move-result-object v6

    iget-object v7, p0, Lanetwork/channel/entity/f;->c:Lanetwork/channel/entity/c;

    invoke-static {v7}, Lanetwork/channel/entity/c;->d(Lanetwork/channel/entity/c;)Ljava/lang/String;

    move-result-object v7

    new-array v5, v5, [Ljava/lang/Object;

    invoke-static {v0, v6, v7, v5}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 163
    iget-wide v5, v3, Lanet/channel/statist/RequestStatistic;->start:J

    iget-wide v7, v1, Lanet/channel/fulltrace/b;->c:J

    sub-long/2addr v5, v7

    iput-wide v5, v3, Lanet/channel/statist/RequestStatistic;->sinceInitTime:J

    .line 164
    iget v0, v1, Lanet/channel/fulltrace/b;->a:I

    iput v0, v3, Lanet/channel/statist/RequestStatistic;->startType:I

    .line 166
    iget v0, v1, Lanet/channel/fulltrace/b;->a:I

    if-eq v0, v2, :cond_6

    .line 167
    iget-wide v5, v1, Lanet/channel/fulltrace/b;->c:J

    iget-wide v7, v1, Lanet/channel/fulltrace/b;->d:J

    sub-long/2addr v5, v7

    iput-wide v5, v3, Lanet/channel/statist/RequestStatistic;->sinceLastLaunchTime:J

    .line 169
    :cond_6
    iget v0, v1, Lanet/channel/fulltrace/b;->e:I

    iput v0, v3, Lanet/channel/statist/RequestStatistic;->deviceLevel:I

    .line 170
    iget-boolean v0, v1, Lanet/channel/fulltrace/b;->b:Z

    iput v0, v3, Lanet/channel/statist/RequestStatistic;->isFromExternal:I

    .line 171
    iget-object v0, v1, Lanet/channel/fulltrace/b;->f:Ljava/lang/String;

    iput-object v0, v3, Lanet/channel/statist/RequestStatistic;->speedBucket:Ljava/lang/String;

    .line 172
    iget-object v0, v1, Lanet/channel/fulltrace/b;->g:Ljava/lang/String;

    iput-object v0, v3, Lanet/channel/statist/RequestStatistic;->abTestBucket:Ljava/lang/String;

    .line 176
    :cond_7
    iget-wide v0, v3, Lanet/channel/statist/RequestStatistic;->reqServiceTransmissionEnd:J

    iget-wide v5, v3, Lanet/channel/statist/RequestStatistic;->netReqStart:J

    sub-long/2addr v0, v5

    iput-wide v0, v3, Lanet/channel/statist/RequestStatistic;->serializeTransferTime:J

    iget-object v0, p0, Lanetwork/channel/entity/f;->c:Lanetwork/channel/entity/c;

    .line 179
    invoke-static {v0}, Lanetwork/channel/entity/c;->c(Lanetwork/channel/entity/c;)Lanetwork/channel/entity/g;

    move-result-object v0

    const-string v1, "RequestUserInfo"

    invoke-virtual {v0, v1}, Lanetwork/channel/entity/g;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v3, Lanet/channel/statist/RequestStatistic;->userInfo:Ljava/lang/String;

    .line 181
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v0

    invoke-interface {v0, v3}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    .line 183
    invoke-static {v3}, Lanetwork/channel/config/NetworkConfigCenter;->isRequestInMonitorList(Lanet/channel/statist/RequestStatistic;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 184
    new-instance v0, Lanet/channel/statist/RequestMonitor;

    invoke-direct {v0, v3}, Lanet/channel/statist/RequestMonitor;-><init>(Lanet/channel/statist/RequestStatistic;)V

    .line 185
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v1

    invoke-interface {v1, v0}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 190
    :cond_8
    :try_start_1
    iget-object v0, v3, Lanet/channel/statist/RequestStatistic;->ip:Ljava/lang/String;

    .line 191
    iget-object v1, v3, Lanet/channel/statist/RequestStatistic;->extra:Lorg/json/JSONObject;

    if-nez v1, :cond_9

    goto :goto_1

    :cond_9
    iget-object v1, v3, Lanet/channel/statist/RequestStatistic;->extra:Lorg/json/JSONObject;

    const-string v2, "firstIp"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 192
    :goto_1
    invoke-static {v0}, Lanet/channel/strategy/utils/c;->b(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_a

    invoke-static {v4}, Lanet/channel/strategy/utils/c;->b(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 193
    :cond_a
    new-instance v0, Lanet/channel/statist/RequestMonitor;

    invoke-direct {v0, v3}, Lanet/channel/statist/RequestMonitor;-><init>(Lanet/channel/statist/RequestStatistic;)V

    .line 194
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v1

    invoke-interface {v1, v0}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 200
    :catch_0
    :cond_b
    :try_start_2
    invoke-static {}, Lanetwork/channel/stat/NetworkStat;->getNetworkStat()Lanetwork/channel/stat/INetworkStat;

    move-result-object v0

    iget-object v1, p0, Lanetwork/channel/entity/f;->c:Lanetwork/channel/entity/c;

    invoke-static {v1}, Lanetwork/channel/entity/c;->c(Lanetwork/channel/entity/c;)Lanetwork/channel/entity/g;

    move-result-object v1

    invoke-virtual {v1}, Lanetwork/channel/entity/g;->g()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lanetwork/channel/entity/f;->a:Lanetwork/channel/aidl/DefaultFinishEvent;

    invoke-virtual {v2}, Lanetwork/channel/aidl/DefaultFinishEvent;->getStatisticData()Lanetwork/channel/statist/StatisticData;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lanetwork/channel/stat/INetworkStat;->put(Ljava/lang/String;Lanetwork/channel/statist/StatisticData;)V

    .line 203
    invoke-static {v3}, Lanet/channel/detect/n;->a(Lanet/channel/statist/RequestStatistic;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :catchall_0
    :cond_c
    return-void
.end method
