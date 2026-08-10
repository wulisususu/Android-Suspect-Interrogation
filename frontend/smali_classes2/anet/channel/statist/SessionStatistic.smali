.class public Lanet/channel/statist/SessionStatistic;
.super Lanet/channel/statist/StatObject;
.source "Taobao"


# annotations
.annotation runtime Lanet/channel/statist/Monitor;
    module = "networkPrefer"
    monitorPoint = "session"
.end annotation


# static fields
.field public static maxRetryTime:I


# instance fields
.field public ackTime:J
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public authTime:J
    .annotation runtime Lanet/channel/statist/Measure;
        max = 15000.0
    .end annotation
.end field

.field public cfRCount:J
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public closeReason:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public congControlKind:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public connectionTime:J
    .annotation runtime Lanet/channel/statist/Measure;
        max = 15000.0
        name = "connTime"
    .end annotation
.end field

.field public conntype:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
        name = "protocolType"
    .end annotation
.end field

.field public dcid:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public errorCode:J
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

.field public inceptCount:J
    .annotation runtime Lanet/channel/statist/Measure;
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

.field public isBackground:Z
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public isCommitted:Z

.field public isKL:J
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public isProxy:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public isTunnel:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public lastPingInterval:I
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public liveTime:J
    .annotation runtime Lanet/channel/statist/Measure;
        max = 86400.0
    .end annotation
.end field

.field public lossRate:D
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public netType:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public pRate:J
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public port:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public ppkgCount:J
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public recvSizeCount:J
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public requestCount:J
    .annotation runtime Lanet/channel/statist/Measure;
        constantValue = 1.0
    .end annotation
.end field

.field public ret:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public retransmissionRate:D
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public retryTimes:J
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public rtoCount:I
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public scid:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public sdkv:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public sendSizeCount:J
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public srtt:J
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public sslCalTime:J
    .annotation runtime Lanet/channel/statist/Measure;
        max = 15000.0
    .end annotation
.end field

.field public sslTime:J
    .annotation runtime Lanet/channel/statist/Measure;
        max = 15000.0
    .end annotation
.end field

.field public stdRCount:J
    .annotation runtime Lanet/channel/statist/Measure;
        constantValue = 0.0
    .end annotation
.end field

.field public tlpCount:I
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public xqc0RttStatus:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public xqcConnEnv:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lanet/channel/entity/a;)V
    .locals 4

    .line 72
    invoke-direct {p0}, Lanet/channel/statist/StatObject;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lanet/channel/statist/SessionStatistic;->isProxy:I

    iput v0, p0, Lanet/channel/statist/SessionStatistic;->ipRefer:I

    const/4 v1, 0x1

    iput v1, p0, Lanet/channel/statist/SessionStatistic;->ipType:I

    const/4 v1, 0x0

    iput-object v1, p0, Lanet/channel/statist/SessionStatistic;->extra:Lorg/json/JSONObject;

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lanet/channel/statist/SessionStatistic;->liveTime:J

    const-wide/16 v2, 0x1

    iput-wide v2, p0, Lanet/channel/statist/SessionStatistic;->requestCount:J

    iput-wide v2, p0, Lanet/channel/statist/SessionStatistic;->stdRCount:J

    iput-boolean v0, p0, Lanet/channel/statist/SessionStatistic;->isCommitted:Z

    if-nez p1, :cond_0

    return-void

    .line 77
    :cond_0
    invoke-virtual {p1}, Lanet/channel/entity/a;->a()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/statist/SessionStatistic;->ip:Ljava/lang/String;

    .line 78
    invoke-virtual {p1}, Lanet/channel/entity/a;->b()I

    move-result v0

    iput v0, p0, Lanet/channel/statist/SessionStatistic;->port:I

    .line 79
    iget-object v0, p1, Lanet/channel/entity/a;->a:Lanet/channel/strategy/IConnStrategy;

    if-eqz v0, :cond_1

    .line 80
    iget-object v0, p1, Lanet/channel/entity/a;->a:Lanet/channel/strategy/IConnStrategy;

    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getIpSource()I

    move-result v0

    iput v0, p0, Lanet/channel/statist/SessionStatistic;->ipRefer:I

    .line 81
    iget-object v0, p1, Lanet/channel/entity/a;->a:Lanet/channel/strategy/IConnStrategy;

    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getIpType()I

    move-result v0

    iput v0, p0, Lanet/channel/statist/SessionStatistic;->ipType:I

    .line 83
    :cond_1
    invoke-virtual {p1}, Lanet/channel/entity/a;->g()I

    move-result v0

    int-to-long v2, v0

    iput-wide v2, p0, Lanet/channel/statist/SessionStatistic;->pRate:J

    .line 84
    invoke-virtual {p1}, Lanet/channel/entity/a;->c()Lanet/channel/entity/ConnType;

    move-result-object v0

    invoke-virtual {v0}, Lanet/channel/entity/ConnType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/statist/SessionStatistic;->conntype:Ljava/lang/String;

    .line 85
    iget v0, p1, Lanet/channel/entity/a;->b:I

    int-to-long v2, v0

    iput-wide v2, p0, Lanet/channel/statist/SessionStatistic;->retryTimes:J

    .line 86
    iget p1, p1, Lanet/channel/entity/a;->c:I

    sput p1, Lanet/channel/statist/SessionStatistic;->maxRetryTime:I

    .line 89
    invoke-static {}, Lanet/channel/fulltrace/a;->a()Lanet/channel/fulltrace/IFullTraceAnalysis;

    move-result-object p1

    invoke-interface {p1}, Lanet/channel/fulltrace/IFullTraceAnalysis;->getSceneInfo()Lanet/channel/fulltrace/b;

    move-result-object p1

    if-eqz p1, :cond_2

    .line 91
    iget-object v1, p1, Lanet/channel/fulltrace/b;->f:Ljava/lang/String;

    .line 93
    :cond_2
    invoke-static {}, Lanet/channel/e/a;->b()Z

    move-result p1

    .line 94
    invoke-static {}, Lanet/channel/AwcnConfig;->isHttp3OrangeEnable()Z

    move-result v0

    .line 95
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 96
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "_"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 97
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lanet/channel/statist/SessionStatistic;->xqcConnEnv:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public beforeCommit()Z
    .locals 7

    iget v0, p0, Lanet/channel/statist/SessionStatistic;->ret:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez v0, :cond_2

    iget-wide v3, p0, Lanet/channel/statist/SessionStatistic;->retryTimes:J

    sget v0, Lanet/channel/statist/SessionStatistic;->maxRetryTime:I

    int-to-long v5, v0

    cmp-long v0, v3, v5

    if-nez v0, :cond_0

    iget-wide v3, p0, Lanet/channel/statist/SessionStatistic;->errorCode:J

    const-wide/16 v5, -0xa35

    cmp-long v0, v3, v5

    if-eqz v0, :cond_0

    const-wide/16 v5, -0xa29

    cmp-long v0, v3, v5

    if-nez v0, :cond_2

    .line 105
    :cond_0
    invoke-static {v2}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-wide v2, p0, Lanet/channel/statist/SessionStatistic;->retryTimes:J

    .line 106
    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    sget v2, Lanet/channel/statist/SessionStatistic;->maxRetryTime:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    iget-wide v3, p0, Lanet/channel/statist/SessionStatistic;->errorCode:J

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    const-string v4, "maxRetryTime"

    const-string v5, "errorCode"

    filled-new-array {v0, v4, v2, v5, v3}, [Ljava/lang/Object;

    move-result-object v0

    const-string v2, "SessionStat no need commit"

    const/4 v3, 0x0

    const-string v4, "retry:"

    invoke-static {v2, v3, v4, v0}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    return v1

    :cond_2
    iget-boolean v0, p0, Lanet/channel/statist/SessionStatistic;->isCommitted:Z

    if-eqz v0, :cond_3

    return v1

    :cond_3
    iput-boolean v2, p0, Lanet/channel/statist/SessionStatistic;->isCommitted:Z

    return v2
.end method

.method public getAlarmObject()Lanet/channel/statist/AlarmObject;
    .locals 3

    .line 118
    new-instance v0, Lanet/channel/statist/AlarmObject;

    invoke-direct {v0}, Lanet/channel/statist/AlarmObject;-><init>()V

    const-string v1, "networkPrefer"

    .line 119
    iput-object v1, v0, Lanet/channel/statist/AlarmObject;->module:Ljava/lang/String;

    const-string v1, "connect_succ_rate"

    .line 120
    iput-object v1, v0, Lanet/channel/statist/AlarmObject;->modulePoint:Ljava/lang/String;

    iget v1, p0, Lanet/channel/statist/SessionStatistic;->ret:I

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 121
    :goto_0
    iput-boolean v1, v0, Lanet/channel/statist/AlarmObject;->isSuccess:Z

    .line 122
    iget-boolean v1, v0, Lanet/channel/statist/AlarmObject;->isSuccess:Z

    if-eqz v1, :cond_1

    iget-object v1, p0, Lanet/channel/statist/SessionStatistic;->closeReason:Ljava/lang/String;

    .line 123
    iput-object v1, v0, Lanet/channel/statist/AlarmObject;->arg:Ljava/lang/String;

    goto :goto_1

    :cond_1
    iget-wide v1, p0, Lanet/channel/statist/SessionStatistic;->errorCode:J

    .line 125
    invoke-static {v1, v2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lanet/channel/statist/AlarmObject;->errorCode:Ljava/lang/String;

    :goto_1
    return-object v0
.end method
