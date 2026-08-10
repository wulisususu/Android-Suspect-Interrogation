.class public Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;
.super Ljava/lang/Object;
.source "ApmHardwareCpu.java"

# interfaces
.implements Lcom/taobao/monitor/adapter/device/ApmCalScore;


# instance fields
.field private final info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

.field mCpuInfo:Ljava/lang/String;

.field mCpuProcessCount:I

.field private mCpuScore0:Ljava/lang/String;

.field private mCpuScore1:Ljava/lang/String;

.field private mCpuScore10:Ljava/lang/String;

.field private mCpuScore2:Ljava/lang/String;

.field private mCpuScore3:Ljava/lang/String;

.field private mCpuScore4:Ljava/lang/String;

.field private mCpuScore5:Ljava/lang/String;

.field private mCpuScore6:Ljava/lang/String;

.field private mCpuScore7:Ljava/lang/String;

.field private mCpuScore8:Ljava/lang/String;

.field private mCpuScore9:Ljava/lang/String;

.field mCpuScoreAry:[Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)V
    .locals 12
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "info"
        }
    .end annotation

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x4

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuProcessCount:I

    const-string v11, "SDM845,KIRIN970,MSM8998,EXYNOS8895"

    iput-object v11, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore10:Ljava/lang/String;

    const-string v10, "MSM8997,HI3660"

    iput-object v10, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore9:Ljava/lang/String;

    const-string v9, "MSM8996,MSM8996PRO,MSM8996 PRO,EXYNOS8890,MT6799"

    iput-object v9, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore8:Ljava/lang/String;

    const-string v8, "SDM660,SDM630,MSM8994,MSM8992,HI3650,EXYNOS7420,VBOX86"

    iput-object v8, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore7:Ljava/lang/String;

    const-string v7, "MSM8956,MSM8946,MT6797X,MT6797X,MT6797T,MT6797D"

    iput-object v7, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore6:Ljava/lang/String;

    const-string v6, "APQ8084,MSM8084,MSM8953,HI3630,EXYNOS5433,HI3635,EXYNOS5"

    iput-object v6, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore5:Ljava/lang/String;

    const-string v5, "MSM8X74,MSM8X74AA,MSM8X74AB,MSM8X74AC,MSM8674,MSM8274,MSM8074,EXYNOS5430,EXYNOS7870,EXYNOS7580,EXYNOS5433,MT679X,MT6797T,MT6797,EXYNOS5420,UNIVERSAL5420,RANCHU"

    iput-object v5, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore4:Ljava/lang/String;

    const-string v4, "MT675X,MT6795,MT6755,MT6752,MT6753,EXYNOS5800,EXYNOS5422,EXYNOS5410,MSM8952,MSM8940,PXA1936,HI6210SFT"

    iput-object v4, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore3:Ljava/lang/String;

    const-string v3, "EXYNOS5260,EXYNOS5250,MT6750,MT6735,MSM8939V2,MSM8937,MSM8929,APQ8064,MSM8917,EXYNOS52,K3V2+,REDHOOKBAY,PXA1908,SC9860,HI6620OEM"

    iput-object v3, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore2:Ljava/lang/String;

    const-string v2, "MT6595,MT6592,MT6582,MSM8936,MSM8909,MSM8909V2,MSM8916V2,MSM8208,MSM8960T,MSM8260A,MSM8660A,MSM8960,MSM8X12,MSM8X10,MSM8X30,LC1860"

    iput-object v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore1:Ljava/lang/String;

    const-string v1, "K3V2E,K3V2,MT6589,EXYNOS4210,EXYNOS4212,MSM8X25Q,MSM8X26,PXA1088,PXA1L88,MSM8260,MSM8660,MSM8625,MSM8225,MSM8655,APQ8055,MSM7230,MSM7630,GOLDFISH,MSM8255T,MSM8655T,MSM7627A,MSM7227A,MSM7627T,MSM7227T,MT6577T,MT6572M,MT6515M,MT6575,QSD8650,QSD8250,OMAP4470,SP8810,SC8810MT6516,MT6573,MT6513,S5PC100,S5L8900,HI3611,HI3620,OMAP4460,OMAP4440,OMAP4430,EXYNOS3475,EXYNOS3110"

    iput-object v1, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScore0:Ljava/lang/String;

    .line 28
    filled-new-array/range {v1 .. v11}, [Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScoreAry:[Ljava/lang/String;

    iput-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    return-void
.end method

.method private findIndex(Ljava/lang/String;)I
    .locals 3
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "cpuBrand"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuInfo:Ljava/lang/String;

    const/4 v1, -0x1

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScoreAry:[Ljava/lang/String;

    .line 40
    array-length v0, v0

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_2

    iget-object v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuScoreAry:[Ljava/lang/String;

    .line 41
    aget-object v2, v2, v0

    if-eqz v2, :cond_1

    .line 42
    invoke-virtual {v2, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 43
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "cpuModel="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, ",score="

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v1, "OnlineMonitor"

    invoke-static {v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return v0

    :cond_1
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_2
    return v1
.end method


# virtual methods
.method public getCpuHzScore(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)I
    .locals 21
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "info"
        }
    .end annotation

    move-object/from16 v0, p1

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    .line 192
    :cond_0
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuCount:I

    const/high16 v3, 0x40000000    # 2.0f

    const v5, 0x3fb33333    # 1.4f

    const/4 v6, 0x7

    const v7, 0x3fe66666    # 1.8f

    const/4 v8, 0x3

    const/high16 v9, 0x3f800000    # 1.0f

    const/4 v10, 0x5

    const v11, 0x3f99999a    # 1.2f

    const/4 v12, 0x2

    const/4 v13, 0x6

    const v14, 0x3fa66666    # 1.3f

    const/high16 v15, 0x3fc00000    # 1.5f

    const/16 v16, 0x9

    const/16 v17, 0xa

    const/16 v2, 0x8

    if-lt v1, v2, :cond_8

    .line 193
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    const v18, 0x3ff33333    # 1.9f

    cmpl-float v1, v1, v18

    if-ltz v1, :cond_1

    goto :goto_0

    .line 195
    :cond_1
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v7

    if-ltz v1, :cond_2

    goto :goto_1

    .line 197
    :cond_2
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    const v18, 0x3fd9999a    # 1.7f

    cmpl-float v1, v1, v18

    if-ltz v1, :cond_3

    goto :goto_2

    .line 199
    :cond_3
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v15

    if-ltz v1, :cond_4

    goto :goto_3

    .line 201
    :cond_4
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v5

    if-ltz v1, :cond_5

    goto :goto_4

    .line 203
    :cond_5
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v14

    if-ltz v1, :cond_6

    goto :goto_5

    .line 205
    :cond_6
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v11

    if-ltz v1, :cond_7

    const/4 v1, 0x4

    goto :goto_7

    .line 207
    :cond_7
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v9

    if-ltz v1, :cond_10

    goto :goto_6

    .line 211
    :cond_8
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    const v18, 0x4019999a    # 2.4f

    cmpl-float v1, v1, v18

    if-ltz v1, :cond_9

    :goto_0
    move/from16 v1, v17

    goto :goto_7

    .line 213
    :cond_9
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    const v18, 0x400ccccd    # 2.2f

    cmpl-float v1, v1, v18

    if-ltz v1, :cond_a

    :goto_1
    move/from16 v1, v16

    goto :goto_7

    .line 215
    :cond_a
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v3

    if-ltz v1, :cond_b

    :goto_2
    move v1, v2

    goto :goto_7

    .line 217
    :cond_b
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v7

    if-ltz v1, :cond_c

    :goto_3
    move v1, v6

    goto :goto_7

    .line 219
    :cond_c
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v15

    if-ltz v1, :cond_d

    :goto_4
    move v1, v13

    goto :goto_7

    .line 221
    :cond_d
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v14

    if-ltz v1, :cond_e

    :goto_5
    move v1, v10

    goto :goto_7

    .line 223
    :cond_e
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v11

    if-ltz v1, :cond_f

    :goto_6
    move v1, v8

    goto :goto_7

    .line 225
    :cond_f
    iget v1, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMaxFreq:F

    cmpl-float v1, v1, v9

    if-ltz v1, :cond_10

    move v1, v12

    goto :goto_7

    :cond_10
    const/4 v1, 0x1

    .line 229
    :goto_7
    iget v4, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuMinFreq:F

    .line 231
    iget v0, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuCount:I

    const v19, 0x3f8ccccd    # 1.1f

    const v20, 0x3fcccccd    # 1.6f

    if-lt v0, v2, :cond_17

    cmpl-float v0, v4, v20

    if-ltz v0, :cond_11

    goto :goto_c

    :cond_11
    cmpl-float v0, v4, v15

    if-ltz v0, :cond_12

    goto :goto_d

    :cond_12
    cmpl-float v0, v4, v5

    if-ltz v0, :cond_13

    goto/16 :goto_e

    :cond_13
    cmpl-float v0, v4, v14

    if-ltz v0, :cond_14

    :goto_8
    move v2, v13

    goto :goto_e

    :cond_14
    cmpl-float v0, v4, v11

    if-ltz v0, :cond_15

    :goto_9
    move v2, v10

    goto :goto_e

    :cond_15
    cmpl-float v0, v4, v19

    if-ltz v0, :cond_16

    :goto_a
    move v2, v8

    goto :goto_e

    :cond_16
    cmpl-float v0, v4, v9

    if-ltz v0, :cond_20

    :goto_b
    move v2, v12

    goto :goto_e

    :cond_17
    cmpl-float v0, v4, v3

    if-ltz v0, :cond_18

    :goto_c
    move/from16 v2, v17

    goto :goto_e

    :cond_18
    cmpl-float v0, v4, v7

    if-ltz v0, :cond_19

    :goto_d
    move/from16 v2, v16

    goto :goto_e

    :cond_19
    cmpl-float v0, v4, v20

    if-ltz v0, :cond_1a

    goto :goto_e

    :cond_1a
    cmpl-float v0, v4, v15

    if-ltz v0, :cond_1b

    move v2, v6

    goto :goto_e

    :cond_1b
    cmpl-float v0, v4, v5

    if-ltz v0, :cond_1c

    goto :goto_8

    :cond_1c
    cmpl-float v0, v4, v14

    if-ltz v0, :cond_1d

    goto :goto_9

    :cond_1d
    cmpl-float v0, v4, v11

    if-ltz v0, :cond_1e

    const/4 v2, 0x4

    goto :goto_e

    :cond_1e
    cmpl-float v0, v4, v19

    if-ltz v0, :cond_1f

    goto :goto_a

    :cond_1f
    cmpl-float v0, v4, v9

    if-ltz v0, :cond_20

    goto :goto_b

    :cond_20
    const/4 v2, 0x1

    :goto_e
    add-int/2addr v1, v2

    .line 268
    div-int/2addr v1, v12

    return v1
.end method

.method public getScore()I
    .locals 13

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 52
    iget v0, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuCount:I

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuProcessCount:I

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 53
    iget-object v0, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mCpuName:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuInfo:Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_2a

    .line 57
    invoke-direct {p0, v0}, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->findIndex(Ljava/lang/String;)I

    move-result v0

    const-string v2, "MT"

    const-string v3, "MSM"

    const/4 v4, 0x1

    const/4 v5, 0x5

    const/4 v6, 0x4

    if-gez v0, :cond_1

    iget-object v7, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuInfo:Ljava/lang/String;

    .line 60
    invoke-virtual {v7, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v7

    const-string v8, "X"

    if-eqz v7, :cond_0

    iget-object v7, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuInfo:Ljava/lang/String;

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v7

    if-le v7, v5, :cond_0

    .line 61
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v7, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuInfo:Ljava/lang/String;

    invoke-virtual {v7, v1, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v7, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuInfo:Ljava/lang/String;

    invoke-virtual {v7, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 62
    invoke-direct {p0, v0}, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->findIndex(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    :cond_0
    iget-object v7, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuInfo:Ljava/lang/String;

    .line 65
    invoke-virtual {v7, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_1

    iget-object v7, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuInfo:Ljava/lang/String;

    .line 66
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v9

    sub-int/2addr v9, v4

    invoke-virtual {v7, v9}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/16 v9, 0x30

    if-lt v7, v9, :cond_1

    const/16 v9, 0x39

    if-gt v7, v9, :cond_1

    .line 68
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v7, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuInfo:Ljava/lang/String;

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v9

    sub-int/2addr v9, v4

    invoke-virtual {v7, v1, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 69
    invoke-direct {p0, v0}, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->findIndex(Ljava/lang/String;)I

    move-result v0

    :cond_1
    :goto_0
    if-gez v0, :cond_29

    .line 76
    sget-object v0, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    .line 79
    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    const/16 v7, 0x9

    const/4 v8, 0x3

    const/16 v9, 0xa

    const/16 v10, 0x8

    const/4 v11, 0x2

    if-nez v3, :cond_22

    const-string v3, "EXYNOS8"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_22

    const-string v3, "KIRIN"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    goto/16 :goto_c

    :cond_2
    const-string v3, "SDM"

    .line 93
    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    const/4 v12, 0x7

    if-nez v3, :cond_1e

    const-string v3, "EXYNOS7"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1e

    const-string v3, "HI"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto/16 :goto_9

    :cond_3
    const-string v3, "QCOM"

    .line 106
    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    const/4 v7, 0x6

    if-nez v3, :cond_1a

    const-string v3, "QUALCOMM"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1a

    const-string v3, "APQ"

    .line 107
    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_4

    goto/16 :goto_6

    :cond_4
    const-string v3, "MOOREFIELD"

    .line 119
    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_8

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuProcessCount:I

    if-lt v0, v9, :cond_5

    goto/16 :goto_a

    :cond_5
    if-lt v0, v10, :cond_6

    goto/16 :goto_d

    :cond_6
    if-lt v0, v6, :cond_7

    goto/16 :goto_f

    :cond_7
    if-lt v0, v11, :cond_27

    :goto_1
    move v1, v8

    goto/16 :goto_11

    :cond_8
    const-string v3, "MERRIFIELD"

    .line 131
    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_16

    const-string v3, "CLOVERTRAIL"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_16

    const-string v3, "REDHOOKBAY"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_16

    const-string v3, "TEGRA"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_16

    const-string v3, "NVIDIA"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_16

    const-string v3, "K3"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_9

    goto/16 :goto_4

    :cond_9
    const-string v3, "SMDK"

    .line 143
    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_12

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_a

    goto :goto_3

    :cond_a
    const-string v2, "PXA"

    .line 155
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_e

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuProcessCount:I

    if-lt v0, v10, :cond_b

    goto/16 :goto_f

    :cond_b
    if-lt v0, v6, :cond_c

    goto :goto_5

    :cond_c
    if-lt v0, v11, :cond_d

    goto/16 :goto_10

    :cond_d
    :goto_2
    move v1, v4

    goto/16 :goto_11

    :cond_e
    const-string v2, "SP"

    .line 166
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_f

    const-string v2, "SC"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_f

    const-string v2, "OMAP"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_26

    :cond_f
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuProcessCount:I

    if-lt v0, v10, :cond_10

    goto :goto_8

    :cond_10
    if-lt v0, v6, :cond_11

    goto/16 :goto_10

    :cond_11
    if-lt v0, v11, :cond_28

    goto :goto_2

    :cond_12
    :goto_3
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuProcessCount:I

    if-lt v0, v9, :cond_13

    goto :goto_a

    :cond_13
    if-lt v0, v10, :cond_14

    goto :goto_d

    :cond_14
    if-lt v0, v6, :cond_15

    goto :goto_f

    :cond_15
    if-lt v0, v11, :cond_27

    goto :goto_5

    :cond_16
    :goto_4
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuProcessCount:I

    if-lt v0, v9, :cond_17

    goto :goto_7

    :cond_17
    if-lt v0, v10, :cond_18

    goto :goto_d

    :cond_18
    if-lt v0, v6, :cond_19

    goto :goto_f

    :cond_19
    if-lt v0, v11, :cond_27

    :goto_5
    goto/16 :goto_1

    :cond_1a
    :goto_6
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuProcessCount:I

    if-lt v0, v9, :cond_1b

    goto :goto_e

    :cond_1b
    if-lt v0, v10, :cond_1c

    :goto_7
    goto :goto_a

    :cond_1c
    if-lt v0, v6, :cond_1d

    goto :goto_d

    :cond_1d
    if-lt v0, v11, :cond_27

    :goto_8
    goto :goto_b

    :cond_1e
    :goto_9
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuProcessCount:I

    if-lt v0, v9, :cond_1f

    goto :goto_d

    :cond_1f
    if-lt v0, v10, :cond_20

    goto :goto_e

    :cond_20
    if-lt v0, v6, :cond_21

    :goto_a
    move v1, v12

    goto :goto_11

    :cond_21
    if-lt v0, v11, :cond_27

    :goto_b
    move v1, v6

    goto :goto_11

    :cond_22
    :goto_c
    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->mCpuProcessCount:I

    if-lt v0, v9, :cond_23

    move v1, v9

    goto :goto_11

    :cond_23
    if-lt v0, v10, :cond_24

    :goto_d
    move v1, v7

    goto :goto_11

    :cond_24
    if-lt v0, v6, :cond_25

    :goto_e
    move v1, v10

    goto :goto_11

    :cond_25
    if-lt v0, v11, :cond_27

    :cond_26
    :goto_f
    move v1, v5

    goto :goto_11

    :cond_27
    :goto_10
    move v1, v11

    :cond_28
    :goto_11
    mul-int/2addr v1, v11

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->info:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 180
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/adapter/device/ApmHardwareCpu;->getCpuHzScore(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)I

    move-result v0

    add-int/2addr v1, v0

    .line 181
    div-int/2addr v1, v8

    goto :goto_12

    :cond_29
    move v1, v0

    :cond_2a
    :goto_12
    return v1
.end method
