.class public Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;
.super Ljava/lang/Object;
.source "ApmHardwareStorage.java"

# interfaces
.implements Lcom/taobao/monitor/adapter/device/ApmCalScore;


# instance fields
.field private mInnerFree:I

.field private mInnerSize:I


# direct methods
.method constructor <init>()V
    .locals 8

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x30

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->mInnerSize:I

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->mInnerFree:I

    .line 18
    :try_start_0
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    .line 19
    new-instance v1, Landroid/os/StatFs;

    invoke-direct {v1, v0}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 20
    invoke-virtual {v1}, Landroid/os/StatFs;->getBlockSize()I

    move-result v0

    int-to-long v2, v0

    .line 21
    invoke-virtual {v1}, Landroid/os/StatFs;->getBlockCount()I

    move-result v0

    int-to-long v4, v0

    mul-long/2addr v4, v2

    const-wide/16 v6, 0x400

    .line 22
    div-long/2addr v4, v6

    div-long/2addr v4, v6

    div-long/2addr v4, v6

    long-to-int v0, v4

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->mInnerSize:I

    .line 23
    invoke-virtual {v1}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v0

    int-to-long v0, v0

    mul-long/2addr v2, v0

    div-long/2addr v2, v6

    div-long/2addr v2, v6

    div-long/2addr v2, v6

    long-to-int v0, v2

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->mInnerFree:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public getScore()I
    .locals 13

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->mInnerSize:I

    const/16 v1, 0x30

    if-gtz v0, :cond_0

    iput v1, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->mInnerSize:I

    :cond_0
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->mInnerFree:I

    const/16 v2, 0x18

    if-gtz v0, :cond_1

    iput v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->mInnerFree:I

    :cond_1
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->mInnerSize:I

    const/16 v3, 0xdc

    const/4 v4, 0x6

    const/16 v5, 0x9

    const/16 v6, 0x50

    const/16 v7, 0x64

    const/4 v8, 0x1

    const/4 v9, 0x2

    const/4 v10, 0x5

    const/16 v11, 0xa

    const/16 v12, 0x8

    if-lt v0, v3, :cond_2

    move v1, v11

    goto :goto_0

    :cond_2
    if-lt v0, v7, :cond_3

    move v1, v5

    goto :goto_0

    :cond_3
    if-lt v0, v6, :cond_5

    :cond_4
    move v1, v12

    goto :goto_0

    :cond_5
    if-lt v0, v1, :cond_6

    move v1, v4

    goto :goto_0

    :cond_6
    if-lt v0, v2, :cond_7

    move v1, v10

    goto :goto_0

    :cond_7
    if-lt v0, v11, :cond_8

    move v1, v9

    goto :goto_0

    :cond_8
    if-lt v0, v10, :cond_4

    move v1, v8

    :goto_0
    iget v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->mInnerFree:I

    mul-int/2addr v2, v7

    .line 54
    div-int/2addr v2, v0

    if-lt v2, v6, :cond_9

    move v4, v11

    goto :goto_1

    :cond_9
    const/16 v0, 0x46

    if-lt v2, v0, :cond_a

    move v4, v5

    goto :goto_1

    :cond_a
    const/16 v0, 0x3c

    if-lt v2, v0, :cond_b

    move v4, v12

    goto :goto_1

    :cond_b
    const/16 v0, 0x32

    if-lt v2, v0, :cond_c

    const/4 v4, 0x7

    goto :goto_1

    :cond_c
    const/16 v0, 0x28

    if-lt v2, v0, :cond_d

    goto :goto_1

    :cond_d
    const/16 v0, 0x1e

    if-lt v2, v0, :cond_e

    move v4, v10

    goto :goto_1

    :cond_e
    const/16 v0, 0x14

    if-lt v2, v0, :cond_f

    const/4 v4, 0x4

    goto :goto_1

    :cond_f
    if-lt v2, v11, :cond_10

    const/4 v4, 0x3

    goto :goto_1

    :cond_10
    if-lt v2, v10, :cond_11

    move v4, v9

    goto :goto_1

    :cond_11
    if-lt v2, v8, :cond_12

    move v4, v8

    goto :goto_1

    :cond_12
    const/4 v4, 0x0

    :goto_1
    add-int/2addr v1, v4

    .line 78
    div-int/2addr v1, v9

    return v1
.end method
