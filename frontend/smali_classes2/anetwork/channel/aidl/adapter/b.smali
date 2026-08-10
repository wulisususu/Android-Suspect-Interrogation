.class public Lanetwork/channel/aidl/adapter/b;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanetwork/channel/Network;


# static fields
.field protected static final DEGRADE:I = 0x1

.field protected static final HTTP:I = 0x0

.field protected static TAG:Ljava/lang/String; = "anet.NetworkProxy"


# instance fields
.field private mContext:Landroid/content/Context;

.field private volatile mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

.field private mType:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;I)V
    .locals 1

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    iput-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mContext:Landroid/content/Context;

    iput p2, p0, Lanetwork/channel/aidl/adapter/b;->mType:I

    return-void
.end method

.method private initDelegateInstance(Z)V
    .locals 5

    iget-object v0, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    if-eqz v0, :cond_0

    return-void

    .line 84
    :cond_0
    invoke-static {}, Lanetwork/channel/config/NetworkConfigCenter;->isRemoteNetworkServiceEnable()Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eqz v0, :cond_7

    .line 85
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isTargetProcess()Z

    move-result v0

    .line 86
    invoke-static {}, Lanetwork/channel/config/NetworkConfigCenter;->isBindServiceOptimize()Z

    move-result v3

    const/4 v4, 0x1

    if-eqz v3, :cond_3

    if-eqz v0, :cond_3

    iget-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mContext:Landroid/content/Context;

    .line 87
    invoke-static {p1, v2}, Lanetwork/channel/aidl/adapter/d;->a(Landroid/content/Context;Z)V

    .line 88
    sget-boolean p1, Lanetwork/channel/aidl/adapter/d;->c:Z

    if-eqz p1, :cond_2

    iget-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    if-nez p1, :cond_2

    iget p1, p0, Lanetwork/channel/aidl/adapter/b;->mType:I

    if-ne p1, v4, :cond_1

    .line 89
    new-instance p1, Lanetwork/channel/degrade/DegradableNetworkDelegate;

    iget-object v0, p0, Lanetwork/channel/aidl/adapter/b;->mContext:Landroid/content/Context;

    invoke-direct {p1, v0}, Lanetwork/channel/degrade/DegradableNetworkDelegate;-><init>(Landroid/content/Context;)V

    goto :goto_0

    :cond_1
    new-instance p1, Lanetwork/channel/http/HttpNetworkDelegate;

    iget-object v0, p0, Lanetwork/channel/aidl/adapter/b;->mContext:Landroid/content/Context;

    invoke-direct {p1, v0}, Lanetwork/channel/http/HttpNetworkDelegate;-><init>(Landroid/content/Context;)V

    :goto_0
    iput-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    sget-object p1, Lanetwork/channel/aidl/adapter/b;->TAG:Ljava/lang/String;

    const-string v0, "[initDelegateInstance] getNetworkInstance when binding service"

    new-array v2, v2, [Ljava/lang/Object;

    .line 90
    invoke-static {p1, v0, v1, v2}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    :cond_2
    iget p1, p0, Lanetwork/channel/aidl/adapter/b;->mType:I

    .line 93
    invoke-direct {p0, p1}, Lanetwork/channel/aidl/adapter/b;->tryGetRemoteNetworkInstance(I)V

    iget-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    if-eqz p1, :cond_4

    return-void

    :cond_3
    iget-object v3, p0, Lanetwork/channel/aidl/adapter/b;->mContext:Landroid/content/Context;

    .line 98
    invoke-static {v3, p1}, Lanetwork/channel/aidl/adapter/d;->a(Landroid/content/Context;Z)V

    iget p1, p0, Lanetwork/channel/aidl/adapter/b;->mType:I

    .line 99
    invoke-direct {p0, p1}, Lanetwork/channel/aidl/adapter/b;->tryGetRemoteNetworkInstance(I)V

    iget-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    if-eqz p1, :cond_4

    return-void

    .line 106
    :cond_4
    invoke-static {}, Lanetwork/channel/config/NetworkConfigCenter;->isAllowSpdyWhenBindServiceFailed()Z

    move-result p1

    if-eqz p1, :cond_7

    if-eqz v0, :cond_7

    sget-boolean p1, Lanetwork/channel/aidl/adapter/d;->b:Z

    if-eqz p1, :cond_7

    .line 107
    monitor-enter p0

    :try_start_0
    iget-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    if-nez p1, :cond_6

    iget p1, p0, Lanetwork/channel/aidl/adapter/b;->mType:I

    if-ne p1, v4, :cond_5

    .line 109
    new-instance p1, Lanetwork/channel/degrade/DegradableNetworkDelegate;

    iget-object v0, p0, Lanetwork/channel/aidl/adapter/b;->mContext:Landroid/content/Context;

    invoke-direct {p1, v0}, Lanetwork/channel/degrade/DegradableNetworkDelegate;-><init>(Landroid/content/Context;)V

    goto :goto_1

    :cond_5
    new-instance p1, Lanetwork/channel/http/HttpNetworkDelegate;

    iget-object v0, p0, Lanetwork/channel/aidl/adapter/b;->mContext:Landroid/content/Context;

    invoke-direct {p1, v0}, Lanetwork/channel/http/HttpNetworkDelegate;-><init>(Landroid/content/Context;)V

    :goto_1
    iput-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    sget-object p1, Lanetwork/channel/aidl/adapter/b;->TAG:Ljava/lang/String;

    const-string v0, "[initDelegateInstance] getNetworkInstance when bindService failed."

    new-array v2, v2, [Ljava/lang/Object;

    .line 110
    invoke-static {p1, v0, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 111
    monitor-exit p0

    return-void

    .line 113
    :cond_6
    monitor-exit p0

    goto :goto_2

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    .line 117
    :cond_7
    :goto_2
    monitor-enter p0

    :try_start_1
    iget-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    if-nez p1, :cond_9

    const/4 p1, 0x2

    .line 119
    invoke-static {p1}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result p1

    if-eqz p1, :cond_8

    sget-object p1, Lanetwork/channel/aidl/adapter/b;->TAG:Ljava/lang/String;

    const-string v0, "[getLocalNetworkInstance]"

    new-array v2, v2, [Ljava/lang/Object;

    .line 120
    invoke-static {p1, v0, v1, v2}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 122
    :cond_8
    new-instance p1, Lanetwork/channel/http/HttpNetworkDelegate;

    iget-object v0, p0, Lanetwork/channel/aidl/adapter/b;->mContext:Landroid/content/Context;

    invoke-direct {p1, v0}, Lanetwork/channel/http/HttpNetworkDelegate;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    .line 124
    :cond_9
    monitor-exit p0

    return-void

    :catchall_1
    move-exception p1

    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    throw p1
.end method

.method private recordRequestStat(Lanetwork/channel/Request;)V
    .locals 3

    if-nez p1, :cond_0

    return-void

    .line 193
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const-string v2, "f-netReqStart"

    .line 194
    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v2, v0}, Lanetwork/channel/Request;->setExtProperty(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "f-traceId"

    .line 196
    invoke-interface {p1, v0}, Lanetwork/channel/Request;->getExtProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 197
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 198
    invoke-static {}, Lanet/channel/fulltrace/a;->a()Lanet/channel/fulltrace/IFullTraceAnalysis;

    move-result-object v1

    invoke-interface {v1}, Lanet/channel/fulltrace/IFullTraceAnalysis;->createRequest()Ljava/lang/String;

    move-result-object v1

    .line 200
    :cond_1
    invoke-interface {p1, v0, v1}, Lanetwork/channel/Request;->setExtProperty(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "f-reqProcess"

    .line 201
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getCurrentProcess()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v0, v1}, Lanetwork/channel/Request;->setExtProperty(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private reportRemoteError(Ljava/lang/Throwable;Ljava/lang/String;)V
    .locals 3

    sget-object v0, Lanetwork/channel/aidl/adapter/b;->TAG:Ljava/lang/String;

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    .line 183
    invoke-static {v0, v2, p2, p1, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 184
    new-instance p2, Lanet/channel/statist/ExceptionStatistic;

    const/16 v0, -0x67

    const-string v1, "rt"

    invoke-direct {p2, v0, v2, v1}, Lanet/channel/statist/ExceptionStatistic;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    .line 185
    invoke-virtual {p1}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p2, Lanet/channel/statist/ExceptionStatistic;->exceptionStack:Ljava/lang/String;

    .line 186
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    invoke-interface {p1, p2}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    return-void
.end method

.method private declared-synchronized tryGetRemoteNetworkInstance(I)V
    .locals 4

    const-string v0, "[tryGetRemoteNetworkInstance] type="

    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v1, :cond_0

    .line 165
    monitor-exit p0

    return-void

    :cond_0
    const/4 v1, 0x2

    .line 168
    :try_start_1
    invoke-static {v1}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Lanetwork/channel/aidl/adapter/b;->TAG:Ljava/lang/String;

    .line 169
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {v1, v0, v3, v2}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 172
    :cond_1
    invoke-static {}, Lanetwork/channel/aidl/adapter/d;->a()Lanetwork/channel/aidl/IRemoteNetworkGetter;

    move-result-object v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    if-eqz v0, :cond_2

    .line 175
    :try_start_2
    invoke-interface {v0, p1}, Lanetwork/channel/aidl/IRemoteNetworkGetter;->get(I)Lanetwork/channel/aidl/RemoteNetwork;

    move-result-object p1

    iput-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    :try_start_3
    const-string v0, "[tryGetRemoteNetworkInstance]get RemoteNetwork Delegate failed."

    .line 177
    invoke-direct {p0, p1, v0}, Lanetwork/channel/aidl/adapter/b;->reportRemoteError(Ljava/lang/Throwable;Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 180
    :cond_2
    :goto_0
    monitor-exit p0

    return-void

    :catchall_1
    move-exception p1

    monitor-exit p0

    throw p1
.end method


# virtual methods
.method public asyncSend(Lanetwork/channel/Request;Ljava/lang/Object;Landroid/os/Handler;Lanetwork/channel/NetworkListener;)Ljava/util/concurrent/Future;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lanetwork/channel/Request;",
            "Ljava/lang/Object;",
            "Landroid/os/Handler;",
            "Lanetwork/channel/NetworkListener;",
            ")",
            "Ljava/util/concurrent/Future<",
            "Lanetwork/channel/Response;",
            ">;"
        }
    .end annotation

    sget-object v0, Lanetwork/channel/aidl/adapter/b;->TAG:Ljava/lang/String;

    .line 129
    invoke-interface {p1}, Lanetwork/channel/Request;->getSeqNo()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    const-string v4, "networkProxy asyncSend"

    invoke-static {v0, v4, v1, v3}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 130
    invoke-direct {p0, p1}, Lanetwork/channel/aidl/adapter/b;->recordRequestStat(Lanetwork/channel/Request;)V

    .line 131
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-eq v0, v1, :cond_0

    const/4 v2, 0x1

    :cond_0
    invoke-direct {p0, v2}, Lanetwork/channel/aidl/adapter/b;->initDelegateInstance(Z)V

    .line 132
    new-instance v0, Lanetwork/channel/aidl/ParcelableRequest;

    invoke-direct {v0, p1}, Lanetwork/channel/aidl/ParcelableRequest;-><init>(Lanetwork/channel/Request;)V

    if-nez p4, :cond_2

    if-eqz p3, :cond_1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    goto :goto_1

    .line 135
    :cond_2
    :goto_0
    new-instance p1, Lanetwork/channel/aidl/adapter/ParcelableNetworkListenerWrapper;

    invoke-direct {p1, p4, p3, p2}, Lanetwork/channel/aidl/adapter/ParcelableNetworkListenerWrapper;-><init>(Lanetwork/channel/NetworkListener;Landroid/os/Handler;Ljava/lang/Object;)V

    .line 138
    :goto_1
    iget-object p2, v0, Lanetwork/channel/aidl/ParcelableRequest;->url:Ljava/lang/String;

    const/16 p3, -0x66

    if-nez p2, :cond_4

    if-eqz p1, :cond_3

    .line 141
    :try_start_0
    new-instance p2, Lanetwork/channel/aidl/DefaultFinishEvent;

    invoke-direct {p2, p3}, Lanetwork/channel/aidl/DefaultFinishEvent;-><init>(I)V

    invoke-virtual {p1, p2}, Lanetwork/channel/aidl/adapter/ParcelableNetworkListenerWrapper;->onFinished(Lanetwork/channel/aidl/DefaultFinishEvent;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 145
    :catch_0
    :cond_3
    new-instance p1, Lanetwork/channel/aidl/adapter/a;

    new-instance p2, Lanetwork/channel/aidl/NetworkResponse;

    invoke-direct {p2, p3}, Lanetwork/channel/aidl/NetworkResponse;-><init>(I)V

    invoke-direct {p1, p2}, Lanetwork/channel/aidl/adapter/a;-><init>(Lanetwork/channel/Response;)V

    return-object p1

    .line 149
    :cond_4
    :try_start_1
    new-instance p2, Lanetwork/channel/aidl/adapter/a;

    iget-object p4, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    invoke-interface {p4, v0, p1}, Lanetwork/channel/aidl/RemoteNetwork;->asyncSend(Lanetwork/channel/aidl/ParcelableRequest;Lanetwork/channel/aidl/ParcelableNetworkListener;)Lanetwork/channel/aidl/ParcelableFuture;

    move-result-object p4

    invoke-direct {p2, p4}, Lanetwork/channel/aidl/adapter/a;-><init>(Lanetwork/channel/aidl/ParcelableFuture;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    return-object p2

    :catchall_0
    move-exception p2

    if-eqz p1, :cond_5

    .line 153
    :try_start_2
    new-instance p4, Lanetwork/channel/aidl/DefaultFinishEvent;

    invoke-direct {p4, p3}, Lanetwork/channel/aidl/DefaultFinishEvent;-><init>(I)V

    invoke-virtual {p1, p4}, Lanetwork/channel/aidl/adapter/ParcelableNetworkListenerWrapper;->onFinished(Lanetwork/channel/aidl/DefaultFinishEvent;)V
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_5
    const-string p1, "[asyncSend]call asyncSend exception"

    .line 158
    invoke-direct {p0, p2, p1}, Lanetwork/channel/aidl/adapter/b;->reportRemoteError(Ljava/lang/Throwable;Ljava/lang/String;)V

    .line 159
    new-instance p1, Lanetwork/channel/aidl/adapter/a;

    new-instance p2, Lanetwork/channel/aidl/NetworkResponse;

    const/16 p3, -0x67

    invoke-direct {p2, p3}, Lanetwork/channel/aidl/NetworkResponse;-><init>(I)V

    invoke-direct {p1, p2}, Lanetwork/channel/aidl/adapter/a;-><init>(Lanetwork/channel/Response;)V

    return-object p1
.end method

.method public getConnection(Lanetwork/channel/Request;Ljava/lang/Object;)Lanetwork/channel/aidl/Connection;
    .locals 3

    sget-object p2, Lanetwork/channel/aidl/adapter/b;->TAG:Ljava/lang/String;

    .line 48
    invoke-interface {p1}, Lanetwork/channel/Request;->getSeqNo()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "networkProxy getConnection"

    invoke-static {p2, v2, v0, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 49
    invoke-direct {p0, p1}, Lanetwork/channel/aidl/adapter/b;->recordRequestStat(Lanetwork/channel/Request;)V

    const/4 p2, 0x1

    .line 50
    invoke-direct {p0, p2}, Lanetwork/channel/aidl/adapter/b;->initDelegateInstance(Z)V

    .line 51
    new-instance p2, Lanetwork/channel/aidl/ParcelableRequest;

    invoke-direct {p2, p1}, Lanetwork/channel/aidl/ParcelableRequest;-><init>(Lanetwork/channel/Request;)V

    .line 52
    iget-object p1, p2, Lanetwork/channel/aidl/ParcelableRequest;->url:Ljava/lang/String;

    if-nez p1, :cond_0

    .line 53
    new-instance p1, Lanetwork/channel/aidl/adapter/ConnectionDelegate;

    const/16 p2, -0x66

    invoke-direct {p1, p2}, Lanetwork/channel/aidl/adapter/ConnectionDelegate;-><init>(I)V

    return-object p1

    :cond_0
    :try_start_0
    iget-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    .line 56
    invoke-interface {p1, p2}, Lanetwork/channel/aidl/RemoteNetwork;->getConnection(Lanetwork/channel/aidl/ParcelableRequest;)Lanetwork/channel/aidl/Connection;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    const-string p2, "[getConnection]call getConnection method failed."

    .line 58
    invoke-direct {p0, p1, p2}, Lanetwork/channel/aidl/adapter/b;->reportRemoteError(Ljava/lang/Throwable;Ljava/lang/String;)V

    .line 59
    new-instance p1, Lanetwork/channel/aidl/adapter/ConnectionDelegate;

    const/16 p2, -0x67

    invoke-direct {p1, p2}, Lanetwork/channel/aidl/adapter/ConnectionDelegate;-><init>(I)V

    return-object p1
.end method

.method public syncSend(Lanetwork/channel/Request;Ljava/lang/Object;)Lanetwork/channel/Response;
    .locals 3

    sget-object p2, Lanetwork/channel/aidl/adapter/b;->TAG:Ljava/lang/String;

    .line 65
    invoke-interface {p1}, Lanetwork/channel/Request;->getSeqNo()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "networkProxy syncSend"

    invoke-static {p2, v2, v0, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 66
    invoke-direct {p0, p1}, Lanetwork/channel/aidl/adapter/b;->recordRequestStat(Lanetwork/channel/Request;)V

    const/4 p2, 0x1

    .line 67
    invoke-direct {p0, p2}, Lanetwork/channel/aidl/adapter/b;->initDelegateInstance(Z)V

    .line 68
    new-instance p2, Lanetwork/channel/aidl/ParcelableRequest;

    invoke-direct {p2, p1}, Lanetwork/channel/aidl/ParcelableRequest;-><init>(Lanetwork/channel/Request;)V

    .line 69
    iget-object p1, p2, Lanetwork/channel/aidl/ParcelableRequest;->url:Ljava/lang/String;

    if-nez p1, :cond_0

    .line 70
    new-instance p1, Lanetwork/channel/aidl/NetworkResponse;

    const/16 p2, -0x66

    invoke-direct {p1, p2}, Lanetwork/channel/aidl/NetworkResponse;-><init>(I)V

    return-object p1

    :cond_0
    :try_start_0
    iget-object p1, p0, Lanetwork/channel/aidl/adapter/b;->mDelegate:Lanetwork/channel/aidl/RemoteNetwork;

    .line 73
    invoke-interface {p1, p2}, Lanetwork/channel/aidl/RemoteNetwork;->syncSend(Lanetwork/channel/aidl/ParcelableRequest;)Lanetwork/channel/aidl/NetworkResponse;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    const-string p2, "[syncSend]call syncSend method failed."

    .line 75
    invoke-direct {p0, p1, p2}, Lanetwork/channel/aidl/adapter/b;->reportRemoteError(Ljava/lang/Throwable;Ljava/lang/String;)V

    .line 76
    new-instance p1, Lanetwork/channel/aidl/NetworkResponse;

    const/16 p2, -0x67

    invoke-direct {p1, p2}, Lanetwork/channel/aidl/NetworkResponse;-><init>(I)V

    return-object p1
.end method
