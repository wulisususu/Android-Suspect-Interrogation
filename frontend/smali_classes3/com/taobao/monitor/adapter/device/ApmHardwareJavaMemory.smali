.class public Lcom/taobao/monitor/adapter/device/ApmHardwareJavaMemory;
.super Ljava/lang/Object;
.source "ApmHardwareJavaMemory.java"

# interfaces
.implements Lcom/taobao/monitor/adapter/device/ApmCalScore;


# instance fields
.field private mJavaHeapLimitLargeMemory:I

.field private mJavaHeapLimitMemory:I


# direct methods
.method constructor <init>()V
    .locals 2

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object v0

    const-string v1, "activity"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    if-eqz v0, :cond_0

    .line 22
    invoke-virtual {v0}, Landroid/app/ActivityManager;->getMemoryClass()I

    move-result v1

    iput v1, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareJavaMemory;->mJavaHeapLimitMemory:I

    .line 23
    invoke-virtual {v0}, Landroid/app/ActivityManager;->getLargeMemoryClass()I

    move-result v0

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareJavaMemory;->mJavaHeapLimitLargeMemory:I

    :cond_0
    return-void
.end method


# virtual methods
.method public getScore()I
    .locals 7

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareJavaMemory;->mJavaHeapLimitMemory:I

    const/16 v1, 0x80

    const/16 v2, 0x8

    const/16 v3, 0xa

    const/16 v4, 0x100

    if-le v0, v4, :cond_0

    move v0, v3

    goto :goto_0

    :cond_0
    if-lt v0, v4, :cond_1

    move v0, v2

    goto :goto_0

    :cond_1
    const/16 v5, 0xc0

    if-lt v0, v5, :cond_2

    const/4 v0, 0x7

    goto :goto_0

    :cond_2
    if-lt v0, v1, :cond_3

    const/4 v0, 0x5

    goto :goto_0

    :cond_3
    const/16 v5, 0x60

    if-lt v0, v5, :cond_4

    const/4 v0, 0x3

    goto :goto_0

    :cond_4
    const/4 v0, 0x4

    :goto_0
    iget v5, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareJavaMemory;->mJavaHeapLimitLargeMemory:I

    const/16 v6, 0x200

    if-lt v5, v6, :cond_5

    move v2, v3

    goto :goto_1

    :cond_5
    if-lt v5, v4, :cond_6

    goto :goto_1

    :cond_6
    if-lt v5, v1, :cond_7

    const/4 v2, 0x6

    goto :goto_1

    :cond_7
    const/4 v2, 0x1

    :goto_1
    add-int/2addr v2, v0

    .line 50
    div-int/lit8 v2, v2, 0x2

    return v2
.end method
