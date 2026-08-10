.class Lcom/taobao/monitor/adapter/device/ApmHardwareUseTime;
.super Ljava/lang/Object;
.source "ApmHardwareUseTime.java"

# interfaces
.implements Lcom/taobao/monitor/adapter/device/ApmCalScore;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getScore()I
    .locals 8

    const-string v0, "/sdcard/Android/"

    const/high16 v1, 0x40a00000    # 5.0f

    const/4 v2, 0x0

    const/high16 v3, 0x40e00000    # 7.0f

    .line 16
    :try_start_0
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 17
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 18
    invoke-virtual {v4}, Ljava/io/File;->lastModified()J

    move-result-wide v4

    .line 19
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    sub-long/2addr v6, v4

    .line 20
    invoke-static {v6, v7}, Ljava/lang/Math;->abs(J)J

    move-result-wide v4

    const-wide v6, 0x9a7ec800L

    .line 22
    div-long/2addr v4, v6

    const-wide/16 v6, 0x64

    cmp-long v0, v4, v6

    if-lez v0, :cond_0

    move v3, v1

    goto :goto_0

    :cond_0
    const-wide/16 v6, 0x32

    cmp-long v0, v4, v6

    if-lez v0, :cond_1

    move v3, v2

    goto :goto_0

    :cond_1
    const v0, 0x3e4ccccd    # 0.2f

    long-to-float v4, v4

    mul-float/2addr v4, v0

    const/high16 v0, 0x41200000    # 10.0f

    sub-float/2addr v0, v4

    .line 32
    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    int-to-float v0, v0

    move v3, v0

    :catchall_0
    :cond_2
    :goto_0
    cmpg-float v0, v3, v2

    if-gez v0, :cond_3

    goto :goto_1

    :cond_3
    move v1, v3

    :goto_1
    float-to-int v0, v1

    return v0
.end method
