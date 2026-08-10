.class public Lanet/channel/a/a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/fulltrace/IFullTraceAnalysis;


# instance fields
.field private a:Z


# direct methods
.method public constructor <init>()V
    .locals 4

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    :try_start_0
    const-string v0, "com.taobao.analysis.fulltrace.FullTraceAnalysis"

    .line 28
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    .line 29
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/taobao/analysis/scene/SceneIdentifier;->setContext(Landroid/content/Context;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanet/channel/a/a;->a:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lanet/channel/a/a;->a:Z

    const/4 v1, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v2, "awcn.DefaultFullTraceAnalysis"

    const-string v3, "not supoort FullTraceAnalysis"

    .line 33
    invoke-static {v2, v3, v1, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method


# virtual methods
.method public commitRequest(Ljava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    .locals 5

    iget-boolean v0, p0, Lanet/channel/a/a;->a:Z

    if-eqz v0, :cond_1

    if-eqz p2, :cond_1

    .line 48
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_0

    .line 51
    :cond_0
    new-instance v0, Lcom/taobao/analysis/fulltrace/RequestInfo;

    invoke-direct {v0}, Lcom/taobao/analysis/fulltrace/RequestInfo;-><init>()V

    .line 52
    iget-object v1, p2, Lanet/channel/statist/RequestStatistic;->host:Ljava/lang/String;

    iput-object v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->host:Ljava/lang/String;

    .line 53
    iget-object v1, p2, Lanet/channel/statist/RequestStatistic;->bizId:Ljava/lang/String;

    iput-object v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->bizId:Ljava/lang/String;

    .line 54
    iget-object v1, p2, Lanet/channel/statist/RequestStatistic;->url:Ljava/lang/String;

    iput-object v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->url:Ljava/lang/String;

    .line 55
    iget v1, p2, Lanet/channel/statist/RequestStatistic;->retryTimes:I

    iput v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->retryTimes:I

    .line 56
    iget-object v1, p2, Lanet/channel/statist/RequestStatistic;->netType:Ljava/lang/String;

    iput-object v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->netType:Ljava/lang/String;

    .line 57
    iget-object v1, p2, Lanet/channel/statist/RequestStatistic;->protocolType:Ljava/lang/String;

    iput-object v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->protocolType:Ljava/lang/String;

    .line 58
    iget v1, p2, Lanet/channel/statist/RequestStatistic;->ret:I

    iput v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->ret:I

    const/4 v1, 0x0

    .line 59
    iput-boolean v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->isCbMain:Z

    .line 60
    iget-boolean v1, p2, Lanet/channel/statist/RequestStatistic;->isReqMain:Z

    iput-boolean v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->isReqMain:Z

    .line 61
    iget-boolean v1, p2, Lanet/channel/statist/RequestStatistic;->isReqSync:Z

    iput-boolean v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->isReqSync:Z

    .line 62
    iget v1, p2, Lanet/channel/statist/RequestStatistic;->statusCode:I

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->netErrorCode:Ljava/lang/String;

    .line 63
    iget-object v1, p2, Lanet/channel/statist/RequestStatistic;->pTraceId:Ljava/lang/String;

    iput-object v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->pTraceId:Ljava/lang/String;

    .line 65
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->netReqStart:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->netReqStart:J

    .line 66
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->reqServiceTransmissionEnd:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->netReqServiceBindEnd:J

    .line 67
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->reqStart:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->netReqProcessStart:J

    .line 68
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->sendStart:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->netReqSendStart:J

    .line 69
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->rspEnd:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->netRspRecvEnd:J

    .line 70
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->rspCbDispatch:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->netRspCbDispatch:J

    .line 71
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->rspCbStart:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->netRspCbStart:J

    .line 72
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->rspCbEnd:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->netRspCbEnd:J

    .line 74
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->reqHeadDeflateSize:J

    iget-wide v3, p2, Lanet/channel/statist/RequestStatistic;->reqBodyDeflateSize:J

    add-long/2addr v1, v3

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->reqDeflateSize:J

    .line 75
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->reqHeadInflateSize:J

    iget-wide v3, p2, Lanet/channel/statist/RequestStatistic;->reqBodyInflateSize:J

    add-long/2addr v1, v3

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->reqInflateSize:J

    .line 76
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->rspHeadDeflateSize:J

    iget-wide v3, p2, Lanet/channel/statist/RequestStatistic;->rspBodyDeflateSize:J

    add-long/2addr v1, v3

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->rspDeflateSize:J

    .line 77
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->rspHeadInflateSize:J

    iget-wide v3, p2, Lanet/channel/statist/RequestStatistic;->rspBodyInflateSize:J

    add-long/2addr v1, v3

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->rspInflateSize:J

    .line 78
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->serverRT:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->serverRT:J

    .line 79
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->sendDataTime:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->sendDataTime:J

    .line 80
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->firstDataTime:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->firstDataTime:J

    .line 81
    iget-wide v1, p2, Lanet/channel/statist/RequestStatistic;->recDataTime:J

    iput-wide v1, v0, Lcom/taobao/analysis/fulltrace/RequestInfo;->recvDataTime:J

    .line 82
    invoke-static {}, Lcom/taobao/analysis/fulltrace/FullTraceAnalysis;->getInstance()Lcom/taobao/analysis/fulltrace/FullTraceAnalysis;

    move-result-object p2

    const-string v1, "network"

    invoke-virtual {p2, p1, v1, v0}, Lcom/taobao/analysis/fulltrace/FullTraceAnalysis;->commitRequest(Ljava/lang/String;Ljava/lang/String;Lcom/taobao/analysis/fulltrace/RequestInfo;)V

    nop

    :cond_1
    :goto_0
    return-void
.end method

.method public createRequest()Ljava/lang/String;
    .locals 2

    iget-boolean v0, p0, Lanet/channel/a/a;->a:Z

    if-eqz v0, :cond_0

    .line 40
    invoke-static {}, Lcom/taobao/analysis/fulltrace/FullTraceAnalysis;->getInstance()Lcom/taobao/analysis/fulltrace/FullTraceAnalysis;

    move-result-object v0

    const-string v1, "network"

    invoke-virtual {v0, v1}, Lcom/taobao/analysis/fulltrace/FullTraceAnalysis;->createRequest(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getSceneInfo()Lanet/channel/fulltrace/b;
    .locals 3

    iget-boolean v0, p0, Lanet/channel/a/a;->a:Z

    if-eqz v0, :cond_0

    .line 89
    new-instance v0, Lanet/channel/fulltrace/b;

    invoke-direct {v0}, Lanet/channel/fulltrace/b;-><init>()V

    .line 90
    invoke-static {}, Lcom/taobao/analysis/scene/SceneIdentifier;->isUrlLaunch()Z

    move-result v1

    iput-boolean v1, v0, Lanet/channel/fulltrace/b;->b:Z

    .line 91
    invoke-static {}, Lcom/taobao/analysis/scene/SceneIdentifier;->getAppLaunchTime()J

    move-result-wide v1

    iput-wide v1, v0, Lanet/channel/fulltrace/b;->c:J

    .line 92
    invoke-static {}, Lcom/taobao/analysis/scene/SceneIdentifier;->getLastLaunchTime()J

    move-result-wide v1

    iput-wide v1, v0, Lanet/channel/fulltrace/b;->d:J

    .line 93
    invoke-static {}, Lcom/taobao/analysis/scene/SceneIdentifier;->getDeviceLevel()I

    move-result v1

    iput v1, v0, Lanet/channel/fulltrace/b;->e:I

    .line 94
    invoke-static {}, Lcom/taobao/analysis/scene/SceneIdentifier;->getStartType()I

    move-result v1

    iput v1, v0, Lanet/channel/fulltrace/b;->a:I

    .line 95
    invoke-static {}, Lcom/taobao/analysis/scene/SceneIdentifier;->getBucketInfo()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lanet/channel/fulltrace/b;->f:Ljava/lang/String;

    const-string v1, "networksdk"

    .line 96
    invoke-static {v1}, Lcom/taobao/analysis/abtest/ABTestCenter;->getUTABTestBucketId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lanet/channel/fulltrace/b;->g:Ljava/lang/String;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method
