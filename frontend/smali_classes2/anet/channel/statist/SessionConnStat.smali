.class public Lanet/channel/statist/SessionConnStat;
.super Lanet/channel/statist/StatObject;
.source "Taobao"


# annotations
.annotation runtime Lanet/channel/statist/Monitor;
    module = "networkPrefer"
    monitorPoint = "conn_stat"
.end annotation


# instance fields
.field public accuracy:F
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public authTime:J
    .annotation runtime Lanet/channel/statist/Measure;
        max = 60000.0
    .end annotation
.end field

.field public bssid:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public errorCode:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public errorMsg:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public errorTrace:Ljava/lang/StringBuilder;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public extra:Lorg/json/JSONObject;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public host:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public ip:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public ipRefer:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public ipType:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public volatile isCommited:Z

.field public isProxy:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public lat:D
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public lng:D
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public mnc:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public netType:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public port:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public protocolType:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public ret:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public retryTimes:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public roaming:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public volatile start:J

.field public volatile startConnect:J

.field public totalTime:J
    .annotation runtime Lanet/channel/statist/Measure;
        max = 60000.0
    .end annotation
.end field

.field public unit:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 44
    invoke-direct {p0}, Lanet/channel/statist/StatObject;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lanet/channel/statist/SessionConnStat;->ipRefer:I

    const/4 v1, 0x1

    iput v1, p0, Lanet/channel/statist/SessionConnStat;->ipType:I

    const-wide v1, 0x40f5f90000000000L    # 90000.0

    iput-wide v1, p0, Lanet/channel/statist/SessionConnStat;->lng:D

    iput-wide v1, p0, Lanet/channel/statist/SessionConnStat;->lat:D

    const/high16 v1, -0x40800000    # -1.0f

    iput v1, p0, Lanet/channel/statist/SessionConnStat;->accuracy:F

    iput v0, p0, Lanet/channel/statist/SessionConnStat;->isProxy:I

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lanet/channel/statist/SessionConnStat;->totalTime:J

    iput-wide v1, p0, Lanet/channel/statist/SessionConnStat;->authTime:J

    iput-boolean v0, p0, Lanet/channel/statist/SessionConnStat;->isCommited:Z

    iput-wide v1, p0, Lanet/channel/statist/SessionConnStat;->start:J

    iput-wide v1, p0, Lanet/channel/statist/SessionConnStat;->startConnect:J

    .line 45
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getNetworkSubType()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/statist/SessionConnStat;->netType:Ljava/lang/String;

    .line 46
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getWifiBSSID()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/statist/SessionConnStat;->bssid:Ljava/lang/String;

    .line 47
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->isRoaming()Z

    move-result v0

    iput v0, p0, Lanet/channel/statist/SessionConnStat;->roaming:I

    .line 48
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getSimOp()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/statist/SessionConnStat;->mnc:Ljava/lang/String;

    const/4 v0, -0x1

    iput v0, p0, Lanet/channel/statist/SessionConnStat;->retryTimes:I

    return-void
.end method


# virtual methods
.method public appendErrorTrace(I)V
    .locals 4

    iget-object v0, p0, Lanet/channel/statist/SessionConnStat;->errorTrace:Ljava/lang/StringBuilder;

    if-nez v0, :cond_0

    .line 79
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iput-object v0, p0, Lanet/channel/statist/SessionConnStat;->errorTrace:Ljava/lang/StringBuilder;

    :cond_0
    iget-object v0, p0, Lanet/channel/statist/SessionConnStat;->errorTrace:Ljava/lang/StringBuilder;

    .line 81
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lanet/channel/statist/SessionConnStat;->errorTrace:Ljava/lang/StringBuilder;

    const-string v1, ","

    .line 82
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_1
    iget-object v0, p0, Lanet/channel/statist/SessionConnStat;->errorTrace:Ljava/lang/StringBuilder;

    .line 84
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lanet/channel/statist/SessionConnStat;->startConnect:J

    sub-long/2addr v0, v2

    invoke-virtual {p1, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    return-void
.end method

.method public beforeCommit()Z
    .locals 1

    iget-boolean v0, p0, Lanet/channel/statist/SessionConnStat;->isCommited:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lanet/channel/statist/SessionConnStat;->isCommited:Z

    return v0
.end method

.method public putExtra(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lanet/channel/statist/SessionConnStat;->extra:Lorg/json/JSONObject;

    if-nez v0, :cond_0

    .line 90
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lanet/channel/statist/SessionConnStat;->extra:Lorg/json/JSONObject;

    :cond_0
    iget-object v0, p0, Lanet/channel/statist/SessionConnStat;->extra:Lorg/json/JSONObject;

    .line 92
    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public syncValueFromSession(Lanet/channel/Session;)V
    .locals 2

    .line 53
    iget-object v0, p1, Lanet/channel/Session;->q:Lanet/channel/statist/SessionStatistic;

    .line 54
    iget-object v1, v0, Lanet/channel/statist/SessionStatistic;->ip:Ljava/lang/String;

    iput-object v1, p0, Lanet/channel/statist/SessionConnStat;->ip:Ljava/lang/String;

    .line 55
    iget v1, v0, Lanet/channel/statist/SessionStatistic;->port:I

    iput v1, p0, Lanet/channel/statist/SessionConnStat;->port:I

    .line 56
    iget v1, v0, Lanet/channel/statist/SessionStatistic;->ipRefer:I

    iput v1, p0, Lanet/channel/statist/SessionConnStat;->ipRefer:I

    .line 57
    iget v1, v0, Lanet/channel/statist/SessionStatistic;->ipType:I

    iput v1, p0, Lanet/channel/statist/SessionConnStat;->ipType:I

    .line 58
    iget-object v1, v0, Lanet/channel/statist/SessionStatistic;->conntype:Ljava/lang/String;

    iput-object v1, p0, Lanet/channel/statist/SessionConnStat;->protocolType:Ljava/lang/String;

    .line 59
    iget-object v1, v0, Lanet/channel/statist/SessionStatistic;->host:Ljava/lang/String;

    iput-object v1, p0, Lanet/channel/statist/SessionConnStat;->host:Ljava/lang/String;

    .line 60
    iget v1, v0, Lanet/channel/statist/SessionStatistic;->isProxy:I

    iput v1, p0, Lanet/channel/statist/SessionConnStat;->isProxy:I

    .line 61
    iget-wide v0, v0, Lanet/channel/statist/SessionStatistic;->authTime:J

    iput-wide v0, p0, Lanet/channel/statist/SessionConnStat;->authTime:J

    .line 62
    invoke-virtual {p1}, Lanet/channel/Session;->getUnit()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lanet/channel/statist/SessionConnStat;->unit:Ljava/lang/String;

    if-nez p1, :cond_0

    iget p1, p0, Lanet/channel/statist/SessionConnStat;->ipRefer:I

    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    const-string p1, "LocalDNS"

    iput-object p1, p0, Lanet/channel/statist/SessionConnStat;->unit:Ljava/lang/String;

    :cond_0
    return-void
.end method
