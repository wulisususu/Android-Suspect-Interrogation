.class public Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;
.super Ljava/lang/Object;
.source "ApmHardWareInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;,
        Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;
    }
.end annotation


# static fields
.field private static final CPU_BRAND:Ljava/lang/String; = "CPU_BRAND"

.field private static final CPU_NAME:Ljava/lang/String; = "CPU_NAME"

.field private static final GPU_BRAND:Ljava/lang/String; = "GPU_BRAND"

.field private static final GPU_NAME:Ljava/lang/String; = "GPU_NAME"


# instance fields
.field private final callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

.field private final editor:Landroid/content/SharedPreferences$Editor;

.field mCpuBrand:Ljava/lang/String;

.field mCpuCount:I

.field mCpuFreqArray:[F

.field mCpuMaxFreq:F

.field mCpuMinFreq:F

.field mCpuName:Ljava/lang/String;

.field mGpuBrand:Ljava/lang/String;

.field mGpuFreq:J

.field mGpuName:Ljava/lang/String;

.field mOnlineGLSurfaceView:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;

.field mViewGroup:Landroid/view/ViewGroup;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "callback"
        }
    .end annotation

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuCount:I

    iput-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    .line 50
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object p1

    const-string v1, "apm"

    invoke-virtual {p1, v1, v0}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->editor:Landroid/content/SharedPreferences$Editor;

    .line 51
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->setCpuCore()I

    .line 52
    invoke-virtual {p0}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->setCpuInfo()V

    .line 53
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->setMaxCpuFreq()F

    return-void
.end method

.method static synthetic access$000(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;
    .locals 0

    .line 24
    iget-object p0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    return-object p0
.end method

.method static synthetic access$100(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)Landroid/content/SharedPreferences$Editor;
    .locals 0

    .line 24
    iget-object p0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->editor:Landroid/content/SharedPreferences$Editor;

    return-object p0
.end method

.method private setCpuCore()I
    .locals 1

    .line 118
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Runtime;->availableProcessors()I

    move-result v0

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuCount:I

    return v0
.end method

.method private setMaxCpuFreq()F
    .locals 5

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    const/4 v1, 0x0

    cmpl-float v2, v0, v1

    if-lez v2, :cond_0

    iget-object v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuFreqArray:[F

    if-eqz v2, :cond_0

    return v0

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuFreqArray:[F

    if-nez v0, :cond_1

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuCount:I

    .line 77
    new-array v0, v0, [F

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuFreqArray:[F

    :cond_1
    const/4 v0, 0x0

    :goto_0
    :try_start_0
    iget v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuCount:I

    if-ge v0, v2, :cond_6

    .line 81
    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "/sys/devices/system/cpu/cpu"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "/cpufreq/cpuinfo_max_freq"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 82
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_2

    goto :goto_1

    .line 85
    :cond_2
    new-instance v3, Ljava/io/FileReader;

    invoke-direct {v3, v2}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    .line 86
    new-instance v2, Ljava/io/BufferedReader;

    invoke-direct {v2, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 88
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    .line 89
    invoke-virtual {v3}, Ljava/io/FileReader;->close()V

    if-eqz v2, :cond_5

    .line 91
    invoke-static {v2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    long-to-float v2, v2

    const v3, 0x49742400    # 1000000.0f

    div-float/2addr v2, v3

    iget-object v3, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuFreqArray:[F

    .line 93
    aput v2, v3, v0

    iget v3, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpg-float v3, v3, v2

    if-gez v3, :cond_3

    iput v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    :cond_3
    iget v3, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMinFreq:F

    cmpl-float v4, v3, v1

    if-nez v4, :cond_4

    iput v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMinFreq:F

    goto :goto_1

    :cond_4
    cmpl-float v3, v3, v2

    if-lez v3, :cond_5

    iput v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMinFreq:F
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_5
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_6
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMinFreq:F

    cmpl-float v0, v0, v1

    if-nez v0, :cond_7

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMinFreq:F

    :cond_7
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    return v0
.end method


# virtual methods
.method getGpuFreq()J
    .locals 11

    const-wide/16 v0, 0x0

    .line 196
    :try_start_0
    new-instance v2, Ljava/io/File;

    const-string v3, "/sys/devices/platform/gpusysfs/gpu_max_clock"

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 197
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_0

    .line 198
    new-instance v2, Ljava/io/File;

    const-string v3, "/sys/devices/platform/gpusysfs/max_freq"

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 200
    :cond_0
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    const-wide/16 v4, 0x3e8

    if-eqz v3, :cond_3

    .line 201
    new-instance v3, Ljava/io/FileReader;

    invoke-direct {v3, v2}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    .line 202
    new-instance v2, Ljava/io/BufferedReader;

    invoke-direct {v2, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 203
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 205
    invoke-static {v2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v6
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    cmp-long v2, v6, v0

    if-lez v2, :cond_2

    .line 207
    :try_start_1
    div-long v8, v6, v4

    div-long v6, v8, v4

    goto :goto_0

    :cond_1
    move-wide v6, v0

    .line 210
    :cond_2
    :goto_0
    invoke-virtual {v3}, Ljava/io/FileReader;->close()V

    cmp-long v2, v6, v0

    if-lez v2, :cond_4

    return-wide v6

    :cond_3
    move-wide v6, v0

    .line 217
    :cond_4
    new-instance v2, Ljava/io/File;

    const-string v3, "/sys/class/devfreq/"

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 218
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_9

    invoke-virtual {v2}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-eqz v3, :cond_9

    .line 219
    invoke-virtual {v2}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2

    if-nez v2, :cond_5

    return-wide v0

    :cond_5
    const/4 v3, 0x0

    .line 223
    :goto_1
    array-length v8, v2

    if-ge v3, v8, :cond_9

    .line 224
    aget-object v8, v2, v3

    .line 225
    invoke-virtual {v8}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v8

    const-string v9, "kgsl"

    invoke-virtual {v8, v9}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-eqz v8, :cond_8

    .line 226
    new-instance v8, Ljava/io/File;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    aget-object v10, v2, v3

    invoke-virtual {v10}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "/max_freq"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 227
    invoke-virtual {v8}, Ljava/io/File;->exists()Z

    move-result v9

    if-nez v9, :cond_6

    .line 228
    new-instance v8, Ljava/io/File;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    aget-object v2, v2, v3

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/max_gpuclk"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v8, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 230
    :cond_6
    invoke-virtual {v8}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_9

    .line 231
    new-instance v2, Ljava/io/FileReader;

    invoke-direct {v2, v8}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    .line 232
    new-instance v3, Ljava/io/BufferedReader;

    invoke-direct {v3, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 233
    invoke-virtual {v3}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_7

    .line 235
    invoke-static {v3}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v6

    cmp-long v3, v6, v0

    if-lez v3, :cond_7

    .line 237
    div-long v8, v6, v4

    div-long/2addr v8, v4

    move-wide v6, v8

    .line 240
    :cond_7
    invoke-virtual {v2}, Ljava/io/FileReader;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :cond_8
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :catch_0
    move-wide v6, v0

    :catch_1
    :cond_9
    :goto_2
    cmp-long v0, v6, v0

    if-nez v0, :cond_a

    const-string v0, "/sys/devices/"

    .line 251
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->getKgslFreq(Ljava/lang/String;)J

    move-result-wide v6

    :cond_a
    return-wide v6
.end method

.method public getGpuInfo(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 59
    :try_start_0
    invoke-virtual {p1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mViewGroup:Landroid/view/ViewGroup;

    if-eqz v0, :cond_0

    .line 61
    new-instance v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;

    invoke-direct {v0, p0, p1}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;-><init>(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mOnlineGLSurfaceView:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;

    const/4 p1, 0x0

    .line 62
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;->setAlpha(F)V

    .line 63
    new-instance p1, Landroid/view/ViewGroup$LayoutParams;

    const/4 v0, 0x1

    invoke-direct {p1, v0, v0}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mViewGroup:Landroid/view/ViewGroup;

    iget-object v1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mOnlineGLSurfaceView:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;

    .line 64
    invoke-virtual {v0, v1, p1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 67
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    return-void
.end method

.method getKgslFreq(Ljava/lang/String;)J
    .locals 9
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "path"
        }
    .end annotation

    const-wide/16 v0, 0x0

    .line 265
    :try_start_0
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 267
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 268
    invoke-virtual {v2}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    if-nez v2, :cond_0

    return-wide v0

    :cond_0
    const/4 v3, 0x0

    move-wide v4, v0

    .line 272
    :goto_0
    :try_start_1
    array-length v6, v2

    if-ge v3, v6, :cond_3

    .line 273
    aget-object v6, v2, v3

    if-eqz v6, :cond_1

    .line 274
    invoke-virtual {v6}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    const-string v8, "kgsl"

    invoke-virtual {v7, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-virtual {v6}, Ljava/io/File;->isDirectory()Z

    move-result v7

    if-eqz v7, :cond_1

    .line 275
    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->getKgslFreq(Ljava/lang/String;)J

    move-result-wide v4

    cmp-long v6, v4, v0

    if-lez v6, :cond_1

    return-wide v4

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    move-wide v4, v0

    .line 282
    :cond_3
    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "/max_freq"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 283
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_4

    .line 284
    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v3, "/max_gpuclk"

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 286
    :cond_4
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_7

    .line 287
    new-instance p1, Ljava/io/FileReader;

    invoke-direct {p1, v2}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    .line 288
    new-instance v2, Ljava/io/BufferedReader;

    invoke-direct {v2, p1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 289
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_6

    .line 291
    invoke-static {v2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    cmp-long v0, v2, v0

    if-lez v0, :cond_5

    const-wide/16 v0, 0x3e8

    .line 293
    :try_start_2
    div-long v4, v2, v0

    div-long/2addr v4, v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    :catch_0
    move-wide v0, v2

    goto :goto_3

    :cond_5
    move-wide v0, v2

    goto :goto_2

    :cond_6
    :goto_1
    move-wide v0, v4

    .line 296
    :goto_2
    :try_start_3
    invoke-virtual {p1}, Ljava/io/FileReader;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_3

    :catch_1
    move-wide v0, v4

    :catch_2
    :goto_3
    move-wide v4, v0

    :cond_7
    return-wide v4
.end method

.method setCpuInfo()V
    .locals 9

    .line 125
    sget-object v0, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    .line 126
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto/16 :goto_8

    :cond_0
    iget-object v1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuName:Ljava/lang/String;

    .line 132
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_18

    :cond_1
    const-string v1, "EXYNOS"

    .line 134
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    const-string v2, "samsung"

    const-string v3, ""

    .line 135
    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_2
    const/4 v2, 0x0

    :try_start_0
    const-string v3, "android.os.Build"

    .line 138
    invoke-static {v3}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    const-string v4, "getString"

    const/4 v5, 0x1

    new-array v6, v5, [Ljava/lang/Class;

    .line 139
    const-class v7, Ljava/lang/String;

    const/4 v8, 0x0

    aput-object v7, v6, v8

    invoke-virtual {v3, v4, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 140
    invoke-virtual {v3, v5}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 141
    const-class v4, Landroid/os/Build;

    new-array v5, v5, [Ljava/lang/Object;

    const-string v6, "ro.board.platform"

    aput-object v6, v5, v8

    invoke-virtual {v3, v4, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v3, :cond_3

    :try_start_1
    const-string v2, "mtk"

    .line 143
    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    if-eqz v2, :cond_3

    move-object v3, v0

    :catch_0
    :cond_3
    move-object v2, v3

    :catch_1
    if-eqz v0, :cond_5

    .line 150
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x4

    if-lt v3, v4, :cond_5

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_4

    const-string v3, "unknown"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    const-string v3, "samsungexynos"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_4

    const-string v3, "mrvl"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_5

    :cond_4
    move-object v2, v0

    :cond_5
    :goto_0
    if-eqz v2, :cond_6

    .line 155
    invoke-virtual {v2}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v2

    :cond_6
    if-nez v2, :cond_7

    return-void

    .line 160
    :cond_7
    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_17

    const-string v1, "SMDK"

    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_17

    const-string v1, "UNIVERSAL"

    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_8

    goto/16 :goto_6

    :cond_8
    const-string v1, "MSM"

    .line 162
    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_16

    const-string v1, "APQ"

    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_16

    const-string v1, "QSD"

    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_16

    const-string v1, "SDM"

    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_9

    goto/16 :goto_5

    :cond_9
    const-string v1, "REDHOOKBAY"

    .line 164
    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_15

    const-string v1, "MOOREFIELD"

    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_15

    const-string v1, "MERRIFIELD"

    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_a

    goto/16 :goto_4

    :cond_a
    const-string v1, "MT"

    .line 166
    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_b

    const-string v0, "\u8054\u53d1\u79d1"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    goto/16 :goto_7

    :cond_b
    const-string v1, "OMAP"

    .line 168
    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_c

    const-string v0, "\u5fb7\u5dde\u4eea\u5668"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    goto/16 :goto_7

    :cond_c
    const-string v1, "PXA"

    .line 170
    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_d

    const-string v0, "Marvell"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    goto :goto_7

    :cond_d
    const-string v1, "HI"

    .line 172
    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_14

    const-string v1, "K3"

    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_e

    goto :goto_3

    :cond_e
    const-string v1, "SP"

    .line 174
    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_13

    const-string v1, "SC"

    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_f

    goto :goto_2

    :cond_f
    const-string v1, "TEGRA"

    .line 176
    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    const-string v3, "NVIDIA"

    if-nez v1, :cond_12

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_10

    goto :goto_1

    :cond_10
    const-string v1, "LC"

    .line 178
    invoke-virtual {v2, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_11

    const-string v0, "\u8054\u82af\u79d1\u6280"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    goto :goto_7

    :cond_11
    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    goto :goto_7

    :cond_12
    :goto_1
    iput-object v3, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    goto :goto_7

    :cond_13
    :goto_2
    const-string v0, "\u5c55\u8baf"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    goto :goto_7

    :cond_14
    :goto_3
    const-string v0, "\u534e\u4e3a\u6d77\u601d"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    goto :goto_7

    :cond_15
    :goto_4
    const-string v0, "\u82f1\u7279\u5c14"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    goto :goto_7

    :cond_16
    :goto_5
    const-string v0, "\u9ad8\u901a"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    goto :goto_7

    :cond_17
    :goto_6
    const-string v0, "\u4e09\u661f"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    :goto_7
    iput-object v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuName:Ljava/lang/String;

    :cond_18
    :goto_8
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    iget-object v1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuName:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    .line 186
    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;->cpuInfo(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->editor:Landroid/content/SharedPreferences$Editor;

    const-string v1, "CPU_NAME"

    iget-object v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuName:Ljava/lang/String;

    .line 187
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->editor:Landroid/content/SharedPreferences$Editor;

    const-string v1, "CPU_BRAND"

    iget-object v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuBrand:Ljava/lang/String;

    .line 188
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->editor:Landroid/content/SharedPreferences$Editor;

    .line 189
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method
