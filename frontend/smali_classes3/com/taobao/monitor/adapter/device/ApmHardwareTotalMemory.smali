.class public Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;
.super Ljava/lang/Object;
.source "ApmHardwareTotalMemory.java"

# interfaces
.implements Lcom/taobao/monitor/adapter/device/ApmCalScore;


# instance fields
.field private mDeviceTotalMemory:J


# direct methods
.method constructor <init>()V
    .locals 2

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->mDeviceTotalMemory:J

    .line 20
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->initDeviceTotalMemory()V

    return-void
.end method

.method private getTotalMemFromFile()I
    .locals 4

    const-string v0, ""

    const/16 v1, 0x400

    .line 57
    :try_start_0
    new-instance v2, Ljava/io/FileReader;

    const-string v3, "/proc/meminfo"

    invoke-direct {v2, v3}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    .line 58
    new-instance v3, Ljava/io/BufferedReader;

    invoke-direct {v3, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 60
    invoke-virtual {v3}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    .line 61
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V

    if-eqz v2, :cond_0

    const-string v3, "MemTotal:"

    .line 63
    invoke-virtual {v2, v3, v0}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "kB"

    .line 64
    invoke-virtual {v2, v3, v0}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    const-string v3, " "

    .line 65
    invoke-virtual {v2, v3, v0}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 66
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 68
    :goto_0
    div-int/lit16 v1, v0, 0x400
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return v1
.end method

.method private initDeviceTotalMemory()V
    .locals 6

    .line 25
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object v0

    const-string v1, "activity"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    if-eqz v0, :cond_3

    .line 30
    :try_start_0
    new-instance v0, Landroid/app/ActivityManager$MemoryInfo;

    invoke-direct {v0}, Landroid/app/ActivityManager$MemoryInfo;-><init>()V

    .line 31
    iget-wide v0, v0, Landroid/app/ActivityManager$MemoryInfo;->totalMem:J

    const-wide/16 v2, 0x400

    div-long/2addr v0, v2

    div-long/2addr v0, v2

    iput-wide v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->mDeviceTotalMemory:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 33
    :catchall_0
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->getTotalMemFromFile()I

    move-result v0

    div-int/lit16 v0, v0, 0x400

    int-to-long v0, v0

    iput-wide v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->mDeviceTotalMemory:J

    :goto_0
    iget-wide v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->mDeviceTotalMemory:J

    const-wide/16 v2, 0x100

    cmp-long v4, v0, v2

    if-gez v4, :cond_0

    iput-wide v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->mDeviceTotalMemory:J

    goto :goto_2

    :cond_0
    const-wide/16 v2, 0x200

    cmp-long v0, v0, v2

    if-gez v0, :cond_1

    iput-wide v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->mDeviceTotalMemory:J

    goto :goto_2

    :cond_1
    const/4 v0, 0x1

    :goto_1
    const/16 v1, 0x14

    if-gt v0, v1, :cond_3

    mul-int/lit16 v1, v0, 0x400

    iget-wide v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->mDeviceTotalMemory:J

    int-to-long v4, v1

    cmp-long v1, v2, v4

    if-gez v1, :cond_2

    iput-wide v4, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->mDeviceTotalMemory:J

    goto :goto_2

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    :goto_2
    return-void
.end method


# virtual methods
.method public getScore()I
    .locals 4

    iget-wide v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->mDeviceTotalMemory:J

    const-wide/16 v2, 0x1800

    cmp-long v2, v0, v2

    if-ltz v2, :cond_0

    const/16 v0, 0xa

    goto :goto_0

    :cond_0
    const-wide/16 v2, 0x1000

    cmp-long v2, v0, v2

    if-ltz v2, :cond_1

    const/16 v0, 0x9

    goto :goto_0

    :cond_1
    const-wide/16 v2, 0xc00

    cmp-long v2, v0, v2

    if-ltz v2, :cond_2

    const/4 v0, 0x7

    goto :goto_0

    :cond_2
    const-wide/16 v2, 0x800

    cmp-long v2, v0, v2

    if-ltz v2, :cond_3

    const/4 v0, 0x5

    goto :goto_0

    :cond_3
    const-wide/16 v2, 0x400

    cmp-long v2, v0, v2

    if-ltz v2, :cond_4

    const/4 v0, 0x3

    goto :goto_0

    :cond_4
    const-wide/16 v2, 0x200

    cmp-long v0, v0, v2

    if-ltz v0, :cond_5

    const/4 v0, 0x1

    goto :goto_0

    :cond_5
    const/16 v0, 0x8

    :goto_0
    return v0
.end method
