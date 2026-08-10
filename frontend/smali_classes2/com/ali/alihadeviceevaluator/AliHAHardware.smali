.class public Lcom/ali/alihadeviceevaluator/AliHAHardware;
.super Ljava/lang/Object;
.source "AliHAHardware.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;,
        Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;,
        Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;,
        Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;,
        Lcom/ali/alihadeviceevaluator/AliHAHardware$SingleHolder;
    }
.end annotation


# static fields
.field public static final CONFIG_CPUTRACKTICK:Ljava/lang/String; = "cpuTrackTick"

.field public static final DEVICE_IS_FATAL:I = 0x3

.field public static final DEVICE_IS_GOOD:I = 0x0

.field public static final DEVICE_IS_NORMAL:I = 0x1

.field public static final DEVICE_IS_RISKY:I = 0x2

.field public static final HIGH_END_DEVICE:I = 0x0

.field public static final LOW_END_DEVICE:I = 0x2

.field public static final MEDIUM_DEVICE:I = 0x1


# instance fields
.field private lifecycle:Lcom/ali/alihadeviceevaluator/util/AliHALifecycle;

.field private volatile mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

.field private volatile mAliHAMemoryTracker:Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;

.field private volatile mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

.field private mContext:Landroid/content/Context;

.field private volatile mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

.field private mHandler:Landroid/os/Handler;

.field private volatile mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

.field private volatile mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/ali/alihadeviceevaluator/AliHAHardware$1;)V
    .locals 0

    .line 21
    invoke-direct {p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;-><init>()V

    return-void
.end method

.method static synthetic access$200(Lcom/ali/alihadeviceevaluator/AliHAHardware;)Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;
    .locals 0

    .line 21
    iget-object p0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    return-object p0
.end method

.method static synthetic access$300(Lcom/ali/alihadeviceevaluator/AliHAHardware;)Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;
    .locals 0

    .line 21
    iget-object p0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    return-object p0
.end method

.method static synthetic access$400(Lcom/ali/alihadeviceevaluator/AliHAHardware;)Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;
    .locals 0

    .line 21
    iget-object p0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    return-object p0
.end method

.method private varargs evaluateLevel(I[I)I
    .locals 3
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "score",
            "splits"
        }
    .end annotation

    const/4 v0, -0x1

    if-ne v0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    .line 139
    :goto_0
    array-length v2, p2

    if-ge v1, v2, :cond_2

    .line 140
    aget v2, p2, v1

    if-lt p1, v2, :cond_1

    goto :goto_1

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    move v1, v0

    :goto_1
    if-ne v1, v0, :cond_3

    if-ltz p1, :cond_3

    .line 146
    array-length v1, p2

    :cond_3
    return v1
.end method

.method public static getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;
    .locals 1

    .line 27
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware$SingleHolder;->access$100()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public effectConfig(Ljava/util/HashMap;)V
    .locals 5
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "params"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    if-nez v0, :cond_1

    return-void

    :cond_1
    const-string v0, "cpuTrackTick"

    .line 72
    invoke-virtual {p1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    const-wide/16 v0, -0x1

    .line 73
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    .line 75
    :try_start_0
    invoke-static {p1}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 77
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    .line 79
    :goto_0
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    cmp-long p1, v3, v0

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    .line 80
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;->reset(J)V

    :cond_2
    return-void
.end method

.method public getContext()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method public getCpuInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;
    .locals 5

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mContext:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 111
    new-instance v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    invoke-direct {v0, p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;-><init>(Lcom/ali/alihadeviceevaluator/AliHAHardware;)V

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    if-nez v0, :cond_2

    .line 115
    new-instance v0, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUInfo;

    invoke-direct {v0}, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUInfo;-><init>()V

    .line 116
    invoke-virtual {v0}, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUInfo;->evaluateCPUScore()V

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    if-nez v1, :cond_1

    .line 118
    new-instance v1, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v2

    iget-object v3, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mHandler:Landroid/os/Handler;

    invoke-direct {v1, v2, v3}, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;-><init>(ILandroid/os/Handler;)V

    iput-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    .line 120
    :cond_1
    new-instance v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    invoke-direct {v1, p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;-><init>(Lcom/ali/alihadeviceevaluator/AliHAHardware;)V

    iput-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    .line 121
    iget v2, v0, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUInfo;->mCPUCore:I

    iput v2, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuCoreNum:I

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    .line 122
    iget v2, v0, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUInfo;->mCPUAvgFreq:F

    iput v2, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->avgFreq:F

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    .line 123
    iget v2, v0, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUInfo;->mCPUScore:I

    iput v2, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuDeivceScore:I

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    .line 124
    iget v0, v0, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUInfo;->mCPUScore:I

    const/16 v2, 0x8

    const/4 v3, 0x5

    filled-new-array {v2, v3}, [I

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->evaluateLevel(I[I)I

    move-result v0

    iput v0, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->deviceLevel:I

    :cond_2
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    .line 126
    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;->peakCurProcessCpuPercent()F

    move-result v1

    iput v1, v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuUsageOfApp:F

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    .line 127
    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;->peakCpuPercent()F

    move-result v1

    iput v1, v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuUsageOfDevcie:F

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    .line 128
    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuUsageOfDevcie:F

    const/high16 v2, 0x42c80000    # 100.0f

    sub-float/2addr v2, v1

    float-to-int v1, v2

    const/16 v2, 0x3c

    const/16 v3, 0x14

    const/16 v4, 0x5a

    filled-new-array {v4, v2, v3}, [I

    move-result-object v2

    invoke-direct {p0, v1, v2}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->evaluateLevel(I[I)I

    move-result v1

    iput v1, v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->runtimeLevel:I

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    return-object v0
.end method

.method public getDisplayInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;
    .locals 4

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mContext:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 88
    new-instance v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    invoke-direct {v0, p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;-><init>(Lcom/ali/alihadeviceevaluator/AliHAHardware;)V

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mContext:Landroid/content/Context;

    .line 92
    invoke-static {v0}, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->getDisplayInfo(Landroid/content/Context;)Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;

    move-result-object v0

    .line 93
    new-instance v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    invoke-direct {v1, p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;-><init>(Lcom/ali/alihadeviceevaluator/AliHAHardware;)V

    iput-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    .line 94
    iget v2, v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mDensity:F

    iput v2, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mDensity:F

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    .line 95
    iget v2, v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mHeightPixels:I

    iput v2, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mHeightPixels:I

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    .line 96
    iget v0, v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mWidthPixels:I

    iput v0, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mWidthPixels:I

    .line 98
    new-instance v0, Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;

    invoke-direct {v0}, Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;-><init>()V

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mContext:Landroid/content/Context;

    .line 99
    invoke-virtual {v0, v1}, Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;->generateOpenGLVersion(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    .line 100
    iget v2, v0, Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;->mOpenGLVersion:F

    invoke-static {v2}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mOpenGLVersion:Ljava/lang/String;

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    .line 101
    iget v0, v0, Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;->mScore:I

    const/16 v2, 0x8

    const/4 v3, 0x6

    filled-new-array {v2, v3}, [I

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->evaluateLevel(I[I)I

    move-result v0

    iput v0, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mOpenGLDeviceLevel:I

    :cond_1
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    return-object v0
.end method

.method public getMemoryInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;
    .locals 13

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mContext:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 156
    new-instance v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    invoke-direct {v0, p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;-><init>(Lcom/ali/alihadeviceevaluator/AliHAHardware;)V

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    if-nez v0, :cond_1

    .line 160
    new-instance v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    invoke-direct {v0, p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;-><init>(Lcom/ali/alihadeviceevaluator/AliHAHardware;)V

    iput-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 161
    new-instance v0, Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;

    invoke-direct {v0}, Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;-><init>()V

    iput-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHAMemoryTracker:Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;

    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHAMemoryTracker:Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;

    .line 164
    invoke-virtual {v0}, Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;->getDeviceMem()[J

    move-result-object v0

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    const/4 v2, 0x0

    .line 165
    aget-wide v3, v0, v2

    iput-wide v3, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->deviceTotalMemory:J

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    const/4 v3, 0x1

    .line 166
    aget-wide v4, v0, v3

    iput-wide v4, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->deviceUsedMemory:J

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHAMemoryTracker:Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;

    .line 169
    invoke-virtual {v0}, Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;->getHeapJVM()[J

    move-result-object v0

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 170
    aget-wide v4, v0, v2

    iput-wide v4, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->jvmTotalMemory:J

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 171
    aget-wide v4, v0, v3

    iput-wide v4, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->jvmUsedMemory:J

    .line 172
    aget-wide v4, v0, v2

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    const-wide/high16 v8, 0x4059000000000000L    # 100.0

    const/4 v10, -0x1

    if-eqz v1, :cond_2

    aget-wide v11, v0, v3

    long-to-double v0, v11

    mul-double/2addr v0, v8

    long-to-double v4, v4

    div-double/2addr v0, v4

    double-to-int v0, v0

    goto :goto_0

    :cond_2
    move v0, v10

    :goto_0
    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHAMemoryTracker:Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;

    .line 174
    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;->getHeapNative()[J

    move-result-object v1

    iget-object v4, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 175
    aget-wide v11, v1, v2

    iput-wide v11, v4, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->nativeTotalMemory:J

    iget-object v4, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 176
    aget-wide v11, v1, v3

    iput-wide v11, v4, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->nativeUsedMemory:J

    .line 177
    aget-wide v4, v1, v2

    cmp-long v6, v4, v6

    if-eqz v6, :cond_3

    aget-wide v6, v1, v3

    long-to-double v6, v6

    mul-double/2addr v6, v8

    long-to-double v4, v4

    div-double/2addr v6, v4

    double-to-int v10, v6

    :cond_3
    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHAMemoryTracker:Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;

    iget-object v4, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mContext:Landroid/content/Context;

    .line 179
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v5

    invoke-virtual {v1, v4, v5}, Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;->getPSS(Landroid/content/Context;I)[J

    move-result-object v1

    iget-object v4, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 180
    aget-wide v5, v1, v2

    iput-wide v5, v4, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->dalvikPSSMemory:J

    iget-object v2, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 181
    aget-wide v3, v1, v3

    iput-wide v3, v2, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->nativePSSMemory:J

    iget-object v2, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    const/4 v3, 0x2

    .line 182
    aget-wide v3, v1, v3

    iput-wide v3, v2, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->totalPSSMemory:J

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    iget-object v2, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 184
    iget-wide v2, v2, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->deviceTotalMemory:J

    long-to-int v2, v2

    const/high16 v3, 0x500000

    const/high16 v4, 0x280000

    filled-new-array {v3, v4}, [I

    move-result-object v3

    invoke-direct {p0, v2, v3}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->evaluateLevel(I[I)I

    move-result v2

    iput v2, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->deviceLevel:I

    rsub-int/lit8 v0, v0, 0x64

    const/16 v1, 0x46

    const/16 v2, 0x32

    const/16 v3, 0x1e

    filled-new-array {v1, v2, v3}, [I

    move-result-object v1

    .line 185
    invoke-direct {p0, v0, v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->evaluateLevel(I[I)I

    move-result v0

    rsub-int/lit8 v1, v10, 0x64

    const/16 v2, 0x3c

    const/16 v3, 0x28

    const/16 v4, 0x14

    filled-new-array {v2, v3, v4}, [I

    move-result-object v2

    .line 186
    invoke-direct {p0, v1, v2}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->evaluateLevel(I[I)I

    move-result v1

    iget-object v2, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    add-int/2addr v0, v1

    int-to-float v0, v0

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    .line 187
    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    iput v0, v2, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->runtimeLevel:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    .line 189
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_1
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    return-object v0
.end method

.method public getOutlineInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;
    .locals 5

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mContext:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 199
    new-instance v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    invoke-direct {v0, p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;-><init>(Lcom/ali/alihadeviceevaluator/AliHAHardware;)V

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    const/high16 v1, 0x40000000    # 2.0f

    if-nez v0, :cond_4

    .line 203
    new-instance v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    invoke-direct {v0, p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;-><init>(Lcom/ali/alihadeviceevaluator/AliHAHardware;)V

    iput-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    if-nez v0, :cond_1

    .line 204
    invoke-virtual {p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getMemoryInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    :cond_1
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    if-nez v0, :cond_2

    .line 205
    invoke-virtual {p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getCpuInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    :cond_2
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    if-nez v0, :cond_3

    .line 206
    invoke-virtual {p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getDisplayInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    :cond_3
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    iget-object v2, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 207
    iget v2, v2, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->deviceLevel:I

    int-to-float v2, v2

    const v3, 0x3f666666    # 0.9f

    mul-float/2addr v2, v3

    iget-object v3, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    iget v3, v3, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->deviceLevel:I

    int-to-float v3, v3

    const/high16 v4, 0x3fc00000    # 1.5f

    mul-float/2addr v3, v4

    add-float/2addr v2, v3

    iget-object v3, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    iget v3, v3, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mOpenGLDeviceLevel:I

    int-to-float v3, v3

    const v4, 0x3f19999a    # 0.6f

    mul-float/2addr v3, v4

    add-float/2addr v2, v3

    const/high16 v3, 0x40400000    # 3.0f

    div-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    iput v2, v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->deviceLevelEasy:I

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    iget-object v2, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 208
    iget v2, v2, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->runtimeLevel:I

    iget-object v3, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    iget v3, v3, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->runtimeLevel:I

    add-int/2addr v2, v3

    int-to-float v2, v2

    div-float/2addr v2, v1

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v1

    iput v1, v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->runtimeLevel:I

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    if-nez v0, :cond_5

    .line 210
    invoke-virtual {p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getMemoryInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    :cond_5
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    if-nez v0, :cond_6

    .line 211
    invoke-virtual {p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getCpuInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    :cond_6
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    if-nez v0, :cond_7

    .line 212
    invoke-virtual {p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getDisplayInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    :cond_7
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    iget-object v2, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mMemoryInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    .line 213
    iget v2, v2, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->runtimeLevel:I

    int-to-float v2, v2

    const v3, 0x3f4ccccd    # 0.8f

    mul-float/2addr v2, v3

    iget-object v3, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mCPUInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    iget v3, v3, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->runtimeLevel:I

    int-to-float v3, v3

    const v4, 0x3f99999a    # 1.2f

    mul-float/2addr v3, v4

    add-float/2addr v2, v3

    div-float/2addr v2, v1

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v1

    iput v1, v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->runtimeLevel:I

    :goto_0
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    return-object v0
.end method

.method public onAppBackGround()V
    .locals 3

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    const-wide/16 v1, 0x0

    .line 59
    invoke-virtual {v0, v1, v2}, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;->reset(J)V

    :cond_0
    return-void
.end method

.method public onAppForeGround()V
    .locals 3

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    .line 65
    iget-wide v1, v1, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;->mDeltaDuration:J

    invoke-virtual {v0, v1, v2}, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;->reset(J)V

    :cond_0
    return-void
.end method

.method public setDeviceScore(I)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "i"
        }
    .end annotation

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    if-nez v0, :cond_0

    .line 220
    invoke-virtual {p0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getOutlineInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    :cond_0
    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    .line 222
    iput p1, v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->deviceScore:I

    const/16 v0, 0x5a

    if-lt p1, v0, :cond_1

    iget-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    const/4 v0, 0x0

    .line 223
    iput v0, p1, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->deviceLevel:I

    goto :goto_0

    :cond_1
    const/16 v0, 0x46

    if-lt p1, v0, :cond_2

    iget-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    const/4 v0, 0x1

    .line 224
    iput v0, p1, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->deviceLevel:I

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mOutlineInfo:Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    const/4 v0, 0x2

    .line 225
    iput v0, p1, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->deviceLevel:I

    :cond_3
    :goto_0
    return-void
.end method

.method public setUp(Landroid/app/Application;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "application"
        }
    .end annotation

    const/4 v0, 0x0

    .line 50
    invoke-virtual {p0, p1, v0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->setUp(Landroid/app/Application;Landroid/os/Handler;)V

    return-void
.end method

.method public setUp(Landroid/app/Application;Landroid/os/Handler;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "application",
            "handler"
        }
    .end annotation

    iput-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mHandler:Landroid/os/Handler;

    iget-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    if-nez p1, :cond_0

    .line 43
    new-instance p1, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result p2

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mHandler:Landroid/os/Handler;

    invoke-direct {p1, p2, v0}, Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;-><init>(ILandroid/os/Handler;)V

    iput-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->mAliHACPUTracker:Lcom/ali/alihadeviceevaluator/cpu/AliHACPUTracker;

    .line 45
    :cond_0
    new-instance p1, Lcom/ali/alihadeviceevaluator/util/AliHALifecycle;

    invoke-direct {p1}, Lcom/ali/alihadeviceevaluator/util/AliHALifecycle;-><init>()V

    iput-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->lifecycle:Lcom/ali/alihadeviceevaluator/util/AliHALifecycle;

    .line 46
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object p1

    iget-object p2, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware;->lifecycle:Lcom/ali/alihadeviceevaluator/util/AliHALifecycle;

    invoke-virtual {p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->addObserver(Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;)V

    return-void
.end method
