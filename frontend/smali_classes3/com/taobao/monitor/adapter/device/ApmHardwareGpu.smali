.class public Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;
.super Ljava/lang/Object;
.source "ApmHardwareGpu.java"

# interfaces
.implements Lcom/taobao/monitor/adapter/device/ApmCalScore;


# instance fields
.field private mCpuMaxFreq:F

.field private mCpuMinFreq:F

.field private mGpuBrand:Ljava/lang/String;

.field private mGpuName:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "info"
        }
    .end annotation

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    iget-object v0, p1, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuName:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    .line 17
    iget-object v0, p1, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuBrand:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuBrand:Ljava/lang/String;

    .line 18
    iget v0, p1, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mCpuMaxFreq:F

    .line 19
    iget p1, p1, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMinFreq:F

    iput p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mCpuMinFreq:F

    return-void
.end method


# virtual methods
.method public getScore()I
    .locals 14

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_32

    const-string v2, "Adreno"

    .line 26
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    const/16 v2, 0x9

    const/4 v3, 0x1

    const/high16 v4, 0x40000000    # 2.0f

    const/4 v5, 0x7

    const/4 v6, 0x4

    const/16 v7, 0x8

    const/16 v8, 0xa

    const/4 v9, 0x3

    const/4 v10, 0x2

    const/4 v11, 0x5

    const/4 v12, 0x6

    if-eqz v0, :cond_13

    const-string v0, "\u9ad8\u901a"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuBrand:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v13, "540"

    .line 28
    invoke-virtual {v0, v13}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_f

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v13, "530"

    invoke-virtual {v0, v13}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_f

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v13, "53"

    invoke-virtual {v0, v13}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_f

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v13, "Adreno (TM) 5"

    invoke-virtual {v0, v13}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_f

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v13, "Adreno (TM) 6"

    invoke-virtual {v0, v13}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_1

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "Adreno 5"

    .line 37
    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_10

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "Adreno 6"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto/16 :goto_2

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "430"

    .line 39
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    goto/16 :goto_7

    :cond_2
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "420"

    .line 41
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_e

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "418"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_3

    goto/16 :goto_0

    :cond_3
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "510"

    .line 43
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2c

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "506"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2c

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "505"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    goto/16 :goto_8

    :cond_4
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "330"

    .line 45
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mCpuMaxFreq:F

    const v1, 0x40133333    # 2.3f

    cmpl-float v0, v0, v1

    if-lez v0, :cond_2e

    goto/16 :goto_8

    :cond_5
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "405"

    .line 52
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_6

    goto/16 :goto_9

    :cond_6
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "320"

    .line 54
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_7

    goto/16 :goto_9

    :cond_7
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "225"

    .line 56
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_8

    goto/16 :goto_a

    :cond_8
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "305"

    .line 58
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_30

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "306"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_30

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "308"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_9

    goto/16 :goto_a

    :cond_9
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "220"

    .line 60
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_a

    goto/16 :goto_6

    :cond_a
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "205"

    .line 62
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_23

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "203"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_b

    goto/16 :goto_5

    :cond_b
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "200"

    .line 64
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_c

    goto/16 :goto_4

    :cond_c
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "Adreno 4"

    .line 66
    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_d

    goto/16 :goto_8

    :cond_d
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "Adreno 3"

    .line 68
    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_32

    goto/16 :goto_a

    :cond_e
    :goto_0
    move v1, v5

    goto/16 :goto_c

    :cond_f
    :goto_1
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mCpuMaxFreq:F

    cmpl-float v0, v0, v4

    if-lez v0, :cond_11

    :cond_10
    :goto_2
    move v1, v8

    goto/16 :goto_c

    :cond_11
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mCpuMinFreq:F

    const/high16 v1, 0x3fc00000    # 1.5f

    cmpl-float v0, v0, v1

    if-lez v0, :cond_12

    goto :goto_2

    :cond_12
    :goto_3
    move v1, v2

    goto/16 :goto_c

    :cond_13
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v13, "Mali"

    .line 72
    invoke-virtual {v0, v13}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_21

    .line 73
    sget-object v0, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v3, "G71"

    .line 74
    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_10

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v3, "G72"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_14

    goto :goto_2

    :cond_14
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v3, "T880 MP"

    .line 76
    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_12

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v3, "T880"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_15

    goto :goto_3

    :cond_15
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "T860"

    .line 78
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_16

    goto/16 :goto_7

    :cond_16
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "T830"

    .line 80
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_17

    goto :goto_0

    :cond_17
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "T820"

    .line 82
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_18

    goto :goto_0

    :cond_18
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "400 MP"

    .line 84
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_19

    goto/16 :goto_8

    :cond_19
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "400"

    .line 86
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1a

    goto/16 :goto_5

    :cond_1a
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "450"

    .line 88
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1b

    goto :goto_5

    :cond_1b
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "T624"

    .line 90
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1c

    goto/16 :goto_9

    :cond_1c
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "T678"

    .line 92
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1d

    goto/16 :goto_9

    :cond_1d
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "T628"

    .line 94
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1e

    goto/16 :goto_8

    :cond_1e
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "T604"

    .line 96
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1f

    goto/16 :goto_6

    :cond_1f
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "T760"

    .line 98
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_20

    goto/16 :goto_8

    :cond_20
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "T720"

    .line 100
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_32

    goto/16 :goto_8

    :cond_21
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "PowerVR"

    .line 104
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2a

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "SGX 530"

    .line 105
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_22

    :goto_4
    move v1, v3

    goto/16 :goto_c

    :cond_22
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "SGX 535"

    .line 107
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_24

    :cond_23
    :goto_5
    move v1, v10

    goto/16 :goto_c

    :cond_24
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "SGX 531"

    .line 109
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_25

    goto :goto_5

    :cond_25
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "SGX 544"

    .line 111
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_29

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "SGX 543"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_26

    goto :goto_6

    :cond_26
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "G6200"

    .line 113
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2e

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "6200"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_27

    goto :goto_9

    :cond_27
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "G6400"

    .line 115
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2e

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "G6430"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2e

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "G6"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2e

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "6"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_28

    goto :goto_9

    :cond_28
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "6450"

    .line 117
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2c

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v1, "7"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_29

    goto :goto_8

    :cond_29
    :goto_6
    move v1, v9

    goto :goto_c

    :cond_2a
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "NVIDIA"

    .line 122
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_31

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mCpuMaxFreq:F

    const v1, 0x3fe66666    # 1.8f

    cmpl-float v2, v0, v1

    if-ltz v2, :cond_2b

    :goto_7
    goto :goto_b

    :cond_2b
    const v2, 0x400ccccd    # 2.2f

    cmpl-float v2, v0, v2

    if-ltz v2, :cond_2d

    :cond_2c
    :goto_8
    move v1, v12

    goto :goto_c

    :cond_2d
    cmpl-float v2, v0, v4

    if-ltz v2, :cond_2f

    :cond_2e
    :goto_9
    move v1, v11

    goto :goto_c

    :cond_2f
    cmpl-float v0, v0, v1

    if-ltz v0, :cond_29

    :cond_30
    :goto_a
    move v1, v6

    goto :goto_c

    :cond_31
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareGpu;->mGpuName:Ljava/lang/String;

    const-string v2, "Android Emulator"

    .line 134
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_32

    :goto_b
    move v1, v7

    :cond_32
    :goto_c
    return v1
.end method
