.class public Lanet/channel/flow/FlowStat;
.super Ljava/lang/Object;
.source "Taobao"


# instance fields
.field public downstream:J

.field public protocoltype:Ljava/lang/String;

.field public refer:Ljava/lang/String;

.field public req_identifier:Ljava/lang/String;

.field public upstream:J


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    .locals 2

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lanet/channel/flow/FlowStat;->refer:Ljava/lang/String;

    .line 20
    iget-object p1, p2, Lanet/channel/statist/RequestStatistic;->protocolType:Ljava/lang/String;

    iput-object p1, p0, Lanet/channel/flow/FlowStat;->protocoltype:Ljava/lang/String;

    .line 21
    iget-object p1, p2, Lanet/channel/statist/RequestStatistic;->url:Ljava/lang/String;

    iput-object p1, p0, Lanet/channel/flow/FlowStat;->req_identifier:Ljava/lang/String;

    .line 22
    iget-wide v0, p2, Lanet/channel/statist/RequestStatistic;->sendDataSize:J

    iput-wide v0, p0, Lanet/channel/flow/FlowStat;->upstream:J

    .line 23
    iget-wide p1, p2, Lanet/channel/statist/RequestStatistic;->recDataSize:J

    iput-wide p1, p0, Lanet/channel/flow/FlowStat;->downstream:J

    return-void
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 3

    .line 28
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "FlowStat{refer=\'"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lanet/channel/flow/FlowStat;->refer:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', protocoltype=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lanet/channel/flow/FlowStat;->protocoltype:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', req_identifier=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lanet/channel/flow/FlowStat;->req_identifier:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', upstream="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lanet/channel/flow/FlowStat;->upstream:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", downstream="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lanet/channel/flow/FlowStat;->downstream:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
