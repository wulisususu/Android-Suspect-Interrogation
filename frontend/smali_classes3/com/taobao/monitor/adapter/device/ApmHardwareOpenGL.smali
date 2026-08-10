.class public Lcom/taobao/monitor/adapter/device/ApmHardwareOpenGL;
.super Ljava/lang/Object;
.source "ApmHardwareOpenGL.java"

# interfaces
.implements Lcom/taobao/monitor/adapter/device/ApmCalScore;


# instance fields
.field private mOpenglv:F


# direct methods
.method constructor <init>()V
    .locals 2

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/high16 v0, 0x40000000    # 2.0f

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareOpenGL;->mOpenglv:F

    .line 17
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object v0

    const-string v1, "activity"

    .line 19
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    if-eqz v0, :cond_0

    .line 22
    :try_start_0
    invoke-virtual {v0}, Landroid/app/ActivityManager;->getDeviceConfigurationInfo()Landroid/content/pm/ConfigurationInfo;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/pm/ConfigurationInfo;->getGlEsVersion()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(Ljava/lang/String;)Ljava/lang/Float;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareOpenGL;->mOpenglv:F
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    :cond_0
    return-void
.end method


# virtual methods
.method public getScore()I
    .locals 7

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareOpenGL;->mOpenglv:F

    float-to-double v1, v0

    const-wide/high16 v3, 0x4010000000000000L    # 4.0

    cmpl-double v1, v1, v3

    if-lez v1, :cond_0

    const/16 v0, 0xa

    goto :goto_0

    :cond_0
    float-to-double v1, v0

    cmpl-double v1, v1, v3

    if-ltz v1, :cond_1

    const/16 v0, 0x9

    goto :goto_0

    :cond_1
    float-to-double v1, v0

    const-wide v3, 0x400999999999999aL    # 3.2

    cmpl-double v1, v1, v3

    const/16 v2, 0x8

    if-ltz v1, :cond_3

    :cond_2
    move v0, v2

    goto :goto_0

    :cond_3
    float-to-double v3, v0

    const-wide v5, 0x4008cccccccccccdL    # 3.1

    cmpl-double v1, v3, v5

    if-ltz v1, :cond_4

    const/4 v0, 0x7

    goto :goto_0

    :cond_4
    float-to-double v3, v0

    const-wide/high16 v5, 0x4008000000000000L    # 3.0

    cmpl-double v1, v3, v5

    if-ltz v1, :cond_5

    const/4 v0, 0x6

    goto :goto_0

    :cond_5
    float-to-double v0, v0

    const-wide/high16 v3, 0x4000000000000000L    # 2.0

    cmpl-double v0, v0, v3

    if-ltz v0, :cond_2

    const/4 v0, 0x3

    :goto_0
    return v0
.end method
