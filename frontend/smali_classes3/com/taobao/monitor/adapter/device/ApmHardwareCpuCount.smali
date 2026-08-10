.class public Lcom/taobao/monitor/adapter/device/ApmHardwareCpuCount;
.super Ljava/lang/Object;
.source "ApmHardwareCpuCount.java"

# interfaces
.implements Lcom/taobao/monitor/adapter/device/ApmCalScore;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getScore()I
    .locals 3

    .line 11
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Runtime;->availableProcessors()I

    move-result v0

    const/16 v1, 0x10

    if-lt v0, v1, :cond_0

    const/16 v0, 0xa

    goto :goto_2

    :cond_0
    const/16 v1, 0x8

    if-lt v0, v1, :cond_1

    const/16 v0, 0x9

    goto :goto_2

    :cond_1
    const/4 v2, 0x6

    if-lt v0, v2, :cond_2

    :goto_0
    move v0, v1

    goto :goto_2

    :cond_2
    const/4 v1, 0x4

    if-lt v0, v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v2, 0x2

    if-lt v0, v2, :cond_4

    goto :goto_0

    :cond_4
    :goto_1
    move v0, v2

    :goto_2
    return v0
.end method
