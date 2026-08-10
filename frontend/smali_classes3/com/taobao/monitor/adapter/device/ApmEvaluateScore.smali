.class public Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;
.super Ljava/lang/Object;
.source "ApmEvaluateScore.java"

# interfaces
.implements Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;


# static fields
.field private static final CPU_BRAND:Ljava/lang/String; = "CPU_BRAND"

.field private static final CPU_NAME:Ljava/lang/String; = "CPU_NAME"

.field private static final DEVICE_SCORE:Ljava/lang/String; = "DEVICE_SCORE"

.field private static final GPU_BRAND:Ljava/lang/String; = "GPU_BRAND"

.field private static final GPU_NAME:Ljava/lang/String; = "GPU_NAME"


# instance fields
.field private final callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

.field private info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;


# direct methods
.method public constructor <init>(Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "callback"
        }
    .end annotation

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    return-void
.end method

.method private calDeviceScore()I
    .locals 14

    .line 64
    new-instance v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;-><init>(Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;)V

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 66
    new-instance v0, Lcom/taobao/monitor/adapter/device/ApmHardwareBrand;

    invoke-direct {v0}, Lcom/taobao/monitor/adapter/device/ApmHardwareBrand;-><init>()V

    .line 67
    invoke-virtual {v0}, Lcom/taobao/monitor/adapter/device/ApmHardwareBrand;->getScore()I

    move-result v0

    .line 69
    new-instance v1, Lcom/taobao/monitor/adapter/device/ApmHardwareCpuCount;

    invoke-direct {v1}, Lcom/taobao/monitor/adapter/device/ApmHardwareCpuCount;-><init>()V

    .line 70
    invoke-virtual {v1}, Lcom/taobao/monitor/adapter/device/ApmHardwareCpuCount;->getScore()I

    move-result v1

    .line 72
    new-instance v2, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;

    iget-object v3, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    invoke-direct {v2, v3}, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;-><init>(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)V

    .line 73
    invoke-virtual {v2}, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->getScore()I

    move-result v3

    .line 75
    new-instance v4, Lcom/taobao/monitor/adapter/device/ApmHardwareOsVersion;

    invoke-direct {v4}, Lcom/taobao/monitor/adapter/device/ApmHardwareOsVersion;-><init>()V

    .line 76
    invoke-virtual {v4}, Lcom/taobao/monitor/adapter/device/ApmHardwareOsVersion;->getScore()I

    move-result v4

    .line 78
    new-instance v5, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;

    invoke-direct {v5}, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;-><init>()V

    .line 79
    invoke-virtual {v5}, Lcom/taobao/monitor/adapter/device/ApmHardwareTotalMemory;->getScore()I

    move-result v5

    .line 81
    new-instance v6, Lcom/taobao/monitor/adapter/device/ApmHardwareJavaMemory;

    invoke-direct {v6}, Lcom/taobao/monitor/adapter/device/ApmHardwareJavaMemory;-><init>()V

    .line 82
    invoke-virtual {v6}, Lcom/taobao/monitor/adapter/device/ApmHardwareJavaMemory;->getScore()I

    move-result v6

    .line 84
    new-instance v7, Lcom/taobao/monitor/adapter/device/ApmHardwareScreen;

    invoke-direct {v7}, Lcom/taobao/monitor/adapter/device/ApmHardwareScreen;-><init>()V

    .line 85
    invoke-virtual {v7}, Lcom/taobao/monitor/adapter/device/ApmHardwareScreen;->getScore()I

    move-result v7

    .line 87
    new-instance v8, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;

    invoke-direct {v8}, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;-><init>()V

    .line 88
    invoke-virtual {v8}, Lcom/taobao/monitor/adapter/device/ApmHardwareStorage;->getScore()I

    move-result v8

    .line 90
    new-instance v9, Lcom/taobao/monitor/adapter/device/ApmHardwareOpenGL;

    invoke-direct {v9}, Lcom/taobao/monitor/adapter/device/ApmHardwareOpenGL;-><init>()V

    .line 91
    invoke-virtual {v9}, Lcom/taobao/monitor/adapter/device/ApmHardwareOpenGL;->getScore()I

    move-result v9

    .line 93
    new-instance v10, Lcom/taobao/monitor/adapter/device/ApmHardwareUseTime;

    invoke-direct {v10}, Lcom/taobao/monitor/adapter/device/ApmHardwareUseTime;-><init>()V

    .line 94
    invoke-virtual {v10}, Lcom/taobao/monitor/adapter/device/ApmHardwareUseTime;->getScore()I

    move-result v10

    iget-object v11, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 96
    invoke-virtual {v2, v11}, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->getCpuHzScore(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)I

    move-result v2

    .line 97
    new-instance v11, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;

    iget-object v12, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    invoke-direct {v11, v12}, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;-><init>(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)V

    .line 98
    invoke-virtual {v11}, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->getScore()I

    move-result v11

    const/high16 v12, 0x3f000000    # 0.5f

    if-nez v11, :cond_0

    int-to-float v11, v3

    mul-float/2addr v11, v12

    int-to-float v13, v1

    mul-float/2addr v13, v12

    add-float/2addr v11, v13

    int-to-float v2, v2

    const/high16 v13, 0x3e800000    # 0.25f

    mul-float/2addr v2, v13

    add-float/2addr v11, v2

    float-to-int v11, v11

    :cond_0
    add-int/2addr v0, v11

    int-to-float v0, v0

    int-to-float v1, v1

    mul-float/2addr v1, v12

    add-float/2addr v0, v1

    int-to-float v1, v3

    const/high16 v2, 0x40000000    # 2.0f

    mul-float/2addr v1, v2

    add-float/2addr v0, v1

    int-to-float v1, v4

    add-float/2addr v0, v1

    int-to-float v1, v5

    const/high16 v2, 0x3fc00000    # 1.5f

    mul-float/2addr v1, v2

    add-float/2addr v0, v1

    int-to-float v1, v6

    mul-float/2addr v1, v12

    add-float/2addr v0, v1

    int-to-float v1, v7

    mul-float/2addr v1, v12

    add-float/2addr v0, v1

    int-to-float v1, v8

    mul-float/2addr v1, v12

    add-float/2addr v0, v1

    int-to-float v1, v9

    mul-float/2addr v1, v12

    add-float/2addr v0, v1

    int-to-float v1, v10

    add-float/2addr v0, v1

    .line 114
    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    int-to-float v0, v0

    float-to-int v0, v0

    const/16 v1, 0x64

    if-le v0, v1, :cond_1

    move v0, v1

    :cond_1
    return v0
.end method


# virtual methods
.method public cpuInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "cpuName",
            "cpuBrand"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    .line 139
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;->cpuInfo(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public deviceScore(I)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "deviceScore"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    .line 134
    invoke-interface {v0, p1}, Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;->deviceScore(I)V

    return-void
.end method

.method public evaluateDeviceScore()Z
    .locals 7

    .line 33
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object v0

    const-string v1, "apm"

    const/4 v2, 0x0

    .line 34
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "GPU_NAME"

    const-string v3, ""

    .line 36
    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v4, "GPU_BRAND"

    .line 37
    invoke-interface {v0, v4, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 39
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    const-string v6, "DEVICE_SCORE"

    if-nez v5, :cond_0

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_0

    iget-object v5, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    .line 40
    invoke-interface {v5, v1, v4}, Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;->gpuInfo(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "CPU_NAME"

    .line 42
    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v4, "CPU_BRAND"

    .line 43
    invoke-interface {v0, v4, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 44
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_0

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_0

    iget-object v4, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    .line 45
    invoke-interface {v4, v1, v3}, Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;->cpuInfo(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v1, -0x1

    .line 47
    invoke-interface {v0, v6, v1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v3

    if-eq v3, v1, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    .line 49
    invoke-interface {v0, v3}, Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;->deviceScore(I)V

    const/4 v0, 0x1

    return v0

    .line 55
    :cond_0
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->calDeviceScore()I

    move-result v1

    iget-object v3, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    .line 56
    invoke-interface {v3, v1}, Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;->deviceScore(I)V

    .line 57
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 58
    invoke-interface {v0, v6, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 59
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return v2
.end method

.method public getGpuInfo(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    if-eqz v0, :cond_1

    .line 124
    iget-object v0, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuName:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    iget-object v0, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuBrand:Ljava/lang/String;

    .line 125
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 126
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->getGpuInfo(Landroid/app/Activity;)V

    :cond_1
    return-void
.end method

.method public gpuInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "gpuName",
            "gpuBrand"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    .line 144
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;->gpuInfo(Ljava/lang/String;Ljava/lang/String;)V

    .line 145
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->calDeviceScore()I

    move-result p1

    iget-object p2, p0, Lcom/taobao/monitor/adapter/device/ApmEvaluateScore;->callback:Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    .line 146
    invoke-interface {p2, p1}, Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;->deviceScore(I)V

    .line 147
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object p2

    invoke-virtual {p2}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object p2

    const-string v0, "apm"

    const/4 v1, 0x0

    .line 148
    invoke-virtual {p2, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p2

    .line 149
    invoke-interface {p2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p2

    const-string v0, "DEVICE_SCORE"

    .line 150
    invoke-interface {p2, v0, p1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 151
    invoke-interface {p2}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method
