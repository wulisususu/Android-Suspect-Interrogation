.class public Lanet/channel/statist/RequestMonitor;
.super Lanet/channel/statist/RequestStatistic;
.source "Taobao"


# annotations
.annotation runtime Lanet/channel/statist/Monitor;
    module = "networkPrefer"
    monitorPoint = "request_monitor"
.end annotation


# direct methods
.method public constructor <init>(Lanet/channel/statist/RequestStatistic;)V
    .locals 2

    const/4 v0, 0x0

    .line 12
    invoke-direct {p0, v0, v0}, Lanet/channel/statist/RequestStatistic;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    if-nez p1, :cond_0

    return-void

    .line 17
    :cond_0
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->host:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->host:Ljava/lang/String;

    .line 18
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->ip:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->ip:Ljava/lang/String;

    .line 19
    iget v0, p1, Lanet/channel/statist/RequestStatistic;->port:I

    iput v0, p0, Lanet/channel/statist/RequestMonitor;->port:I

    .line 20
    iget-boolean v0, p1, Lanet/channel/statist/RequestStatistic;->isSSL:Z

    iput-boolean v0, p0, Lanet/channel/statist/RequestMonitor;->isSSL:Z

    .line 21
    iget v0, p1, Lanet/channel/statist/RequestStatistic;->ipRefer:I

    iput v0, p0, Lanet/channel/statist/RequestMonitor;->ipRefer:I

    .line 22
    iget v0, p1, Lanet/channel/statist/RequestStatistic;->ipType:I

    iput v0, p0, Lanet/channel/statist/RequestMonitor;->ipType:I

    .line 23
    iget-boolean v0, p1, Lanet/channel/statist/RequestStatistic;->isProxy:Z

    iput-boolean v0, p0, Lanet/channel/statist/RequestMonitor;->isProxy:Z

    .line 24
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->proxyType:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->proxyType:Ljava/lang/String;

    .line 25
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->netType:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->netType:Ljava/lang/String;

    .line 26
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->bssid:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->bssid:Ljava/lang/String;

    .line 27
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->protocolType:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->protocolType:Ljava/lang/String;

    .line 28
    iget-boolean v0, p1, Lanet/channel/statist/RequestStatistic;->isDNS:Z

    iput-boolean v0, p0, Lanet/channel/statist/RequestMonitor;->isDNS:Z

    .line 29
    iget v0, p1, Lanet/channel/statist/RequestStatistic;->retryTimes:I

    iput v0, p0, Lanet/channel/statist/RequestMonitor;->retryTimes:I

    .line 30
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->bizId:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->bizId:Ljava/lang/String;

    .line 31
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->f_refer:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->f_refer:Ljava/lang/String;

    .line 32
    iget v0, p1, Lanet/channel/statist/RequestStatistic;->ret:I

    iput v0, p0, Lanet/channel/statist/RequestMonitor;->ret:I

    .line 33
    iget v0, p1, Lanet/channel/statist/RequestStatistic;->statusCode:I

    iput v0, p0, Lanet/channel/statist/RequestMonitor;->statusCode:I

    .line 34
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->msg:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->msg:Ljava/lang/String;

    .line 35
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->contentEncoding:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->contentEncoding:Ljava/lang/String;

    .line 36
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->contentType:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->contentType:Ljava/lang/String;

    .line 37
    iget v0, p1, Lanet/channel/statist/RequestStatistic;->degraded:I

    iput v0, p0, Lanet/channel/statist/RequestMonitor;->degraded:I

    .line 38
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->isBg:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->isBg:Ljava/lang/String;

    .line 39
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->errorTrace:Ljava/lang/StringBuilder;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->errorTrace:Ljava/lang/StringBuilder;

    .line 40
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->url:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->url:Ljava/lang/String;

    .line 41
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->lng:D

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->lng:D

    .line 42
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->lat:D

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->lat:D

    .line 43
    iget v0, p1, Lanet/channel/statist/RequestStatistic;->accuracy:F

    iput v0, p0, Lanet/channel/statist/RequestMonitor;->accuracy:F

    .line 44
    iget v0, p1, Lanet/channel/statist/RequestStatistic;->roaming:I

    iput v0, p0, Lanet/channel/statist/RequestMonitor;->roaming:I

    .line 45
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->mnc:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->mnc:Ljava/lang/String;

    .line 46
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->unit:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->unit:Ljava/lang/String;

    .line 47
    iget-object v0, p1, Lanet/channel/statist/RequestStatistic;->extra:Lorg/json/JSONObject;

    iput-object v0, p0, Lanet/channel/statist/RequestMonitor;->extra:Lorg/json/JSONObject;

    .line 50
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->reqHeadInflateSize:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->reqHeadInflateSize:J

    .line 51
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->reqBodyInflateSize:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->reqBodyInflateSize:J

    .line 52
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->reqHeadDeflateSize:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->reqHeadDeflateSize:J

    .line 53
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->reqBodyDeflateSize:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->reqBodyDeflateSize:J

    .line 54
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->rspHeadInflateSize:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->rspHeadInflateSize:J

    .line 55
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->rspBodyInflateSize:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->rspBodyInflateSize:J

    .line 56
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->rspHeadDeflateSize:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->rspHeadDeflateSize:J

    .line 57
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->rspBodyDeflateSize:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->rspBodyDeflateSize:J

    .line 58
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->retryCostTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->retryCostTime:J

    .line 59
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->connWaitTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->connWaitTime:J

    .line 60
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->sendBeforeTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->sendBeforeTime:J

    .line 61
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->processTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->processTime:J

    .line 62
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->sendDataTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->sendDataTime:J

    .line 63
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->firstDataTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->firstDataTime:J

    .line 64
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->recDataTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->recDataTime:J

    .line 65
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->serverRT:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->serverRT:J

    .line 66
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->cacheTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->cacheTime:J

    .line 67
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->lastProcessTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->lastProcessTime:J

    .line 68
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->callbackTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->callbackTime:J

    .line 69
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->oneWayTime:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->oneWayTime:J

    .line 70
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->sendDataSize:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->sendDataSize:J

    .line 71
    iget-wide v0, p1, Lanet/channel/statist/RequestStatistic;->recDataSize:J

    iput-wide v0, p0, Lanet/channel/statist/RequestMonitor;->recDataSize:J

    return-void
.end method
