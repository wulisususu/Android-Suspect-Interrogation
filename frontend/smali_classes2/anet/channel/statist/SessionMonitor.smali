.class public Lanet/channel/statist/SessionMonitor;
.super Lanet/channel/statist/SessionStatistic;
.source "Taobao"


# annotations
.annotation runtime Lanet/channel/statist/Monitor;
    module = "networkPrefer"
    monitorPoint = "session_monitor"
.end annotation


# direct methods
.method public constructor <init>(Lanet/channel/statist/SessionStatistic;)V
    .locals 2

    const/4 v0, 0x0

    .line 13
    invoke-direct {p0, v0}, Lanet/channel/statist/SessionStatistic;-><init>(Lanet/channel/entity/a;)V

    if-nez p1, :cond_0

    return-void

    .line 19
    :cond_0
    iget-object v0, p1, Lanet/channel/statist/SessionStatistic;->host:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/SessionMonitor;->host:Ljava/lang/String;

    .line 20
    iget-object v0, p1, Lanet/channel/statist/SessionStatistic;->ip:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/SessionMonitor;->ip:Ljava/lang/String;

    .line 21
    iget v0, p1, Lanet/channel/statist/SessionStatistic;->port:I

    iput v0, p0, Lanet/channel/statist/SessionMonitor;->port:I

    .line 22
    iget-object v0, p1, Lanet/channel/statist/SessionStatistic;->closeReason:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/SessionMonitor;->closeReason:Ljava/lang/String;

    .line 23
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->retryTimes:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->retryTimes:J

    .line 24
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->errorCode:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->errorCode:J

    .line 25
    iget v0, p1, Lanet/channel/statist/SessionStatistic;->sdkv:I

    iput v0, p0, Lanet/channel/statist/SessionMonitor;->sdkv:I

    .line 26
    iget-object v0, p1, Lanet/channel/statist/SessionStatistic;->conntype:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/SessionMonitor;->conntype:Ljava/lang/String;

    .line 27
    iget v0, p1, Lanet/channel/statist/SessionStatistic;->isProxy:I

    iput v0, p0, Lanet/channel/statist/SessionMonitor;->isProxy:I

    .line 28
    iget-object v0, p1, Lanet/channel/statist/SessionStatistic;->isTunnel:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/SessionMonitor;->isTunnel:Ljava/lang/String;

    .line 29
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->isKL:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->isKL:J

    .line 30
    iget v0, p1, Lanet/channel/statist/SessionStatistic;->ret:I

    iput v0, p0, Lanet/channel/statist/SessionMonitor;->ret:I

    .line 31
    iget-boolean v0, p1, Lanet/channel/statist/SessionStatistic;->isBackground:Z

    iput-boolean v0, p0, Lanet/channel/statist/SessionMonitor;->isBackground:Z

    .line 32
    iget-object v0, p1, Lanet/channel/statist/SessionStatistic;->netType:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/SessionMonitor;->netType:Ljava/lang/String;

    .line 33
    iget v0, p1, Lanet/channel/statist/SessionStatistic;->ipRefer:I

    iput v0, p0, Lanet/channel/statist/SessionMonitor;->ipRefer:I

    .line 34
    iget v0, p1, Lanet/channel/statist/SessionStatistic;->ipType:I

    iput v0, p0, Lanet/channel/statist/SessionMonitor;->ipType:I

    .line 35
    iget-object v0, p1, Lanet/channel/statist/SessionStatistic;->extra:Lorg/json/JSONObject;

    iput-object v0, p0, Lanet/channel/statist/SessionMonitor;->extra:Lorg/json/JSONObject;

    .line 38
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->connectionTime:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->connectionTime:J

    .line 39
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->authTime:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->authTime:J

    .line 40
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->sslTime:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->sslTime:J

    .line 41
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->liveTime:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->liveTime:J

    .line 42
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->requestCount:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->requestCount:J

    .line 43
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->cfRCount:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->cfRCount:J

    .line 44
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->stdRCount:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->stdRCount:J

    .line 45
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->ppkgCount:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->ppkgCount:J

    .line 46
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->pRate:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->pRate:J

    .line 47
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->ackTime:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->ackTime:J

    .line 48
    iget v0, p1, Lanet/channel/statist/SessionStatistic;->lastPingInterval:I

    iput v0, p0, Lanet/channel/statist/SessionMonitor;->lastPingInterval:I

    .line 49
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->sslCalTime:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->sslCalTime:J

    .line 50
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->sendSizeCount:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->sendSizeCount:J

    .line 51
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->recvSizeCount:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->recvSizeCount:J

    .line 52
    iget-wide v0, p1, Lanet/channel/statist/SessionStatistic;->inceptCount:J

    iput-wide v0, p0, Lanet/channel/statist/SessionMonitor;->inceptCount:J

    return-void
.end method
