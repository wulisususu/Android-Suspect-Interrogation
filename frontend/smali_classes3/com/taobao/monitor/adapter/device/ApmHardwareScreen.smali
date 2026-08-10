.class public Lcom/taobao/monitor/adapter/device/ApmHardwareScreen;
.super Ljava/lang/Object;
.source "ApmHardwareScreen.java"

# interfaces
.implements Lcom/taobao/monitor/adapter/device/ApmCalScore;


# instance fields
.field private mDesty:F

.field private mHeight:I

.field private mWidth:I


# direct methods
.method constructor <init>()V
    .locals 2

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object v0

    .line 21
    :try_start_0
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 23
    iget v1, v0, Landroid/util/DisplayMetrics;->density:F

    iput v1, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareScreen;->mDesty:F

    .line 24
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iput v1, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareScreen;->mWidth:I

    .line 25
    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    iput v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareScreen;->mHeight:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    :cond_0
    return-void
.end method


# virtual methods
.method public getScore()I
    .locals 12

    iget v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareScreen;->mWidth:I

    if-eqz v0, :cond_f

    iget v1, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareScreen;->mHeight:I

    if-nez v1, :cond_0

    goto/16 :goto_2

    :cond_0
    iget v2, p0, Lcom/taobao/monitor/adapter/device/ApmHardwareScreen;->mDesty:F

    const v3, 0x3fb33333    # 1.4f

    cmpg-float v3, v2, v3

    const/high16 v4, 0x41000000    # 8.0f

    const/high16 v5, 0x41100000    # 9.0f

    const/high16 v6, 0x40c00000    # 6.0f

    const/high16 v7, 0x40400000    # 3.0f

    const/high16 v8, 0x41200000    # 10.0f

    const/high16 v9, 0x40800000    # 4.0f

    const/high16 v10, 0x3f800000    # 1.0f

    const/high16 v11, 0x40000000    # 2.0f

    if-gtz v3, :cond_1

    move v2, v10

    goto :goto_0

    :cond_1
    const/high16 v3, 0x3fc00000    # 1.5f

    cmpg-float v3, v2, v3

    if-gtz v3, :cond_2

    move v2, v11

    goto :goto_0

    :cond_2
    cmpg-float v3, v2, v11

    if-gtz v3, :cond_3

    move v2, v9

    goto :goto_0

    :cond_3
    const/high16 v3, 0x40200000    # 2.5f

    cmpg-float v3, v2, v3

    if-gtz v3, :cond_4

    move v2, v6

    goto :goto_0

    :cond_4
    cmpg-float v3, v2, v7

    if-gtz v3, :cond_5

    move v2, v4

    goto :goto_0

    :cond_5
    const/high16 v3, 0x40600000    # 3.5f

    cmpg-float v2, v2, v3

    if-gtz v2, :cond_6

    move v2, v5

    goto :goto_0

    :cond_6
    move v2, v8

    :goto_0
    mul-int/2addr v0, v1

    const/high16 v1, 0x870000

    if-lt v0, v1, :cond_7

    move v4, v8

    goto :goto_1

    :cond_7
    const v1, 0x384000

    if-lt v0, v1, :cond_8

    move v4, v5

    goto :goto_1

    :cond_8
    const v1, 0x1fa400

    if-le v0, v1, :cond_9

    goto :goto_1

    :cond_9
    if-ne v0, v1, :cond_a

    const/high16 v4, 0x40e00000    # 7.0f

    goto :goto_1

    :cond_a
    const v1, 0xe1000

    if-le v0, v1, :cond_b

    move v4, v6

    goto :goto_1

    :cond_b
    if-lt v0, v1, :cond_c

    move v4, v9

    goto :goto_1

    :cond_c
    const/high16 v1, 0xc0000

    if-lt v0, v1, :cond_d

    move v4, v7

    goto :goto_1

    :cond_d
    const v1, 0x96000

    if-lt v0, v1, :cond_e

    move v4, v11

    goto :goto_1

    :cond_e
    move v4, v10

    :goto_1
    add-float/2addr v2, v4

    div-float/2addr v2, v11

    .line 76
    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0

    :cond_f
    :goto_2
    const/4 v0, 0x5

    return v0
.end method
