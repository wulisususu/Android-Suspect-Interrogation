.class Lanet/channel/detect/i;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/RequestCb;


# instance fields
.field final synthetic a:Lanet/channel/detect/h;


# direct methods
.method constructor <init>(Lanet/channel/detect/h;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    .line 237
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDataReceive(Lanet/channel/bytes/ByteArray;Z)V
    .locals 0

    return-void
.end method

.method public onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    .locals 5

    const-string p3, "anet.HorseRaceDetector"

    const-string v0, "LongLinkTask request finish"

    iget-object v1, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    .line 250
    iget-object v1, v1, Lanet/channel/detect/h;->c:Ljava/lang/String;

    const-string v2, "statusCode"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v4, "msg"

    filled-new-array {v2, v3, v4, p2}, [Ljava/lang/Object;

    move-result-object p2

    invoke-static {p3, v0, v1, p2}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p2, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    .line 251
    iget-object p2, p2, Lanet/channel/detect/h;->a:Lanet/channel/statist/HorseRaceStat;

    iget p2, p2, Lanet/channel/statist/HorseRaceStat;->reqErrorCode:I

    if-nez p2, :cond_0

    iget-object p2, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    .line 252
    iget-object p2, p2, Lanet/channel/detect/h;->a:Lanet/channel/statist/HorseRaceStat;

    iput p1, p2, Lanet/channel/statist/HorseRaceStat;->reqErrorCode:I

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    .line 254
    iget-object p1, p1, Lanet/channel/detect/h;->a:Lanet/channel/statist/HorseRaceStat;

    iget-object p2, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    iget-object p2, p2, Lanet/channel/detect/h;->a:Lanet/channel/statist/HorseRaceStat;

    iget p2, p2, Lanet/channel/statist/HorseRaceStat;->reqErrorCode:I

    const/16 p3, 0xc8

    if-ne p2, p3, :cond_1

    const/4 p2, 0x1

    goto :goto_0

    :cond_1
    const/4 p2, 0x0

    :goto_0
    iput p2, p1, Lanet/channel/statist/HorseRaceStat;->reqRet:I

    :goto_1
    iget-object p1, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    .line 256
    iget-object p1, p1, Lanet/channel/detect/h;->a:Lanet/channel/statist/HorseRaceStat;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2

    iget-object v0, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    iget-wide v0, v0, Lanet/channel/detect/h;->b:J

    sub-long/2addr p2, v0

    iget-object v0, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    iget-object v0, v0, Lanet/channel/detect/h;->a:Lanet/channel/statist/HorseRaceStat;

    iget-wide v0, v0, Lanet/channel/statist/HorseRaceStat;->connTime:J

    add-long/2addr p2, v0

    iput-wide p2, p1, Lanet/channel/statist/HorseRaceStat;->reqTime:J

    iget-object p1, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    .line 258
    iget-object p1, p1, Lanet/channel/detect/h;->a:Lanet/channel/statist/HorseRaceStat;

    monitor-enter p1

    :try_start_0
    iget-object p2, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    .line 259
    iget-object p2, p2, Lanet/channel/detect/h;->a:Lanet/channel/statist/HorseRaceStat;

    invoke-virtual {p2}, Ljava/lang/Object;->notify()V

    .line 260
    monitor-exit p1

    return-void

    :catchall_0
    move-exception p2

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p2
.end method

.method public onResponseCode(ILjava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    iget-object p2, p0, Lanet/channel/detect/i;->a:Lanet/channel/detect/h;

    .line 240
    iget-object p2, p2, Lanet/channel/detect/h;->a:Lanet/channel/statist/HorseRaceStat;

    iput p1, p2, Lanet/channel/statist/HorseRaceStat;->reqErrorCode:I

    return-void
.end method
